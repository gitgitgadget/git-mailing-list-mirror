Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C38C41F728
	for <e@80x24.org>; Fri, 24 Jun 2016 11:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbcFXLfT (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 07:35:19 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:46362 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750956AbcFXLfT convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 07:35:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 6AB902612;
	Fri, 24 Jun 2016 13:35:15 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JJSsctl2WM94; Fri, 24 Jun 2016 13:35:15 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 4D6D625E8;
	Fri, 24 Jun 2016 13:35:15 +0200 (CEST)
Date:	Fri, 24 Jun 2016 13:49:24 +0200 (CEST)
From:	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	"Robin H. Johnson" <robbat2@gentoo.org>
Message-ID: <1865881092.716701.1466768964884.JavaMail.zimbra@ensimag.grenoble-inp.fr>
In-Reply-To: <20160623232158.GD3668@sigill.intra.peff.net>
References: <20160623231512.GA27683@sigill.intra.peff.net> <20160623232158.GD3668@sigill.intra.peff.net>
Subject: Re: [PATCH v3 4/4] archive-tar: drop return value
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF39 (Linux)/8.0.9_GA_6191)
Thread-Topic: archive-tar: drop return value
Thread-Index: bEfKj7aje8Iv0SWDLLCl8VBHXlPL1g==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff,

Jeff King <peff@peff.net> writes:
> @@ -413,7 +411,7 @@ static int write_tar_archive(const struct archiver *ar,
>  {
>          int err = 0;
>  
> -        err = write_global_extended_header(args);
> +        write_global_extended_header(args);
>          if (!err)
>                  err = write_archive_entries(args, write_tar_entry);

If we drop the error code from 'write_global_extended_header' then the
above 'if (!err)' becomes useless (always evaluates to 'true' since
'err' is set to '0').

>          if (!err)

Thanks,
Rémi
