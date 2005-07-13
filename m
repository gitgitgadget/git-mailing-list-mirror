From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Is cogito really this inefficient
Date: Wed, 13 Jul 2005 13:28:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507131325170.17536@g5.osdl.org>
References: <20050713135052.C6791@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 22:33:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dsnu8-0005Ze-Dm
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 22:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbVGMUbo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 16:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbVGMU3D
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 16:29:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44501 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262749AbVGMU22 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2005 16:28:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6DKSJjA017640
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 13 Jul 2005 13:28:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6DKSIY1002195;
	Wed, 13 Jul 2005 13:28:19 -0700
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050713135052.C6791@flint.arm.linux.org.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 13 Jul 2005, Russell King wrote:
>
> This says it all.  1min 22secs to generate a patch from a locally
> modified but uncommitted file.

No, there's something else going on.

Most likely that something forced a total index file re-validation, and
the time you see is every single checked out file having its SHA1
re-computed.

Was this a recently cloned tree, or what was the last operation you did on
that tree before that command? Something must have invalidated the index.

			Linus
