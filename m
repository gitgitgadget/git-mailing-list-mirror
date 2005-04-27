From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: A shortcoming of the git repo format
Date: Wed, 27 Apr 2005 12:15:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504271212460.18901@ppc970.osdl.org>
References: <426F2671.1080105@zytor.com> <Pine.LNX.4.58.0504270820370.18901@ppc970.osdl.org>
 <426FD3EE.5000404@zytor.com> <20050427183239.GE19011@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 21:09:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQrtC-0001AB-78
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 21:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbVD0TNX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 15:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVD0TNW
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 15:13:22 -0400
Received: from fire.osdl.org ([65.172.181.4]:32183 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261969AbVD0TNS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 15:13:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3RJDBs4005058
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Apr 2005 12:13:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3RJDAbm002752;
	Wed, 27 Apr 2005 12:13:11 -0700
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20050427183239.GE19011@redhat.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 27 Apr 2005, Dave Jones wrote:
> 
> That actually broke one of my first git scripts when one of the
> changelog texts started a line with 'tree '.  I hacked around it
> by making my script only grep in the 'head -n4' lines, but this
> seems somewhat fragile having to make assumptions that the field
> I want to see is in the first 4 lines.

It's not an assumption.

IT'S THE LAW.

The speed of light is not "an assumption". It is.

The tree is in the first line of a commit. You don't even need to parse 
it, you do

	tree=$(cat-file commit $head | sed 's/tree //;q')

and that's it. No parsing.

Git doesn't guess. Git knows.

		Linus
