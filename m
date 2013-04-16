From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Mon, 15 Apr 2013 21:08:23 -0400
Message-ID: <CAPig+cTemYT1qTNpYFF2gvZhu=O=NwQu5GzAisgnMCjfZYFCkA@mail.gmail.com>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
	<20130415232532.GA7134@sigill.intra.peff.net>
	<20130416003038.GA5336@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 16 03:08:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URuNq-0006Cx-NO
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 03:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935205Ab3DPBI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 21:08:26 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:51119 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934834Ab3DPBIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 21:08:25 -0400
Received: by mail-la0-f54.google.com with SMTP id ec20so4944981lab.13
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 18:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=re2qQTiHgSIQD/N/eZwNl2N1iMTr1y4pak1l+fkV4KI=;
        b=TphEftlzQ3Ss6dFD64oLDhoGnzyC88oTh/Ie+suRd66rQlKy7MuVSKRrC+pvdCj2qX
         Vgrqscxqs3zsF1tf/8SUDdiA2zdh8hCJh+MhI7i2vcPHQaN7OsPl4IBfRPug0zscudCG
         Cer31kchPzWfGlNLqvFbuRMhOzJaXh+UUrxKHdKLqkoeShftUtTVINtamt038Vhvq99I
         Z0me18sn5mnUOLJ7UtxUYGyOWLPxZjeQNO1We3P5MEBKqEvvT6ToblF8LooOK2GWXYIs
         hrgSnps6AqcoJkKXY322PcXqST4SLCMSwjlv32pbFtELIWz5wintS60YMIrM5dmEVQnx
         /Uqw==
X-Received: by 10.152.20.226 with SMTP id q2mr80740lae.16.1366074503632; Mon,
 15 Apr 2013 18:08:23 -0700 (PDT)
Received: by 10.114.186.233 with HTTP; Mon, 15 Apr 2013 18:08:23 -0700 (PDT)
In-Reply-To: <20130416003038.GA5336@sigill.intra.peff.net>
X-Google-Sender-Auth: yE4i6WbN7O-mlko0aB_KFz57ClA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221341>

On Mon, Apr 15, 2013 at 8:30 PM, Jeff King <peff@peff.net> wrote:
> Subject: [PATCH] http: set curl FAILONERROR each time we select a handle
>
> Until commit 6d052d7 (http: add HTTP_KEEP_ERROR option,
> 2013-04-05), setting curl's FAILONERROR option was a global
> setup; we never changed it. However, 6d052d7 introduced in

s/in/an/

> option where some requests might turn off FAILONERROR. Later
> requests using the same handle would have the option
> unexpectedly turned off, which meant they would not notice
> http failures at all.
