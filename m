From: Miguel Ramos <mail@miguel.ramos.name>
Subject: Re: Using a git repository on the root directory
Date: Sat, 17 Apr 2010 12:15:55 +0100
Message-ID: <t2g3e2876431004170415r71d5f834z3bfdedfaec076c6c@mail.gmail.com>
References: <q2k3e2876431004161344vfff638a7ncfa74aa0e3b979dc@mail.gmail.com>
	 <4BC9364D.7020204@gmail.com>
	 <alpine.DEB.2.01.1004162120490.16996@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Gabriel Filion <lelutin@gmail.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sat Apr 17 13:16:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O360K-0002uX-Dx
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 13:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708Ab0DQLP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 07:15:58 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:28524 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485Ab0DQLP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 07:15:56 -0400
Received: by qw-out-2122.google.com with SMTP id 5so155041qwd.37
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 04:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:received:message-id:subject
         :from:to:cc:content-type;
        bh=JKi3NR12/kqLRVQPHajNr/XQ7Lr38YABbYbfUnDnLe0=;
        b=k0bb8ujSdE0z1PXELLkTUm6Em+DyJwjI9qy5Q1Eid+IKTNV4SzQJ1gPIdzCZkb8QdA
         eDT6gs30o5tFi9pwrlO6A1k7eN/LCAS65LdK87YFpcTZW+wDUNJe4yNU4enk6IL7i55a
         nGOewKiRLgdx6X0fu/9b4Mr9epdSXIKlzGU+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=jo7dBgAI8XYNBUFFnRpEmvh4X8R2LD0ojHOZt+F7XKYEN9C9SzuGZdmuahTQ8yPjhu
         xrCf3CAJ1D2TqAYaRn8bzSPGHAAd8ynoPl7pPxk+7x5jh11Tuxy4n/lA6gSpTHEA0bcM
         ACCuPR6c4tojcCQu+GGqy7wr+kvIZuKsC3LqM=
Received: by 10.229.90.199 with HTTP; Sat, 17 Apr 2010 04:15:55 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.01.1004162120490.16996@asgard.lang.hm>
X-Google-Sender-Auth: 2230e6bbea15ef5a
Received: by 10.229.241.76 with SMTP id ld12mr3587409qcb.92.1271502955629; 
	Sat, 17 Apr 2010 04:15:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145135>

2010/4/17  <david@lang.hm>:
> On Sat, 17 Apr 2010, Gabriel Filion wrote:
>
>> On 2010-04-16 16:44, Miguel Ramos wrote:
>>>
>>> Hi,
>>>
>>> Is it possible with git to use a git repository on the root directory?
>>> I'm trying to replace subversion doing this.
>>> I used this method before to get my home directory versioned with
>>> success, so far.
>>>
>>
>> Although I'll give comments on the rest, is it really relvant to put all
>> of the filesystem into a version control system? From a system
>> administrator's point of view, backing up is more about keeping copies
>> of what's important in the computer than about versioning every tiny
>> change in the file system.
>
> every tiny change in the filesystem could be important. it takes a lot of
> time to examine every package your distro creates to be sure that you know
> what files in it are important and what ones aren't.
>
> In addition, if you need the ability to recreate a system later (potentially
> years later, after the distro mirrors have stopped carrying that version),
> even the binaries can be important.

No, but that's not my intention, I should have explained myself better.

What I mean, and what I've been doing with svn, is to keep versioned
copies of configuration files only; files in general would never be
added to the repository.
That's why a VCS would be (and svn has been) useful.

Can you see how useful it is, now?
You can have the same configuration files on several machines, you can
have different branches for machines which are configured differently,
merge in changes done on different branches.
Really, it's great, I've been using svn for this, and I'd never want to go back.
I can install an OS on a machine and get everything up and running very quickly.

The only thing is that not all configuration files are in /etc, some
are in /usr/src/linux, some in /boot, /var, etc, that's why the root
of the repository is root and not something else.
Also, although I could have different repositories for each of these
subtrees, because I use FreeBSD and linux, some files in one are in
/etc and in the other in /usr/local/etc, etc. That's why the root of
the repository is root.

