From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git Daemon Dummy: 301 Redirects for git:// to https://
Date: Tue, 23 Feb 2016 19:13:28 +0700
Message-ID: <CACsJy8D1H6k2FJOHQnT3BEnpXDPn8+ux-vJfDLMhO-JybFvR=w@mail.gmail.com>
References: <CAHmME9rTpGNHMKbXD48oBYm136=u79YiHjX5hm8ZYC4xSThJsA@mail.gmail.com>
 <20160223061517.GA3252@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 23 13:14:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYBqx-00013P-Ae
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 13:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbcBWMOD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 07:14:03 -0500
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34635 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbcBWMN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 07:13:59 -0500
Received: by mail-lf0-f48.google.com with SMTP id j78so113724508lfb.1
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 04:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IImXWR2ZvKzs6YL65KH68LZrb9r3sE4miWnpKI8vrvU=;
        b=dmE1Ek//W0FNHoyW7fd7dz+8uowcsIHhRavvO/cwn1Mn0kqnmmtsuqUioY3TEK2BQU
         UTknLyjCokpMWlTM3yBX/b8qRxSodFQG75kBtQQgUVsHcC9Nux+2HhYGgjQrkWtkZO9+
         b/rTy2yiV9Tp8AAyHS0GfRfl3QP0mu/NWYY6x1P2BRK9z4C+EJqETUNj9S27pZD3gSxO
         r15PQ5foXWHe6U/eurKurQiTHQ2mb5I4l00KSfTWGKGSSYq7DbCc5d2gQGSvWH/lB9Fi
         +ZR9gMsvQq0wn3RFVpicU1RfSkRCMmyxZN8oJQzDkG8bzgD08BFRG7v2S14T72npouAS
         +O0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=IImXWR2ZvKzs6YL65KH68LZrb9r3sE4miWnpKI8vrvU=;
        b=TdDzIa5T570dwz62cxapML5yudQIlXOpkWldHMpHSsrrtj95Ay/VYFdNwzKrEqIsMo
         Dg1mA9Um4tnwRhEm5eXuDTir8elW8GFhPb3m6Q81PhP1HTUScx4HGkBuo/+JGCt/F387
         zz1JokHz14C0319ghiXSJzexphgegFc4yzPhkL7spydZr+2u1Of+vwGbXp04W+WjSPs/
         Gm7wQRpPjAnQ1lbYOo5WwFa1KoFtQ987gP0OAwci0KPqKlpYbVrGp1Z9FeOLkTQOq5/h
         O3PuT4eK7Ey+7Ou32p0J3WaFb2QahLaj3gRgO4eMtVe50jw6ujAxeO7t5gFS3eQRnjw/
         I0gA==
X-Gm-Message-State: AG10YOT5v1n4gRatSbbghtjdA8jyChIR30pAoC/NjQK+zWWDDEmEeBvQaTOvXjfWVIhDdtQY03+QC2JfMuZr8g==
X-Received: by 10.25.159.68 with SMTP id i65mr12028302lfe.94.1456229638507;
 Tue, 23 Feb 2016 04:13:58 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Tue, 23 Feb 2016 04:13:28 -0800 (PST)
In-Reply-To: <20160223061517.GA3252@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287047>

On Tue, Feb 23, 2016 at 1:15 PM, Jeff King <peff@peff.net> wrote:
> I looked into it once, but was unable to find any reasonably sized
> explanation of how to implement either the server or client side of
> websockets. :)

Wikipedia explained handshake in four paragraphs. Then you only have
to chew about ten pages of RFC6455, from page 27 to master data frames
(and we probably just need binary frames for pkt-line, or fragmented
when sending the pack). Come on, give us git+ws:// :D

PS. Too bad I couldn't find any minimal library that just deals with
websocket data frame handling. I suppose curl can deal with handshake
just fine.
-- 
Duy
