From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/9] update-index: add --checkout/--no-checkout to
	update CE_NO_CHECKOUT bit
Date: Wed, 19 Nov 2008 08:02:23 -0500
Message-ID: <20081119130223.GA27893@segfault.peff.net>
References: <1222833849-22129-1-git-send-email-pclouds@gmail.com> <1222833849-22129-2-git-send-email-pclouds@gmail.com> <1222833849-22129-3-git-send-email-pclouds@gmail.com> <1222833849-22129-4-git-send-email-pclouds@gmail.com> <1222833849-22129-5-git-send-email-pclouds@gmail.com> <1222833849-22129-6-git-send-email-pclouds@gmail.com> <20081118113316.GA18610@segfault.peff.net> <7vk5b0vp19.fsf@gitster.siamese.dyndns.org> <7v4p24tq59.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 14:03:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2mia-00047R-Da
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 14:03:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924AbYKSNCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 08:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752875AbYKSNCZ
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 08:02:25 -0500
Received: from peff.net ([208.65.91.99]:1432 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752857AbYKSNCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 08:02:25 -0500
Received: (qmail 27905 invoked by uid 1000); 19 Nov 2008 13:02:23 -0000
Content-Disposition: inline
In-Reply-To: <7v4p24tq59.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101337>

On Tue, Nov 18, 2008 at 06:18:10PM -0800, Junio C Hamano wrote:

> Having said all that, I wouldn't suggest redoing the patch using >>
> redirection.  But change from "touch 1 nondigit" to "touch nondigit 1"
> is a bit too subtle to my taste.  Let's write it this way instead:

Yes, I also dislike the subtlety, but my "obvious" idea was something
like:

  for i in 1 2 sub/1 sub/2; do
    touch $i
  done

which just seemed clunky. But:

> -	touch 1 2 sub/1 sub/2 &&
> +	touch ./1 ./2 sub/1 sub/2 &&

this is less clunky, and I have confirmed that it solves the problem. I
just wasn't clever enough to think of it in the first place. ;)

-Peff
