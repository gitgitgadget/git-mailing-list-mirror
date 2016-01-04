From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 14/14] shortlog: match commit trailers with --ident
Date: Mon, 4 Jan 2016 04:44:15 -0500
Message-ID: <CAPig+cTqfd4QezR09QwUb_7viML_4LB5ChNF_eXVCsbGHLaDMQ@mail.gmail.com>
References: <20151229071847.GA8726@sigill.intra.peff.net>
	<20151229073832.GN8842@sigill.intra.peff.net>
	<20151229075013.GA9191@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 04 10:44:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aG1gd-0004wA-PW
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 10:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbcADJoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 04:44:18 -0500
Received: from mail-vk0-f53.google.com ([209.85.213.53]:33020 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbcADJoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 04:44:16 -0500
Received: by mail-vk0-f53.google.com with SMTP id a188so247512496vkc.0
        for <git@vger.kernel.org>; Mon, 04 Jan 2016 01:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=s5PcmeqIcvk3hKxoWAUpPn0lEzZ/6xFyBfKg1d7Vnx0=;
        b=dLB0AZEBo3dh2vCMlq9a2Axx+lnWgzsRChEZfH/2hnQQbxDeDeTLYGSsaCjU3nBcgI
         4iunBjCikOIFfULJ2xvD6IcJraB+bCA1TGSF0vHioCG9XkPjhmL0It0wM0mI8psgSph7
         8TcpxsTD/m3/Vhv8Fb/iNTjOl/qkAzKfEre5oy1M61vuh7tp3Rt8zXUs3yKLpc3TQLhY
         pelHSt9MB4jCD5rxBZ/86OEGPzleg9lNB8i7EZEaCMVV5DB7xybuw5xPbGFI9bTnVGGb
         b/OupCNDqI6biNV+/aGxW5pjCi+7miUoMj448c37px0caFCQ63v3Cx1aMLTdnDZpapwN
         ufPA==
X-Received: by 10.31.58.74 with SMTP id h71mr60071672vka.151.1451900656042;
 Mon, 04 Jan 2016 01:44:16 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 4 Jan 2016 01:44:15 -0800 (PST)
In-Reply-To: <20151229075013.GA9191@sigill.intra.peff.net>
X-Google-Sender-Auth: gqBGGrl7DBD6iEjiIkXhS1Zih9A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283291>

On Tue, Dec 29, 2015 at 2:50 AM, Jeff King <peff@peff.net> wrote:
> This doesn't leave us many syntactic "outs" for adding new ident types
> in the future (nor can you match a trailer called "Author"). I guess we
> could call this "--ident=trailer:reviewed-by" to be more precise, but
> it's more annoying to type. Perhaps we could consider that the
> "official" syntax, and DWIM "--ident=foo" to "--ident=trailer:foo", with
> the caveat that it may change in the future. I dunno.

Would anyone ever want to be able to specify multiple trailers for
counting? That is:

    --ident=trailer:helped-by,reviewed-by

or

    --ident=trailer:helped-by --ident=trailer:reviewed-by
