From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Finding the name of the parent branch?
Date: Fri, 30 Jan 2009 15:46:27 +0100
Message-ID: <adf1fd3d0901300646h39e27f50pdb6510083284cf8a@mail.gmail.com>
References: <a2633edd0901300256k2ad7530elcaca5cdc30c17534@mail.gmail.com>
	 <adf1fd3d0901300318s5a0e4c94gab5f31342643ea52@mail.gmail.com>
	 <a2633edd0901300456y48e8d78fn199675f2ae105c8@mail.gmail.com>
	 <adf1fd3d0901300516y3d1bf58dmda9c5172586d828@mail.gmail.com>
	 <a2633edd0901300535mf2d9ceemd9e9009e0aa18b40@mail.gmail.com>
	 <adf1fd3d0901300557t19ca4bccn7fe24013a05d2d57@mail.gmail.com>
	 <a2633edd0901300606ub4c507bocccb6747b436f01f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Fri Jan 30 15:49:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSuez-0004eh-Ee
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 15:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753159AbZA3Oqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 09:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753117AbZA3Oqa
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 09:46:30 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:41018 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945AbZA3Oq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 09:46:29 -0500
Received: by fxm13 with SMTP id 13so223888fxm.13
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 06:46:27 -0800 (PST)
Received: by 10.103.223.2 with SMTP id a2mr609380mur.54.1233326787632; Fri, 30 
	Jan 2009 06:46:27 -0800 (PST)
In-Reply-To: <a2633edd0901300606ub4c507bocccb6747b436f01f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107828>

2009/1/30 Pascal Obry <pascal@obry.net>:
>> At least part of. You have to understand the branch model:
>>
>> git model:
>>  * a branch is just a pointer to a commit
>>  * you cannot say "this commit was done in that branch"
>>  * what you can say is "this commit is contained in that branch"
>
> The second point wasn't clear to me.

A practical example:

$ git clone path/to/project.git
$ cd project
$ git checkout -b bugfix-1234 origin/master
$ # hack, hack, hack
$ git commit -a -m "Fix for the Bug #1234"
$ git push origin HEAD:master

So, you've done a commit in a local branch named bugfix-1234 and once
you push it to the master branch in origin there is nothing to tell
you so. A commit is defined with the current state, the old commit(s)
and some metadata (author and committer) but nothing about which
branch it was made, and as a branch is a pointer to a commit there is
nothing more.

Santi
