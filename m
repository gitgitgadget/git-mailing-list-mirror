Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D8E4207E4
	for <e@80x24.org>; Wed, 26 Apr 2017 01:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1434568AbdDZB6g (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 21:58:36 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35284 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034504AbdDZB6e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 21:58:34 -0400
Received: by mail-pf0-f179.google.com with SMTP id v14so30815760pfd.2
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 18:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=RYeW23s/Tb7S+sbVDof61dffMDG7ZFnm6F0DE0dorX8=;
        b=br+U3a3eSTT6ACOv3I3COEwE4/APLLfg/DDDF09rYCC7tdioq/UtA2g+3Q28Ptewzu
         ju5NDY0hCM3EgWnopFbRUP+nFZKOovWpG+E2agMrbi4A7Ed3lV7kl/e6t7SocMS0BYIe
         J7QgyfEJlmKKMZ0gDS9mU+UzqWdt8L15F3Z+BH5JRnjnKkYHjwjvNInOvSKdTPNhI981
         CVgap5R+9rEgFHPIe7vrGQ5i23Zl3zJaabu7npvBl+3AN5jUEWecdmIILcRTK8ufMnCS
         Hvca/x8511yr7NFoJR0Muv1YKN9FhX9WI7VbCmBbHz9HakOvtzQ8MfjFm0YLVCDpG00d
         0mbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=RYeW23s/Tb7S+sbVDof61dffMDG7ZFnm6F0DE0dorX8=;
        b=GC0jcxoD7ws+kMHXRZzrJv7ZNaFeFkJCWfjhQUT2yxvEwfNGsRo7kiJfL3X6F7MYli
         ETlhJbsZr1SWBlNl+a0LWMzC4Vtd9aYoVM99VakqwvVRzwgz3HwA/SNEHoyE6Jxd6jrh
         2HryH756tHYoTc61+GNOl4jbGl1ABZfMySgVYOpfMfcmjH2SmwRmPRFfO1BM1S71tG5U
         WqTnIT3r7ya3DAOoTBDMzAPjdTHlOI2r5QQ149qdCCXKTiXCbJ8dpbmPh9sdN8l5lGV0
         x09+0ZCqWAkONbSVcDnYg/n2Ss0lSi/pUkp7hIviOnQ3Ibd1IksSCy3EuFPXKWrxSka8
         rAWQ==
X-Gm-Message-State: AN3rC/6s8udzNm2BqOTzI8OfIudm7cASNVVtr9zO8izbw3Rb3F0HP/T6
        lLh2Ie+df1SBvQ==
X-Received: by 10.84.224.206 with SMTP id k14mr40413265pln.159.1493171914203;
        Tue, 25 Apr 2017 18:58:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3179:d004:20b:b383])
        by smtp.gmail.com with ESMTPSA id 202sm38653804pgh.21.2017.04.25.18.58.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 18:58:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael J Gruber <git@grubix.eu>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] tests: fix tests broken under GETTEXT_POISON=YesPlease
References: <FDAE86E2-F607-4E82-8E0C-0E6DCEF7ED67@gmail.com>
        <20170421185757.28978-1-avarab@gmail.com>
        <xmqq1ssi4nci.fsf@gitster.mtv.corp.google.com>
        <CACBZZX63VQK4fLSB2T8onXJ_hQE8dkOCAyFFM-C_yOfoMwxLMA@mail.gmail.com>
        <xmqqmvb5w2hj.fsf@gitster.mtv.corp.google.com>
        <CACBZZX494g8CKoN0V1N4xRuDsErPtJcMjaZcLFAqJgDQ+Mz+yA@mail.gmail.com>
Date:   Tue, 25 Apr 2017 18:58:32 -0700
In-Reply-To: <CACBZZX494g8CKoN0V1N4xRuDsErPtJcMjaZcLFAqJgDQ+Mz+yA@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 25 Apr
 2017 10:56:43
        +0200")
Message-ID: <xmqqmvb4szef.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Indeed, I've tried to be careful not to introduce bugs like that, but
> in this skipped case the tests look completely stand-alone to me.

Yes, the ones I commented on in the upthread looked like their side
effect were not felt in the later tests.

> In any case, I like my other patch to just remove this whole thing better.

Hmph, did I miss a patch message?
