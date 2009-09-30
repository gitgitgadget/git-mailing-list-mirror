From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-email: fix mutt regex for grouped aliases
Date: Wed, 30 Sep 2009 07:28:34 -0400
Message-ID: <20090930112833.GA4984@sigio.peff.net>
References: <1254269323-16600-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 30 13:25:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsxJ9-0005nI-Fv
	for gcvg-git-2@lo.gmane.org; Wed, 30 Sep 2009 13:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754192AbZI3LZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2009 07:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754180AbZI3LZI
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 07:25:08 -0400
Received: from peff.net ([208.65.91.99]:44035 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751405AbZI3LZH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2009 07:25:07 -0400
Received: (qmail 4999 invoked by uid 1000); 30 Sep 2009 11:28:35 -0000
Content-Disposition: inline
In-Reply-To: <1254269323-16600-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129340>

On Wed, Sep 30, 2009 at 03:08:43AM +0300, Felipe Contreras wrote:

> For example:
> alias -group friends foo Foo Bar <foo@bar.com>

Hmm. If I am reading the mutt docs correctly, is it also legal to have:

  alias -group group1 -group group2 foo Foo Bar <foo@bar.com>

?

Which would need just:

> -		if (/^\s*alias\s+(\S+)\s+(.*)$/) {
> +		if (/^\s*alias\s+(?:-group\s+\S+\s+)?(\S+)\s+(.*)$/) {

   (?:-group\s+\S+\s+)*

I think.

-Peff
