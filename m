From: David <wizzardx@gmail.com>
Subject: Re: avoiding committing personal cruft
Date: Sun, 22 Jun 2008 09:58:13 +0200
Message-ID: <18c1e6480806220058u72b1cbc5x9ec737c724258608@mail.gmail.com>
References: <e5e204700806210620m35fce27eh8eddaf7cb68f1986@mail.gmail.com>
	 <18c1e6480806210853k72274173gaaeb11dd7991c8ed@mail.gmail.com>
	 <e5e204700806211901v17a0450fw56b9db1c8c578dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "James Sadler" <freshtonic@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 22 09:59:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAKTe-0002Uh-5a
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 09:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbYFVH6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 03:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbYFVH6P
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 03:58:15 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:18886 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbYFVH6O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 03:58:14 -0400
Received: by rv-out-0506.google.com with SMTP id k40so6423311rvb.1
        for <git@vger.kernel.org>; Sun, 22 Jun 2008 00:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=cH+I8V0cWSnbFCIwNYREcncawnSIWtszBcb4SdBQ16g=;
        b=uQ5LU9C/j9XxbYLx9ZQCaqgBFt+YlZIL+tIOGBID6/pe2heFnT8Ei2Ua2eq4qHaw8e
         dimdcyTNkkk4PDMfuSqP3Ro4WGB9QXLPSCSW7p+Orlw2BJcBtw/z0Rck95e+rSyRwcCq
         vEPZbePd0JtTiII+vZZ+cAFqiBfxsEoP3Ibko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=hG1IoIhT/h2vnA3veV1cISYlpcDH762cWt4bOKk5uhu7Tne0mKEnypk6+0zNSgnNYu
         IvYervFQIwuinMdxnOQRpnz8N21NYqcp3sF/m8ql8PrsUwTcJdesItGqsESPePary3ON
         pov8ABdb46VlKfjlGqJeM4WBMk1pfstMQ7vxo=
Received: by 10.141.190.9 with SMTP id s9mr10502377rvp.110.1214121493755;
        Sun, 22 Jun 2008 00:58:13 -0700 (PDT)
Received: by 10.140.132.18 with HTTP; Sun, 22 Jun 2008 00:58:13 -0700 (PDT)
In-Reply-To: <e5e204700806211901v17a0450fw56b9db1c8c578dd@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85752>

Re-cc-ing the list, I assume you didn't intend to mail me off-list.

On Sun, Jun 22, 2008 at 4:01 AM, James Sadler <freshtonic@gmail.com> wrote:
> 2008/6/22 David <wizzardx@gmail.com>:
>> On Sat, Jun 21, 2008 at 3:20 PM, James Sadler <freshtonic@gmail.com> wrote:
>>>
>>> The ide-branch has nothing in it except the cruft from the IDE and the
>>> paths leading up to that cruft.
>>> The master branch has a .gitignore that ignores the IDE files so I
>>> won't end up polluting master by accident.
>>>
>>> It's a manageable solution for now.  I tend to think of it
>>> conceptually as 'layering' two branches: I want the
>>> content of both present in the working tree.
>>>
>>> I was just wondering if anyone else has tried something similar.
>>>
>>
>> Sounds like a normal use of topic branches. Branches rebased against
>> master, where you you keep changes you don't want to go into the main
>> branch at this time.
>
> Just to clarify, are you saying that the topic branch would contain
> all of master + ide cruft?
> I was maintaining a branch that *only* contained my ide cruft.
>

More correctly, the topic branch would contain the changes to the
master branch required to add your personal cruft.

Here is one relatively simple way to do it (there are other ways, this
one works well for me when I have local cruft I want for local dev but
don't want in public repos):

Assuming you have these 2 branches:

master - clean & version, ready to be used by others)

james_updates - your own private cruft. work in progress, ide files,
etc, on top of the master branch. Not ready for others yet.

Do all your hacking, private commits, cruft updates, etc in the
james_updates branch. Also try to keep changes in separate commits (1
for cruft & personal files, 1 for feature change X, one for bugfix Y,
etc).

Later, when you are ready to move (some of the) changes over to the
master branch:

1) Make a temporary copy of the james_updates branch:

git checkout james_updates
git checkout -b james_updates_tmp

2) Interactively rebase the temporary branch over to master:

git rebase -i master

During the interactive rebase, you strip out the cruft commits,
reorder updates, etc, as necessary

3) After the rebase, test the new version. Make sure it compiles and
the new features work correctly. Run any automated tests.

4) Merge the temporary branch into master, and drop the temporary branch:

git checkout master
git merge james_updates_tmp
git branch -d james_updates_tmp

5) Rebase your (original) updates branch onto the updated master:

git checkout james_updates
git rebase master

Now you have a james_updates branch on top of master which only has
your cruft etc which you didn't merge earlier. The already-merged
commits are automatically removed from james_updates during the
rebase.

David.
