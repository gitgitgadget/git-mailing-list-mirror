From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] builtin/merge.c: drop a parameter that is never used
Date: Fri, 24 Oct 2014 12:37:23 -0700
Message-ID: <20141024193723.GF5500@google.com>
References: <xmqq1tpxgw6t.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 24 21:37:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xhkg3-0002gC-Oc
	for gcvg-git-2@plane.gmane.org; Fri, 24 Oct 2014 21:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331AbaJXTha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2014 15:37:30 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:40341 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbaJXTh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2014 15:37:29 -0400
Received: by mail-pd0-f170.google.com with SMTP id z10so1988874pdj.15
        for <git@vger.kernel.org>; Fri, 24 Oct 2014 12:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=AMPymMNFYEe1fKrN1h+Dpo+2+k9xKBR0G+M6bah3uZc=;
        b=xVl99w4YEp+PMdHqvrRgIIfwpaCE8oA8tGFN28/oniuoYe1LMqWTpoNxiSY259BC/p
         iqX+RVgoU8gjvVB7CpGN6jTm12yTUg3hx7g9Z/dmFEmDABBEpm8sSKtxfPUmpJf2uyBv
         C0hcgxv6VUukgJg3IdK4TMoJzGM9M93G8qCBrnP5IOYY76HedW1FZnf4TyYXPU68V0Ka
         fn80iFUes+orlTz9ULWyQMKaN7S3iCDV+sXWRk6xW5Y0AvAfI2z+dYpPSUmusLivtuYU
         vkv4xOcM6ybcGYAqarZD8QwB07jqrZ+MleJen5xrpSf3iKcDxbg7bzrIvXAK38p7bdES
         LmiQ==
X-Received: by 10.68.135.198 with SMTP id pu6mr6765025pbb.106.1414179448614;
        Fri, 24 Oct 2014 12:37:28 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:70f7:b5d6:efd8:7317])
        by mx.google.com with ESMTPSA id vf10sm4536086pbc.11.2014.10.24.12.37.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 Oct 2014 12:37:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqq1tpxgw6t.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> Since the very beginning when we added the "renormalizing" parameter
> to this function with 7610fa57 (merge-recursive --renormalize,
> 2010-08-05), nobody seems to have ever referenced it.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

>  * ... or is there any "renormalization" the said commit meant to
>    but forgot to do?

I suspect it's related to this TODO from rerere.c::handle_cache:

	/*
	 * NEEDSWORK: handle conflicts from merges with
	 * merge.renormalize set, too
	 */
	ll_merge(&result, path, &mmfile[0], NULL,
		 &mmfile[1], "ours",
		 &mmfile[2], "theirs", NULL);

But if someone has time for it, rather than plumbing in a useless
parameter that goes nowhere, it would be better to add tests as a
reminder of what is unimplemented. :)

Thanks,
Jonathan
