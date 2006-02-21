From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Add new git-rm command with documentation
Date: Tue, 21 Feb 2006 17:32:54 -0500
Message-ID: <20060221223254.GB20744@spearce.org>
References: <87u0ass7tj.wl%cworth@cworth.org> <43FB8F31.9090302@people.pl> <20060221221446.GA20744@spearce.org> <43FB9455.6010402@people.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: cworth@cworth.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 23:33:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBg46-0008RJ-8C
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 23:33:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbWBUWc7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 17:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbWBUWc7
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 17:32:59 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57762 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S964877AbWBUWc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2006 17:32:58 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FBg3s-0005nr-Kf; Tue, 21 Feb 2006 17:32:48 -0500
Received: by asimov.spearce.org (Postfix, from userid 1000)
	id DFFF620FBA0; Tue, 21 Feb 2006 17:32:54 -0500 (EST)
To: Krzysiek Pawlik <krzysiek.pawlik@people.pl>
Content-Disposition: inline
In-Reply-To: <43FB9455.6010402@people.pl>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16565>

Krzysiek Pawlik <krzysiek.pawlik@people.pl> wrote:
[...]
> +while : ; do
> +  case "$1" in
> +    -n)
> +	show_only=true
> +	;;
> +    -v)
> +	verbose=--verbose
> +	;;
> +    -f)
> +	remove_files=true
> +	;;
> +    --)
> +	break
> +	;;
> +    -*)
> +	usage
> +	;;
> +    *)
> +	break
> +	;;
> +  esac
> +  shift
> +done
[...]

You are leaving -- in $@ for processing later, which means we'll
try to delete the file '--'.  :-)

I think a shift before the break in the -- case would fix this.

-- 
Shawn.
