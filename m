From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fixes handling of --reference argument.
Date: Thu, 25 Oct 2012 04:36:26 -0400
Message-ID: <20121025083625.GA8390@sigill.intra.peff.net>
References: <5088c5a4.L25tOcUVCSwBRpYF%szager@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: szager@google.com
X-From: git-owner@vger.kernel.org Thu Oct 25 10:36:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRIvj-0005My-4B
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 10:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933688Ab2JYIgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 04:36:31 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55939 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932829Ab2JYIg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 04:36:29 -0400
Received: (qmail 6193 invoked by uid 107); 25 Oct 2012 08:37:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Oct 2012 04:37:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2012 04:36:26 -0400
Content-Disposition: inline
In-Reply-To: <5088c5a4.L25tOcUVCSwBRpYF%szager@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208365>

On Wed, Oct 24, 2012 at 09:52:52PM -0700, szager@google.com wrote:

> Signed-off-by: Stefan Zager <szager@google.com>
> ---
>  git-submodule.sh |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index ab6b110..dcceb43 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -270,7 +270,6 @@ cmd_add()
>  			;;
>  		--reference=*)
>  			reference="$1"
> -			shift
>  			;;

Is that right? We'll unconditionally do a "shift" at the end of the
loop. If it were a two-part argument like "--reference foo", the extra
shift would make sense, but for "--reference=*", no extra shift should
be neccessary. Am I missing something?

-Peff
