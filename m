From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Newbie question about setting up git repository from svn (git
 svn)
Date: Sun, 06 Mar 2011 20:23:37 -0600
Message-ID: <4D7441A9.7090505@gmail.com>
References: <AANLkTi=UG4oq4QHhKoDOi9+4bhF1TDy4Z26ORj9Bdcwc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Hillel (Sabba) Markowitz" <sabbahillel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 07 03:23:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwQ6t-0001b7-6b
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 03:23:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754849Ab1CGCXm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Mar 2011 21:23:42 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35505 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753547Ab1CGCXl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 21:23:41 -0500
Received: by yxs7 with SMTP id 7so1454747yxs.19
        for <git@vger.kernel.org>; Sun, 06 Mar 2011 18:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version
         :newsgroups:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=EDrymDv8DQlNgJm4GcdSf08CiOQmIQA4P5FKz9C+Fw8=;
        b=WzD9kPP0gZAoViWfuIRwFwbD+oorV6E/qYdejzAU1nZR+t2t82ly0x1zgzenNqoECk
         pL7aMcohWx5mI61G61fptui/36xJ7BwvbRNFDIuNFUQHTOqrXG5buHa/bFRtOasTa0I0
         z3F/0sYl0DLQOzA8nN9zx749lS5r85i13Sz/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=x5ebuqTfU4UdZlpKghAev+I5ZS4Es3ziXZjOSBDYRyFETVYB0y94CofPJWtx8ud13d
         o/alkvFfp/WAA5bvliLWIQNFOcOFfXvib5nyNCJStGvc8hpvOaHiisYfecggYpNwH0Ka
         HMTe0q1vRjYl0sImN4rr0G+dqGKEuJ5Bq5UcA=
Received: by 10.150.237.11 with SMTP id k11mr3765602ybh.315.1299464621067;
        Sun, 06 Mar 2011 18:23:41 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id 7sm1403162yhl.45.2011.03.06.18.23.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Mar 2011 18:23:40 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.14) Gecko/20110221 Thunderbird/3.1.8
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <AANLkTi=UG4oq4QHhKoDOi9+4bhF1TDy4Z26ORj9Bdcwc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168564>

On 3/4/2011 9:57 AM, Hillel (Sabba) Markowitz wrote:
> Please respond directly to sabbahillel@gmail.com as I do not have tim=
e
> to follow this mailing list.
>
It is standard practice on this newsgroup to reply to the sender and cc=
=20
the original cclist along with the newgroup.  Following this newsgroup=20
can be challenging when your schedule is busy, but you can learn alot o=
f=20
really cool stuff by perusing it regularly.  I try to keep up daily but=
=20
alas I am a few days behind.

> I am attempting to set up a git repository based on an svn repository=
=2E
> The idea would be that the members of the project would be able to us=
e
> git exclusively with the central git repository acting as the
> coordinator. This git server would be the only one capable of issuing
> the git svn dcommit and git svn rebase and the members of the project
> would not have to worry about it. Eventually, the subversion
> repository would be transferred to git.
>
I have no experience with git-svn (the svn part, that is), but your pla=
n=20
sounds good to me.  Read on to see my comments on the parts I do have=20
experience with...

> I created a separate Ubuntu VM in order to set up the git repository.
> I used "git svn clone -s" to set up MyProject.git on "gitserver"
>
> The command "git branch -a" shows
> * master
>    remotes/branch1
>    remotes/branch2
>    remotes/trunk
>
>
> I then went to my main VM and used ssh to clone the repository
>
> git clone gitserver:/opt/git/MyProject
> cd MyProject
> git branch -a
> * master
>    remotes/origin/HEAD ->  origin/master
>    remotes/origin/master
>
> How do I check out the trunk or appropriate branches from the remote?
> I am probably misreading the documentation. Would it be
>
> git checkout -b branch1
>
"git checkout -b branch1" will create a new branch called branch1 based=
=20
on whatever your current HEAD is.  HEAD is the commit that you are=20
currently pointing to, ie. the tip of the branch currently checkout out=
=2E=20
  (see git checkout manpage.)  By "trunk" i take it you mean the=20
