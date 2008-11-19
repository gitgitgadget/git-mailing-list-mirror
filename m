From: Kalle Olavi Niemitalo <kon@iki.fi>
Subject: Re: [RFC] On how to manage tags fetched from remote?
Date: Wed, 19 Nov 2008 09:50:42 +0200
Message-ID: <87skpotar1.fsf@Astalo.kon.iki.fi>
References: <91b13c310811181827y4e37815egaa34ba164d9f4269@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 19 08:52:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2hr1-0007xt-JN
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 08:52:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbYKSHur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 02:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbYKSHur
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 02:50:47 -0500
Received: from smtp2.dnainternet.fi ([87.94.96.112]:33292 "EHLO
	smtp2.dnainternet.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbYKSHuq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 02:50:46 -0500
Received: from Astalo.kon.iki.fi (85-23-32-64-Rajakyla-TR1.suomi.net [85.23.32.64])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp2.dnainternet.fi (Postfix) with ESMTP id E40F2CECA
	for <git@vger.kernel.org>; Wed, 19 Nov 2008 09:50:44 +0200 (EET)
Received: from Kalle by Astalo.kon.iki.fi with local (Exim 4.52)
	id 1L2hpi-0003pb-Qm; Wed, 19 Nov 2008 09:50:42 +0200
In-Reply-To: <91b13c310811181827y4e37815egaa34ba164d9f4269@mail.gmail.com>
	(rae l.'s message of "Wed, 19 Nov 2008 10:27:37 +0800")
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/23.0.51 (gnu/linux)
X-Accept-Language: fi;q=1.0, en;q=0.9, sv;q=0.5, de;q=0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101314>

"rae l" <crquan@gmail.com> writes:

> 2. Store a no-tags config item to the remote config, which like:
>   [remote "linux-iscsi"]
> 	url = git://git.kernel.org/pub/scm/linux/kernel/git/mnc/linux-2.6-iscsi.git
> 	fetch = +refs/heads/*:refs/remotes/linux-iscsi/*
> 	fetch-tags = false
>   when git fetch read the no-tags config, it will disable tags from this remote;

A config option like that already exists.  I am using:

[remote "git.debian.org"]
	url = git://git.debian.org/git/collab-maint/elinks.git
	fetch = +refs/heads/*:refs/remotes/git.debian.org/*
	fetch = refs/tags/*:refs/tags/git.debian.org/*
	tagopt = --no-tags

So I have e.g. a ref called refs/tags/git.debian.org/orig-0.11.4
that points to a tag object that says "tag orig-0.11.4".  I hope
git fsck will never be changed to complain about that.
