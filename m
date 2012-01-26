From: Stephen Bash <bash@genarts.com>
Subject: Re: [PATCH] Don't search files with an unset "grep" attribute
Date: Thu, 26 Jan 2012 08:51:52 -0500 (EST)
Message-ID: <1af46e50-fdc5-47b8-af36-d070d91dd954@mail>
References: <20120125214625.GA4666@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Conrad Irwin <conrad.irwin@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 26 15:01:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqPt4-0006rM-3e
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 15:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027Ab2AZOBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 09:01:08 -0500
Received: from hq.genarts.com ([173.9.65.1]:34218 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751645Ab2AZOBH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 09:01:07 -0500
X-Greylist: delayed 538 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Jan 2012 09:00:57 EST
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 39438BE2669;
	Thu, 26 Jan 2012 08:51:58 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vCZGoctEDEej; Thu, 26 Jan 2012 08:51:52 -0500 (EST)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 35EE7BE2969;
	Thu, 26 Jan 2012 08:51:52 -0500 (EST)
In-Reply-To: <20120125214625.GA4666@sigill.intra.peff.net>
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC16 (Mac)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189148>

----- Original Message -----
> From: "Jeff King" <peff@peff.net>
> Sent: Wednesday, January 25, 2012 4:46:26 PM
> Subject: Re: [PATCH] Don't search files with an unset "grep" attribute
>
> ... snip ...
> 
> So if this was all spelled:
> 
>   $ cat .gitattributes
>   *.pdf filetype=pdf
>   $ cat .git/config
>   [filetype "pdf"]
>           binary = true
>           textconv = pdf2txt
> 
> I think it would be a no-brainer that those type attributes should
> apply to "git grep".

Looking at this purely as a user, what difference/advantage would that bring versus

  $ cat .gitattributes
  *.pdf binary=true textconv=pdf2text

or

  $ cat .gitattributes
  [attr]pdf binary=true textconv=pdf2text
  *.pdf pdf

(admittedly I have no clue if gitattributes actually supports anything like this)

I guess my point is as a user, I've gravitated to "gitattributes is about files in my repo, gitconfig is about Git's behavior" (though this is a grey area).

To partially answer my own question: one advantage of putting the filetype information in a config file is it allows system- and user-wide filetype settings.  In my personal experience I've always handled that information on a per-repository basis, but that doesn't mean everyone would want to.

Thanks,
Stephen
