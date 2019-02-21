Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DC461F453
	for <e@80x24.org>; Thu, 21 Feb 2019 14:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfBUO0E (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 09:26:04 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35321 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUO0D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 09:26:03 -0500
Received: by mail-yw1-f67.google.com with SMTP id s204so10696990ywg.2
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 06:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=rIaXBPsqdXuBYQEhyMP8mW5x1ixMsUnDkCj463Txa2I=;
        b=anITEhYBfdKqIGGp1qI8I5i/B40gO9eKfyGoMstALIFMg0B88a0lXp8Z3iYaB+rcz3
         TMgHR1WADz8iplema4RjpQ4PDP9tHHByxrsW48vdBShl/tXu43LK3HbQO04HIFqsYUN+
         HtIlnnhw8CXREKAaYTyVd7tVDrUAwAzI7ltzL5j9nCQQic3AieHhjTywlSbLUsVUD+Zg
         nDZ1H3Zi4UXBwtGBB81bqHdwD6NqU23iaZwNtt/ZEtRRRMYuifbeDtAuFEQsCmOSI42j
         ewH9RE3gk/iNXc2xjohZluvWfQyUqild+7OW/Qi4zktzKfgiiUxR0UOYcvH37flhhxeZ
         xgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=rIaXBPsqdXuBYQEhyMP8mW5x1ixMsUnDkCj463Txa2I=;
        b=aED5D6eTC7R11y0OUhcH/+3e3kI0xHj7J4l2I8viXvCmZNVdXe4+bcIlPJEPt/YKWi
         ox53RjKvGX6skHwHi0KEiRu48zff80p9rPBBiZUoZ9q4FGql4LDbo6UAxdZxg3wIiVaC
         PWsDPaZMc5XdXs6oap1D61G6wxiVOqLQRU+gT0aM5Zkyog+lQYAhOBgr48V22k5p9u1p
         NGzPf8esmt9eztxRB5lzReb5ypSRltFzXi5gXBhEuGFV18IBTtqeSf6/6D2V8UzTCBxH
         o3BNIYnfkYgP0zu2yR3YycgsBXqubB5XUUQHFDklSh8G5hzon0+kJEY9AHisFxYYRLVQ
         x6PQ==
X-Gm-Message-State: AHQUAuaBtvVAebywtgWnbCOz1CWkfLZYAYIEtSDV2NDJp59Iqs+a8KPe
        BjUYrxX5/EbdNdCHcO+p9UGKYFrhWjv9ixOvIOu4Q8nD
X-Google-Smtp-Source: AHgI3IZ/75Itm2UnwFzQ+Il4pxaf8R4vqBdV0K7DPNkwSlWZpxe1MCeEnkzotZbzkk8S9EblDBvBrcwWnyxy7rlliF8=
X-Received: by 2002:a81:7d5:: with SMTP id 204mr32885581ywh.143.1550759162651;
 Thu, 21 Feb 2019 06:26:02 -0800 (PST)
MIME-Version: 1.0
References: <CAHMHMxVdpOnTkf9RHzCa+YjjvpqJApsSE03Jjyb_VbJp_4q-jw@mail.gmail.com>
In-Reply-To: <CAHMHMxVdpOnTkf9RHzCa+YjjvpqJApsSE03Jjyb_VbJp_4q-jw@mail.gmail.com>
From:   =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Date:   Thu, 21 Feb 2019 16:25:26 +0200
Message-ID: <CAHMHMxUfjnNXFikVD=rys_t5BUho=7uRw4LsXgAphFwSf3xOnw@mail.gmail.com>
Subject: Re: git format-patch can clobber existing patch
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello there,

During my work flow, I tend to use `git format-patch` to move patches
around (nasty, I know, but bear with me)

It has occured to me that, it is possible that `git format-patch` can
clobber existing files, if they match in the name and in the "patch
order".
However, if the patch is one, then, it will normally start with `0001-x.pat=
ch`

It was fine for me when I pushed updates of the same "patch series".
Now that I wanted to diff a "previous patch file" with the patch
upstream, however, it was almost a "disaster". :-)

Would it make sense / be easy enough to have some clobbering check / flag?

=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82 =CE=A3=CF=84=CE=B1=CF=8D=CF=81=
=CE=BF=CF=82
