From: Dun Peal <dunpealer@gmail.com>
Subject: Re: Inexplicably deteriorating performance of Git repositories on Windows
Date: Wed, 24 Nov 2010 20:10:40 +0000
Message-ID: <AANLkTim9hvekD0VmYdM2YfyGCqPe71yHv9PxsvnbNnR0@mail.gmail.com>
References: <AANLkTimTh7ka21inpovM=qqdWs6j2OcPXVsFh_CMiZ7N@mail.gmail.com>
	<4CECF837.1080404@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git ML <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Nov 24 21:14:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLLjC-0002Mp-KK
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 21:14:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755888Ab0KXUKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 15:10:42 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:39410 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389Ab0KXUKl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 15:10:41 -0500
Received: by qyk12 with SMTP id 12so215546qyk.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 12:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=bV9SMl3XWgTdcyqmwHvhRqqM99E522wcWZG0xM3AzLc=;
        b=vZrbYo99qU83VekOjq5BjOM+AyHww0f7rrItI3VmRKHtZATd92OC8F8/2vAn6QhrhG
         w2f8Y5talAm357CCLaLvGG4z/wbv7sf3PST1YfRN40mEfvx+/ZEdRPadW4oXtXAeT+t8
         HyGTwWcybaxOUYfdK06jISospe9nyYQvCyYWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=AtWYD87wR8zAQVF1jMRrOAWo9yvldYVvThAcm4jpiqKuSjgCpmt3ofJA8Y1lAhH/f5
         wPU4dDKBU6/95soVs47ErkiEFpfYDj6ezrV6MCwmJKxrdBS2sdl4uO+gU2XSvPZH9SP8
         fqXgdCzWfJjqVOGw9y8Ionk/BePlW5HW2vFvQ=
Received: by 10.224.11.145 with SMTP id t17mr8278623qat.54.1290629440744; Wed,
 24 Nov 2010 12:10:40 -0800 (PST)
Received: by 10.220.186.198 with HTTP; Wed, 24 Nov 2010 12:10:40 -0800 (PST)
In-Reply-To: <4CECF837.1080404@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162078>

On Wed, Nov 24, 2010 at 11:34 AM, Andreas Ericsson <ae@op5.se> wrote:
> How many refs (tags and branches) do you have?

We have about 15 branches, but thousands of tags (we tag each release,
and we make those often). However, I'm not sure how that could make
`git status` slow, since it shouldn't care about tags at all?

> Are the refs packed or loose?

Packed.

> If they are loose, does packing them resolve the issue?
> Are you using network-mounted or local storage?

Local storage on all workstations. One machine with those performance
issues actually utilizes an incredibly fast, cutting edge SSD. It's
twice as fast as the other slow machine, but 8s for `git status` is
still slow.

> What does the .git/config file look like for a user where git status
> is excruciatingly slow?

It's the normal .git/config you get by default on Git 1.7.x when
cloning from a remote. I can paste it if you want, but doubt it will
interest anyone: we didn't modify it.

> Does copying the config file from a windows user to a linux user make
> timings somewhat consistent between various systems?

No.

> Do older version of git perform as poorly?

Yes.

> How is the repository laid out (ie, are there any directories with
> a ton of files in, or are they spread across multiple directories)?

Generally spread across multiple directories.

> How many .gitignore files are you using, and what do they look like?

We're using 25 of those,

>> However, after a reboot (of all things), `git status` latency
>> skyrockets to 14-15s, making the repo unusable.
> That's just plain weird, and is almost certainly a system issue.

Yes, it's weird. I'm not sure it's a "system" issue since we're seeing
it across a diverse set of Windows systems: Vista, Windows 7, pretty
sure I saw XP as well, different hardware and software setups
(different programs installed and running).

.D
