From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: Any way to "flatten" a series of changes in git
Date: Fri, 23 Oct 2009 06:36:10 +0100
Message-ID: <26ae428a0910222236l58bc64b7l12c4cff09b086dac@mail.gmail.com>
References: <26ae428a0910221303n493fb7s701269d694110685@mail.gmail.com>
	 <m3hbtrdu1r.fsf@localhost.localdomain>
	 <26ae428a0910221411l73aa7cbak5c060925ccdf4cea@mail.gmail.com>
	 <200910222357.15189.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 07:36:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1Cp3-0001aC-Fs
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 07:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbZJWFgJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Oct 2009 01:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbZJWFgI
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 01:36:08 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:56845 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbZJWFgH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Oct 2009 01:36:07 -0400
Received: by ewy4 with SMTP id 4so1317889ewy.37
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 22:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=29ilJbQyLOkRmX5VTsj+6X5mSzmwrVRxmHp6jttlISU=;
        b=jkOhOcNSEIXe7pL9x7By1o1ee9icP0HfOqaEdRm1WnA9Fqzz4d1NQyT39xe/GJB2Dh
         TkrueAdks/aRcd0p9LOvskH7YK/55liFfA6XXGwdwhwZKMk0kxxwlujAKvS1ctwPrRFZ
         /AoISgtccLbK/CjtSTjltMk6c1XULVf7xxqZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=ZNX1gF0eiEa3Qy3ex+xC7sVzZsHYDtqBivdu79c776mTh6LMTqq4yNM8zrlCOxr9KT
         z28wj4bcyrT58zI7lzSsrTTEWiOZuuhY4spenA0h/11KBYAb3xnqSlbCNNyEbbPIuaoc
         69KBkAhoIxSXKfwPvlJby4lm/H05UWU6P7/sQ=
Received: by 10.216.91.13 with SMTP id g13mr3632770wef.36.1256276170480; Thu, 
	22 Oct 2009 22:36:10 -0700 (PDT)
In-Reply-To: <200910222357.15189.jnareb@gmail.com>
X-Google-Sender-Auth: eeaff83986dc83df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131086>

2009/10/22 Jakub Narebski <jnareb@gmail.com>:
> On Thu, 22 Oct 2009, Howard Miller wrote:
>
>> > You can use either "git merge --squash" or "git rebase --interacti=
ve"
>> > (changing 'pick' to 'squash').
>> >
>>
>> Actually thinking some more.... I don't understand something about
>> this. I don't actually want to merge or rebase with anything. I just
>> want to say "make those commits a series of commits on a branch into
>> just one commit with a new message". I seriously suspect I'm missing
>> the point somewhere but what has that got to do with merging or
>> rebasing?
>
> Actually using "git merge --squash" is a bit different from using
> "git rebase --interactive".
>
>
> 1. "git merge --squash"
>
> From documentation:
>
> =A0--squash::
> =A0 =A0 =A0 =A0Produce the working tree and index state as if a real
> =A0 =A0 =A0 =A0merge happened (except for the merge information),
> =A0 =A0 =A0 =A0but do not actually make a commit or
> =A0 =A0 =A0 =A0move the `HEAD`, nor record `$GIT_DIR/MERGE_HEAD` to
> =A0 =A0 =A0 =A0cause the next `git commit` command to create a merge
> =A0 =A0 =A0 =A0commit. =A0This allows you to create a single commit o=
n
> =A0 =A0 =A0 =A0top of the current branch whose effect is the same as
> =A0 =A0 =A0 =A0merging another branch (or more in case of an octopus)=
=2E
>
> This means for example if you did your changes on a separate
> topic branch, and you want to merge your changes into 'master'
> branch, you would do
>
> =A0$ git checkout master
> =A0$ git merge side-branch
>
> which would result in the following history:
>
>
> =A0 ---*---*---*---*---*---*---*---M =A0 =A0 =A0 =A0 <-- master
> =A0 =A0 =A0 \ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /
> =A0 =A0 =A0 =A0\-.---.---.---.---.---.-/ =A0 =A0 =A0 =A0 =A0 <-- side=
-branch
>
>
> If you used '--squash' option to git-merge, because changes were
> made in throwaway topic branch, and as you said only final result
> matter, you would get:
>
> =A0$ git checkout master
> =A0$ git merge --squash side-branch
>
> =A0 ---*---*---*---*---*---*---*---M' =A0 =A0 =A0 =A0<-- master
> =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0\-.---.---.---.---.---. =A0 =A0 =A0 =A0 =A0 =A0 <-- si=
de-branch
>
>
> where commit M' has the same contents (the same tree) as commit M
> in previous example, but is not a merge commit.
>
> If you simply want to squash last say 5 commits into one, you can
> use "git merge --squash" for it in the following way:
>
> =A0$ git reset --hard HEAD~5
> =A0$ git merge --squash --no-ff HEAD@{1}
>
> which means basically: rewind to state 5 commits back, then merge
> in changes from before rewind, squashing them. =A0The --no-ff is need=
ed
> because otherwise it would be fast-forward and no commit would be
> created.
>
>
> 2. "git rebase --interactive"
>
> The interactive rebase is meant to edit commits being rebased, but
> it can be used simply to edit commits. =A0It includes 'squash' comman=
d
> that can be used to concatenate (squash) commits.
>
> So to squash last say 5 commits into one, you would use
>
> =A0$ git rebase --interactive HEAD~5
>
> then edit provided list of commands and commits to read something lik=
e
> this:
>
> =A0 pick deadbee The oneline of this commit
> =A0 squash fa1afe1 The oneline of the next commit
> =A0 ...
> =A0 squash beedead The oneline of the that commit
>
> i.e. replace 'pick' command by 'squash' command.
>
> This is a very powerfull command, and can be used for example to turn
> series of say 5 commits into series of say 2 commits; not simply squa=
shing
> to a single commit, but reducing number of commits (and presumably
> cleaning up those commits).
>
>
> HTH (hope that helps)
> --
> Jakub Narebski
> Poland
>

Hi Jakub,

Yes it helps a lot. What I *don't* care about (or want to do) is
actually do a merge or a rebase I just want to change history. Well,
that's what I thought I wanted. What I suppose I really want is the
full history for *me* and a second branch with the 'reduced' history
to push to my client.  I suppose that's different yet again?

Howard
