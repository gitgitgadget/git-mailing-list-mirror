Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 566B61F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 10:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbeJKSDv (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 14:03:51 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:33844 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbeJKSDv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 14:03:51 -0400
Received: by mail-io1-f50.google.com with SMTP id w2-v6so6208242ioc.1
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 03:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dana-is.20150623.gappssmtp.com; s=20150623;
        h=from:content-transfer-encoding:mime-version:subject:date:references
         :to:in-reply-to:message-id;
        bh=uTjo8c01jxuf8S6wo3IZsfGuQQtaAVWSHCw+TvrhzqQ=;
        b=V+nZd90UUdwlWokNYtmRrL8VvZtOBrRsVEjYIWmzK43oD0I4rJuFSS84xBRHn1tb4l
         IXrZElZi3iQqp042sDEvIeDfgOvUsHs3J12Gt/ZGdyS01QQ4Ah7vTjEjej2Rf8HAqCA0
         hRSZGoZ+n9oU2kKSPKGBSTQKL/Z0qt73A/Yg5XSrvUiAKN60hzuj6YeEdp7rZYiPgvo2
         tMg3d14idCtroXB6uGufE6MXc2qzRKwefYIGxQ/Ip8ddFgAmOjO7ffbos30E5SOW7s/9
         0qREihbTxB3VTHsxu5c/m2yNftVaVWrnfCbJjXUlAJwsInTA10q17T3iW0alXpgTQ2+j
         wJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:references:to:in-reply-to:message-id;
        bh=uTjo8c01jxuf8S6wo3IZsfGuQQtaAVWSHCw+TvrhzqQ=;
        b=oH09vgIAIW1xqs6LQJ2bCRxBN+3usZfcoQeTpiAErzKlEFpWZyjf8DiACoRjTup4v1
         tABo1Dn8J0xvgxaATQB3VKPY0DAs6eIjOn4kKHeiPTi5TlZJ4d8kEQgVPjIvvJpRaRSV
         piJgHyf/GCQM+LLNwlWwouaeSnyWLs5cw74HmSiz9wHBE+d4Lbbdrw4uOVRuCDYA5OVe
         zb4m7iyjKlI4QwNpy/rSBkiUe3GYEV5+ksweE3GrEVG34po1uM8uWhUkpyBHCbVLjDsq
         sXLlqDeffA//60ghbGPEmvr8zGfueRCRXKCnl3mUwuPp22JFB2xzpCeJMUoxH/LUc9Cf
         ZV/w==
X-Gm-Message-State: ABuFfojik0eztrVI65ei914xwxmotNQGCu0xh/BQbQ/I9fOZIamN4Bk0
        WhiRN3q6oQAV4Onb2Bzt3/1JMX0eelY=
X-Google-Smtp-Source: ACcGV60uA2+LDEbnVMJ2yfJxf0Xhm+e7qJ7Bjk4/kd9+RpbqkQGhfNFpUSVpYVsuGaFOrUo1xAR0HQ==
X-Received: by 2002:a6b:ee0e:: with SMTP id i14-v6mr637052ioh.69.1539254231134;
        Thu, 11 Oct 2018 03:37:11 -0700 (PDT)
Received: from heartswap.lan.dana.is (173-21-17-19.client.mchsi.com. [173.21.17.19])
        by smtp.gmail.com with ESMTPSA id x7-v6sm8393579ioh.2.2018.10.11.03.37.10
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 03:37:10 -0700 (PDT)
From:   dana <dana@dana.is>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [BUG] gitignore documentation inconsistent with actual behaviour
Date:   Thu, 11 Oct 2018 05:37:10 -0500
References: <C16A9F17-0375-42F9-90A9-A92C9F3D8BBA@dana.is>
To:     git@vger.kernel.org
In-Reply-To: <C16A9F17-0375-42F9-90A9-A92C9F3D8BBA@dana.is>
Message-Id: <EB612DF5-EA44-4BB9-95D4-540E3F09FD0F@dana.is>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11 Oct 2018, at 05:19, dana <dana@dana.is> wrote:
>git itself happily accepts these patterns, however, apparently treating =
the **
>like a single * without fnmatch(3)'s FNM_PATHNAME flag set (in other =
words, it
>matches / as a regular character, thus crossing directory boundaries).

Sorry for replying to myself so quickly, but i think this bit is wrong. =
It seems
like it actually just treats ** in this sort of pattern like a regular * =
=E2=80=94 but
i haven't studied the source very closely, so maybe that's not the full =
story
either, i'm not sure.

dana

