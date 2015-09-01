From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3] git-p4: add "--path-encoding" option
Date: Tue, 1 Sep 2015 20:55:13 +0200
Message-ID: <1243E147-EFEC-4D0B-9872-6B9A8BBE7737@gmail.com>
References: <1441059026-66814-1-git-send-email-larsxschneider@gmail.com> <1441059026-66814-2-git-send-email-larsxschneider@gmail.com> <xmqqk2sbt5kv.fsf@gitster.mtv.corp.google.com> <523D2C52-893E-4A54-9DD1-2DDBCEA29960@gmail.com> <xmqqmvx6rqk7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, luke@diamand.org, tboegi@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 20:55:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWqiM-00015e-4f
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 20:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbbIASzT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Sep 2015 14:55:19 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37458 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbbIASzS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Sep 2015 14:55:18 -0400
Received: by wicfx3 with SMTP id fx3so22424548wic.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 11:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Xbpf45zMVH+RNsVr/EtAS4AQPz8ToM0j34VhVJfTOBM=;
        b=o+z4vO6/p+iIQvbuADGWeneNA5x49F7SluvFm5Gd4Exona/ZFMFWFtmXCJ4RKgivkJ
         iUzqnSzQMlAivQPAf7WVBECfrcbQ4ZEdW5Hzw/ug5EXFndVDgO1K8C5PRKlcSr8yxLy4
         ynlf8h+2guAA2lkSh605zYCffIlTfZx9JJwlZbNTwKATiK/I0vXWPJKGeBvUrTTvYQqw
         9+YPNZmfgKnHiQuV6InCu88DNXvb+x6Rhfxef3YL4BxrsHoEL0R4dJLyjZXUf/CdLAeK
         yW2xBLGZzlubt/+jt/D0e9Un4ZBODoFU7yICcQNjc0BDDGn/18wHIwOmutSPytG4h3HB
         R/HA==
X-Received: by 10.194.173.35 with SMTP id bh3mr31554160wjc.88.1441133717400;
        Tue, 01 Sep 2015 11:55:17 -0700 (PDT)
Received: from [10.32.249.9] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id cx1sm208881wib.0.2015.09.01.11.55.15
        (version=TLS1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Sep 2015 11:55:16 -0700 (PDT)
In-Reply-To: <xmqqmvx6rqk7.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277028>


On 01 Sep 2015, at 19:35, Junio C Hamano <gitster@pobox.com> wrote:

> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>> On 01 Sep 2015, at 01:13, Junio C Hamano <gitster@pobox.com> wrote:
>>=20
>>> larsxschneider@gmail.com writes:
>>>=20
>>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>>=20
>>>=20
>>> Here is a space for you to describe what it does and why it is a
>>> good idea to have it.
>> How about this:
>>=20
>> Perforce keeps the encoding of a path as given by the originating
>> OS. Git expects paths encoded as UTF-8. Add an option to tell git-p4
>> what encoding Perforce had used for the paths. This encoding is used
>> to transcode the paths to UTF-8. As an example, Perforce on Windows
>> uses =93cp1252=94 to encode path names.
>=20
> Very readable.  Does "Perforce on Windows" always use cp1252, or
> is it more correct to say "often uses" here?
Thank you! I don=92t know if =93always=94 or =93often=94 is better. On =
my Windows test system it is =93always=94=85 but that=92s not a valid s=
ample size :-)
I searched the Internet for clues around cp1252 and found that a simila=
r patch was submitted to Mercurial just a month ago. The author seconds=
 my cp1252 observation:
http://mercurial.808500.n3.nabble.com/PATCH-stable-convert-use-original=
-local-encoding-when-converting-from-Perfoce-tp4025088p4025094.html

- Lars