From: Joshua N Pritikin <jpritikin@pobox.com>
Subject: Re: [PATCH] Don't allow newlines to occur in $Id:$ collapse
Date: Fri, 25 May 2007 18:58:00 +0530
Message-ID: <20070525132800.GH6667@always.joy.eth.net>
References: <200705251412.06196.andyparkins@gmail.com> <200705251413.42389.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 15:28:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrZq7-000739-O1
	for gcvg-git@gmane.org; Fri, 25 May 2007 15:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbXEYN2L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 09:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbXEYN2L
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 09:28:11 -0400
Received: from rune.pobox.com ([208.210.124.79]:53721 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936AbXEYN2L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 09:28:11 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 8A56AF0CAA;
	Fri, 25 May 2007 09:28:31 -0400 (EDT)
Received: from emit.nirmalvihar.info (house.nirmalvihar.info [61.17.90.7])
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 5D664F0BCB;
	Fri, 25 May 2007 09:28:27 -0400 (EDT)
Received: by emit.nirmalvihar.info (sSMTP sendmail emulation); Fri, 25 May 2007 18:58:01 +0530
Content-Disposition: inline
In-Reply-To: <200705251413.42389.andyparkins@gmail.com>
X-PGP-Key: 06E3 3D22 D307 AAE6 ACB4  6B44 A9CA A794 A4A6 0BBD
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48371>

On Fri, May 25, 2007 at 02:13:42PM +0100, Andy Parkins wrote:
> If a newline ever made it into an repository-side expanded $Id$ field,
> the keyword would still be detected as a keyword and collapsed, before
> rexpansion, e.g.
> 
>  $Id: all of this text would be removed, even if there
>  were a newline in the middle of it$
> 
> This patch catches newlines in this case and abandons treating this as a
> keyword expansion, this text would be left untouched in the working
> checkout.

That's better but I would error out instead of silently ignoring it.
Your choice.
