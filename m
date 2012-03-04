From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] http.proxy: also mention https_proxy and all_proxy
Date: Sun, 4 Mar 2012 13:46:28 +0100
Message-ID: <20120304124627.GA1596@ecki>
References: <20120303145053.GA29948@ecki>
 <20120303174252.GC28602@sigill.intra.peff.net>
 <7v399p72a8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 04 13:55:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4AyE-0000Nv-8Q
	for gcvg-git-2@plane.gmane.org; Sun, 04 Mar 2012 13:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780Ab2CDMy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Mar 2012 07:54:56 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:11867 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753721Ab2CDMy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 07:54:56 -0500
Received: from localhost (p5B22D02D.dip.t-dialin.net [91.34.208.45])
	by bsmtp.bon.at (Postfix) with ESMTP id 337C42C400A;
	Sun,  4 Mar 2012 13:55:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v399p72a8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192150>

On Sat, Mar 03, 2012 at 02:22:39PM -0800, Junio C Hamano wrote:
> 
> As to the way forward, I suspect that http.proxy was a mistake to begin
> with, considering the structure of namespace our configuration variables
> fit in.  Shouldn't they be proxy.http, proxy.https, etc.?

I actually prefer the current behavior, which is to configure only one
proxy for all protocols. I have not seen a setup where HTTP and HTTPS
are routed through different proxies before. But if this is really
needed, one has the option to use the environment variable, or
remote.<name>.proxy.

I suggest instead that we map curl's CURLOPT_PROXY to core.proxy.  That
would also fit well with the remote.<name>.proxy scheme.
