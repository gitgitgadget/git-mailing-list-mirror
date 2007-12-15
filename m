From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-browse-help?
Date: Sat, 15 Dec 2007 17:25:18 -0500
Message-ID: <20071215222518.GL14735@spearce.org>
References: <20071214092829.GA22725@coredump.intra.peff.net> <7vtzmlrxc2.fsf@gitster.siamese.dyndns.org> <20071215100811.GA1692@coredump.intra.peff.net> <20071215110153.GA3447@coredump.intra.peff.net> <20071215111154.GB3447@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 15 23:25:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3fS9-0006IE-P4
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 23:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753441AbXLOWZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 17:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753384AbXLOWZ1
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 17:25:27 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49477 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753267AbXLOWZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 17:25:26 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1J3fRW-0003KF-On; Sat, 15 Dec 2007 17:25:10 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3324220FBCB; Sat, 15 Dec 2007 17:25:18 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20071215111154.GB3447@coredump.intra.peff.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68420>

Jeff King <peff@peff.net> wrote:
> -- >8 --
> teach bash completion to treat commands with "--" as plumbing
> 
> There is a convention that commands containing a double-dash
> are implementation details and not to be used by mortals. We
> should automatically remove them from the completion
> suggestions as plumbing.
> 
> Signed-off-by: Jeff King <peff@peff.net>

Acked-by: Shawn O. Pearce <spearce@spearce.org>


> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 58e0e53..2fd32db 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -291,7 +291,7 @@ __git_commands ()
>  	for i in $(git help -a|egrep '^ ')
>  	do
>  		case $i in
> -		add--interactive) : plumbing;;
> +		*--*)             : plumbing pattern;;
>  		applymbox)        : ask gittus;;
>  		applypatch)       : ask gittus;;
>  		archimport)       : import;;
> @@ -308,7 +308,6 @@ __git_commands ()
>  		diff-tree)        : plumbing;;
>  		fast-import)      : import;;
>  		fsck-objects)     : plumbing;;
> -		fetch--tool)      : plumbing;;
>  		fetch-pack)       : plumbing;;
>  		fmt-merge-msg)    : plumbing;;
>  		for-each-ref)     : plumbing;;

-- 
Shawn.
