From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: please pull ppc64-2.6.git
Date: Mon, 29 Aug 2005 11:02:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508291057380.3243@g5.osdl.org>
References: <17170.25803.413408.44080@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0508291006440.3243@g5.osdl.org>
	<20050829184510.A20605@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc64-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: linuxppc64-dev-bounces@ozlabs.org Mon Aug 29 20:06:24 2005
Return-path: <linuxppc64-dev-bounces@ozlabs.org>
Received: from ozlabs.org ([203.10.76.45])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9nyF-0007J6-Q2
	for glppd-linuxppc64-dev@m.gmane.org; Mon, 29 Aug 2005 20:03:00 +0200
Received: from ozlabs.org (localhost [127.0.0.1])
	by ozlabs.org (Postfix) with ESMTP id 072006817B;
	Tue, 30 Aug 2005 04:02:57 +1000 (EST)
X-Original-To: linuxppc64-dev@ozlabs.org
Delivered-To: linuxppc64-dev@ozlabs.org
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 24A2168175
	for <linuxppc64-dev@ozlabs.org>; Tue, 30 Aug 2005 04:02:54 +1000 (EST)
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7TI2djA011780
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 29 Aug 2005 11:02:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7TI2cpO015625;
	Mon, 29 Aug 2005 11:02:39 -0700
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050829184510.A20605@flint.arm.linux.org.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
X-BeenThere: linuxppc64-dev@ozlabs.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: 64-bit Linux on PowerPC Developers Mail List
	<linuxppc64-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc64-dev>,
	<mailto:linuxppc64-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc64-dev>
List-Post: <mailto:linuxppc64-dev@ozlabs.org>
List-Help: <mailto:linuxppc64-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc64-dev>,
	<mailto:linuxppc64-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc64-dev-bounces@ozlabs.org
Errors-To: linuxppc64-dev-bounces@ozlabs.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7911>



On Mon, 29 Aug 2005, Russell King wrote:
> 
> Is the expected filesystem layout documented somewhere online (_external_
> to the source code) ?

Nope, I don't think so. 

> Alternatively, when changes occur to the repostory format, please can
> they be marked with some obvious subject so that folk know when things
> are going to break?

The only actual filesystem _breakage_ has been the introduction of 
pack-files (and the old, old _old_ thing where I changed the actual object 
compression/hashing order).

The "objects/info/alternates" thing is an extension, which allows you to 
have a partial object store, and point to the "rest of it", and still have 
all the tools understand it and be able to parse the totality of it. So it 
doesn't break or change old formats, it only allows a new one.

(Partial repos have always worked with the rsync protocol, and with the
client-side pulling. But that was more of an accident than anything else,
and they fundamentally were broken for any real work - gitweb can't show
anything really sane, server-side serving - whether anonymous or ssh -
doesn't work, etc etc).

		Linus
