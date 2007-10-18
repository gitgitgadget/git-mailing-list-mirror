From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/2 v3] mergetool: use path to mergetool in config var mergetool.<tool>.path
Date: Thu, 18 Oct 2007 01:27:24 -0400
Message-ID: <20071018052724.GA27813@spearce.org>
References: <11926413722362-git-send-email-prohaska@zib.de> <11926413723666-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Oct 18 07:27:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiNv2-0004Ni-QM
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 07:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbXJRF13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 01:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbXJRF13
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 01:27:29 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51540 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497AbXJRF13 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 01:27:29 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IiNuk-0006qs-6h; Thu, 18 Oct 2007 01:27:22 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 63DC720FBAE; Thu, 18 Oct 2007 01:27:24 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <11926413723666-git-send-email-prohaska@zib.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61478>

Steffen Prohaska <prohaska@zib.de> wrote:
> This commit adds a mechanism to provide absolute paths to the
> external programs called by 'git mergetool'.  ...
...
> @@ -297,17 +297,38 @@ do
>      shift
>  done
>  
> +valid_tool() {
> +	case "$1" in
> +		kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff)
> +			;; # happy
> +		*)
> +			return 1
> +			;;
> +	esac
> +}
...
> +    test -n "$merge_tool" || valid_tool "$merge_tool" || {

Wouldn't an empty $merge_tool string be caught above in the
valid_tool function where it falls through and returns 1?
So isn't test -n here redundant?

-- 
Shawn.
