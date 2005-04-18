From: tony.luck@intel.com
Subject: Re: [PATCH] Get commits from remote repositories by HTTP
Date: Mon, 18 Apr 2005 11:41:42 -0700
Message-ID: <200504181841.j3IIfgP31258@unix-os.sc.intel.com>
References: <Pine.LNX.4.21.0504161750020.30848-100000@iabervon.org> <12c511ca050416152452a4c620@mail.gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 20:39:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNb8N-0002wl-Ia
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 20:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbVDRSlz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 14:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbVDRSlz
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 14:41:55 -0400
Received: from fmr24.intel.com ([143.183.121.16]:44937 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S262160AbVDRSlp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 14:41:45 -0400
Received: from scsfmr100.sc.intel.com (scsfmr100.sc.intel.com [10.3.253.9])
	by scsfmr004.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j3IIfgcM005364
	for <git@vger.kernel.org>; Mon, 18 Apr 2005 18:41:42 GMT
Received: from unix-os.sc.intel.com (unix-os.sc.intel.com [172.25.110.7])
	by scsfmr100.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id j3IIh44Q005565
	for <git@vger.kernel.org>; Mon, 18 Apr 2005 18:43:04 GMT
Received: from localhost (localhost [[UNIX: localhost]])
	by unix-os.sc.intel.com (8.11.6/8.11.2) id j3IIfgP31258;
	Mon, 18 Apr 2005 11:41:42 -0700
X-Authentication-Warning: unix-os.sc.intel.com: aegl set sender to tony.luck@intel.com using -f
In-Reply-To: <200504170316.j3H3GaZ03333@unix-os.sc.intel.com>
To: <git@vger.kernel.org>
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>Not a patch ... it is a whole file.  I called it "git-wget", but it might
>also want to be called "git-pulltop".

It's been pointed out to me that I based this script on a pre-historic version
of ls-tree from sometime last week.  Modern versions print the mode with %06o
so there is a leading 0 on the mode for a directory.  Just change

		if [ $mode = 40000 ]

to

		if [ $mode = 040000 ]

to fix it.

The script might also be useful for anyone behind a firewall that blocks
rsync transfers.

-Tony
