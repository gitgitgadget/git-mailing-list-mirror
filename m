From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] pretty: Fix bug in truncation support for %>, %< and %><
Date: Sun, 28 Apr 2013 06:59:04 +0700
Message-ID: <CACsJy8Dx2tKdQDLw9=i1aM6=uqVBvHYpzq-q+rQE-e7-oJTRcg@mail.gmail.com>
References: <517C2A68.4030802@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Apr 28 01:59:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWF1n-0004oC-NF
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 01:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726Ab3D0X7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 19:59:35 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:38075 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870Ab3D0X7f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 19:59:35 -0400
Received: by mail-oa0-f49.google.com with SMTP id j1so5122495oag.36
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 16:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=4TK8mGynZMz/p1qMTN3TAvibHIUQrA4ZJN78gVTQqmw=;
        b=S86lnKAVvYtFjB0XubV9Z1JOjPgWQcxwDZ+UA/XIjp6yMUCPgKz3WZai46EvPClN2N
         GSlqOukr3WcRwvNHX2NMZeXaW20bKb4tQfeRt3ommP7BLn4wmcYsmz/xTup0eCAKDOLR
         37wrCokjkeqclKIkhiNrXOFWW5wr6FgaTUej7n3xWpQl5rPQ9Fw0DadxmgE22WS9/qsb
         9KwTVnxBpKx0Jf5c8Ye8WVsSqeIxMg7OO+zOp5rNzW07j1JOpHvoE/VUpZ8InQl6vRnG
         Oug3jO9wiAOkWYYGqh7Tq5YjBuvMc56nRil0cfB9NKP0hHfJjWdNLLHvPo6ALuk/nHcH
         anPA==
X-Received: by 10.60.65.68 with SMTP id v4mr21493522oes.13.1367107174886; Sat,
 27 Apr 2013 16:59:34 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Sat, 27 Apr 2013 16:59:04 -0700 (PDT)
In-Reply-To: <517C2A68.4030802@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222717>

On Sun, Apr 28, 2013 at 2:43 AM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
> The truncation support was implemented with the assistance of a
> new strbuf function (strbuf_utf8_replace). This function contains
> the following code:
>
>        strbuf_attach(sb_src, strbuf_detach(&sb_dst, NULL),
>                      sb_dst.len, sb_dst.alloc);
>
> Unfortunately, this code is subject to unspecified behaviour. In
> particular, the order of evaluation of the argument expressions
> (along with the associated side effects) is not specified by the
> C standard.

Thanks for noticing and fixing it. What compiler did you use by the way?
--
Duy
