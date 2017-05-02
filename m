Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0523E1F790
	for <e@80x24.org>; Tue,  2 May 2017 19:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbdEBTcZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 15:32:25 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33204 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbdEBTcY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 15:32:24 -0400
Received: by mail-pg0-f53.google.com with SMTP id y4so60919096pge.0
        for <git@vger.kernel.org>; Tue, 02 May 2017 12:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PgQvIqfwOdI70RZCMq7ouyRRdK98qEE1CnY6sIQjNA8=;
        b=U7xdnsyLneCl8U45JklLMBVzUGOeZnC5vOaTLZlyaZb5xUpke3pX+7tsYDUq0zVi0v
         OE/Zd6e+4Aq5fQYoxj6s2zrPs2sdjrdBCdRNX3FwczY+42BGkRPQ2Uq458rLGh7pj7SV
         eeaOWr42LBMBI3CqYL5tJQfcLt9nWeI+5vaZ5UXIAfLXY4Em0bJQV3dUdAT7A2W3lq5h
         0+7aUMcgMCoc2uijrNspEc1PjN1lcgANmBNLPFvLCubrCBchSQ5GkAfeBaYzh3klbocn
         AyDeU1s4qjsh+vFeIcsJyrJZbIMSNHtobjB5C0PNAsEdozvNrb9uKhYk9XG1k6rjjXOG
         XV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PgQvIqfwOdI70RZCMq7ouyRRdK98qEE1CnY6sIQjNA8=;
        b=MyEOAuLchHC3lgJ5oa/UZcJwKOQm5RgkMgxwDyEd5lpOfHTHRbHJWoKoEkVbyZV0Ya
         bEtQQqshhx6nuMQzlL9ISEthAOzMMzJ36Cih8NfCLef/rp1DYgpGJoNTuD7kTUQvyJmw
         GAeCML2+XEchpBgPwB+qGTB29Ic8C3MeMJcJYcKLPcHMcVmuKX+RtCYZgsApXVL2IAFN
         E9IMXFa0EYJnlqyQEZAKtlehBa4KnyQjj9JHNoo63msPabPz9HZrBhYMpGiZpinSRHFq
         WqS7DnDz91LcXmluYXfSjCH0IiiITiTODy7ZOL3nBzR3bukSLGOiv38OMpMQgnfC/i6z
         OJ4w==
X-Gm-Message-State: AN3rC/7uGF7/OGPwM4+N4hD4QLxIqGkoAMHBtIZMODEG+DUo6VX1L1Nk
        G3fUIIX9H8jwfxVnRUd46w==
X-Received: by 10.98.7.140 with SMTP id 12mr701676pfh.202.1493753543934;
        Tue, 02 May 2017 12:32:23 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c805:cf1:74c5:2e74])
        by smtp.gmail.com with ESMTPSA id l85sm364860pfg.123.2017.05.02.12.32.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 12:32:23 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com, bmwill@google.com
Cc:     jrnieder@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/3] Some submodule bugfixes
Date:   Tue,  2 May 2017 12:32:11 -0700
Message-Id: <20170502193214.7121-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.18.g9ce9a66034
In-Reply-To: <20170501180058.8063-1-sbeller@google.com>
References: <20170501180058.8063-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:
 * I dropped the RFC patches for reattaching HEAD as that is not the main
   concern of this series.
 * patch1 is just about dropping cp1 to reusing cp, instead of additionally
   "fixing" mem leaks as finish_command does that for us
 * reordered the patches, former patch 3 now as patch 2 (avoid auto-discovery
   in new working tree manipulator code)
 * Regarding former patch2, I wrote:
> Junio wrote:
>> Sounds good (if only because this makes it similar to other
>> codepaths).
>>
>> Is this something whose breakage before the patch is easily
>> demonstrated with a test?

> I'll try to come up with a test in a reroll.
 
done

Thanks,
Stefan


Stefan Beller (3):
  submodule_move_head: reuse child_process structure for futher commands
  submodule: avoid auto-discovery in new working tree manipulator code
  submodule: properly recurse for read-tree and checkout

 submodule.c                    | 21 +++++++++++----------
 t/lib-submodule-update.sh      |  7 +------
 t/t1013-read-tree-submodule.sh |  1 -
 t/t2013-checkout-submodule.sh  |  1 -
 4 files changed, 12 insertions(+), 18 deletions(-)

-- 
2.13.0.rc1.19.g083305f9b1

