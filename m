From: Peter van der Does <peter@ourvirtualhome.com>
Subject: Re: git tag listing order
Date: Tue, 24 Nov 2009 14:24:28 -0500
Message-ID: <20091124142428.514564d6@montecarlo.grandprix.int>
References: <20091124105609.0980e796@montecarlo.grandprix.int>
	<20091124185947.GA24409@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 24 20:24:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ND10H-0003vx-Nm
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 20:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758199AbZKXTY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 14:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758164AbZKXTY2
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 14:24:28 -0500
Received: from bellona.lunarservers.com ([74.50.21.190]:45370 "EHLO
	bellona.lunarservers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758168AbZKXTY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 14:24:28 -0500
Received: from c-69-248-103-68.hsd1.nj.comcast.net ([69.248.103.68] helo=monza.grandprix.int)
	by bellona.lunarservers.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <peter@ourvirtualhome.com>)
	id 1ND104-0000ud-M9
	for git@vger.kernel.org; Tue, 24 Nov 2009 11:24:32 -0800
Received: from montecarlo.grandprix.int (unknown [192.168.1.102])
	by monza.grandprix.int (Postfix) with ESMTPA id F00EA101FCD
	for <git@vger.kernel.org>; Tue, 24 Nov 2009 14:24:30 -0500 (EST)
In-Reply-To: <20091124185947.GA24409@coredump.intra.peff.net>
X-Mailer: Claws Mail 3.7.3 (GTK+ 2.18.3; i486-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bellona.lunarservers.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - ourvirtualhome.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133589>

On Tue, 24 Nov 2009 14:00:23 -0500
Jeff King <peff@peff.net> wrote:

> On Tue, Nov 24, 2009 at 10:56:09AM -0500, Peter van der Does wrote:
> 
> > I'm using git 1.6.5.3 on Ubuntu and was wondering if there is a way
> > to list tags in order of when they were added to the tree, instead
> > of alphabetical?
> 
> You can use for-each-ref with its sort option:
> 
>   git for-each-ref --sort=taggerdate --format='%(refname:short)'
> refs/tags
> 
> Though note that unannotated tags will have no taggerdate, and will
> all sort to the front of the list. To exclude them, I think you'd
> have to use a special format to grep and sort yourself. Something
> like:
> 
>   git for-each-ref \
>     --format='%(taggerdate:iso8601) %(refname:short)' refs/tags |
>     grep -v '^ ' |
>     sort |
>     cut -d' ' -f4-
> 
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks for the info, just what I was looking for.

-- 
Peter van der Does

GPG key: E77E8E98
Twitter: @petervanderdoes
git Ubuntu Packages:
http://blog.avirtualhome.com/git-packages-for-ubuntu/
