From: Christopher Tiwald <christiwald@gmail.com>
Subject: Re: [PATCH v3] push: Provide situational hints for non-fast-forward
 errors
Date: Mon, 26 Mar 2012 15:57:43 -0400
Message-ID: <20120326195743.GD32387@gmail.com>
References: <20120320043133.GA2755@gmail.com>
 <20120323214114.GB18198@sigill.intra.peff.net>
 <20120326192001.GB32387@gmail.com>
 <20120326195150.GA13098@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, zbyszek@in.waw.pl,
	Matthieu.Moy@grenoble-inp.fr, drizzd@aon.at
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 21:57:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCG3A-0002wS-Nt
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 21:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755474Ab2CZT5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 15:57:51 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:63550 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283Ab2CZT5u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 15:57:50 -0400
Received: by qaeb19 with SMTP id b19so2415218qae.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 12:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=gNEOyWkTwYSWWINH5Dpq53VRdmTPzcItMF4gVKHYGh4=;
        b=MLB8ZrqeF6UpTEvTKp44v0iKKTss1nYM5/BnNbRSfdUdNGREeXobnkjTO5FEb9Lmbw
         EJzsT7cyJVX9m3gSVQ5gyOx0Wa72cIekMHBJGkmZFIuRI/+RbUI79JtqxAkuDMsyNpSy
         id/qVDyMkJIxbCq/+zwIMIkkodojguTA0TGcVe4bcu6nosOMOKwwUsw+LGle17tv4+Ay
         ETI7wJ/SIndzldaJ7ACOT6D7T9lYasiuXV4f4whPD+p+NvcvJbtaMbQ2G6SzWD3FBz1c
         OBDAdi4xoU33dY0F+G97ggA9aRLvT2CbXs07oleiAN6R8wsoD9eyw7w5so0oafirAzTW
         xUZw==
Received: by 10.224.189.137 with SMTP id de9mr7124324qab.45.1332791869337;
        Mon, 26 Mar 2012 12:57:49 -0700 (PDT)
Received: from gmail.com ([216.55.38.246])
        by mx.google.com with ESMTPS id ha10sm31577593qab.14.2012.03.26.12.57.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Mar 2012 12:57:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120326195150.GA13098@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193968>

On Mon, Mar 26, 2012 at 03:51:50PM -0400, Jeff King wrote:
> On Mon, Mar 26, 2012 at 03:20:01PM -0400, Christopher Tiwald wrote:
> 
> > I used the REF_STATUS_* enum as a template for what I wanted to accomplish
> > when authoring v1, but did notice there was no other place my new
> > options made much sense (Junio helped me remove one other call between v1
> > and v2). I like the readability fixup, but it won't compile as both push.c
> > and transport.c need to see these. Would something like the following
> > work? It simply moves the define statements to cache.h, so that both push and
> > transport can use them.
> 
> My suggestion put them in transport.h, which is included from both
> places. It compiles fine for me. Am I missing something?

Ah nope. That was me. Sorry about the noise. This otherwise makes sense
to me.

--
Christopher Tiwald
