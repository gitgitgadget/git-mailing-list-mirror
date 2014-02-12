From: Thomas Adam <thomas@xteddy.org>
Subject: Re: [PATCH] contrib/diff-highlight: multibyte characters diff
Date: Wed, 12 Feb 2014 23:10:49 +0000
Message-ID: <CA+39Oz5TSPNzYVvFytJwwUhRYjbEp5f_BdBWKT2tcYzpbF1WyQ@mail.gmail.com>
References: <1392109750-47852-1-git-send-email-sugi1982@gmail.com> <20140212205948.GA4453@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Yoshihiro Sugi <sugi1982@gmail.com>, git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 13 00:11:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDixT-0001gy-KK
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 00:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754667AbaBLXLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 18:11:06 -0500
Received: from mail-yh0-f50.google.com ([209.85.213.50]:45387 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754039AbaBLXLF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 18:11:05 -0500
Received: by mail-yh0-f50.google.com with SMTP id 29so9350848yhl.37
        for <git@vger.kernel.org>; Wed, 12 Feb 2014 15:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=SRS1mLCgViKlkA5UeStowF7YEdopUyOyug/l0xm8mZU=;
        b=pejmfWzPShFBSiIiusQ4WmfwXl8B/SUg6/W896EdAtReKQCiqMNxW2ayufevvd2sVa
         bELlak+QalL0oUBwkzA9eg7vmNgra1xyhIC7BnSaP0d0ld4iMDVyxaECsHtoPj6Iv7LT
         UFdDpfqlVsB9uyX6yYgBL+VzgLESG4JfIGHntDweiS+Yti9EL6//4pclEOndJHeDT3IL
         S4JeGfmdPOOTF8sTt2eJfAYVnB9RQcVYCH685PjELBZgAvXzCurq92+dtnDifdFvpyA/
         jFNcxVd4Cqx3QGcvhnqyt8J/q2CCGS3skwIisI/dK20UY6DXkmc1+NEFtubxiFfSBFJF
         KJkg==
X-Received: by 10.236.168.166 with SMTP id k26mr4809714yhl.64.1392246664340;
 Wed, 12 Feb 2014 15:11:04 -0800 (PST)
Received: by 10.170.173.194 with HTTP; Wed, 12 Feb 2014 15:10:49 -0800 (PST)
In-Reply-To: <20140212205948.GA4453@sigill.intra.peff.net>
X-Google-Sender-Auth: 3qJ-mfBpv7MIU54xdkbJx2EQ1uA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242033>

On 12 February 2014 20:59, Jeff King <peff@peff.net> wrote:
> +sub decode {
> +       my $orig = shift;
> +       my $decoded = eval { decode_utf8($orig, Encode::FB_CROAK) };
> +       return defined $decoded ?

I'd still advocate checking $@ here, rather than the defined $decoded check.

> +              ($decoded, sub { encode_utf8(shift) }) :
> +              ($orig, sub { shift });
> +}
> +

-- Thomas Adam
