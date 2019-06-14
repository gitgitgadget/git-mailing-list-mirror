Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99B6F1F462
	for <e@80x24.org>; Fri, 14 Jun 2019 03:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbfFNDqI (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 23:46:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39891 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfFNDqI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 23:46:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id 196so715168pgc.6
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 20:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+/4QPBA1m+sPAmQU56e+rog0+tv3j+18pUKK3OXHyFU=;
        b=cuRNp7g6zmYYOICUNqYffwczOUFQrC1m0W88hFASGvZKyRE0OOWsOWM+Jklm3+KbTc
         U9Ko5HxhbDs2U9VwvutqNQ+Pww+iI6LwRQjFzF8ml8vbfM6BPlHpqHC3OTy4wWgpIzKY
         R6CTLfdlQMpVOFFZOpDwHkkiGu5QjT8hmSJeAyJghiFsPOwXLp4wK+qnEz0rGpYxVHS0
         GCA+j9trMy9YJ89wCLBXNBUl2Qvi9+yoh/50t14OTCVYfAUPGKJJf9djWXaINHlgTV3r
         66Ip91WGY2Npxcz2w0c1l7dJ4uPXLGf185wOuyPXGyFae2z/UqO2ifBmixXydGhO/pTq
         Xjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+/4QPBA1m+sPAmQU56e+rog0+tv3j+18pUKK3OXHyFU=;
        b=rzf76hGidC2jqM0Fu2Us+nxhryZSdG1BwB6cv2K3gbfIPxxo3KzM/ZnApovUUbrqBR
         EqHzPeX3/d9PrnZ0/P1UxbjVwmX0aKHzJIpdNTnsh3V3kwy/dVWKj4DSZ4it8lVe2Qn1
         1yV0dM1qFGexjbkzuKR+vvU7F5Iw0McOgkFt/pVx+lFl7HVtge46SHho7HJr/WlHP7Dc
         f8G9kwsR09I/CMXI0P7ADa1C0OcgNjl8Zkq+pOgc+b/88vTXxS5PSk+pLQSzuzC39yP+
         XU+iAjXy6YtEaA4yx7od9mSR/t+Ma3XnbIQWD1p2l42gBUdBleEXew8lcTGRmHQYaNak
         c+wQ==
X-Gm-Message-State: APjAAAVB0LcOb2IK00L9NYHr+mkY+X+9nOVLzDtqOPaYxZ6puF8iYnvB
        zmawhAeodXkjBhoSRxVf+J0okWhfP7o=
X-Google-Smtp-Source: APXvYqz+TqnTzyl72X7f4rN7h/IE2xMMy6tmds5OhlOIuSC/RtGpoFZA8UTTkTBRCPLHrDRdJh6vmg==
X-Received: by 2002:a17:90a:ad86:: with SMTP id s6mr8913528pjq.42.1560483967822;
        Thu, 13 Jun 2019 20:46:07 -0700 (PDT)
Received: from ar135.iitr.local ([117.234.2.144])
        by smtp.gmail.com with ESMTPSA id a24sm1125192pgb.85.2019.06.13.20.46.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 20:46:06 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     phillip.wood123@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        rohit.ashiwal265@gmail.com, t.gummerer@gmail.com
Subject: Re: [GSoC][PATCH v3 1/3] sequencer: add advice for revert
Date:   Fri, 14 Jun 2019 09:13:56 +0530
Message-Id: <20190614034356.19073-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <0333fe2f-d68a-4536-c736-ca2a356df34b@gmail.com>
References: <0333fe2f-d68a-4536-c736-ca2a356df34b@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip

On 2019-06-13 17:45 UTC Phillip Wood <phillip.wood123@gmail.com> wrote:
>
>> +			break;
>> +		default:
>> +			BUG(_("the control must not reach here"));
>
> This does not need to be translated as BUG() messages are not really for
> users. Everything else looks fine to be now

I know this is not intended for the users, but seeing a message like
this a user might think to report it to the team with the steps for
reproducing the BUG. Yes, I agree this needs a little bit of re-wording.

> Best Wishes
> 
> Phillip

Thanks
Rohit

