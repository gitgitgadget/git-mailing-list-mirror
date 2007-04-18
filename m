From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] pack-refs: dereference .git/packed-refs if it is a
 symlink
Date: Wed, 18 Apr 2007 09:09:13 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704180908360.2828@woody.linux-foundation.org>
References: <20070417161720.GA3930@xp.machine.xx>
 <Pine.LNX.4.64.0704172253140.14155@beast.quantumfyre.co.uk>
 <20070418055215.GA32634@xp.machine.xx> <7v7isajfl1.fsf@assigned-by-dhcp.cox.net>
 <20070418102823.GA5586@xp.machine.xx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 18 18:09:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeCii-0002Se-QX
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 18:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992780AbXDRQJV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 12:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992782AbXDRQJV
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 12:09:21 -0400
Received: from smtp.osdl.org ([65.172.181.24]:36865 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992780AbXDRQJU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 12:09:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3IG9EYC019236
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Apr 2007 09:09:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3IG9Dcw028768;
	Wed, 18 Apr 2007 09:09:14 -0700
In-Reply-To: <20070418102823.GA5586@xp.machine.xx>
X-Spam-Status: No, hits=-2.464 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44907>



On Wed, 18 Apr 2007, Peter Baumann wrote:
>
> git-new-workdir creates a new working directory where everything
> necessary, including .git/packed-refs, is symlinked to your master repo.
> But git-pack-refs breaks the symlink, so you could accidentally loose some
> refs. This fixes it to first dereference .git/packed-refs if it is a
> symlink.

Wouldn't it be nicer to instead make "git gc" *notice* the fact that we're 
in a workdir, and just "cd" to the main git repository instead?

		Linus
