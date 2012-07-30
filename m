From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] buitin_config: return postitive status in get_value
Date: Mon, 30 Jul 2012 19:26:51 +0700
Message-ID: <CACsJy8CSXo-BsVsqNb4+f97ns30SuSn_iRJgEk=WjgGyEQaywQ@mail.gmail.com>
References: <1343475730-18743-1-git-send-email-nikolay@vladimiroff.com>
 <CACsJy8BUU13H1tRfTtUme_7u0Jf0upca31U-VNhXva_0R2MLoQ@mail.gmail.com>
 <CAJg5NvdAq_zEx2phVGS4EiUfqMtFJA2Bo=y1d3FJyWXtzMwCTw@mail.gmail.com>
 <20120728132923.GA31388@do> <7vipd7vzql.fsf@alter.siamese.dyndns.org> <7v4noqwb6e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nikolay Vladimirov <nikolay@vladimiroff.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 14:27:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svp4N-0001dl-El
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 14:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545Ab2G3M11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 08:27:27 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41905 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736Ab2G3M10 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 08:27:26 -0400
Received: by yenl2 with SMTP id l2so4697430yen.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 05:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6FpWrClBPZLH0cYXWdiMDcYhXtZ90esQ6azG/3k/jRE=;
        b=Qij8W77ijM6igKjylqEsXyf+m+tiLS6BIyALuIXoGtEV9q+YL9InYT/wKLzmDDAZPh
         e3kA+3tBVYGMpdEf/JnKbLUss/oOfxSxIKl3s/73UecOcwUXbQ0nnSGa0wxWKATfZQiU
         oVnkNxb2+SgbMftRH+fo2R//gdGDoQD0H1Vy+h0V/EC2yEdjZG8H9YzzCHTK+b01LpVT
         JE96U0gPM6G7i5MJt8Nsk4wmg+g1JKBfPhAHJSbQfCjlZUp1arZAUmtvzhz/vmXHWWwU
         aextKwU2JBINNd9I2QIOfV4ba8rBI1AxmtmME2/Mp95De3uwed/qdYv/ERsw61HT0xjt
         r9qg==
Received: by 10.50.87.131 with SMTP id ay3mr8180447igb.36.1343651241481; Mon,
 30 Jul 2012 05:27:21 -0700 (PDT)
Received: by 10.64.90.2 with HTTP; Mon, 30 Jul 2012 05:26:51 -0700 (PDT)
In-Reply-To: <7v4noqwb6e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202537>

On Mon, Jul 30, 2012 at 3:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> +. You use '--global' option without $HOME being properly set (ret=128),
> +. Any other errors (ret=7).

To be pedantic, ret=128 is a result of die() and not setting $HOME is
just one of them. There's also ret=129 for usage(), which is not
documented. So maybe we can make it clear that we document some exit
codes, but not all of them.

> -This command will fail (with exit code ret) if:
> +This command will fail with non-zero status if:

"This command will fail with non-zero status. Some important exit codes are:"
-- 
Duy
