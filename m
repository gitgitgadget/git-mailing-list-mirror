From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: Project organisation and structure
Date: Thu, 18 Sep 2008 10:30:05 +0300
Message-ID: <48D2037D.5040301@panasas.com>
References: <bcf9fe2c0809170649x3f377c7erecc9f69a4a664d52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: k wayne <pleexed@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 09:34:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgDz2-00089c-3b
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 09:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbYIRHaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 03:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbYIRHaO
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 03:30:14 -0400
Received: from ik-out-1112.google.com ([66.249.90.182]:58323 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbYIRHaM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 03:30:12 -0400
Received: by ik-out-1112.google.com with SMTP id c30so3198678ika.5
        for <git@vger.kernel.org>; Thu, 18 Sep 2008 00:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=7j00GXXipzKCKsYDfy5Vjq7FNTrJseaWRUKcZJL8r2c=;
        b=mVYkKqChBuXta0GkoZsEF8hmG3+uyEDXB2V5sNygYAm0DWJ+j3LjGpJdbug9fTxeq4
         I43N8+9ihPz5Xdb8yYcseiaUp3QJ3CF84LTOCOkPrFu1ZHLhjkettkO5yxpK29ll7FbO
         icFdGisfXhjfe8krBfVx1eMwYdpNnak+7NG+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=TFpL+pzpXHbOaypOfzreBkxekLapJwSWrqEoIM6zWZ8Py3gO2JzcFqqEmzgILeLnEb
         hieKUeXlM7fUySvISB2MegBRNJwf3Wtd1T4oJSaCRHm9f6lo4txBdz+2WkU77Mr1yDt5
         ws0t2xFh1V9raBt8II8LbBA10/Qr9xpqrhX+8=
Received: by 10.210.142.10 with SMTP id p10mr4469153ebd.164.1221723010199;
        Thu, 18 Sep 2008 00:30:10 -0700 (PDT)
Received: from bh-buildlin2.bhalevy.com ( [212.235.53.3])
        by mx.google.com with ESMTPS id 5sm24872805eyh.2.2008.09.18.00.30.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Sep 2008 00:30:09 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <bcf9fe2c0809170649x3f377c7erecc9f69a4a664d52@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96177>

k wayne wrote:
> Hello,
> I'm new to git, and I hope this is the right mailinglist for what I'm
> going to ask; it was the only one I found on http://git.or.cz. Sorry
> if it's not or my question is remarkably stupid. I've read the git
> documentation, of course, but it wasn't always easy to wrap my head
> around all the concepts, so I might have missed an obvious solution to
> my problem.
> 
> Currently, I've got a tree of self-written C++ source code for which I
> don't use any SCM, and I'd like to start using git on it. However,
> I've run into issues with my directory layout I cannot resolve on my
> own.
> I have a collection of libraries and programs, which aren't coupled
> too much, but aren't really independent either; for example, library X
> depends on Y, program Z on lib A and so forth. Since all of these libs
> and programs are logically connected to each other in some way, I
> would like to have them all in one central repository.
> So I heard that I could create kind of a "meta-repository" for the
> whole project, and have submodules for each library or program, which
> sounds exactly like what I want. However, I've been told that my
> current directory layout will not work this way with git.
> 
> This is how my project root directory (say it's ~) looks like:
> ~/build - Build files which apply for the whole project, like doxygen
> build files.
> ~/include/$submodule - Each library/program has an own directory here,
> in which all header files go.
> ~/projects/$submodule - Files related to an individual project, like
> makefiles etc.
> ~/src/$submodule - Like the above two, but for source files.
> ~/test/$submodule - Again, a directory for each library/program,
> containing files for (unit)tests.
> ~/doc - Documentation files for the project as a whole.
> ~/doc/$submodule - Documentation files for individual libraries/programs.
> 
> These are the directories I would like git to track for me. There are
> some other dirs not listed here (e.g. for object files,) but I can
> easily add them to .gitignore.
> 
> So, the git structure as I imagine it would look like this: ~/.git
> contains the "meta-repository," in which all the submodules reside.
> Each submodule would have its .git directory in ~/projects/$submodule.
> Alternatively, ~/.git for the meta-repo and ~/.git-$subproject or
> something like this would be okay too.
> 
> However, I have been told I cannot go to ~/projects/$submodule and do
> a "git add ../../{include,src,test,doc}/$submodule" there. I could add
> symlinks in ~/projects/$submodule to each of these dirs and add that
> link, but this would not work with windows, I guess (would it work
> with git, anyway?)
> 
> So, how can I manage my code without having to restructure my tree?
> 
> I'd like to keep it that way, because it is convenient to have only
> one directory to pass to the compiler as an additional include dir,
> and can include my header files as "submodule/someheader.hpp" which
> is, in my opinion, helpful in organizing the code.
> 
> If there should be no way I can keep my directory setup the way it is
> with the current git, would a feature request be a good idea (and
> possibly implemented), or does my directory tree have a serious flaw I
> haven't stumbled across yet, which makes it unusable anyways?
> 
> Thank you in advance.
> --

Your directory structure is common and intuitive in the sense that thats
what happens, you start coding then add stuff along the way. You don't
know from the start what will the tree look like.

Git is well suited for your tree and will eat it with out solt

Do not use subprojects these are used with two separately developed
projects that are dependent (one on the other not two ways).
For example I have a GUI app that uses wxWidgets. Instead of instructing
my users on where to get it and what exact version to use, with what 
version of my program, I mirror it in a submodule and this is all done
automatically for me and my cloners.

What you need is topic branches. Not all branches need have all the
same files. In fact they can have nothing in common. The only thing
with git is that at a certain checkout in time only these files will
be present on disk.

So lets say you have:

/include/lib4foobar
/include/lib4bar
/src/lib4foobar
/src/lib4bar
/src/foo
/src/bar

Lets complicate it and say lib4bar is also dependent on lib4foobar
then you have these branches: lib4foobar lib4bar foo bar

When you work on a library/app you take your foo-maintainer hat and
push patches to your subtree branch. When it is time for integration,
checkout master and merge all the branches in.

Simple as hell. And faster then you ever imagine.

Additionally you can have working branches that, lets say
did-of-the-day, where you save work to 3 topics /src/bar
/src/lib4bar /src/lib4foobar. Once you are happy. You can
push them through the project branches, and delete the
working branch, or you can merge that directly into master
and when you pull master into the topic branches after a big
merge, they will have it automatically.

This is all very similar to Linux. With the subject maintainers
and all, just with fewer people.

PS: Don't forget to have a very first patch with nothing but
a common root file like GPLv2 or README. The first patch is
hard to work with.

Just my $0.017
Boaz
