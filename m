From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Correct missing SP characters in grammar comment at
	top of fast-import.c
Date: Wed, 25 Mar 2009 14:26:33 -0700
Message-ID: <20090325212633.GB23521@spearce.org>
References: <1238016133-13509-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: newren@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 25 22:28:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmads-0001on-Jj
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 22:28:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755441AbZCYV0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 17:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755132AbZCYV0f
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 17:26:35 -0400
Received: from george.spearce.org ([209.20.77.23]:37032 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754916AbZCYV0e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 17:26:34 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 46BCC38211; Wed, 25 Mar 2009 21:26:33 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1238016133-13509-1-git-send-email-newren@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114668>

newren@gmail.com wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

> Some point after discovering this 'bug', I noticed that the documentation
> in Documentation/git-fast-import.txt was accurate, so I added a comment at
> the top of the file pointing people at that document, as I suspect it is
> more likely to be kept up to date.  If my assumption is wrong, or would
> prefer different wording, I'm all ears.

Good catch.  The grammar at the top of the file should be more
accurate than the documentation you point to.  This was just a
thinko when I wrote the grammar out in the header.


> diff --git a/fast-import.c b/fast-import.c
> index beeac0d..db44da3 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1,4 +1,5 @@
>  /*
> +(See Documentation/git-fast-import.txt for maintained documentation.)
>  Format of STDIN stream:
>  
>    stream ::= cmd*;
> @@ -18,8 +19,8 @@ Format of STDIN stream:
>  
>    new_commit ::= 'commit' sp ref_str lf
>      mark?
> -    ('author' sp name '<' email '>' when lf)?
> -    'committer' sp name '<' email '>' when lf
> +    ('author' sp name sp '<' email '>' sp when lf)?
> +    'committer' sp name sp '<' email '>' sp when lf
>      commit_msg
>      ('from' sp (ref_str | hexsha1 | sha1exp_str | idnum) lf)?
>      ('merge' sp (ref_str | hexsha1 | sha1exp_str | idnum) lf)*
> @@ -43,7 +44,7 @@ Format of STDIN stream:
>  
>    new_tag ::= 'tag' sp tag_str lf
>      'from' sp (ref_str | hexsha1 | sha1exp_str | idnum) lf
> -    ('tagger' sp name '<' email '>' when lf)?
> +    ('tagger' sp name sp '<' email '>' sp when lf)?
>      tag_msg;
>    tag_msg ::= data;
>  
> -- 
> 1.6.0.6
> 

-- 
Shawn.
