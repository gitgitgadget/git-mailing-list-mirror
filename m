Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B55E1F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 09:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756391AbcH2JnQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 05:43:16 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37993 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbcH2JnP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 05:43:15 -0400
Received: by mail-wm0-f42.google.com with SMTP id o80so82394904wme.1
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 02:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tVNogqtycoH9bPmf+dUw/XfhlAxEE1AgFsZHO28XOBU=;
        b=EgsBzLh4YodgP1jV/aCLoipgLy3eA6nXGrQktdTbCvu8sKX3NU2ZrUuDFKS4uivTri
         upHv0xzBXoXKJNL7O82pV173JxaisVNQDhKoeaLyI7yTo33habKfoEaIXBBxP/0mln2U
         parahfPShvwujDuWMMo4JXgpwhxmYclnwN+hLwQ0FuR079m5102zQuqFyraz+ATpyGrI
         5GuafQXHEpQ/V+5vpIhxekynV9gcv/Xzfb2MFM+1QCbLMA/TwPEzfi0KXF+ZqoPAlaW1
         yfeUsHqvEpYfZvWRrU3NDT57mO27PiFnkQAXi3jwyxMOAWA9U+gggBTP9XtbL25pFGZ/
         t8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tVNogqtycoH9bPmf+dUw/XfhlAxEE1AgFsZHO28XOBU=;
        b=DxFLpe9fESifrt29o5WBmypjL48aRTpk9isK2rR+pLPQQLf2fAi+AM/bNCLq1oCjfO
         sVeX0VlLNuAkovdQcyn8QvAt5SoD8PEGCFiyCTxJyyj9XCgno2Z6LnVKkTqT8wYXXSGk
         VSzW4BOaVic7KrBtbefaLU3R3N/kgWVvexTBzHNaA/LckvJ7j84Woz/CSlSmZ8rdZvoF
         hx/+qe/m/yqkZzNQJa/jnmvds7q4r4mW7WFj6HV8KuUUMPVWlYbCn0P33VPg5ajrajkq
         syUVLhAtDxEeJTuTUM961dY4qdkOKFsaETkrBFco1oGvpHfVFzP3SEI2hHqYGpdtZ7F5
         AA/A==
X-Gm-Message-State: AE9vXwP9e5MXHhlZDhSynZ35oOPnggHMHAdxymjR9cVPsrMd3J6BQaApx2Kn/oEoxECNJA==
X-Received: by 10.28.140.5 with SMTP id o5mr10339065wmd.13.1472463793974;
        Mon, 29 Aug 2016 02:43:13 -0700 (PDT)
Received: from [10.32.248.244] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id a203sm13697248wma.0.2016.08.29.02.43.12
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Aug 2016 02:43:13 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v6 06/13] pkt-line: add functions to read/write flush terminated packet streams
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq60qnigyz.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 29 Aug 2016 11:43:12 +0200
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <64722B90-8C48-409A-8FAC-75DCD4CBACCD@gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com> <20160825110752.31581-7-larsxschneider@gmail.com> <xmqqzio0jxh7.fsf@gitster.mtv.corp.google.com> <D8C981C6-22F5-4922-BBF7-F71961B3271B@gmail.com> <xmqq60qnigyz.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 26 Aug 2016, at 19:21, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>> OK, what function names would be more clear from your point of view?
>> 
>> write_packetized_stream_from_fd()
>> write_packetized_stream_from_buf()
>> read_packetized_stream_to_buf()
> 
> Would
> 
>    write_packetized_from_fd()
>    write_packetized_from_buf()
>    read_packetized_to_buf()
> 
> be shorter, still understandable, be consistent with the existing
> convention to name write_/read_ a function that shuffles bytes via a
> file descriptor, and to the point, perhaps?

Agreed.

Thanks,
Lars
