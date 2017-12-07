Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D39E120954
	for <e@80x24.org>; Thu,  7 Dec 2017 17:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753715AbdLGR5F (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 12:57:05 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:34674 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752823AbdLGR5B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 12:57:01 -0500
Received: by mail-wr0-f171.google.com with SMTP id y21so8401787wrc.1
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 09:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5XjPZHTtPIHtagpvU2TZTIq93HmDzvJwFQ0fV9WhDJY=;
        b=AeXhuPzxVgVbEADTK0cwst6h4xUT6/MMG5oZ4wy88R0oV3GvUJ5T1vTBUDnHZeAWy9
         V3mpypGA14mfBd7Q/QJFdOIJuGyRvmU8VQ0CWcOfjQHn3L8SAvFeZwcqNYYz3LC6c4Rp
         qDHnp2XppMAe8p5Ej1P0kJJJVO/TJyPO57GqjulaOFQ31Uj7SgxVWO8NoPRBxEY1x3K3
         9DnKWaVAUNJKO7DA3qJBYQZzOiuxecCk1KcqFOL4d/q7hxeSmJYSVUJIYRXlVe5clnNL
         JrJpWbEeGw7PrNaM2FDIpe5Faa9iGvXYquU48CDNgbEF1LTo7jikrmTzN00Wh2rHK/9B
         wa/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5XjPZHTtPIHtagpvU2TZTIq93HmDzvJwFQ0fV9WhDJY=;
        b=suUIpNPXop/tkB+C2/GYRGZV/CG0MZ+S+MVzLWiQTk8O+QrsH+8gQmeukkwxhpleg2
         y2JkPIJf1ie64B79nBBmhXVW4FHlFKncRkmx+YVyQQGAQaKIZ/C3mvsvEyUhGCALq8iq
         69uu2biFTDsmd+ZTqNskrH5IsYVU2j8qL6wZ6lJZx2wXhH+38msywIAAkcMrZiGPLss/
         tmwyq+3Qe1PMhXoNDTM7faVOe17eYDVm3e18Oi4i/ZwjksZNDxndtl0qWmSmqAP59baR
         xB8pdBoV98D2PI46sOY5lW0lP1Z+2SJqQs8SE9qVWeVExFFGDHGkwoj9Mcbm5Lf1zYIF
         FZDg==
X-Gm-Message-State: AJaThX6nwRd9ZL5cnVX25dfJ9MhCB/w2lxe9cVTpBpRM1Qr27SsjqSqt
        bok0fdR8ZhhFuALU7YMAa+o=
X-Google-Smtp-Source: AGs4zMaImKqQsjgck+m1EsZZ0DbZZjsbHDPpF/vKUd5wZg5ZoPFlwDCyw6Cuic+4cOBSLIvcnNnA/g==
X-Received: by 10.223.133.198 with SMTP id 6mr23196167wru.199.1512669420447;
        Thu, 07 Dec 2017 09:57:00 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id k69sm5947374wmg.8.2017.12.07.09.56.59
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Dec 2017 09:56:59 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 2/2] launch_editor(): indicate that Git waits for user input
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <dfb2cde5-a499-8da3-9695-8c8fd46a96ad@gmail.com>
Date:   Thu, 7 Dec 2017 18:56:59 +0100
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <lars.schneider@autodesk.com>,
        git@vger.kernel.org, sbeller@google.com, sunshine@sunshineco.com,
        sandals@crustytoothpaste.net, peff@peff.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <84C88A13-FB21-425A-BEB2-C9041848CA67@gmail.com>
References: <20171207151641.75065-1-lars.schneider@autodesk.com> <20171207151641.75065-3-lars.schneider@autodesk.com> <xmqqr2s6ee7e.fsf@gitster.mtv.corp.google.com> <FCBDBD58-0593-4FFC-B574-61D67CAF13C6@gmail.com> <D17F94FA-702E-4E37-BDA5-94F0FFD5BD01@gmail.com> <xmqqmv2uec0p.fsf@gitster.mtv.corp.google.com> <dfb2cde5-a499-8da3-9695-8c8fd46a96ad@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 07 Dec 2017, at 18:37, Kaartic Sivaraam =
<kaartic.sivaraam@gmail.com> wrote:
>=20
> On Thursday 07 December 2017 10:00 PM, Junio C Hamano wrote:
>> +
>> +		if (print_waiting_for_editor) {
>> +			/*
>> +			 * A dumb terminal cannot erase the line later =
on. Add a
>> +			 * newline to separate the hint from subsequent =
output.
>> +			 *
>=20
>=20
>> +			 * In case the editor emits further cruft after =
what
>> +			 * we wrote above, separate it from our message =
with SP.
>=20
> I guess this part of the comment could be improved a little. I =
currently interpret it as "See if the editor emits further cruft, print =
a space in that case". Though, it's not what we are doing. Something =
like the following, perhaps?
>=20
>     In a non-dumb terminal, separate our message from further cruft
>     that might be emitted by the editor with SP.

I see what you mean. My (non-native) language feeling tells me that
reordering the sentence might sound better:

				 * In a non-dumb terminal, separate our =
message with SP
				 * from further cruft that might be =
emitted by the editor.


@Junio: If you agree with the change, can you squash either of the new =
versions?=20

Thanks,
Lars=
