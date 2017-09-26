Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CFA2202A5
	for <e@80x24.org>; Tue, 26 Sep 2017 05:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935008AbdIZFW2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 01:22:28 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:47685 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752952AbdIZFW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 01:22:27 -0400
Received: by mail-pf0-f170.google.com with SMTP id u12so5024188pfl.4
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 22:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QuGSVhhhFzCsINZlDp77/HiEJzMbeqDQn50rCL57OFw=;
        b=ZkKNcx1YQMoTFeF/y+O7C6pspcJrJBqPG/LMAQnMnEiSYdYz/r6ZbcJgG4SoZmEgbM
         OFkNKTJuqwiGLL5Octh61bbcOQ8xgMYcHib/6mk1hTDUkcxrtxqXYqINPDdMuNG4WaJi
         lQ7i0EM/+4SoD4yU0969KKRGjlQ6TcTDq5pZvVTg/tGIs/QpQWgy67/v/4EjFnvJ7xAi
         zSol2+IywWeR8dzppPe5tdTr3HmjeTCBFgWApkk9Ml5gbjVexNYJe/tg7vy+J0NLWm9b
         4EWhVCm0W5RdEenOHyC/igA5a2+bGJesDaFRcb4rnEbSbETlK1ChMDfUj55YwF0CXKJM
         5yjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QuGSVhhhFzCsINZlDp77/HiEJzMbeqDQn50rCL57OFw=;
        b=RdR5kQvQ1Y6tamI9FSt/H7J1DQY5arrFu8JpZKzPU+7vjLBOcs5fkMDRkIrqAam71+
         V0UdM7tHFE1jQslKvam3nX3UgrlzZgNNUoOL9/qhxVv5j/tMn+wR4C+LzsJJQPTpqt3G
         /3jP7zrNiPyoliUhFzSnSZbRbwpwe+j8Ap0ld1Yup801uCV3Abb2hWiadDhr1/FAyc91
         u32EddtVkhujjodVNFaaFNm2K19qplCxZCQib0HaYVDt+/PVCJsKyZi2MQcUZ6CNfXnQ
         4H3jxENdw5eYtyv+C5jaC8heMO3h8QAp56eshEOn0GA6c1eDM4Sx6Z+V+hHtf9Ll0v3G
         boKQ==
X-Gm-Message-State: AHPjjUhDVv9TBrMLvXhA1lnqusRfvkiSvuQkB2H8i2YrnabNqybXc7v0
        2mjMUvo/VeSD3HAMU2AqFkU=
X-Google-Smtp-Source: AOwi7QDyRHS1ZdmliDIk0YgKAOrYBXd1r5AOaIK06GYh9GvhUtY/zKKiSsJWLPNWJWb3t74lc4HPNA==
X-Received: by 10.101.86.133 with SMTP id v5mr10029919pgs.249.1506403346910;
        Mon, 25 Sep 2017 22:22:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8cad:f525:a0b8:9738])
        by smtp.gmail.com with ESMTPSA id i12sm13812582pgr.21.2017.09.25.22.22.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 22:22:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, bmwill@google.com
Subject: Re: [PATCH 4/4] Move documentation of string_list into string-list.h
References: <20170925155927.32328-1-hanwen@google.com>
        <20170925155927.32328-5-hanwen@google.com>
        <xmqqing6aw0w.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 26 Sep 2017 14:22:25 +0900
In-Reply-To: <xmqqing6aw0w.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 26 Sep 2017 14:06:39 +0900")
Message-ID: <xmqqefquavam.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>
> Thanks.  I am not sure if you can safely reorder the contents of the
> header files in general, but I trust that you made sure that this
> does not introduce problems (e.g. referrals before definition).

Alas, this time it seems my trust was grossly misplaced.  Discarding
this patch and redoing the integration cycle for the day.
