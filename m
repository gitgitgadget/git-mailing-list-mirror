From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: disable "Reset %s branch to here" when on a detached head
Date: Fri, 2 May 2008 22:52:04 +1000
Message-ID: <18459.3700.934377.597975@cargo.ozlabs.ibm.com>
References: <200803181535.53635.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Fri May 02 14:57:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrupT-0004dm-41
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 14:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764243AbYEBM4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 08:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761544AbYEBM4q
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 08:56:46 -0400
Received: from ozlabs.org ([203.10.76.45]:47849 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760852AbYEBM4p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 08:56:45 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 9450CDDDEE; Fri,  2 May 2008 22:56:43 +1000 (EST)
In-Reply-To: <200803181535.53635.barra_cuda@katamail.com>
X-Mailer: VM 7.19 under Emacs 22.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80987>

Michele Ballabio writes:

> When we are on a detached head, reset has no sense, so disable
> the line on the context menu.

Sounds reasonable.

> -	$menu entryconfigure 7 -label [mc "Reset %s branch to here" $mainhead]
> +	if {$mainhead ne {}} {
> +	    $menu entryconfigure 7 -label [mc "Reset %s branch to here" $mainhead]
> +	} else {
> +	    $menu entryconfigure 7 -label [mc "Reset %s branch to here" $mainhead] -state disabled

I wonder if we can make this message something more appropriate than
"Reset  branch to here" (since $mainhead has to be the empty string
here)?  Not sure what I would suggest though. :)

Paul.
