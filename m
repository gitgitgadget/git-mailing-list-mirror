From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] graph.c: avoid compile warnings
Date: Mon, 30 Mar 2009 08:58:42 -0700
Message-ID: <7vd4bzf1e5.fsf@gitster.siamese.dyndns.org>
References: <20090330141322.GA6221@linux.vnet>
 <cover.1238428115u.git.johannes.schindelin@gmx.de>
 <7ee8d1c4ca806ce964356a1fe78efac19d56c29b.1238428115u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Allan Caffee <allan.caffee@gmail.com>,
	Jeff King <peff@peff.net>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 30 18:03:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoJuV-0005dX-F3
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 18:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649AbZC3P6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 11:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752567AbZC3P6y
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 11:58:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52159 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbZC3P6y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 11:58:54 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CBAB8A60B6;
	Mon, 30 Mar 2009 11:58:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E8B40A60B0; Mon,
 30 Mar 2009 11:58:43 -0400 (EDT)
In-Reply-To: <7ee8d1c4ca806ce964356a1fe78efac19d56c29b.1238428115u.git.johannes.schindelin@gmx.de> (Johannes Schindelin's message of "Mon, 30 Mar 2009 17:49:36 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A94D0014-1D43-11DE-BB81-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115168>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	I'd actually like to see this and the next patch squashed in.
>
>  graph.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
>
> diff --git a/graph.c b/graph.c
> index 2929c8b..5e2f224 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -701,8 +701,8 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
>  	for (i = 0; i < graph->num_columns; i++) {
>  		struct column *col = &graph->columns[i];
>  		if (col->commit == graph->commit) {
> -			seen_this = 1;
>  			struct strbuf tmp = STRBUF_INIT;
> +			seen_this = 1;

Which codebase are you working on top of?

>  			strbuf_addf(&tmp, "| %*s", graph->expansion_row, "");
>  			strbuf_write_column(sb, col, tmp.buf);
>  			strbuf_release(&tmp);
> @@ -921,8 +921,6 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
>  {
>  	int i;
>  	int *tmp_mapping;
> -	static int collapsing_columns[255];
> -	int collapsing_seen_so_far = 0;
>  
>  	/*
>  	 * Clear out the new_mapping array
> -- 
> 1.6.2.1.493.g67cf3
