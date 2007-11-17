From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/3] send-pack: check ref->status before updating
	tracking refs
Date: Sat, 17 Nov 2007 14:45:46 +0100
Message-ID: <20071117134546.GC2716@steel.home>
References: <20071117125323.GA23125@sigill.intra.peff.net> <20071117125515.GB23186@sigill.intra.peff.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 17 14:46:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItNzr-0000fa-Iw
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 14:46:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459AbXKQNpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 08:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752681AbXKQNpt
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 08:45:49 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:42677 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbXKQNpt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 08:45:49 -0500
Received: from tigra.home (Fcbd3.f.strato-dslnet.de [195.4.203.211])
	by post.webmailer.de (mrclete mo21) (RZmta 14.0)
	with ESMTP id 6026a0jAHDFH1s ; Sat, 17 Nov 2007 14:45:47 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id CC272277AE;
	Sat, 17 Nov 2007 14:45:46 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id A57D756D22; Sat, 17 Nov 2007 14:45:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071117125515.GB23186@sigill.intra.peff.net>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBg+Ffo=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65278>

Jeff King, Sat, Nov 17, 2007 13:55:15 +0100:
> diff --git a/t/t5404-tracking-branches.sh b/t/t5404-tracking-branches.sh
> index 799e47e..1493a92 100755
> --- a/t/t5404-tracking-branches.sh
> +++ b/t/t5404-tracking-branches.sh
> @@ -45,4 +45,9 @@ test_expect_success 'check tracking branches not updated for failed refs' '
>  	test "$(git rev-parse origin/b2)" = "$b2"
>  '
>  
> +test_expect_success 'deleted branches have their tracking branches removed' '
> +	git push origin :b1 &&
> +	test "$(git rev-parse origin/b1)" = "origin/b1"
> +'
> +
>  test_done

Oh, missed that.

Completely-Acked-By: Alex "Sleepy" Riesen <raa.lkml@gmail.com>
