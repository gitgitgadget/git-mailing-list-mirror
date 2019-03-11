Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5FCE20248
	for <e@80x24.org>; Mon, 11 Mar 2019 02:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfCKCA2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 22:00:28 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:52629 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfCKCA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 22:00:28 -0400
Received: by mail-wm1-f53.google.com with SMTP id f65so2755701wma.2
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 19:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vq/prPwCUoRavDaVoeT0zhqfZqkgp7eCkWQdI6bNlok=;
        b=XftHM9v9CgDQTMxnVHLE8gsMXiBpvUjKR6OpNSjP9KeujpPVIhNwab/qVvEomnTFOJ
         YcMFSLIXyAZEHgh6Z73CxyydS4dO0eyZKdQTiy4xZJxdfpEBlmH0sNq05y7Q33Vh7kla
         fpZJyiObQAv7WXUGPIXydjR0agiWLBJXYdq2nffDEj4XnK3qxSgExfMwBCGjjiNWEQkR
         QeUaT+j8T0X/6S2GxU21IXJ1XomdEPFlkBaDySzeLoe2XLNc6bNPygrQEtqPx5ASnjYy
         OKkLHrQObU3lfVAvPx99Bmf3x5gx/voIKlQ79z6wrnyc3G5h7NTpK2SZhFi4ivK5GK9m
         +k5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vq/prPwCUoRavDaVoeT0zhqfZqkgp7eCkWQdI6bNlok=;
        b=ZoPNv4SnsKOY6W22LC04eNdmRqgxREyIaN7Q4kmWpHB7ZR5oPYNAClhhYRqagoF5po
         HyGVX46jTRW2iGHHuQEMkht516Hc65kbcTxEupS9RHNeIlmWRaDGHYsSyDs5a62WwBCV
         M8irC/yEDKNl3yZAl+/sCm0l7O4L3WhVuxonAtSdAWQ4OINcDST2NZU3JZVintij8ZfD
         NgvUf20+LSeKQZXE+SIItbpV9nOc93cXLMDRqmXIkRE/hsQizmZ5W7hcQzFKCGTgO2wr
         mJqBelETWkUKFQj9EZDTmdokINlYBfxR03a1kwjhlWJjG+uNl2LVk8s8XccNhSPZmvRT
         qLXA==
X-Gm-Message-State: APjAAAVx5phXOGFbcHu7+foBIYi6TquGzrLxqmbYENh8q0NWX6n4LKMx
        7WyjMfXjyemDHrc7hhg7NsY=
X-Google-Smtp-Source: APXvYqxxXF2oTqLU5FIOOstSJ6U886rkMYrP9G8ijIH03y/P7p1SOd2NkAqUNFvAcudM9+ep5B5Mdw==
X-Received: by 2002:a7b:c3d7:: with SMTP id t23mr15012440wmj.49.1552269626629;
        Sun, 10 Mar 2019 19:00:26 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id r15sm3956334wrt.37.2019.03.10.19.00.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 19:00:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Todd Zullinger <tmz@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: One failed self test on Fedora 29
References: <CAH8yC8k_Zyi89uxTWTrjN65UAAc1L+jLho+P7O7UyvE-LvZuzA@mail.gmail.com>
        <20190308174343.GX31362@zaya.teonanacatl.net>
        <CAH8yC8mg3vjPoof5SDemQ_YiL+7e1ak535U2nFnPbaWJ8xSWOA@mail.gmail.com>
        <CAH8yC8kn=EmEm_UPrnpwaofv97S42Se6FC+hWcm0EHCX-4rewQ@mail.gmail.com>
Date:   Mon, 11 Mar 2019 11:00:25 +0900
In-Reply-To: <CAH8yC8kn=EmEm_UPrnpwaofv97S42Se6FC+hWcm0EHCX-4rewQ@mail.gmail.com>
        (Jeffrey Walton's message of "Sat, 9 Mar 2019 08:12:05 -0500")
Message-ID: <xmqq1s3emapy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeffrey Walton <noloader@gmail.com> writes:

> I think this is the patch for sha1dc/sha1.c . It stops using unaligned
> accesses by default, but still honors SHA1DC_FORCE_UNALIGNED_ACCESS
> for those who want it. Folks who want the undefined behavior have to
> do something special.

Hmph, I somehow thought that folks who want to stick to the
standard printed on paper penalizing what practicaly works well in
the real world would be the one doing extra things.
