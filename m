From: Mike McQuaid <mike@mikemcquaid.com>
Subject: Re: Git 2.7.0 gitignore behaviour regression
Date: Wed, 6 Jan 2016 09:50:39 +0000
Message-ID: <5E517AD0-CD4E-4F85-8FEB-89B7A0183967@mikemcquaid.com>
References: <4B0F686D-3DF9-4E5D-971D-DB106C6573FD@mikemcquaid.com> <20160105150602.GA4130@sigill.intra.peff.net> <CACsJy8AQ9s4VkFn+TNJLD55xJc40+-54BTYbC4Os71uSkL1QSA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 10:50:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGkk0-0004am-Fg
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 10:50:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163AbcAFJus convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jan 2016 04:50:48 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35017 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbcAFJuo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jan 2016 04:50:44 -0500
Received: by mail-wm0-f44.google.com with SMTP id f206so53175585wmf.0
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 01:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mikemcquaid-com.20150623.gappssmtp.com; s=20150623;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zOGh/lGkWE+GA9jl3BfdwjRv2bu9mjOSGzBLVwpEX/A=;
        b=b1PNTp7m3M0VDXunkw85qNxvBvlHYNjCYAOzoVN1uAuShhG/QhdiQY4NnH6/kE/7Cn
         S9x79pwFuEHaDENSn75uBO6+oYm/IZQ0MtPx5YjmCaQmiFel7FcupNcOQrgpFk8b4Q2G
         v8cNvgRuNVd4WppxkfOl5etyPuwbQxUKoTMbd57hUnRXm+9Rt8oKgaEqYqDGB4oZ4uiZ
         adB6blHQ/S2ZH26ex5i2gq9yMp2deD11woJkFLZCa/cxlyyXCPmW+0M0a5MAoPo32UXz
         0eOVYlN7pA4kGMmPFP7oK8zciDkZLKrNuJoqxVv+bZuRPJ1u2v/d3m1MAIwWDLx62OE7
         dXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=zOGh/lGkWE+GA9jl3BfdwjRv2bu9mjOSGzBLVwpEX/A=;
        b=ji1lWrcqOKa9aLyv3a8ZvZVQsBSaShSjWvPn/iF1q3g8psBcBpk/kIK3sJzHCEN48c
         4RfAtQFF6Mmli6865UZDzHwXqCRPOh5LD72pS/XsYY+T4dQWAvuqpHInLeTDomJ3ZMVg
         aL9dPsgucOksvEFi4u0ShpzawHbL8ypq8nsY2HUaBHIgz/6XixafuiQ2Qf0PYQusYkNy
         PF4qenZ8K4/n9keS3jmJQAxxZanSC1iIgz4u+f50kn99eWbI89nqQwcR5lCRpBkyIo+r
         FJHqMYUGLAnmDJILS+Ku9W4JMzttX/9gc67z2EuBfYRTSAabxAsrXtqY2Kz3n/63VIC6
         9aeg==
X-Gm-Message-State: ALoCoQlbFTGucYTztBnMu9PfSBBKBUNwoUdQHISQTYXbN/NRmBDN3AU0CpzqbkKNq0049pCIlAwpAoKCt6mnop9tQi+SQlj7jg==
X-Received: by 10.28.139.205 with SMTP id n196mr9788309wmd.0.1452073842713;
        Wed, 06 Jan 2016 01:50:42 -0800 (PST)
Received: from [10.0.0.14] (bcdc3f6a.skybroadband.com. [188.220.63.106])
        by smtp.gmail.com with ESMTPSA id gl10sm95110217wjb.30.2016.01.06.01.50.39
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Jan 2016 01:50:42 -0800 (PST)
In-Reply-To: <CACsJy8AQ9s4VkFn+TNJLD55xJc40+-54BTYbC4Os71uSkL1QSA@mail.gmail.com>
X-Mailer: Apple Mail (2.3112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283430>


> On 6 Jan 2016, at 09:42, Duy Nguyen <pclouds@gmail.com> wrote:
>=20
> Yeah.. I think it's the only relevant commit in 2.7.0 cycle anyway.
> These patterns "/a" followed by "!/a/*" were wrecking my head. But I
> finally decided 2.7 output makes more sense. You asked to un-ignore
> everything inside 'a' so we can't treat 'a' as (entirely) ignored and
> hide it away.
>=20
>> I'm sympathetic that in making that use-case work, we might have
>> regressed another one, but it's hard to tell from the small example.=
 Can
>> you elaborate on your use case? Why are you both ignoring and unigno=
ring
>> everything in the directory?
>=20
> Also how bad this affects you (widely-used 'wrong' behavior can becom=
e
> 'right', and my change a regression as a result)

This doesn=E2=80=99t affect me badly; I was able to work around the ori=
ginal issue before the bug report in a way that was consistent between =
Git 2.6 and Git 2.7 but wanted to ensure that I filed something upstrea=
m just so it was a known issue as it was relatively easy to reproduce.

I agree that all the pattern handling stuff like in my example is prett=
y awful; it=E2=80=99s also a big area where libgit2 was inconsistent wi=
th Git=E2=80=99s behaviour on either of those versions too. I=E2=80=99v=
e played around and now got a .gitignore file that behaves consistently=
 across Git 2.6, Git 2.7 and libgit2 0.23.4 (https://github.com/Homebre=
w/homebrew/blob/master/.gitignore) so there=E2=80=99s no outstanding is=
sue on my side.

Thanks!

Mike McQuaid
http://mikemcquaid.com