"master" branch, e.g. "git checkout master".  The asterisk indicates=20
above that you are currently on master which is the "trunk" (assuming w=
e=20
have the same definition of "trunk").  Therefore, "git checkout -b=20
branch1" will create a new branch called "branch1" that has the same=20
history as master.  It sounds like you want to checkout "branch1",=20
"branch2", and "trunk".  Read on...

> does the master on the remote (and here) actually point to the trunk =
by default?
> should I checkout the branches on "gitserver"?
>
not being familiar with git-svn, but familiar with "git", I would advis=
e=20
you to do the following:
(1) on "gitserver" perform:
(a) git branch branch1 remotes/branch1 (this will create a branch calle=
d=20
branch1 that tracks remotes/branch1)
(b) git branch branch2 remotes/branch2
(c) git branch trunk remotes/trunk
Now you have the branches master, branch1, branch2, and trunk on=20
"gitserver".
(2) I don't know how to push from a git repo to an svn repo so I can't=20
tell you if gitserver master points to svn trunk or not.  However, read=
=20
on for what I do know...

> I also do not see how I can get the list of branches from the remote
> location.without having to do an ssh into the gitserver, cd to the
> repository directory, and use a 'branch -a' there. Is there a way to
> ask for this information? I have not yet been successful in setting u=
p
> gitosis yet because this is on an internal company intranet and I do
> not have a valid machine name for my accounts as everything is being
> done on VMs. Thus, my public key ends with
> "sabbahillel@desktop-ubuntu" rather than an actual machine name or
> address.
>
The way you get the list is by doing a git-fetch on MyProject (AFTER yo=
u=20
create the branches on gitserver).  This will create remote tracking=20
branches for all the branches on gitserver.  Notice I said "branches on=
=20
gitserver" and not "remote tracking branches on gitserver".  You can't=20
track the remote tracking branches of your remote (at least not sanely)=
=2E=20
  Thats why you had to create tracking branches on gitserver that track=
=20
the remote tracking branches that track the svn repo.  Now that you hav=
e=20
branches "branch1", "branch2", and "trunk" on gitserver you can track=20
them in MyProject.  git-fetch will create remotes/origin/branch1,=20
remotes/origin/branch2, remotes/origin/trunk in MyProject.  Now you can=
=20
do "git branch branch1 remotes/origin/branch1" to create the branch1=20
branch in MyProject.  "git checkout branch1" in MyRepo will check it=20
out.  Repeat for branch2 and trunk.  (I'm not familiar with ssh details=
,=20
but I assume your last ssh comment is made into a non-issue by what I=20
just stated above.)

> Would you have a pointer to a HOW-TO that discusses this.
>
I assume these links:

http://git-scm.com/course/svn.html

https://git.wiki.kernel.org/index.php/GitSvnCrashCourse

https://git.wiki.kernel.org/index.php/GitSvnSwitch

https://git.wiki.kernel.org/index.php/SvnMigration

http://utsl.gen.nz/talks/git-svn/intro.html

http://www.tfnico.com/presentations/git-and-subversion

or the git-svn manpage:

http://www.kernel.org/pub/software/scm/git/docs/v1.7.1.4/git-svn.html

will help you. (you need to use the git version of the manual that=20
corresponds to your installation.  1.7.1.4 is relevant to me, but=20
perhaps not to you.)

> Thanks for any help that you can give me.
>
> --
>         Sabba     -          =D7=A1=D7=91=D7=90 =D7=94=D7=9C=D7=9C   =
     -     Hillel
> Hillel (Sabba) Markowitz | Said the fox to the fish, "Join me ashore"
>   SabbaHillel@gmail.com | The fish are the Jews, Torah is our water
> http://sabbahillel.blogspot.com

Despite my ignorance regarding svn and git-svn, I hope my comments will=
=20
be of some help to you or point you in the right direction.

v/r,
Neal
