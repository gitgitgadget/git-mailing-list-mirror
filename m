From: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>
Subject: Re: [PATCH 2/2] Make guilt work even after git-sh-setup is moved
	out of the user's path
Date: Mon, 7 Jul 2008 20:32:56 -0400
Message-ID: <20080708003256.GB1880@josefsipek.net>
References: <1215475392-26221-1-git-send-email-tytso@mit.edu> <1215475392-26221-2-git-send-email-tytso@mit.edu> <1215475392-26221-3-git-send-email-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Theodore Ts'o" <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Tue Jul 08 02:34:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG19u-0004vp-Iy
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 02:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754883AbYGHAdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 20:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754759AbYGHAdU
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 20:33:20 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:37811 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754650AbYGHAdU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 20:33:20 -0400
Received: from josefsipek.net (baal.fsl.cs.sunysb.edu [130.245.126.78])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.8) with ESMTP id m680Wsre018977;
	Mon, 7 Jul 2008 20:32:54 -0400
Received: by josefsipek.net (Postfix, from userid 1000)
	id 544091C00D88; Mon,  7 Jul 2008 20:32:56 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1215475392-26221-3-git-send-email-tytso@mit.edu>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87672>

On Mon, Jul 07, 2008 at 08:03:12PM -0400, Theodore Ts'o wrote:
> Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
> ---
>  guilt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/guilt b/guilt
> index cdf4e9b..d30d35a 100755
> --- a/guilt
> +++ b/guilt
> @@ -23,7 +23,7 @@ esac
>  # we change directories ourselves
>  SUBDIRECTORY_OK=1
>  
> -. git-sh-setup
> +. $(git --exec-path)/git-sh-setup

This seems wrong.


jeffpc@freyr:~$ git --version
git version 1.5.6.2.247.g923712
jeffpc@freyr:~$ git --exec-path
/home/jeffpc/git-bin/bin

AFAICT, it should be:

/home/jeffpc/git-bin/libexec/git-core

(which contains git-sh-setup)

Josef 'Jeff' Sipek.

-- 
I think there is a world market for maybe five computers.
		- Thomas Watson, chairman of IBM, 1943.
