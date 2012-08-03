From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 05/16] t2104: Don't fail when index version is 5
Date: Fri, 3 Aug 2012 10:22:02 +0200
Message-ID: <878vdwcrmd.fsf@thomas.inf.ethz.ch>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
	<1343905326-23790-6-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, <trast@student.ethz.ch>,
	<mhagger@alum.mit.edu>, <gitster@pobox.com>, <pclouds@gmail.com>,
	<robin.rosenberg@dewire.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 10:22:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxD9A-0002XN-Hf
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 10:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603Ab2HCIWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 04:22:07 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:52648 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752179Ab2HCIWG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 04:22:06 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 3 Aug
 2012 10:21:57 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 3 Aug
 2012 10:22:02 +0200
In-Reply-To: <1343905326-23790-6-git-send-email-t.gummerer@gmail.com> (Thomas
	Gummerer's message of "Thu, 2 Aug 2012 13:01:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202819>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> The test t2104 currently checks if the index version is correctly
> reduced to 2/increased to 3, when an entry need extended flags,
> or doesn't use them anymore. Since index-v5 doesn't have extended
> flags (the extended flags are part of the normal flags), we simply
> add a check if the index version is 2/3 (whichever is correct for
> that test) or 5.

Next time we set a new index format as default (which might be when we
make v4 the default!), we'll have to patch this again.  Wouldn't it make
more sense to let them depend on a "default index format is v2"
prerequisite?

> -test_expect_success 'index is at version 2' '
> -	test "$(test-index-version < .git/index)" = 2
> +test_expect_success 'index is at version 2 or version 5' '
> +	test "$(test-index-version < .git/index)" = 2 ||
> +	test "$(test-index-version < .git/index)" = 5
>  '

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
