Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EA0F1F404
	for <e@80x24.org>; Fri,  2 Mar 2018 17:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946587AbeCBRT5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 12:19:57 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50889 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1945946AbeCBRT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 12:19:56 -0500
Received: by mail-wm0-f68.google.com with SMTP id w128so4531104wmw.0
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 09:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AlZIEFsz1+pr8PTS0b+ozCrJCRvwFg5S0oQoXK2zbKc=;
        b=qkyZYd/OaivdKR7JODDf7tA29/LG5qRTaBVIQShf0amE3KCHWUqoFC+Wd5WPi8ReYI
         gmlRAGm0SbOWDRAD3Ev0isJM4yfMdpt+/gmldrjB9Mp9GaSp/pfDBqt37Mdn7hEI/KxJ
         ZeWCCsT1F3/QDP+gKJ3ZPRXBYwhrVNNook2VyShaQ9qLBM+Ez0+PbpPBOd8LPL/k51GU
         6QMx7K2HeIqSZJereozlsfGJRP+iTiPj78vNjMkMn7Hz5dXq52cLxIEunDWGeqM+g83K
         jUBw5HbzthSqY71B+QfQJfQBTkLJL8f5P5jaA5k8jrstpt6Pb2AJ8HzL0Tk6oMEm/zul
         eNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=AlZIEFsz1+pr8PTS0b+ozCrJCRvwFg5S0oQoXK2zbKc=;
        b=s4+l7ZjFg2H/HIQbcq4GMtbrki27fL4IlhTPlF1OMqCftxXFQr5PMeVlQ2ehf+Hhw9
         ff3UamMe/IMMNh1eKJuyUITlmQgVVD+blWwz4XZhfglvUZp4PiIOJ8YQbZXo/w0yO0bV
         cXTb+/x8AGmrs+GWh/9Q2nAC6TuckzdGBkck3OAr9GBNEKyjN0YJJQ73ywZsNoqjjIxW
         KORts0Z5EpbyjKejfAniKz4iCGuWaNdp4b5sRK0FykapCTCi/l7GygtcKi/p68IvyEO0
         1u559xUo3cZaoCwpxL7ytlw53BFtLuZrGdOrTum+Kr1Qc1RQfV76k21GAyAksDb2Holu
         FcBQ==
X-Gm-Message-State: AElRT7FfrNcBH4SibuKOzY17lGEyPqUIgpdayA/A2rAwdb7bj1JzwXXV
        pqMSivj0H98DGfaiaJUajt4=
X-Google-Smtp-Source: AG47ELveWiMAjKZBLRGLIknxZnB7xmRzEn+XBqqGmjgeuJn+a6QNM7mf9z95BnVvbpvZg8tpgO3+yg==
X-Received: by 10.28.178.81 with SMTP id b78mr2313719wmf.78.1520011194700;
        Fri, 02 Mar 2018 09:19:54 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p29sm2320702wmf.3.2018.03.02.09.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Mar 2018 09:19:53 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        ungureanupaulsebastian@gmail.com,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] ref-filter: mark a file-local symbol as static
References: <1d28d866-535c-6d37-4cb9-5decedab3acb@ramsayjones.plus.com>
        <20180302035904.GA238112@aiede.svl.corp.google.com>
        <733494ed-56b1-9072-3c9d-cedc35acd215@ramsayjones.plus.com>
Date:   Fri, 02 Mar 2018 09:19:53 -0800
In-Reply-To: <733494ed-56b1-9072-3c9d-cedc35acd215@ramsayjones.plus.com>
        (Ramsay Jones's message of "Fri, 2 Mar 2018 17:06:27 +0000")
Message-ID: <xmqqinaecs3q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Junio, do you want me to re-roll, or would you mind tweaking the
> commit message while queueing?

Perfect timing ;-)  I was about to get to these two patches.  Here
is what is queued.

commit 2d7cb07e3718d0af6547e2abb35f9cff9b10c1f5
Author: Ramsay Jones <ramsay@ramsayjones.plus.com>
Date:   Fri Mar 2 02:54:02 2018 +0000

    ref-filter: mark a file-local symbol as static
    
    Commit fcfba37337 ('ref-filter: make "--contains <id>" less chatty if
    <id> is invalid', 2018-02-23) added the add_str_to_commit_list()
    function, which causes sparse to issue a "... not declared. Should it
    be static?" warning for that symbol.
    
    Indeed, the function is only used in this one compilation unit. Mark
    it static.
    
    Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/ref-filter.c b/ref-filter.c
index aa282a27f4..ed993d32d8 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2000,7 +2000,7 @@ static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
 	free(to_clear);
 }
 
-int add_str_to_commit_list(struct string_list_item *item, void *commit_list)
+static int add_str_to_commit_list(struct string_list_item *item, void *commit_list)
 {
 	struct object_id oid;
 	struct commit *commit;

