From: Andrew Morton <akpm@osdl.org>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Tue, 26 Apr 2005 13:56:06 -0700
Message-ID: <20050426135606.7b21a2e2.akpm@osdl.org>
References: <20050426004111.GI21897@waste.org>
	<200504260713.26020.mason@suse.com>
	<aec7e5c305042608095731d571@mail.gmail.com>
	<200504261138.46339.mason@suse.com>
	<aec7e5c305042609231a5d3f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: mason@suse.com, torvalds@osdl.org, mike.taht@timesys.com,
	mpm@selenic.com, linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 22:57:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQX75-0006o1-Bo
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 22:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVDZVCH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 17:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbVDZVCH
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 17:02:07 -0400
Received: from fire.osdl.org ([65.172.181.4]:20165 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261776AbVDZVCD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 17:02:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3QKuSs4025605
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Apr 2005 13:56:28 -0700
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id j3QKuQBV008408;
	Tue, 26 Apr 2005 13:56:26 -0700
To: Magnus Damm <magnus.damm@gmail.com>
In-Reply-To: <aec7e5c305042609231a5d3f0@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Magnus Damm <magnus.damm@gmail.com> wrote:
>
> My primitive guess is that it was because
>  the ext3 journal became full.

The default ext3 journal size is inappropriately small, btw.  Normally you
should manually make it 128M or so, rather than 32M.  Unless you have a
small amount of memory and/or a large number of filesystems, in which case
there might be problems with pinned memory.

Mounting as ext2 is a useful technique for determining whether the fs is
getting in the way.

