From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: AW: [EGIT] [PATCH RFC v1 5/5] Use the ignore patterns cache to
 determine ignores
Date: Sat, 02 May 2009 14:44:10 +0200
Message-ID: <49FC401A.1030701@pelagic.nl>
References: <947431.4782.qm@web27806.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Mark Struberg <struberg@yahoo.de>
X-From: git-owner@vger.kernel.org Sat May 02 14:44:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0EaF-0003UY-1e
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 14:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006AbZEBMoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2009 08:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752593AbZEBMoO
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 08:44:14 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:34982 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751776AbZEBMoN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 May 2009 08:44:13 -0400
Received: from [192.168.0.50] (Paul.internal.Hupie.com [192.168.0.50])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 30E2758BD9F;
	Sat,  2 May 2009 14:44:11 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <947431.4782.qm@web27806.mail.ukl.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118133>

Mark Struberg wrote:
> Ferry,
> 
> I was just quickly hacking a rudimentary IgnoreRules class in jgit-core
> [1] mainly for the purpose of not forgetting about handling ignores
> finally ;)
> 

I think there is no need to do that, I have that in my code already 
(although in a different form). My implementation reflects what C git does.

> I now saw you worked on introducing gitignore to EGIT, but wasn't able
> to find any repo with your code but only a few old patches.
> 

it's in my local repo. I have no public repo

> Do you see a way we can move your work into jgit-core? I've seen you
> have a lot of Eclipse specific stuff in your code, so we'd obviously
> have to cut those things in slices.

I've been asking Shawn about input a few times but did not receive any 
yet. he wants it moved into a treewalk but I'm way too unfamiliar with 
that code to do it properly (and easily)

the reason that I have a lot of eclipse specific stuff in there is because 
I just started implementing the handling in the egit plugin since that was 
the easiest point to plug it into.

I have been thinking a lot about getting rid of the eclipse specific stuff 
and I think that's not hard. it requires a bit of reworking of the code 
but what I have in mind is actually a lot cleaner that what I sent out 
earlier.

> 
> One possible strategy would be to make the IgnoreRules stuff in
> jgit-core contain only the 'readonly' evaluation code, thus no

that would be easy

> addIgnore(File) and addIgnore(String rule). Eclipse (or others, e.g.
> editor) could then manipulate the .gitignore files, and all the other
> ignore options and afterwards tells the IgnoreRules to re-initialise.

I think it would be easier to let eclipse manipulate the ignore file and 
then just re-read it into the 'ignore cache'

> 
> A second thing: Not looked at your code close enough, but I noticed
> that quite a few Eclipse plugins look at the subclipse when it comes to
> ignore handling, and try to 'hide' the ignore files from the user. I
> personally don't like that because the propset based ignore handling is
> a highly SVN specific thing. I prefer the way it's handled with the CVS
> plugin: show the .gitignore files to the user and even let him edit
> those files with an editor. As soon as we detect a change (even after a
> refresh if someone edited it with vi), we simply re-init our
> IgnoreRules.
> 1
> WDYT?

see remark above. exactly what I had in mind. git does ignore handling 
like cvs.

> 
> Btw: Do you have a github account already? We could create an 'ignore'
> branch and I'm sure Jason can give you push rights to it.
> 

no account yet.
would be nice to work on this with other people.

Ferry
