Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89865211B5
	for <e@80x24.org>; Mon, 28 Jan 2019 18:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfA1S1N (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 13:27:13 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:36591 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfA1S1N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 13:27:13 -0500
Received: by mail-wm1-f48.google.com with SMTP id p6so14992101wmc.1
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 10:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9CDxmLy6pKrUTcGaMD8oWPLuSNaq6ZVUeziOEhuMoTU=;
        b=PlUoLbf5sYm5FQmm4anKYlB+ZwheRSphYZsmqg4l6GrR5ZsYrMdI3MPgycwK2U3Tzz
         66u5PzvKuJucdiJAGFeoj6BxnGTQL2nGZH8/gLZcd2NNxcKfjql8/hlzaYvaejF13jhB
         gwkzAI7glaa9tzAjWps7Dx9uxvz752qOnX3r/x0B40mkJl+WpOsMOllb+t1ppfhYUjn+
         jyw9HCcmvMUFqxxHd8fVpT9bYbDy6Lajh44222Gxanf0en8UzQ8ae06Bde2Gv/0OLF7i
         PlMxaTZBRS/T2uzbxDc3zpKD8SvdBzTWDSi5wsQ4ZqbTO/8YX/rYt23xHX+oTRn+ddnn
         acPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9CDxmLy6pKrUTcGaMD8oWPLuSNaq6ZVUeziOEhuMoTU=;
        b=fxu4s0goWNLq4gZ3VdqdHWU/pV5ChVkwVm1YDaccUUD7ED1CvKpyldmw3/DXZhrEC8
         tJHQ5wa0dfQprbeZyx5lzrFtZ+g4hFv4d80+/zyYT3dGTX8F/5OBpnStqw8XY3eM5gKw
         7MuEDMY9cbicd5bNL2nXDWIoPkIwV3fzT+EwJDFpli9RU76w54IWYS/97XP7OW922BE6
         zptVt9/5TGrIQSX46Z/UuIbmP8OM5MXB2T+xkBj+LWztEh13dIqjBV72wPpckWWeW9BP
         h/A1cSUGqGKnEYAn1NTcksl7cBse82XECF9qQlkdPDfHU/6hiHyrQnYoN3gw6jmypF5W
         ZPSw==
X-Gm-Message-State: AJcUukfIqkIUi7DC1GVie42hYMY93Xt+EQhpM1Iyu52iLRJwk/OP0q6R
        Oh22M+KNopQcglRZQcYKWq8g4tK1
X-Google-Smtp-Source: ALg8bN78MiVPVEqj3K5bIkANyDYiapPeHn968lO4MJjPOzimbqzT5Nw2Gz6T33AGmv+FExpp1qteIw==
X-Received: by 2002:a1c:a8d2:: with SMTP id r201mr17422315wme.81.1548700030810;
        Mon, 28 Jan 2019 10:27:10 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w18sm230583wmi.12.2019.01.28.10.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 10:27:10 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Arti Zirk <arti.zirk@gmail.com>
Cc:     git@vger.kernel.org, e@80x24.org, peff@peff.net, jnareb@gmail.com,
        flavio@polettix.it, sandals@crustytoothpaste.net
Subject: Re: [PATCH v2] git-instaweb: Add Python builtin http.server support
References: <20190124161331.25945-1-arti.zirk@gmail.com>
        <20190128132458.31401-1-arti.zirk@gmail.com>
Date:   Mon, 28 Jan 2019 10:27:09 -0800
In-Reply-To: <20190128132458.31401-1-arti.zirk@gmail.com> (Arti Zirk's message
        of "Mon, 28 Jan 2019 15:24:59 +0200")
Message-ID: <xmqq4l9sbptu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Arti Zirk <arti.zirk@gmail.com> writes:

> The generated wrapper is compatible with both Python 2 and 3.

;-)  

Yup, that obviously is the best way to settle "should we make it
clear that this would not work with Python 2?" question.

