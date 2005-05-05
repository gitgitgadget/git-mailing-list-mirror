From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Kernel nightly snapshots..
Date: Thu, 5 May 2005 07:44:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505050742180.2328@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505041639130.2328@ppc970.osdl.org> 
 <42797F9F.9030002@zytor.com> <1115303933.16187.135.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 05 16:37:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DThSy-0001zV-Um
	for gcvg-git@gmane.org; Thu, 05 May 2005 16:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbVEEOnL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 10:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVEEOnL
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 10:43:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:52704 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262114AbVEEOnF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2005 10:43:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j45EgwU3020792
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 5 May 2005 07:42:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j45Egvui020124;
	Thu, 5 May 2005 07:42:57 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1115303933.16187.135.camel@hades.cambridge.redhat.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 5 May 2005, David Woodhouse wrote:
> 
> hera /home/dwmw2/git/snapshot-2.6 $ cg-init /pub/scm/linux/kernel/git/torvalds/linux-2.6.git &> ../asd
> hera /home/dwmw2/git/snapshot-2.6 $ cg-tag-ls
> v2.6.11 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c
> v2.6.11-tree    5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c
> v2.6.12-rc2     9e734775f7c22d2f89943ad6c745571f1930105f
> v2.6.12-rc3     0397236d43e48e821cce5bbe6a80a1a56bb7cc3a
> hera /home/dwmw2/git/snapshot-2.6 $ git-cat-file -t 0397236d43e48e821cce5bbe6a80a1a56bb7cc3a
> .git/objects/03/97236d43e48e821cce5bbe6a80a1a56bb7cc3a: No such file or directory

Looks like cg uses git-http-pull instead of rsync, and doesn't download 
anything but the required objects. 

In which case you probably don't have the v2.6.11 tree either, in fact, 
since it's not required to get a working copy of HEAD.

If you fetch the _whole_ object database (with rsync), you should get 
them.

		Linus
