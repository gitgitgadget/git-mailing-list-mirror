From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCH GSoC] gitweb: Add support for enabling 'write' feature
Date: Wed, 23 Jun 2010 00:05:22 +0530
Message-ID: <AANLkTimpF6CMF0yDmaxABR0BYOBE75sR5Zwtsb79fU4t@mail.gmail.com>
References: <1277157648-6029-1-git-send-email-pavan.sss1991@gmail.com>
	<1277159424-6351-1-git-send-email-pavan.sss1991@gmail.com>
	<201006221312.57801.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, pasky@ucw.cz
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 22 20:35:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OR8Jl-00045c-12
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 20:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349Ab0FVSfY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Jun 2010 14:35:24 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64403 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998Ab0FVSfX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jun 2010 14:35:23 -0400
Received: by gye5 with SMTP id 5so3116179gye.19
        for <git@vger.kernel.org>; Tue, 22 Jun 2010 11:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TuOoKVs8qbo4bp4ExS9h7PTaGg8hNv352FdGMjEnc3k=;
        b=wQKmrEfyfje+xb9dmy/o+HD5AiMMC4d9bwpMPvxlu1ODVSc+kXlh+j42AaGkyjxSPt
         23M3pJ9kJRy+ekXxDA/RrOVOTVDjhbmGNdnV6oySUpAa/0LXZidoRSQksNY090z4eUQD
         6FHBPOZekggAqKgPOvOSjCJCxIKxon/gbG+Y4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=yEYLQTuL6JlwlWpzXvDoIzmtg7fdHafwu4nSBnmAxrm66Fbhi/DplPQBxdPGnCW3kz
         2fYheI0puDHdtSaYPCk/MeZwDHGl/4NeovZL8voDJhZXnX4ZdWkIk/PlzQd4VRuKE3Ha
         LgVHk4qLaRjO98KOvYM+Ty1qmR+IpYDWvB82U=
Received: by 10.101.128.32 with SMTP id f32mr5582811ann.93.1277231722424; Tue, 
	22 Jun 2010 11:35:22 -0700 (PDT)
Received: by 10.100.141.14 with HTTP; Tue, 22 Jun 2010 11:35:22 -0700 (PDT)
In-Reply-To: <201006221312.57801.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149488>

2010/6/22 Jakub Narebski <jnareb@gmail.com>:
> On Tue, 22 June 2010, Pavan Kumar Sunkara wrote:
>
>> Provide $feature{'write'} to enable the 'write'
>> functionalities for gitweb. While outputting HTML
>> it checks for gitweb_check_feature('write') and if
>> it's enabled, proper links will appear along with
>> the HTML divs.
>>
>> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
>> ---
>> =A0This patch is based on my previous patch series.
>> =A0http://mid.gmane.org/1277157648-6029-1-git-send-email-pavan.sss19=
91@gmail.com
>
> It looks a bit like this email is send by accident...
>
>> =A0And this is my first patch in the preparation for integration
>> =A0of write functionality into gitweb.
>>
>> =A0gitweb/lib/Gitweb/Config.pm | =A0 11 +++++++++++
>> =A01 files changed, 11 insertions(+), 0 deletions(-)
>>
>> diff --git a/gitweb/lib/Gitweb/Config.pm b/gitweb/lib/Gitweb/Config.=
pm
>> index c528595..87f0ba6 100644
>> --- a/gitweb/lib/Gitweb/Config.pm
>> +++ b/gitweb/lib/Gitweb/Config.pm
>> @@ -203,6 +203,17 @@ our %feature =3D (
>> =A0 =A0 =A0 # (an array) or gitweb_check_feature(<feature>) to check=
 if <feature>
>> =A0 =A0 =A0 # is enabled
>>
>> + =A0 =A0 # Enable the 'write' functionalities for gitweb. While out=
putting HTML
>> + =A0 =A0 # it checks for gitweb_check_feature('write') and if it's =
enabled,
>> + =A0 =A0 # proper links will appear along with the HTML divs.
>> +
>> + =A0 =A0 # To enable system wide have in $GITWEB_CONFIG
>> + =A0 =A0 # $feature{'write'}{'default'} =3D [1];
>> + =A0 =A0 # Project specific override is not supported.
>> + =A0 =A0 'write' =3D> {
>> + =A0 =A0 =A0 =A0 =A0 =A0 'override' =3D> 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 'default' =3D> [0]},
>> +
>> =A0 =A0 =A0 # Enable the 'blame' blob view, showing the last commit =
that modified
>> =A0 =A0 =A0 # each line in the file. This can be very CPU-intensive.
>
> ...as there is nothing non-trivial in there.
>
> --
> Jakub Narebski
> Poland
>

But don't u think it would be like a small starting patch.

Thanks,
Pavan.
