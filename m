From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] make git-svn resilient to log.abbrevcommit = true
Date: Thu, 24 Nov 2011 14:11:05 +0100
Message-ID: <201111241411.05655.trast@student.ethz.ch>
References: <3A78B8F7-803C-4278-8B5F-4A1B02C9FF04@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
To: Shahid Alam <shahid.alam@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 24 14:11:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTZ5A-0008C5-Oh
	for gcvg-git-2@lo.gmane.org; Thu, 24 Nov 2011 14:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755871Ab1KXNLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Nov 2011 08:11:11 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:20627 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753024Ab1KXNLK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2011 08:11:10 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.339.1; Thu, 24 Nov
 2011 14:11:02 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.339.1; Thu, 24 Nov
 2011 14:11:06 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.0-47-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <3A78B8F7-803C-4278-8B5F-4A1B02C9FF04@gmail.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185913>

[add Eric to Cc]

Shahid Alam wrote:
> Add --no-abbrev-commit arg to working_head_Info()'s invocation
> of git log.
[...]
> @@ -1803,7 +1803,7 @@ sub cmt_sha2rev_batch {
> sub working_head_info {
> 	my ($head, $refs) = @_;
> 	my @args = qw/log --no-color --no-decorate --first-parent
> -	              --pretty=medium/;
> +	              --no-abbrev-commit --pretty=medium/;

Undeniably a bug, but to prevent the same from happening again,
wouldn't it be better to rewrite it using simply

  rev-list --first-parent --pretty=medium

?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
