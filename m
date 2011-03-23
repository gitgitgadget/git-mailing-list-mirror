From: Lasse Makholm <lasse.makholm@gmail.com>
Subject: Re: git svn perl issues
Date: Wed, 23 Mar 2011 23:19:46 +0100
Message-ID: <AANLkTim3yK2=MjO1NbpQ2pu4tV7=hwR-Z9UbixdfAkm=@mail.gmail.com>
References: <AANLkTikowuFsXFwLL14oS0zzHh3RiHOrGTVHXgyy8dLw@mail.gmail.com>
	<521251622.25680.1300916735091.JavaMail.root@tahiti.vyatta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Stephen Hemminger <stephen.hemminger@vyatta.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 23:19:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2WPC-0000Id-6S
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 23:19:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756725Ab1CWWTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 18:19:49 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59445 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756703Ab1CWWTs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 18:19:48 -0400
Received: by bwz15 with SMTP id 15so7061636bwz.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 15:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=8bceekDmg9U9OakXMPo+pM3Fie3WyvqtGaBq5ieTkY4=;
        b=J8SuLk30HUjfSBbGUKWraJ0FOw71wsPB/fl6SEwMl24ZYk+bWv7aJExB22uOKejNq6
         s90FYEVPutVkpvGnaPPgJtuAKece//afXvziNR/WnNe74Sz6ogfjctrh8fIyS3qYuW5E
         rap22CerKRsMjivCVDq7QQ/UnZYhtRqDuL40s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=rLju0e3SZUMDBsZmf85Ct6cKoHg9PisR/tQlJATZDuZFiqhv/RxX9fbfZxiclm2GZ8
         rgFaQpHwa0C9g85bM5R3/wvzp4xEPt5CrPuC+U0HNzD5GXn1UWXvSHkZuYafKZBVqzMC
         NuRgPnHoUJ7tUjxyomilGErdqOjNedOQPeCuQ=
Received: by 10.204.80.29 with SMTP id r29mr6690259bkk.195.1300918786999; Wed,
 23 Mar 2011 15:19:46 -0700 (PDT)
Received: by 10.204.114.207 with HTTP; Wed, 23 Mar 2011 15:19:46 -0700 (PDT)
In-Reply-To: <521251622.25680.1300916735091.JavaMail.root@tahiti.vyatta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169877>

On 23 March 2011 22:45, Stephen Hemminger <stephen.hemminger@vyatta.com> wrote:
>
>> On 23 March 2011 16:52, Stephen Hemminger <shemminger@vyatta.com>
>> wrote:
>> > 1. The following needs to be fixed:
>> >
>> > $ git svn clone
>> > Use of uninitialized value $_[0] in substitution (s///) at
>> > /usr/share/perl/5.10.1/File/Basename.pm line 341.
>> > fileparse(): need a valid pathname at /usr/lib/git-core/git-svn line
>> > 403
>>
>> While noisy and ugly, uninitialized warnings are usually pretty
>> harmless...
>
> User should never see perl splat, it is sloppy.

Agreed.

>> > 2. The git-svn perl script does not follow Perl Best Practices.
>> > If you run the perlcritic script on it, all the following
>> > warnings/errors
>> > are generated:
>>
>> Some of these are undoubtedly valid complaints, but the so called best
>> practices that the perl critic policies implement are, in my opinion,
>> not widely accepted as such by the perl community. At least not all of
>> them. I wouldn't go following them blindly - especially in working
>> production code...
>
> Some of them are crap, but like sparse warnings it is trivial to
> fix them and make it clean so why not.

Well, personally I don't think they all add any value but that's a bit
beside the point here...

> If you don't maintain code it just rots.

True enough. That said, I haven't actually looked into the git-svn
code oh my god why do people write 6K line scripts... *sigh*

My first suggestion would be to split it... :-) It's already 75%
classes anyway...

[forgot to reply all, sorry for the spam Stephen...]
-- 
/Lasse
