From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH 1/2] Fix applying a line when all following lines
	are deletions
Date: Sat, 5 Dec 2009 13:32:45 -0800
Message-ID: <20091205213245.GF5610@spearce.org>
References: <1256160023-29629-1-git-send-email-jepler@unpythonic.net> <1256160023-29629-2-git-send-email-jepler@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff Epler <jepler@unpythonic.net>
X-From: git-owner@vger.kernel.org Sat Dec 05 22:32:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NH2FK-0002T4-9Y
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 22:32:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755499AbZLEVcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 16:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754745AbZLEVcm
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 16:32:42 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:54783 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbZLEVcl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 16:32:41 -0500
Received: by iwn1 with SMTP id 1so2313632iwn.33
        for <git@vger.kernel.org>; Sat, 05 Dec 2009 13:32:48 -0800 (PST)
Received: by 10.231.120.136 with SMTP id d8mr3166009ibr.14.1260048767857;
        Sat, 05 Dec 2009 13:32:47 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 20sm2198505iwn.9.2009.12.05.13.32.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Dec 2009 13:32:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1256160023-29629-2-git-send-email-jepler@unpythonic.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134626>

Jeff Epler <jepler@unpythonic.net> wrote:
> If a diff looked like
>  @@
>   context
>  -del1
>  -del2
> and you wanted to stage the deletion 'del1', the generated patch
> wouldn't apply because it was missing the line 'del2' converted to
> context, but this line was counted in the @@-line
> ---
>  lib/diff.tcl |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/lib/diff.tcl b/lib/diff.tcl
> index bd5d189..066755b 100644
> --- a/lib/diff.tcl
> +++ b/lib/diff.tcl
> @@ -664,6 +664,7 @@ proc apply_line {x y} {
>  		}
>  		set i_l $next_l
>  	}
> +	set patch "$patch$pre_context"

Signed-off-by ?

-- 
Shawn.
