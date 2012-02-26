From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Question about your comment on the git parable
Date: Sun, 26 Feb 2012 16:06:24 +0100
Message-ID: <201202261606.25599.jnareb@gmail.com>
References: <A98A438D-76DD-41B5-B8E1-6FA170B00801@gmail.com> <201202261229.51199.jnareb@gmail.com> <1E5ECB5A-595A-4B04-8269-6E35BF3FEA1A@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Federico Galassi <federico.galassi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 26 16:08:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1fgC-0005vI-KH
	for gcvg-git-2@plane.gmane.org; Sun, 26 Feb 2012 16:06:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766Ab2BZPGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 10:06:23 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:34130 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690Ab2BZPGW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 10:06:22 -0500
Received: by eekc41 with SMTP id c41so385525eek.19
        for <git@vger.kernel.org>; Sun, 26 Feb 2012 07:06:20 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.14.188.144 as permitted sender) client-ip=10.14.188.144;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.14.188.144 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.14.188.144])
        by 10.14.188.144 with SMTP id a16mr5969351een.38.1330268780733 (num_hops = 1);
        Sun, 26 Feb 2012 07:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=FWC6jcJYiQvNHuMhZZ4TGcZL5grNh93GmjiFtJQm5vs=;
        b=deKGrZrCb2C84haNT8xVv4OvEaf5bhCQOffIra0/fDZBWJK2zA4b1j7Fri33eEUAcP
         e0gByqtJo/7UL3CEA0dN0upMp1nGlkAGsUrl5xtspEB12ajvcbTxvrtcEbT+gksGus5e
         rEDulNYNv6uVVOtgpkMfV0eVP7Z18TvpiWthU=
Received: by 10.14.188.144 with SMTP id a16mr4485141een.38.1330268780576;
        Sun, 26 Feb 2012 07:06:20 -0800 (PST)
Received: from [192.168.1.13] (abvv154.neoplus.adsl.tpnet.pl. [83.8.219.154])
        by mx.google.com with ESMTPS id n52sm46061284eea.5.2012.02.26.07.06.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 26 Feb 2012 07:06:19 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1E5ECB5A-595A-4B04-8269-6E35BF3FEA1A@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191563>

On Sun, 26 Feb 2012, Federico Galassi wrote:
> On 26/feb/2012, at 12:29, Jakub Narebski wrote:
> 
>> Would you mind if this discussion was moved to git mailing
>> list (git@vger.kernel.org), of course always with copy directly
>> to you?  There are people there that can answer your questions
>> better.
> 
> No problem.
>
>> On Sun, 26 Feb 2012, Federico Galassi wrote:
>>> Hello, i think you're the author of these comments:
>>> http://news.ycombinator.com/item?id=616610 
>>> 
>>> I'm doing educational work on git based on the parable (talks,
>>> articles, etc..) and i'd like to improve on the real reason
>>> for a staging area.  
>>> 
>>> My question basically is: why is it really needed for merging?
>>> I mean, given the fictional git-like system of the parable,
>>> if I need to merge 2 snapshots i could: 
>>> 
>>> 1) search the commit tree for a base point
[...]
>>> 2) compare the diffs between the snapshots and the base point snapshot
>>> 3) if a conflict happens (change in the same line), just leave
>>>   something in the working dir to mark the conflict. For example,
>>>   keeping it simple, the system could reject a new commit until
>>>   the markers of the conflict are removed from the conflicting file.   
>>> 
>>> Couldn't it just work this way?
>> 
>> Well, it could; that is how many if not most of other version control
>> systems work.
>> 
>> 
>> There are (at least!) three problems with that approach.  First, sometimes
>> it is not possible to "leave something in the working dir to mark the
>> conflict".  Take for example case where binary file (e.g. image) was
>> changed, and textual 3-way diff file-merge algorithm wouldn't work.
>> 
>> Second, what to do in the case of *tree-level* conflict, for example
>> rename/rename conflict, where one side renamed file to different
>> name (moved to different place) than the other side.  There are no
>> conflict markers for this...
>> 
>> Third, what about false positives with detecting conflict markers,
>> i.e. the case where "rejecting new commit until conflict markers are
>> removed", for example AsciiDoc files can be falsely detected as having
>> partial conflict markers, and of course test vectors for testing conflict
>> would have to have conflict markers in them.
> 
> Ok, it's clear to me that the markers in file approach is just a little
> bit too simple. Do you see any concrete advantage in the staging area
> compared to, say, tree conflict metadata in the working dir and maybe
> a dedicated smart "resolve conflict" command?   

First, for such _local_ information working directory isn't the best place.
What if you accidentally delete this?  It is not and should not be
committed to repository,so there is no way to undelete it, except redoing
merge and losing all your progress so far in resolving merge conflicts.
It is much better to put such information somewhere in administrative
area[1] of repository. 

Second, if we have staging area where we store information about which
files are tracked, and a bunch of per-file metadata like modification time
for better performance, why not use it also for storing information about
merge in progress?

[1]: Name taken from "Version Control by Example" (free e-book) by
     Eric Sink.


There is also a thing very specific to Git, namely that "git add" adds
a current content of a file to object database of a repository (though
with modern git there is also "git add --intent-to-add" which works 
like add-ing file in other version control systems)... and you have to
store reference to newly created object somewhere so that it doesn't get
garbage-collected.

>>> Can you mention other situations in which the pattern "files to be added"
>>> is either mandatory or really helpful? 
>> 
>> Note that any version control system must have a kind of proto-staging
>> area to know which files are to be added in next commit.
>> 
>> If you do
>> 
>>  $ scm add file.c
>> 
>> then version control system must save somewhere that 'file.c' is to be
>> tracked (to be added in next commit).
> 
> Yes, the fictional vcs just tracked all the files in the working dir.
> Being selective on which file to track is of course another interesting
> feature.  

IRL it is a _necessary_ feature.  One of more common, if not most common
application of version control system is to manage source files for a
computer program.  And there you have object files, executables and other
_generated_ files which shouldn't be put in version control, not to
mention backups created by your editor / IDE (e.g. "*~" files in Unix
world, "*.bak" files in MS Windows world).

Not to mention files which you have added to working directory, but are
not ready to be added to new commit.

-- 
Jakub Narebski
Poland
