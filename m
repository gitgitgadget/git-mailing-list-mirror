From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] http: fix charset detection of extract_content_type()
Date: Wed, 18 Jun 2014 03:40:26 -0400
Message-ID: <20140618074026.GB24769@sigill.intra.peff.net>
References: <1403043113-12579-1-git-send-email-eungjun.yi@navercorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yi EungJun <eungjun.yi@navercorp.com>, git@vger.kernel.org
To: Yi EungJun <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 09:41:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxAUu-0001ok-Fg
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 09:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbaFRHkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 03:40:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:46594 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964996AbaFRHk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 03:40:28 -0400
Received: (qmail 25336 invoked by uid 102); 18 Jun 2014 07:40:29 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 02:40:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 03:40:26 -0400
Content-Disposition: inline
In-Reply-To: <1403043113-12579-1-git-send-email-eungjun.yi@navercorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251972>

On Wed, Jun 18, 2014 at 07:11:53AM +0900, Yi EungJun wrote:

> From: Yi EungJun <eungjun.yi@navercorp.com>
> 
> extract_content_type() could not extract a charset parameter if the
> parameter is not the first one and there is a whitespace and a following
> semicolon just before the parameter. For example:
> 
>     text/plain; format=fixed ;charset=utf-8
> 
> And it also could not handle correctly some other cases, such as:
> 
>     text/plain; charset=utf-8; format=fixed
>     text/plain; some-param="a long value with ;semicolons;"; charset=utf-8
> 
> Thanks-to: Jeff King <peff@peff.net>
> Signed-off-by: Yi EungJun <eungjun.yi@navercorp.com>

Thanks, this version looks good to me.

-Peff
