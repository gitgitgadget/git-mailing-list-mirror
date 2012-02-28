From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Question about your comment on the git parable
Date: Mon, 27 Feb 2012 20:41:45 -0600
Message-ID: <4F4C3EE9.60709@gmail.com>
References: <A98A438D-76DD-41B5-B8E1-6FA170B00801@gmail.com> <201202261229.51199.jnareb@gmail.com> <1E5ECB5A-595A-4B04-8269-6E35BF3FEA1A@gmail.com> <201202261606.25599.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Federico Galassi <federico.galassi@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 28 03:41:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2D0h-0002kq-OR
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 03:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756711Ab2B1Clq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 21:41:46 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48338 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755203Ab2B1Clp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 21:41:45 -0500
Received: by yenl12 with SMTP id l12so543361yen.19
        for <git@vger.kernel.org>; Mon, 27 Feb 2012 18:41:44 -0800 (PST)
Received-SPF: pass (google.com: domain of nkreitzinger@gmail.com designates 10.236.145.230 as permitted sender) client-ip=10.236.145.230;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of nkreitzinger@gmail.com designates 10.236.145.230 as permitted sender) smtp.mail=nkreitzinger@gmail.com; dkim=pass header.i=nkreitzinger@gmail.com
Received: from mr.google.com ([10.236.145.230])
        by 10.236.145.230 with SMTP id p66mr25382527yhj.27.1330396904496 (num_hops = 1);
        Mon, 27 Feb 2012 18:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=v3rBQhn1XB2srXQwz/fIzSvOmBz6nW/ch/O+AX4vTGY=;
        b=daJZ4AKY95ACgu6pybdZR6nGrw9IbTgoeY9Ey1wM6sFaBdhgU3cEqLkeJhixlafJBV
         wEQfWPdHkfdBw21DPUplfACIHx9RGrKgx55MkeDNEgdUB5203YSz7WsA4aKDa6p6ZHBv
         vRifl9QmnX7Ky/18nCKthlEDKgzLH7o5V5glU=
Received: by 10.236.145.230 with SMTP id p66mr19066287yhj.27.1330396904341;
        Mon, 27 Feb 2012 18:41:44 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id n72sm43266392yhh.21.2012.02.27.18.41.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 27 Feb 2012 18:41:43 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <201202261606.25599.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191696>

On 2/26/2012 9:06 AM, Jakub Narebski wrote:
> On Sun, 26 Feb 2012, Federico Galassi wrote:
>> On 26/feb/2012, at 12:29, Jakub Narebski wrote:
>>
>>> Would you mind if this discussion was moved to git mailing
>>> list (git@vger.kernel.org), of course always with copy directly
>>> to you?  There are people there that can answer your questions
>>> better.
>>
>> No problem.
>>
>>> On Sun, 26 Feb 2012, Federico Galassi wrote:
>>>> Hello, i think you're the author of these comments:
>>>> http://news.ycombinator.com/item?id=616610
>>>>
>>>> I'm doing educational work on git based on the parable (talks,
>>>> articles, etc..) and i'd like to improve on the real reason
>>>> for a staging area.
>>>>
>>>> My question basically is: why is it really needed for merging?
>>>> I mean, given the fictional git-like system of the parable,
>>>> if I need to merge 2 snapshots i could:
>>>>
>>>> 1) search the commit tree for a base point
> [...]
>>>> 2) compare the diffs between the snapshots and the base point snapshot
>>>> 3) if a conflict happens (change in the same line), just leave
>>>>    something in the working dir to mark the conflict. For example,
>>>>    keeping it simple, the system could reject a new commit until
>>>>    the markers of the conflict are removed from the conflicting file.
>>>>
>>>> Couldn't it just work this way?
>>>
>>> Well, it could; that is how many if not most of other version control
>>> systems work.
>>>
>>>
>>> There are (at least!) three problems with that approach.  First, sometimes
>>> it is not possible to "leave something in the working dir to mark the
>>> conflict".  Take for example case where binary file (e.g. image) was
>>> changed, and textual 3-way diff file-merge algorithm wouldn't work.
>>>
>>> Second, what to do in the case of *tree-level* conflict, for example
>>> rename/rename conflict, where one side renamed file to different
>>> name (moved to different place) than the other side.  There are no
>>> conflict markers for this...
>>>
>>> Third, what about false positives with detecting conflict markers,
>>> i.e. the case where "rejecting new commit until conflict markers are
>>> removed", for example AsciiDoc files can be falsely detected as having
>>> partial conflict markers, and of course test vectors for testing conflict
>>> would have to have conflict markers in them.
>>
>> Ok, it's clear to me that the markers in file approach is just a little
>> bit too simple. Do you see any concrete advantage in the staging area
>> compared to, say, tree conflict metadata in the working dir and maybe
>> a dedicated smart "resolve conflict" command?
>
> First, for such _local_ information working directory isn't the best place.
> What if you accidentally delete this?  It is not and should not be
> committed to repository,so there is no way to undelete it, except redoing
> merge and losing all your progress so far in resolving merge conflicts.
> It is much better to put such information somewhere in administrative
> area[1] of repository.
>
> Second, if we have staging area where we store information about which
> files are tracked, and a bunch of per-file metadata like modification time
> for better performance, why not use it also for storing information about
> merge in progress?
>
> [1]: Name taken from "Version Control by Example" (free e-book) by
>       Eric Sink.
>
>
> There is also a thing very specific to Git, namely that "git add" adds
> a current content of a file to object database of a repository (though
> with modern git there is also "git add --intent-to-add" which works
> like add-ing file in other version control systems)... and you have to
> store reference to newly created object somewhere so that it doesn't get
> garbage-collected.
>
>>>> Can you mention other situations in which the pattern "files to be added"
>>>> is either mandatory or really helpful?
>>>
>>> Note that any version control system must have a kind of proto-staging
>>> area to know which files are to be added in next commit.
>>>
>>> If you do
>>>
>>>   $ scm add file.c
>>>
>>> then version control system must save somewhere that 'file.c' is to be
>>> tracked (to be added in next commit).
>>
>> Yes, the fictional vcs just tracked all the files in the working dir.
>> Being selective on which file to track is of course another interesting
>> feature.
>
> IRL it is a _necessary_ feature.  One of more common, if not most common
> application of version control system is to manage source files for a
> computer program.  And there you have object files, executables and other
> _generated_ files which shouldn't be put in version control, not to
> mention backups created by your editor / IDE (e.g. "*~" files in Unix
> world, "*.bak" files in MS Windows world).
>
> Not to mention files which you have added to working directory, but are
> not ready to be added to new commit.
>
In the google tech talk "Contributing to Git": 
http://www.youtube.com/watch?v=j45cs5_nY2k , at the 44:00 min mark the 
index is discussed.  It notes that many scm's have an "index" but hide 
it from you.  Some of the advantages of git giving you access to the 
index are also discussed.

v/r,
neal
