From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add test case for running from a subdirectory with
 GIT_WORK_TREE
Date: Sat, 27 Oct 2007 13:45:23 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710271343270.4362@racer.site>
References: <20071027081954.GA23406@laptop>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1730238617-1193489123=:4362"
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 27 14:46:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ill3M-0003Lc-7C
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 14:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453AbXJ0MqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 08:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752514AbXJ0MqA
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 08:46:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:45236 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752403AbXJ0Mp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 08:45:59 -0400
Received: (qmail invoked by alias); 27 Oct 2007 12:45:58 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 27 Oct 2007 14:45:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19NJs8CHaNNtvcAe/uqeRqW2D79osmnlkVwPBaVfZ
	p9ETeHw0Gy35vg
X-X-Sender: gene099@racer.site
In-Reply-To: <20071027081954.GA23406@laptop>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62488>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1730238617-1193489123=:4362
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 27 Oct 2007, Nguyễn Thái Ngọc Duy wrote:

> +mkdir -p work/sub/dir || exit 1
> +mv .git work
> +if test "$1" = --normal; then
> +	say "Normal case"
> +else
> +	say "Worktree case"
> +fi
> +test "$1" = --normal || mv work/.git repo.git || exit 1
> +
> +test "$1" = --normal || export GIT_DIR=$(pwd)/repo.git
> +export GIT_CONFIG="$(pwd)"/$GIT_DIR/config
> +test "$1" = --normal || export GIT_WORK_TREE=$(pwd)/work
> +
> +cd work/sub || exit 1

Why don't you put this block into a test_expect_success?  And then just 
make a

	for mode in normal worktree
	do

	...

	done

Hmm?  I would like to see this test case in the official git.git.

Ciao,
Dscho

--8323584-1730238617-1193489123=:4362--
