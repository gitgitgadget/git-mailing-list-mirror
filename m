From: Grzegorz Kossakowski <grek@tuffmail.com>
Subject: Re: How to clone git repository with git-svn meta-data included?
Date: Sun, 07 Dec 2008 23:02:37 +0100
Message-ID: <493C47FD.4080302@tuffmail.com>
References: <493A6CEC.4060601@tuffmail.com>	 <eaa105840812070857i27f8e920keaba3f92f5260b38@mail.gmail.com>	 <493C1F36.7050504@tuffmail.com> <eaa105840812071230l5e8d54bcg21b36019711bc3cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 07 23:04:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9RjP-0007kc-Iv
	for gcvg-git-2@gmane.org; Sun, 07 Dec 2008 23:04:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbYLGWCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 17:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751991AbYLGWCl
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 17:02:41 -0500
Received: from mxout-03.mxes.net ([216.86.168.178]:2613 "EHLO
	mxout-03.mxes.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbYLGWCl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 17:02:41 -0500
Received: from [192.168.0.125] (unknown [82.210.157.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.mxes.net (Postfix) with ESMTP id 86A8A23E3FD;
	Sun,  7 Dec 2008 17:02:39 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081112)
In-Reply-To: <eaa105840812071230l5e8d54bcg21b36019711bc3cd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102509>

Peter Harris pisze:
> After the git clone, I do the following:
> git svn init -s svn://repo/sitory
> git svn rebase
> 
> No data is transferred[1], although 'git svn rebase' does spend a
> minute or so reading the commit messages to rebuild its index.

I've tried this method with Cocoon repository
(http://jukka.zitting.name/git/?p=cocoon.git;a=summary) and got this error:

git clone git://jukka.zitting.name/cocoon.git
git svn init -s https://svn.eu.apache.org/repos/asf/cocoon/
git svn rebase
Unable to determine upstream SVN information from working tree history

git --version
git version 1.6.0.2

Any idea what's wrong here?

> This could all be in a common script you distribute to your users.

Good suggestion.

> "git help svn" mentions the rebuild only in passing. I'm not sure if
> it is described in better detail elsewhere.

Ah, I didn't spot this earlier. Thanks.

> If something is in A's tree, it is coming from A. Either A has
> authority, or A has received authority from someone else, or A is
> bringing the legal problem down on himself. When A says "Please Pull"
> (or when A pushes) A is effectively saying "These changes are legally
> mine to give you".
> 
> The Developer's Certificate of Origin 1.0 was designed to address this
> issue; see also "Signed-off-by"
> 
> Of course, if it's a legal issue, make sure you consult your own lawyer.

I see. Thanks for insightful comments.

>>> You could maybe use signed tags ("git help tag")...
>> The question is why Git doesn't sign all commits by default but only tags? Creating tags all the
>> time is rather tedious process and seems to have no sense, right?
> 
> Typing in your GPG passphrase for every single little commit would be
> even more tedious, IMHO.

Yep, that's true.

>> Does it mean that with current Git design it's the best to not use advanced features of Git like
>> tree merging but simply go with posting e-mails with patches instead if contributors cannot be trusted?
> 
> That would be my policy. At the very least, I would have a human
> review the tree before merging it.

Agreed.

> Note that git was designed around a "git am" workflow, so it is very
> efficient at dealing with large numbers of patches at a time.
> 
> Note also that you can do tree merging with an email-patch based
> workflow, since git format-patch preserves parent information,
> although it does take a little bit more work. See also: "git help am"
> under --3way.

Thanks for all your valuable information. As soon as I resolve problem with git svn rebase I'll
start reading on how git am --3way works.

-- 
Best regards,
Grzegorz Kossakowski
