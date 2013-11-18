From: Benjamin Pabst <benjamin.pabst85@gmail.com>
Subject: Re: Fwd: Error with git-svn pushing a rename
Date: Mon, 18 Nov 2013 18:59:49 +0100
Message-ID: <CAM-uYMiSE-XxA7DSWQSwzZ2vwB_MP5gnxuTzEJ7Vw9LRj2nwWA@mail.gmail.com>
References: <CAM-uYMgy8duxdGY8rbCJv9To3FFMAUDv22nnzbQ+e3QrTCLLpQ@mail.gmail.com>
	<CAM-uYMigCTK=j3HkyT0F=jtDoDERdtkpZiTXRvBhSHJW3edJ-w@mail.gmail.com>
	<CAM-uYMiK4wkQyGJLemSAbNwHJNoH-k8Zv0W2yBtnTCbsFLj8Fg@mail.gmail.com>
	<5285CE6C.2030609@futurelab.ch>
	<CAM-uYMgn4SGqurqRG-RDiicLxpf9NfTPUvNn9FaFUUbxFRJsZw@mail.gmail.com>
	<5286235D.9060602@futurelab.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Andreas Stricker <astricker@futurelab.ch>
X-From: git-owner@vger.kernel.org Mon Nov 18 18:59:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViT75-0000tY-CH
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 18:59:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512Ab3KRR7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 12:59:52 -0500
Received: from mail-qa0-f42.google.com ([209.85.216.42]:33496 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab3KRR7u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 12:59:50 -0500
Received: by mail-qa0-f42.google.com with SMTP id k4so153018qaq.1
        for <git@vger.kernel.org>; Mon, 18 Nov 2013 09:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0RGc3wR59yr+xKDk6Ymx2YghvfX0uDwhMDb1W2LLqco=;
        b=qaMwYNdg7szRJR5lnXw7DQO+hzGZSqfe74vTr00nyfZQwzXWhxCcNkxXX8/NnYZJpz
         1ypW74nrKxm9fl450I3qjmry1RXWzXk8XFKfWusXTP8HCo5+qzT60wEUu2dF+m0Qy9Vr
         frM8W/+phJRanCJaKDbByKxAL1sypG6sdtL9GOBQt4pggeKelgOZ2bF+hgwi3oyOAkCg
         HIfhluGenKS/rhJst+dqr5HmdITq8zhK1q+jdn9mm2Yelm5dQyQejzIhUK0SkczRPEqg
         4sepYBAh7nHFgHIN9qfzYyg2bq6zvvc6G7eBIf7eLpgJYyRWBg9WpeBjYufZPCXLfu9+
         2gSA==
X-Received: by 10.229.65.201 with SMTP id k9mr35926984qci.11.1384797589905;
 Mon, 18 Nov 2013 09:59:49 -0800 (PST)
Received: by 10.140.84.104 with HTTP; Mon, 18 Nov 2013 09:59:49 -0800 (PST)
In-Reply-To: <5286235D.9060602@futurelab.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238002>

Hi Andy,

sadly I get the same error with a downgraded svn:

$ git --version
git version 1.8.4.2
$ svn --version
svn, version 1.7.10 (r1485443)
   compiled Nov 18 2013, 18:43:16

Copyright (C) 2013 The Apache Software Foundation.
This software consists of contributions made by many people; see the NOTICE
file for more information.
Subversion is open source software, see http://subversion.apache.org/

The following repository access (RA) modules are available:

* ra_svn : Module for accessing a repository using the svn network protocol.
  - with Cyrus SASL authentication
  - handles 'svn' scheme
* ra_local : Module for accessing a repository on local disk.
  - handles 'file' scheme
* ra_serf : Module for accessing a repository via WebDAV protocol using serf.
  - handles 'http' scheme
  - handles 'https' scheme

$ git svn dcommit
Committing to https://xxxxx.xxx/xxxxx ...
R /some/file => /some/new/filename
perl: subversion/libsvn_subr/dirent_uri.c:2500: svn_fspath__is_child:
Assertion `svn_fspath__is_canonical(child_fspath)' failed.
error: git-svn died of signal 6

Any idea what I should do next to get this working? I also tried with
a "$ git svn rebase" first, which throws no error (just an "already
up-to-date")...

Thanks for your help!

Regards
Ben

2013/11/15 Andreas Stricker <astricker@futurelab.ch>:
> Hi Benjamin
>
>> thanks for your link. Can you give me the exact version you
>> downgraded svn to?
>
> svn, Version 1.7.10 (r1485443)
>
> I tried to reproduce the problem with git version 1.8.4.2 and
> Subversion version 1.8.4 (r1534716) with a fresh and pristine
> subversion repo and a git-svn clone of it: I didn't manage to
> reproduce the rename issue. Then I switched subversion back to
> 1.7.10, created both the repo and the git-svn clone, switched
> againt to 1.8.4.2 and then got an error. Unfortunately I didn't
> check if the subversion perlbindings were regenerated, so I'm
> not exactly sure. I'll repeat the test again, as soon I've find
> the time.
>
> It looks like a fresh git svn clone may fix the problem.
>
> Regards, Andy
