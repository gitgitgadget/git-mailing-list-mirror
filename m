From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow branch names that end with ".lock"
Date: Thu, 07 May 2009 18:25:14 -0700
Message-ID: <7vab5obd39.fsf@alter.siamese.dyndns.org>
References: <1241708714-20326-1-git-send-email-spearce@spearce.org>
	<1241708714-20326-2-git-send-email-spearce@spearce.org>
	<200905080102.44053.robin.rosenberg@dewire.com>
	<alpine.LFD.2.01.0905071620240.4983@localhost.localdomain>
	<7vprekbfik.fsf@alter.siamese.dyndns.org>
	<7viqkcbenb.fsf_-_@alter.siamese.dyndns.org>
	<20090508005417.GV30527@spearce.org>
	<7veiv0bee2.fsf@alter.siamese.dyndns.org>
	<20090508010110.GW30527@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri May 08 03:25:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2EqQ-0007cD-DU
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 03:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762581AbZEHBZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 21:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758770AbZEHBZQ
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 21:25:16 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:59718 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762355AbZEHBZP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 21:25:15 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090508012514.WTDK18948.fed1rmmtao107.cox.net@fed1rmimpo03.cox.net>;
          Thu, 7 May 2009 21:25:14 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id opRF1b0034aMwMQ04pRFGk; Thu, 07 May 2009 21:25:15 -0400
X-Authority-Analysis: v=1.0 c=1 a=wDcnqk65jR8A:10 a=oVFSCg6HenwA:10
 a=oAYF_C9AAAAA:8 a=bqSy3x0WzT4fp4DYKiUA:9 a=UHIlzD0OXLMHbmSrfxZF3VnIovUA:4
 a=R0wQ3QzoQ0IA:10
X-CM-Score: 0.00
In-Reply-To: <20090508010110.GW30527@spearce.org> (Shawn O. Pearce's message of "Thu\, 7 May 2009 18\:01\:10 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118556>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> diff --git a/refs.c b/refs.c
> index 03aded9..b4ca305 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -742,8 +742,6 @@ int check_ref_format(const char *ref)
>  				return CHECK_REF_FORMAT_ERROR;
>  			if (level < 2)
>  				return CHECK_REF_FORMAT_ONELEVEL;
> -			if (has_extension(ref, "..lck"))
> -				return CHECK_REF_FORMAT_ERROR;
>  			return ret;
>  		}
>  	}
>
> NAK, I like how I removed this block.  It can't happen anymore,
> the no ".." in name earlier should have caught the condition.

Very true.  Thanks.
