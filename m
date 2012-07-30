From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC v2 11/16] Add explanatory comment for transport-helpers
 refs mapping.
Date: Mon, 30 Jul 2012 14:15:53 -0500
Message-ID: <20120730191553.GC9564@burratino>
References: <1343658683-10713-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <20120730170842.GC8515@burratino>
 <7vwr1lqhd7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 21:16:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvvRm-0006cB-VH
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 21:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754366Ab2G3TQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 15:16:00 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:41606 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238Ab2G3TP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 15:15:59 -0400
Received: by gglu4 with SMTP id u4so5210895ggl.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 12:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=g6Ob5YrsELZRRfl/KFrXQPKg8MFUE6ky+HIcvaqtwi8=;
        b=ofpcFZxEzO2TUR/0U3s8ioH/IemzBO/B5FR7PTlIWiaCw9CEV67rDf5Da/SJVY3bXP
         p1p2uSy3DoZ9chDQVa8iqz2/0zu/fnd2l/VQCbQV93XgpFaIEbIyPh/l9zU8B2A6HutK
         AvI98VV4rxo/BlYoZ6DJBTbp4MVzvkSnkG0IVgbpqpKuoeeneKchmRoEI15wq2Ywp3cA
         grFA6hamxbjySEZOG/M0dig/D2AEprC75JSVgkEaQyLFsmtPdt6rRR7m0NYBMufXDJmt
         sSBACjgE+nW8SusKfy6ccSrewLiM0n3SvP7otp4iwbiLuRIxLeQueOn64mfUN8kWNa+I
         JcCQ==
Received: by 10.50.191.227 with SMTP id hb3mr56190igc.45.1343675758857;
        Mon, 30 Jul 2012 12:15:58 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id wo5sm7199522igc.0.2012.07.30.12.15.57
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jul 2012 12:15:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vwr1lqhd7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202605>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>>> +	/*
>>> +	 * If the remote helper advertised the "refspec" capability,
>>> +	 * it will have the written result of the import to the refs
>
> perhaps s/will have the written result of/would have written result of/?

That would sound like 'If the remote helper advertised the "refspec"
capability, it would have written the result of the import to the
refs, but it didn't, so...', so I think "will" is the right tense.
But 'will have the written' is awkward.  How about:

	 * The fast-import stream of a remote helper advertising the
	 * "refspec" capability writes to the refs named after the right
	 * hand side of the first refspec matching each ref we were
	 * fetching.
	 *
	 * (If no "refspec" capability is specified, for historical
	 * reasons the default is *:*.)
	 *
	 * Store the result in to_fetch[i].old_sha1. [...]
