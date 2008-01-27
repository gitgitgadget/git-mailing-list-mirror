From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Submodules use case: web development based on modular CMS
Date: Sun, 27 Jan 2008 19:23:42 +0100
Message-ID: <200801271923.43212.jnareb@gmail.com>
References: <200801270139.57830.jnareb@gmail.com> <46a038f90801261900s2c4fa348wd5e0aea4ed9f1c12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, development@drupal.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 19:24:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJCBD-0000WU-VZ
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 19:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbYA0SX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 13:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753542AbYA0SX6
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 13:23:58 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:18355 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbYA0SX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 13:23:57 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1412718fga.17
        for <git@vger.kernel.org>; Sun, 27 Jan 2008 10:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        bh=Ql9ZeeCDPjCVDVNU3dokO+jMUKcaboV9cnhjqKSFdKQ=;
        b=SXq2kV+foPE5SsavgT2lG2DOFa0aqnZ7hN+7WMNt7Qe4rj2gDucxfUdJzFGWX4fqZQE+Sa+lTgc4wJCLNMODizSFGPMbXndPdEqfzYPWz3oaNrEfRe0P0ZnQQLp1DqXC1TuwSc9JJNXHVgxWzQzuEFfYKEXFc+gycWPcwS8F1tk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=MJxB16tP2X6kNDc8tHVMZGrOZC1CsgMhqBt4hWE9Z1lNAkfzGFq94YWEyoACmY+bscIn6LGhzDLwKKSUJmsELXuzecFWUjrUu/gn3o7nBHQHZ2I5QI5y6Vpi7wFKTbQ+NhRdglIBjJT3uxjWI5zo9ILq5WqiHpvG8HH/oKrXjbc=
Received: by 10.82.184.2 with SMTP id h2mr8184411buf.22.1201458235538;
        Sun, 27 Jan 2008 10:23:55 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.201.236])
        by mx.google.com with ESMTPS id j8sm5974174gvb.7.2008.01.27.10.23.52
        (version=SSLv3 cipher=OTHER);
        Sun, 27 Jan 2008 10:23:53 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <46a038f90801261900s2c4fa348wd5e0aea4ed9f1c12@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71825>

I CC'ed drupal mainling list...

On Sun, 27 Jan 2008, Martin Langhoff wrote:
> On Jan 27, 2008 1:39 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>>
>> A bit of time ago I have stumbled upon the following blog entry
>> (question): "Agaric wants version control that lets Drupal core and
>> contrib replace entire directories within our checkouts"[1]
>>   http://tinyurl.com/yv3jp4
> 
> While it is possible to use submodules, I tend to think that you can
> just use your own repo / branch "off" the main project, just like
> unofficial kernel modules do.

I think it is why they currently do, and they want to change it...

<blockquote href="http://tinyurl.com/yv3jp4">
  Right now we have each of these three areas checked out independently,
  and while they do happily reside inside one another, there's some
  inconvenience and risk of not keeping everything in synch.

  The solution we're looking at now is shell scripts but if there's
  a way for a version control system to just understand this need and
  accept it, that would be best.
</quote>

...but I guess they use CVS just like Drupal does, which might make it
painful.

> It does have a number of advantages -- including being explicit wrt to
> what version of the core project the module is developed against.
> Drupal and similar projects (like Moodle) do have a module API, but
> it's not *that* stable -- in spite of the best intentions, those APIs
> get subtle changes all the time. You should have your "release" script
> package only the module subdirectories -- and perhaps any delta in the
> core (of Drupal) that needs to be applied. In many "contrib" projects
> I've seen module files and little patch files that you are supposed to
> apply - and maintenance of those is a pain. It makes more sense to use
> git over the whole tree.
> 
> So it's a tradeoff -- IMHO, at first blush it looks more "natural" to
> use submodules, but as things progress over time I think it forces a
> lot of additional and ill-fitted work like maintaining patches, or
> adding tags that indicate "developed against Drupal v1.2.3". And the
> day the contrib module becomes official, "merging it in" is a bit of a
> mess if you want to preserve history. So in the long haul, it makes a
> lot more sense to use the "branch off the full project" approach that
> has served the kernel modules so well.

I think that choice between developing "in core" / on branch like Linux 
kernel modules and subsystems vs using submodules support like msysGit, 
cgit and (perhaps) in the future git-gui and gitk, depends on a few 
things:
 1. How tightly coupled are modules with core / how independent
    development of modules is
 2. How tightly coupled / how independent modules are from each other,
    both from the development point of view, but also from testing point
    of view
 3. How much work has to be done to add / enable module

How coupled modules are with the core depends among others on the 
stability of modular API.  The dependency of modules on core 
development might be measured by [relative] number of commits which 
change core and module, or which change module responding to change
in core (bugfixes and workaround for core bugs excluded).  And of course 
if module development _is_ done independently.

If modules are not developed in isolation (e.g. code movement), or 
cannot be tested in isolation (unit tests for modules alone, whole 
tests for core + single module) then of course it doesn't make much 
sense to use submodules support.  (For example it would be hard to test 
for example networking module without filesystem module, for Linux 
kernel modules.)

If you have to run some install script to install / start using modules 
(for example phpBB modules are custom files + specialized patch-like 
file, which allows modifying not only files but also databases), then 
that's of no avail to use submodules because you have to use [custom] 
scripts to update nevertheless...

> In that sense, I think that gitk's tree getting merged in a
> subdirectory is good as an example of what git can do, but a bit
> pointless as gitk depend quite tightly on the behaviour of git
> commands. So distributing gitk separately would be a big pain as each
> gitk version is usable against a narrow set of git revisions. Luckily,
> it gets merged into git and that's how it gets distributed.

Errr... AFAICT it is not true. It is true that gitk and git-gui require 
sufficiently new git version to work, but IIRC both have feature 
autodetection, which allows to use gitk and git-gui with older git (and 
of course the reverse: old gitk or git-gui with new git). I have used 
gitk from 'master' occassionaly, while having as default some older git 
version installed from RPM (released version).

gitk and git-gui development is managed independently from git, and can 
be done using only gitk and git-gui sources.  So using submodules is a 
good idea.  Additionally this allows to not checkout gitk and git-gui 
for example if you don't have Tcl/Tk installed or don't use windowed 
environment.

gitweb could also be managed as module... but currently there is no 
maintainer who would manage gitweb.git repository...


On the other hand having gitk, git-gui, gitweb in git proper allow to 
use just introduced features, and not only features available in last 
released version.


BTW. if some tool is tightly coupled with git, it can use git.git 
repository (or modification of thereof) as submodule, as shown in the 
cases of msysGit and cgit.

-- 
Jakub Narebski
Poland
