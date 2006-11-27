X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/10] Teach git-completion.bash how to complete git-merge.
Date: Mon, 27 Nov 2006 11:12:40 -0800
Message-ID: <7vlklwhffb.fsf@assigned-by-dhcp.cox.net>
References: <20061127084047.GA19745@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 19:13:42 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32438>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoluH-000320-Jb for gcvg-git@gmane.org; Mon, 27 Nov
 2006 20:12:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933238AbWK0TMm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 14:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933268AbWK0TMm
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 14:12:42 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:7559 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S933257AbWK0TMl
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 14:12:41 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061127191241.QJBU296.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>; Mon, 27
 Nov 2006 14:12:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id rvC91V00G1kojtg0000000; Mon, 27 Nov 2006
 14:12:09 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

"Shawn O. Pearce" <spearce@spearce.org> writes:

> +__git_merge_strategies ()
> +{
> +	sed -n "/^all_strategies='/{
> +		s/^all_strategies='//
> +		s/'//
> +		p
> +		q
> +		}" "$(git --exec-path)/git-merge"
> +}
> +

Shouldn't we load and compute this once and keep the result in a
variable (say $__git_merge_strategies)?
