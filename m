Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 935EA1F406
	for <e@80x24.org>; Thu, 14 Dec 2017 09:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750825AbdLNJmY (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 04:42:24 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43814 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbdLNJmX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 04:42:23 -0500
Received: by mail-qt0-f193.google.com with SMTP id w10so7134516qtb.10
        for <git@vger.kernel.org>; Thu, 14 Dec 2017 01:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=XjnKkzcssvNLOCbFuxKJRDDcMuw5phR315zXvW3WSSQ=;
        b=FK3e32igXoS48XaWO0ObFdNJUnDrSukEh7F7xv/AQIbC4A6qGoDtczlqc5YNqNd46r
         Q1eZl9otPnEbc9biWF49FA/q7XkdFO2EMfNcYeNfjGm4UNYXklQBw9qhjo2sy2KoB2i4
         mRMZ4UN/yJB1URZ+QXoHQHbL0vCpqvr0ozs5fVf9hvcGT/Wm2mL09UOBnBrPCAHn/BVa
         FLCQXixkG57GyLjyeL7FQAXx7AVcdjKGxoogL9hY3aLyZv2MiNzXeYsR+1Oz4961bvwf
         uWWGMUWHYxMjNAn1LnKpG/TFccZ/RdkYpcNhkF5uaDF0yoU0eP6xNttUVg6ntjgl/bA+
         9hxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=XjnKkzcssvNLOCbFuxKJRDDcMuw5phR315zXvW3WSSQ=;
        b=S+salmJFk6BTECAHiQ8q1Al1ypeDTLablqSNnWzQw/PHzjk7443yV1Xr72ViNEeUkV
         cjQLei/CsBsRo3eqNUv7nONI7wrBJTZ6Kanv5iTbW3Mtu39UpSON1W1iUDNSR6Nh9JI7
         8xK9niT2L5QnkzZnc1X07ybAVBnx9JdnOMAweJ5IMRuDy2yuahxH2/zVGmRebwIsJWcL
         TD3RkBW+T0zeUJHT2iB6d9MCFmoB3vlmgpddcXO6jZX7Ro9d7Q3dZ4iR2am1CtoH0OOx
         JPaDGBjRItS/+Ul7tiG8sqHfXw9jXZikDM1223X75NmU+aa2dAwvOz7Ib73l7ffjMs9e
         34tg==
X-Gm-Message-State: AKGB3mLv107NnYFkkASSF3lynKnAtrol0zFLgV35c9FynHcgDTIIWRlH
        fsNGHrKskTqxnZhkhUw95uHpkRDhuoNHxx512Oo=
X-Google-Smtp-Source: ACJfBov1r2yFcEIqcIZbcpx2QmurqyET1NmZCemfrWmTYZ0tA8kyYgDeHN4/3R4JZb0VTRNMF7ltWZtlKYKFwIhR5ws=
X-Received: by 10.200.35.28 with SMTP id a28mr16357688qta.51.1513244542688;
 Thu, 14 Dec 2017 01:42:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.4 with HTTP; Thu, 14 Dec 2017 01:42:22 -0800 (PST)
In-Reply-To: <20171214093257.15826-1-l.stelmach@samsung.com>
References: <CGME20171214093300eucas1p28ed9bf0261a43a12978b6a3bfe908321@eucas1p2.samsung.com>
 <20171205142326.6140-1-l.stelmach@samsung.com> <20171214093257.15826-1-l.stelmach@samsung.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 14 Dec 2017 04:42:22 -0500
X-Google-Sender-Auth: XTNPia_uK3IPABRgq-4gE30x1-A
Message-ID: <CAPig+cTYYGRynG8r_2DR53u77eCFDGe1BEDcEK3_cJQxT3yncQ@mail.gmail.com>
Subject: Re: [PATCH v4] git-gui: Prevent double UTF-8 conversion
To:     =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 14, 2017 at 4:32 AM, =C5=81ukasz Stelmach <l.stelmach@samsung.c=
om> wrote:
> Convert author's name and e-mail address from the UTF-8 (or any other)
> encoding in load_last_commit function the same way commit message is
> converted.
>
> Amending commits in git-gui without such conversion breaks UTF-8
> strings. For example, "\305\201ukasz" (as written by git cat-file) become=
s
> "\303\205\302\201ukasz" in an amended commit.
>
> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
> Changes since v3:
>
> - Added Reviewed-by footer. Thank you Johannes Schindelin, for review.

No need to re-send. If you consult Junio's latest "What's cooking"[1],
you'll find that your patch has already graduated from his 'pu' branch
to 'next' and is slated to graduate to 'master' (at some point).

[1]: https://public-inbox.org/git/xmqqzi6mutcc.fsf@gitster.mtv.corp.google.=
com/
