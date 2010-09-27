From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 04/12] gitweb: nagivation menu for tags, heads and remotes
Date: Mon, 27 Sep 2010 10:30:49 +0200
Message-ID: <201009271030.50258.jnareb@gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com> <201009261952.07803.jnareb@gmail.com> <AANLkTi=nG9Day4ZCF88JwyeNx2qEM=+hKaKoyWRSTUFW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 10:31:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0975-00013N-KI
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 10:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620Ab0I0IbC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 04:31:02 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34835 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755911Ab0I0IbA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 04:31:00 -0400
Received: by bwz11 with SMTP id 11so3115497bwz.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 01:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=wJhJ8AP4DUVaEoUExuPdkXkwLibUSvAUPQJtRNX7Dkk=;
        b=vSaDXnapGyokZZPsDatSg3CwlTzxXfq8lIKg1omQG+o0IzhzKfv6u/hY0HhdhO8nWP
         gVm6vFPjLCM1YlI7Y4EAqpfdtPLyC25HD/OhyoyV5fkHB5wCngqvOKvMc+yxCUHiOAJE
         s5y9RRzPx2Vh/WxTughh9HAo8c52vIjyJ7iaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=rLwmtD1AjfkVD9H9CCmlKykrmh0sWh/lou2HZg5YxKRvvGAl/D0bb11vrkywPa4XDw
         t3oAwyKEJSnhvM/oTCRqkouHSL7JRIoZdLKjSYBgLOj+vqpvGB9g0vcpS37pHV1f7TQR
         RI4Ocr9FPEQgJndUfUh1MXQ1VbMoPw4ii5tQ4=
Received: by 10.204.156.212 with SMTP id y20mr4898934bkw.179.1285576259258;
        Mon, 27 Sep 2010 01:30:59 -0700 (PDT)
Received: from [192.168.1.13] (abvz242.neoplus.adsl.tpnet.pl [83.8.223.242])
        by mx.google.com with ESMTPS id y19sm4129502bkw.6.2010.09.27.01.30.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Sep 2010 01:30:58 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTi=nG9Day4ZCF88JwyeNx2qEM=+hKaKoyWRSTUFW@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157320>

On Mon, 27 Sep 2010, Giuseppe Bilotta wrote:
> 2010/9/26 Jakub Narebski <jnareb@gmail.com>:
>> On Fri, 24 Sep 2010, Giuseppe Bilotta wrote:
>>>
>>> +# returns a submenu for the nagivation of the refs views (tags, he=
ads,
>>> +# remotes) with the current view disabled and the remotes view onl=
y
>>> +# available if the feature is enabled
>>> +
>>
>> Minor nitpick: this empty line here is not necessary. =A0But I think
>> that Junio can remove it when applying.
>=20
> Since there have been a couple of stylistic suggestions for the
> comments in the first two patches too, I can probably resend the whol=
e
> series including these changes, unless Junio wants to do the
> hand-tuning.

Well, the first half of this series (patches 1 to 5) are good enough,
or almost good enough, to be merged in as they are now.  They might
need at most some minor stylistic corrections.  It depends on Junio
whether he wants to have resend of early part of this series, or if
he prefers to hand-edit those minor corrections.

Patches 6-12 needs, I think, further discussion.
=20
>>> +sub format_ref_views {
>>> + =A0 =A0 my ($current) =3D @_;
>>> + =A0 =A0 my @ref_views =3D qw{tags heads};
>>
>> Hmmm... should we pass it as argument, or use $action in place of
>> $current? =A0Each solution has its advantages and disadvantages. =A0=
Current
>> solution has the advantage of avoiding using global variables, solut=
ion
>> using $action has the (supposed) advantage of automatically detectin=
g
>> current action.
>=20
> Not using $action has the advantage of making it possible to enable
> the $action command if it's wanted, which is something that I use in =
a
> subsequent patch (when enabling single-remote view). But this is of
> course debatable.

I agree that use of format_ref_views further in this series shows that
your version (with $current passed as argument) is better.

--=20
Jakub Narebski
Poland
