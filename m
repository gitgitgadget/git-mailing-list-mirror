Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 367AC201A7
	for <e@80x24.org>; Thu, 18 May 2017 02:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753652AbdERCjT (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 22:39:19 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35704 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753653AbdERCjA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 22:39:00 -0400
Received: by mail-pf0-f182.google.com with SMTP id n23so16313984pfb.2
        for <git@vger.kernel.org>; Wed, 17 May 2017 19:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=baYwdylzT5MwlFI33tOesxIWuk7B9VqL7RZUjRtFwhA=;
        b=Gfrosl63D5IU1TTls0i0vWXou19dK7hPRtRqkGszSBVUHZndMdnrIMBriSAfDZzWq5
         yE2gTUoHSqDVLY7JhwpVMDeJ3FkNwy7HZyKEai0eVnMpqpYLZlR0ddkMtE3/WkwTavX8
         JwEdiiMhHrm3TXm5Ewk/0iPBBZyy3OxoyGRyeGsYenjpi21+PZRI2n1FOxXmlKirJnAS
         Z1bJID2606YaE0HFZUp2L+J7/7CzWv1LAsfiz2sZE6HeK5y4A/TToAtgO4UNm6xF7+A6
         35RSRphKkmKCXvChJkpQvt2AEpi5KFFmVnoxEeYVslwVty/K5gSEAS8pSjuIrpdsbP26
         ingg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=baYwdylzT5MwlFI33tOesxIWuk7B9VqL7RZUjRtFwhA=;
        b=oFNiAlo9QFN/m3g2fB8uB/MWzJeil6g39l9rs5yaw/mmHhOXQvGMgPRdZZpa04Bh5G
         CZ7dbKZYFu5Qn2otGQsPZGomKn2r4er4FZhCzS+lcz3b6Q5+GFBouP/hCObCMFG7IAhw
         Emy8JIkQVJ3jODBQNaTimRUm8HggY4uJDU9ei3e5yzLjY9S4PTwyjkOP+9LEky075wiJ
         ymsi1bSXCjJr1xrORW04SngbcvWLd8tQvN7JVcheuR1AOuktRm8AAJWXM4/KMdoaRw6O
         i4VOpXXXxenjQRcaqsoH6vVrFLE25hiLcyn+4ewnBhR8PdWlKT+hgweWK2E2lYBB1OLH
         QaHg==
X-Gm-Message-State: AODbwcA96D6YLoJONs+1IciiSuiZ4naryuZLHK7ptvgmBWhn0MCp8KGy
        kSSyY2PKPkcKKMygtHQ=
X-Received: by 10.84.128.33 with SMTP id 30mr1996000pla.111.1495075139420;
        Wed, 17 May 2017 19:38:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f155:f4fa:305b:79e3])
        by smtp.gmail.com with ESMTPSA id v13sm5977752pgo.44.2017.05.17.19.38.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 17 May 2017 19:38:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 7/8] t7300: clean -d now skips untracked dirs containing ignored files
References: <20170516073423.25762-1-sxlijin@gmail.com>
        <20170505104611.17845-1-sxlijin@gmail.com>
        <20170516073423.25762-8-sxlijin@gmail.com>
Date:   Thu, 18 May 2017 11:38:58 +0900
In-Reply-To: <20170516073423.25762-8-sxlijin@gmail.com> (Samuel Lijin's
        message of "Tue, 16 May 2017 03:34:22 -0400")
Message-ID: <xmqqzieavqgt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This and 8/8 needs to be part of the code change that fixes them.
Otherwise, running tests after applying only 1-6/8 would give you:

    Test Summary Report
    -------------------
    t7061-wtstatus-ignore.sh (Wstat: 0 Tests: 21 Failed: 0)
      TODO passed:   1-2
    t7300-clean.sh          (Wstat: 0 Tests: 45 Failed: 0)
      TODO passed:   45
    Files=2, Tests=66,...

or

    $ sh t7061-wtstatus-ignore.sh
    ok 1 - status untracke... # TODO known breakage vanished
    ...
    # 2 known breakage(s) vanished; please update test(s)
    # passed all remaining 19 test(s)
    1..21

with the "please update" painted in red.

    
