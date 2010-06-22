From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH GSoC] gitweb: Add support for enabling 'write' feature
Date: Tue, 22 Jun 2010 21:23:53 +0200
Message-ID: <201006222123.54352.jnareb@gmail.com>
References: <1277157648-6029-1-git-send-email-pavan.sss1991@gmail.com> <201006221312.57801.jnareb@gmail.com> <AANLkTimpF6CMF0yDmaxABR0BYOBE75sR5Zwtsb79fU4t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, pasky@ucw.cz
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 22 21:24:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OR952-0006LA-MC
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 21:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793Ab0FVTYG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Jun 2010 15:24:06 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63408 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754467Ab0FVTYD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jun 2010 15:24:03 -0400
Received: by fxm10 with SMTP id 10so2654620fxm.19
        for <git@vger.kernel.org>; Tue, 22 Jun 2010 12:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=YYibfewL3mcj7vv2PWh76qlJPu25RgpLGs5lVnjr32M=;
        b=Va7G3pdkJWgfiCjlH32BczD6nO5OnW0gsVLCgXJEAQXIoyewxRd+YUuZ4U9ucHqfhS
         Dom9/ZW7OJYOkZGznqvdAsb6uqxxyZFk6xpQ7cPiW6DdfsOXrSRCFVIkfvFdc/qaXN8j
         Ij3Mw4XJKN+YmI0wXKbDoqU93MHu1P6AaCipM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=urCDmLp+7Vsw9AFYeyf5wixOZjktUuidCSLA7V9rfpWjgtZ8/GRwzM+/a3DKE59Op9
         LXlDaKOORZUWISGzvXQ8CDVZ6Pk4LxqCpiLABascmHuSdq2PN4Yn/65ozfMrMdnCANnK
         G/hLq2/9gJN/0qQJiZzEG1R+5j3MjgXJq7UZc=
Received: by 10.223.54.143 with SMTP id q15mr6671262fag.16.1277234640717;
        Tue, 22 Jun 2010 12:24:00 -0700 (PDT)
Received: from [192.168.1.15] (abvn56.neoplus.adsl.tpnet.pl [83.8.211.56])
        by mx.google.com with ESMTPS id r9sm89084faq.3.2010.06.22.12.23.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Jun 2010 12:23:59 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTimpF6CMF0yDmaxABR0BYOBE75sR5Zwtsb79fU4t@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149490>

Dnia wtorek 22. czerwca 2010 20:35, Pavan Kumar Sunkara napisa=B3:
> 2010/6/22 Jakub Narebski <jnareb@gmail.com>:
>> On Tue, 22 June 2010, Pavan Kumar Sunkara wrote:
>>
>>> Provide $feature{'write'} to enable the 'write'
>>> functionalities for gitweb. While outputting HTML
>>> it checks for gitweb_check_feature('write') and if
>>> it's enabled, proper links will appear along with
>>> the HTML divs.
>>>
>>> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>

>>> --- a/gitweb/lib/Gitweb/Config.pm
>>> +++ b/gitweb/lib/Gitweb/Config.pm
>>> @@ -203,6 +203,17 @@ our %feature =3D (
>>> =A0 =A0 =A0 # (an array) or gitweb_check_feature(<feature>) to chec=
k if <feature>
>>> =A0 =A0 =A0 # is enabled
>>>
>>> + =A0 =A0 # Enable the 'write' functionalities for gitweb. While ou=
tputting HTML
>>> + =A0 =A0 # it checks for gitweb_check_feature('write') and if it's=
 enabled,
>>> + =A0 =A0 # proper links will appear along with the HTML divs.
>>> +
>>> + =A0 =A0 # To enable system wide have in $GITWEB_CONFIG
>>> + =A0 =A0 # $feature{'write'}{'default'} =3D [1];
>>> + =A0 =A0 # Project specific override is not supported.
>>> + =A0 =A0 'write' =3D> {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 'override' =3D> 0,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 'default' =3D> [0]},
>>> +
>>> =A0 =A0 =A0 # Enable the 'blame' blob view, showing the last commit=
 that modified
>>> =A0 =A0 =A0 # each line in the file. This can be very CPU-intensive=
=2E
>>
>> ...as there is nothing non-trivial in there.
>=20
> But don't u think it would be like a small starting patch.

There is staring small, and there is too small.

You don't provide _any_ write functionality here, or even any authoriza=
tion
framework for write functionality, like checking if we are on localhost=
=2E

--=20
Jakub Narebski
Poland
