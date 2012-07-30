From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC v2 11/16] Add explanatory comment for transport-helpers
 refs mapping.
Date: Mon, 30 Jul 2012 12:08:42 -0500
Message-ID: <20120730170842.GC8515@burratino>
References: <1343658683-10713-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 19:08:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvtSf-0003Fv-Uq
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 19:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754249Ab2G3RIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 13:08:49 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35127 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936Ab2G3RIs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 13:08:48 -0400
Received: by yhmm54 with SMTP id m54so5055804yhm.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 10:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=u/ePHmxPKFc+KJ/rm1WDBjDCxJ0831POoxazKqiLuf8=;
        b=oDAWPOTgNWXPJX6BR3wNGR6IW40BQ0zq7zzHInNfrMaaDDoRLfdrL1z4+NXJVmSINM
         NzmYG/b5t0OCbm7yV3Im/Ud2mPLPc8nyjYeY7BsykdXajvrcTIhIIKDYJMncEDL3yI51
         2gX5ZKhD+y6eyLrF7hcjYR59Cu6t2MyaF5V7j8YkAOa0G9dzhSBV5bTO2QJBhY7HcdkT
         k1PB0HeYH7VT6ZAWOGzQ/q37T3Drdx+RigwJSDiaLE55sFl+ltgruFNIqJ2x6pqcyv02
         8C1SGNN4rFeEsIDQKr7nk29X8i4eWeSdvsW9+xbabU2fu/sTOgrKNauWnOEeQboIhaYK
         bggA==
Received: by 10.50.11.165 with SMTP id r5mr9036414igb.27.1343668127357;
        Mon, 30 Jul 2012 10:08:47 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id uq6sm205862igb.14.2012.07.30.10.08.46
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jul 2012 10:08:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343658683-10713-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202584>

Hi Junio,

Florian Achleitner wrote:

> transport-helpers can advertise the 'refspec' capability,
> if not a default refspec *:* is assumed. This explains
> the post-processing of refs after fetching with fast-import.
>
> Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>

The patch below adds a comment to fetch_with_import() explaining the
loop that saves the fetched commit names after 'git fast-import' has
done its work.  It avoids some confusion that Florian encountered on
first reading about which refs the fast-import stream is supposed to
use to write its result.

(By the way, I guess I find the above paragraph clearer than Florian's
commit message.  But aside from that, the patch seems good to me.)

I would like to see the patch applied so the remote-svn series without
it gets shorter and easier to review. ;-)  Munging the two context
lines ending with argv_array_clear(&importer_argv); to

 	free(fastimport.argv);
 	fastimport.argv = NULL;

makes this patch apply against master.  Does it look ready for
application to you?  If you'd like, I can send a copy rebased against
'master'.

Patch left unsnipped for reference.

Thanks,
Jonathan

> ---
>  transport-helper.c |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/transport-helper.c b/transport-helper.c
> index d6daad5..e10fd6b 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -478,6 +478,21 @@ static int fetch_with_import(struct transport *transport,
>  
>  	argv_array_clear(&importer_argv);
>  
> +	/*
> +	 * If the remote helper advertised the "refspec" capability,
> +	 * it will have the written result of the import to the refs
> +	 * named on the right hand side of the first refspec matching
> +	 * each ref we were fetching.
> +	 *
> +	 * (If no "refspec" capability was specified, for historical
> +	 * reasons we default to *:*.)
> +	 *
> +	 * Store the result in to_fetch[i].old_sha1.  Callers such
> +	 * as "git fetch" can use the value to write feedback to the
> +	 * terminal, populate FETCH_HEAD, and determine what new value
> +	 * should be written to peer_ref if the update is a
> +	 * fast-forward or this is a forced update.
> +	 */
>  	for (i = 0; i < nr_heads; i++) {
>  		char *private;
>  		posn = to_fetch[i];
> -- 
> 1.7.9.5
> 
