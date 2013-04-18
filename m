From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: [PATCH] gitweb/INSTALL: GITWEB_CONFIG_SYSTEM is for backward compatibility
Date: Wed, 17 Apr 2013 21:00:15 -0400
Message-ID: <CAM9Z-nkG0YbudBnhcu6du824aEcXRVLCx406=kVbG83g3rFPdQ@mail.gmail.com>
References: <7v4nfch90r.fsf@alter.siamese.dyndns.org>
	<20130412064837.GA5710@elie.Belkin>
	<20130412064953.GB5710@elie.Belkin>
	<7vy5cnd0m4.fsf@alter.siamese.dyndns.org>
	<516888C0.90501@gmail.com>
	<CAM9Z-nmOzpJdT3ni0rYRkg7Z26N5XSRyqp0TkTY79AAZ85pw2A@mail.gmail.com>
	<7vobdfnlc7.fsf@alter.siamese.dyndns.org>
	<CAM9Z-nm=SUNAHXZtOnz_BSS8VrVYPczicX99FUmDJe6Lj_oKpQ@mail.gmail.com>
	<516D4359.2070501@gmail.com>
	<CAM9Z-nkbBS5qvbkocdGWj7rwtSxB86+R4jdjcBOxCU4YjtgZ1A@mail.gmail.com>
	<20130416222600.GG29773@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 03:00:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USdD8-00051u-Fj
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 03:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350Ab3DRBAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 21:00:18 -0400
Received: from mail-ia0-f177.google.com ([209.85.210.177]:40069 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459Ab3DRBAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 21:00:16 -0400
Received: by mail-ia0-f177.google.com with SMTP id w33so1938863iag.8
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 18:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=xm3n9EB3ZHAvTpaVM/qq0f4jwUkAYK8QEgitDYSA1nc=;
        b=Uh1fIlAnnM7Y0GOuftn5mAC8aAHawy/3GAClS/vZnKZ7cidfjoiXS+lzm5DOUIMUmB
         DX07tAYDSymsofjb794L9s0tQe3i+9yUZcCIUIX7zDUbXwkyzxplK27ulGeo8aHrU4Wo
         vsEPYeeuR+tNSO/qCikzYjE4mGImDg51Zc8dV5QMYBwlzLuepZt6uzeZi8GSwWU5JAFE
         np5U0fbIhGo804veN/ITI3HBXEyh1Cd7v8Si8j/kyj99DtV5Cj5ByRS5/1s1mgTO4GUd
         6dviu2SM2EVsYm2niVOhCNj2QM8wB6tsnjWHnBK+V+oUbNwkXioNYVxMxerN7juc8MNT
         sMhw==
X-Received: by 10.50.187.225 with SMTP id fv1mr5742659igc.74.1366246816063;
 Wed, 17 Apr 2013 18:00:16 -0700 (PDT)
Received: by 10.42.173.70 with HTTP; Wed, 17 Apr 2013 18:00:15 -0700 (PDT)
In-Reply-To: <20130416222600.GG29773@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221596>

On Tue, Apr 16, 2013 at 6:26 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Drew Northup wrote:
>
>>                             This is unobtrusive yet to the point.
>
> I agree with the spirit.
>
> [...]
>> --- a/Documentation/gitweb.conf.txt
>> +++ b/Documentation/gitweb.conf.txt
>> @@ -55,7 +55,8 @@ following order:
>>     then fallback system-wide configuration file (defaults to
>> '/etc/gitweb.conf').
>>
>>  Values obtained in later configuration files override values obtained earlier
>> -in the above sequence.
>> +in the above sequence. This is different from many system-wide software
>> +installations and will stay this way for historical reasons.
>
> That makes it sound like the "per instance overrides common overrides
> built-in" cascading is what is unusual and what we need to apologize
> for.

I don't think were apologizing for anything. It is helpful to say "we
do some things differently here and don't plan on changing for a very
important reason.

> How about something like the following?  (It uses a BUGS section to
> make the warning easy to notice for people tracking down confusing
> behavior by searching for "gitweb.conf".)
>
> diff --git i/Documentation/gitweb.conf.txt w/Documentation/gitweb.conf.txt
> index eb63631..ea0526e 100644
> --- i/Documentation/gitweb.conf.txt
> +++ w/Documentation/gitweb.conf.txt
> @@ -857,6 +857,13 @@ adding the following lines to your gitweb configuration file:
>         $known_snapshot_formats{'zip'}{'disabled'} = 1;
>         $known_snapshot_formats{'tgz'}{'compressor'} = ['gzip','-6'];
>
> +BUGS
> +----
> +Debugging would be easier if the fallback configuration file
> +(`/etc/gitweb.conf`) and environment variable to override its location
> +('GITWEB_CONFIG_SYSTEM') had names reflecting their "fallback" role.
> +The current names are kept to avoid breaking working setups.
> +
>  ENVIRONMENT
>  -----------
>  The location of per-instance and system-wide configuration files can be

I don't disagree with this, as some would consider the naming to be a
bug, but after having been given a good schooling on the git list a
while back as to why it is the way it is I'm hesitant to label "has
history" as a bug.

--
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
