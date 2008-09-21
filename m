From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: ignoring files/directories in git
Date: Sun, 21 Sep 2008 19:20:48 +0200
Message-ID: <20080921172048.GA3877@blimp.localhost>
References: <19596152.post@talk.nabble.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: mwolfe38 <mwolfe38@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 19:56:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhpeZ-0002gY-Ce
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 19:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbYIVRzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 13:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbYIVRzd
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 13:55:33 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:22847 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726AbYIVRzc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 13:55:32 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx9CU82oUGi
Received: from tigra.home (Fa8f0.f.strato-dslnet.de [195.4.168.240])
	by post.webmailer.de (mrclete mo14) (RZmta 17.4)
	with ESMTP id d036eek8MHABSe ; Mon, 22 Sep 2008 19:55:28 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.1.28])
	by tigra.home (Postfix) with ESMTP id A9060277CF;
	Sun, 21 Sep 2008 19:20:48 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 7954D36D1D; Sun, 21 Sep 2008 19:20:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <19596152.post@talk.nabble.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96501>

mwolfe38, Sun, Sep 21, 2008 18:54:01 +0200:
> In my project I have several directories I do not want to have git ignore.
> One of them being
> cache/ and the other log/
> I've added them to the .gitignore file which I have in the initial directory
> of the repository
> The contents of my gitignore are:
> 
> .settings
> .cache
> cache/
> log/
> .project
> 
> However, if I do 
> git add .
> It will add the files from cache and log anyways.
> I know git add . will add anything that hasn't been added but shouldn't it
> ignore files in .gitignore?

It should and indeed it does ignore them:

    $ mkdir ggg && cd ggg
    $ git init
    Initialized empty Git repository in /tmp/ggg/.git/
    $ >a
    $ mkdir cache log
    $ touch cache/b
    $ touch log/c
    $ echo cache/ >.gitignore
    $ echo log/ >>.gitignore
    $ cat .gitignore
    cache
    log
    $ git add .
    $ git ls-files
    .gitignore
    a

What is your git version and where have you got it from?
Is your .gitignore written exactly like this (case, some hidden
extension, like they do on Windows)? Any invisible characters in
.gitignore?
