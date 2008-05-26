From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] builtin-fast-export: Only output a single parent per line
Date: Mon, 26 May 2008 01:30:21 -0400
Message-ID: <20080526053020.GD30245@spearce.org>
References: <1211671313-99006-1-git-send-email-pdebie@ai.rug.nl> <7vskw7jh7c.fsf@gitster.siamese.dyndns.org> <20080526014904.GZ29038@spearce.org> <7v7idhej6f.fsf@gitster.siamese.dyndns.org> <7vzlqdd4ef.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 26 07:31:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0VIy-0000sC-JR
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 07:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbYEZFa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 01:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbYEZFa1
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 01:30:27 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:34358 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbYEZFa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 01:30:26 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1K0VHq-00081u-Cj; Mon, 26 May 2008 01:30:22 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1552C20FBAE; Mon, 26 May 2008 01:30:21 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vzlqdd4ef.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82903>

Junio C Hamano <gitster@pobox.com> wrote:
> > Unfortunately, t9301 does not pass with the "fix".
> 
> Perhaps, this is needed on top?
> 
>  builtin-fast-export.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin-fast-export.c b/builtin-fast-export.c
> index 4d28cf7..4bf5b58 100755
> --- a/builtin-fast-export.c
> +++ b/builtin-fast-export.c
> @@ -209,8 +209,6 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
>  			printf("merge :%d\n", mark);
>  		i++;
>  	}
> -	if (i > 1)
> -		printf("\n");
>  
>  	log_tree_diff_flush(rev);
>  	rev->diffopt.output_format = saved_output_format;


Yea, that looks right.  The LF shouldn't follow the last merge
command.

-- 
Shawn.
