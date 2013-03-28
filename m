From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: More detailed error message for 403 forbidden.
Date: Thu, 28 Mar 2013 11:41:20 -0700
Message-ID: <20130328184120.GQ28148@google.com>
References: <CAFT+Tg_PwAS__AYCwQQZjy4LVvAMZFJuJ+ediDJpRnxx73qMMg@mail.gmail.com>
 <20130328183601.GA11914@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Yi, EungJun" <semtlenori@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 28 19:41:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULHlq-00028J-Ht
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 19:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753744Ab3C1Sl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 14:41:26 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:55918 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335Ab3C1Sl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 14:41:26 -0400
Received: by mail-pb0-f52.google.com with SMTP id ma3so5935930pbc.11
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 11:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=AbqZza8nOka0SaUFP7Vzc6HRhJgCj2joElfMBpJ7PXY=;
        b=kWWTkvrLnXuYnvT/ZveuaFeL8fXzwb0g2zxUCG9+H3F/dNBOsMXnsBCpNxmGkZxH1p
         3HyKXezvPDSUWH9A9s52lqPacITPowRl0lWClKI30O3D5ycoOChcT6mLPaxaWFN77sUx
         I3/ktpfnz86FNjJAQAloVmWPcn4IEATZ6CeAVjc3fDi1b2hJvXA6Qg77R6/p0q8UNpE7
         qjKzqxQ0s6OnRrFO98w8m7bAcgY6qlpuWiCFr36KZ47l+EDoFuB7s8XFpYSirwIQzMUq
         D84nJKtvm+vKO3JRC2wcZhVtgJBtd+kA9GuHVD7W7RKxYoQQF/4c6RO7iUbbIyAqTikB
         z9Jg==
X-Received: by 10.66.122.167 with SMTP id lt7mr228271pab.168.1364496085584;
        Thu, 28 Mar 2013 11:41:25 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id da4sm7664576pbb.34.2013.03.28.11.41.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 28 Mar 2013 11:41:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130328183601.GA11914@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219440>

Jeff King wrote:

> One problem is that the content body sent along with the error is not
> necessarily appropriate for showing to the user (e.g., if it is HTML, it
> is probably not a good idea to show it on the terminal). So I think we
> would want to only show it when the server has indicated via the
> content-type that the message is meant to be shown to the user. I'm
> thinking the server would generate something like:
>
>    HTTP/1.1 403 Forbidden
>    Content-type: application/x-git-error-message
>
>    User 'me' does not have enough permission to access the repository.
>
> which would produce the example you showed above.

Would it make sense to use text/plain this way?

Curious,
Jonathan