Using a VCS almost totally fits this use case.
Configuration files are text, most often only one or two lines change,
I want to see diffs often, branching and merging is very important.
Moreover, using a centralized VCS is very artificial, and is only good
to centralize backups.
It only fits less well because git was thought out in a model where
every file in the repository directory should either belong to the
repository or be some kind of trash put in gitignore; this is not the
case here.

>> One example of something that is weird to backup is /var . It contains
>> data that will almost certainly always change.

That's not weird to backup, that's the data you typically want to
backup frequently: data that keeps changing.
Not /var/run or /var/cache, which are trash after a crash, of course.
Why backup /usr, for instance, which you can recover by re-installing
applications?

But my use case isn't backups.

> that's what .gitignore is for
>
>> A simpler thing to do if you'd like to be able to reinstall a computer
>> real quick would be to make an image of the computer (call it a ghost, a
>> dd of all the disk or whatever) and to establish a backup only for the
>> sensible data (say, for an LDAP server, you would backup ldap's ldiff
>> files and configuration). Then, restoring from a crash would just mean
>> to reinstall with the image of the disk and to restore the latest backup.
>
> if you do this you run the risk of missing some critical file from your
> backup
>
> your approach is 'back up only what I know I need to', using git and
> .gitignore it becomes 'back up everything except what I know I don't want
> to' (and there is a surprising amount of stuff in /var that you may need to
> backup)
>
> if you have one very standard image then you may have a really good image to
> use, but if you want more variety in your systems the git approach gives you
> automatic deduplication of your backed up data, as well as very efficient
> delta compression between similar files on different systems.
>
> the ease in maintaining replicas of the data is just another bonus.
>
> it may not suit your environment, but there are some very attractive
> features here. Compare this to any backup software and (except for git not
> storing permissions) you will find that the feature sets look very similar.
> After all, in both cases you are archiving data so that you can go back in
> history as needed so it's substantially the same problem
>
> David Lang

Well, David, you certainly made a good case defending using a VCS for
filesystems.
However, a versioned filesystem should be more adequate for that.
Why would one want diffs, patches, branches, merges for the entire filesystem?
If only there was one in general use...
FreeBSD had one, LFS, but they set it aside, I think it was buggy.

>>> When I'm on the root directory, things seem to work minimally. I do
>>> git status, etc, and get the expected results.
>>> However, if I change say to /etc, or any other directory, for that
>>> matter, then git status tells me that every file in the repository is
>>> deleted.
>>> Adding files doesn't work, nothing works at all.
>>>
>>
>> This sounds like an issue with finding the actual .git directory when
>> you are in /etc. is this directory under a different partition than / ?

No, it's not. And it happens on every other directory other than root.
It looks like it finds the .git directory, but then has problems
finding the actual files.
It's not a cross filesystem problem.

>>> I have a populated repository elsewhere, I can clone this to an empty
>>> directory and then move .git to / to work around the demand that the
>>> target directory is empty and at the same time avoid overwriting
>>> files.
>>
>> so, you're cloning to some temp dir, then moving temp/.git to / and then
>> using something like git checkout HEAD some/file/somewhere ?

Yes, that's it.
That "technique" is working for me now for the home directory repository.

With svn, I used to do a svn checkout --force, that would not complain
about existing directories and files (which were overwritten, and that
was exactly what I needed).

>>> I know this is an unforeseen use of git, however, unforeseen might not
>>> imply forbidden.
>>> I'm pretty disappointed I couldn't get it working.
>>>
>>> So the motivation for this posting is twofold:
>>> - Is this possible in some other way, or did I do something wrong (I'm
>>> new to git) ?
>>
>> Check out the bup project[1], it uses the packfile format from git to
>> compress data but its focus is more on keeping versions of arbitrary
>> data rather than code files. it's still very new and lacks some
>> important features but it sure is promising.
>>
>> [1] : http://github.com/apenwarr/bup

Hmmm...
thanks but I need diffs, branches and merges.

-- 
Miguel Ramos <mail@miguel.ramos.name>
PGP A006A14C
