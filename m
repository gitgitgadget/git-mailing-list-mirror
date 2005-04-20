From: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] gittrack.sh accepts invalid branch names
Date: Wed, 20 Apr 2005 16:22:34 -0700
Organization: SGI
Message-ID: <20050420162234.3ccbf23e.pj@sgi.com>
References: <1114026510.15186.15.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pasky@ucw.cz
X-From: git-owner@vger.kernel.org Thu Apr 21 01:19:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOOTz-000637-Tk
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 01:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVDTXYF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 19:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbVDTXYF
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 19:24:05 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:20935 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261837AbVDTXYD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 19:24:03 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3L13Oe1013315;
	Wed, 20 Apr 2005 18:03:34 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3KNMdlU16475364;
	Wed, 20 Apr 2005 16:22:40 -0700 (PDT)
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1114026510.15186.15.camel@dv>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Pavel wrote:
> 	sed -ne "/^$name\t/p" .git/remotes | grep -q .

Consider using the following to look for a match of $name with
the first tab separated field of the remotes file (and to avoid
using 'grep -q', which is not in all grep's, so far as I know):

	cut -f1 .git/remotes | grep -Fx "$name" >/dev/null

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
