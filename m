From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Hash name is SHA-1
Date: Thu, 25 Jan 2007 12:01:20 -0500
Message-ID: <20070125170120.GA13089@spearce.org>
References: <11697294071178-git-send-email-vonbrand@inf.utfsm.cl> <1169729410294-git-send-email-vonbrand@inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Thu Jan 25 18:01:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA7ye-0008Av-4S
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 18:01:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030378AbXAYRB3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 12:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbXAYRB3
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 12:01:29 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39857 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030378AbXAYRB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 12:01:28 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HA7yR-00058J-Km; Thu, 25 Jan 2007 12:01:20 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5E5D420FBAE; Thu, 25 Jan 2007 12:01:20 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1169729410294-git-send-email-vonbrand@inf.utfsm.cl>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37741>

"Horst H. von Brand" <vonbrand@inf.utfsm.cl> wrote:
> diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
> index 10e8c46..2fafc79 100644
> --- a/Documentation/git-receive-pack.txt
> +++ b/Documentation/git-receive-pack.txt
> @@ -20,7 +20,7 @@ The UI for the protocol is on the 'git-send-pack' side, and the
>  program pair is meant to be used to push updates to remote
>  repository.  For pull operations, see 'git-fetch-pack'.
>  
> -The command allows for creation and fast forwarding of sha1 refs
> +The command allows for creation and fast forwarding of SHA-1 refs

A good cleanup and correction.  We've apparently been a little lax.
Its a noble and worthy goal to make the correction and I applaud
you for doing the hard work.

> diff --git a/builtin-apply.c b/builtin-apply.c
> index 3fefdac..814f78f 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -1811,7 +1812,8 @@ static int apply_binary(struct buffer_desc *desc, struct patch *patch)
>  			     "without full index line", name);
>  
>  	if (patch->old_name) {
> -		/* See if the old one matches what the patch
> +		/* 
> +		 * See if the old one matches what the patch
>  		 * applies to.
>  		 */
>  		hash_sha1_file(desc->buffer, desc->size, blob_type, sha1);

However I cannot help but feel that this hunk is unrelated to the
theme of this extremely large patch.  I don't know how Junio feels,
but this late in the 1.5.0 series I'm a little leary of a 1600+
line patch which is changing so much code, even if its something
as trivial as the above hunk.

-- 
Shawn.
