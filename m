X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH] Colourise git-branch output
Date: Mon, 11 Dec 2006 19:38:57 -0500
Message-ID: <BAYC1-PASMTP114CF00792AB16B95C1597AED70@CEZ.ICE>
References: <200612112210.08327.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 00:39:15 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.74]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061211193857.976f3660.seanlkml@sympatico.ca>
In-Reply-To: <200612112210.08327.andyparkins@gmail.com>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 12 Dec 2006 00:49:11.0265 (UTC) FILETIME=[56844D10:01C71D87]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gtvfn-0001so-Nr for gcvg-git@gmane.org; Tue, 12 Dec
 2006 01:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750767AbWLLAjE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 19:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWLLAjE
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 19:39:04 -0500
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:61925 "EHLO
 BAYC1-PASMTP11.BAYC1.HOTMAIL.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
 with ESMTP id S1750767AbWLLAjB (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11
 Dec 2006 19:39:01 -0500
Received: from linux1.attic.local ([65.93.43.74]) by
 BAYC1-PASMTP11.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Mon, 11 Dec 2006 16:49:11 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1GtujX-00033o-Fi; Mon, 11 Dec 2006 18:38:55 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

On Mon, 11 Dec 2006 22:10:08 +0000
Andy Parkins <andyparkins@gmail.com> wrote:

> +int git_branch_config(const char *var, const char *value)
> +{
> +	if (!strcmp(var, "branch.color")) {
> +		branch_use_color = git_config_colorbool(var, value);
> +		return 0;
> +	}
> +	return git_default_config(var, value);
> +}

As Junio already highlighted, the "branch.*" namespace is for actual
branch names.  This config option should go into "color.branch" or some
other spot.

