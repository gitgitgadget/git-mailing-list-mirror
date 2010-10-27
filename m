From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: [PATCH v2/RFC] Make git-completion Bash 4 compatible.
Date: Wed, 27 Oct 2010 13:23:27 -0400
Message-ID: <091B05F5-D5F4-4DD6-90AF-E0BD77700326@gernhardtsoftware.com>
References: <20101027131506.4da06c6d@MonteCarlo>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	=?iso-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: Peter van der Does <peter@avirtualhome.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 19:23:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB9it-0000po-QQ
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 19:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687Ab0J0RXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 13:23:35 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:45726 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143Ab0J0RXe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Oct 2010 13:23:34 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id BF61B1FFC061; Wed, 27 Oct 2010 17:23:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id B0D301FFC055;
	Wed, 27 Oct 2010 17:23:26 +0000 (UTC)
In-Reply-To: <20101027131506.4da06c6d@MonteCarlo>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160105>


On Oct 27, 2010, at 1:15 PM, Peter van der Does wrote:

> contrib/completion/git-completion.bash |  417 +++++++++++++++++++++++++++-----
> 1 files changed, 355 insertions(+), 62 deletions(-)

That's a lot of added lines?  Do we use all of this code?  If not, should we trim it down just to support the features we need?

Also, there appears to be no note in the code or commit message that this came from somewhere else.  Shouldn't we note the source of the code?  Is bash-completion GPLv2 as we are?

> +	_upvar() {
> +		if unset -v "$1"; then           # Unset & validate varname

Nit: This should be indented one less level.

> +	        if (( $# == 2 )); then
> +	            eval $1=\"\$2\"          # Return single value
> +	        else
> +	            eval $1=\(\"\${@:2}\"\)  # Return array
> +	        fi
> +	    fi
> +	}
> +

Other than those concerns, I like it.  Good call not trying to redefine the functions from bash-completion if it's loaded already.

~~ Brian
