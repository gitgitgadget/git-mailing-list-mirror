From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] intersect_paths: respect mode in git's tree-sort
Date: Tue, 19 Aug 2014 23:35:39 -0400
Message-ID: <20140820033539.GA2773@peff.net>
References: <20140820021428.GA22266@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kirill Smelkov <kirr@mns.spb.ru>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 05:35:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJwgd-0000IN-1E
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 05:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbaHTDfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 23:35:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:55299 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751713AbaHTDfl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 23:35:41 -0400
Received: (qmail 16450 invoked by uid 102); 20 Aug 2014 03:35:41 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Aug 2014 22:35:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Aug 2014 23:35:39 -0400
Content-Disposition: inline
In-Reply-To: <20140820021428.GA22266@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255551>

On Tue, Aug 19, 2014 at 10:14:30PM -0400, Jeff King wrote:

> diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
> index 1019d7b..71a664d 100755
> --- a/t/t4038-diff-combined.sh
> +++ b/t/t4038-diff-combined.sh
> @@ -401,4 +401,38 @@ test_expect_success 'combine diff missing delete bug' '
>  	compare_diff_patch expected actual
>  '
>  
> +test_expect_success 'combine diff gets tree sorting right' '
> +	# create a directory and a file that sort differently in trees
> +	# versus byte-wise (implied "/" sorts ".")

This should be s/sorts/& after/, of course.

-Peff
