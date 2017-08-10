Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9851208BD
	for <e@80x24.org>; Thu, 10 Aug 2017 21:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753478AbdHJV7w (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 17:59:52 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35682 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbdHJV7v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 17:59:51 -0400
Received: by mail-pf0-f180.google.com with SMTP id t86so8181641pfe.2
        for <git@vger.kernel.org>; Thu, 10 Aug 2017 14:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=adyX6W5hyc07duanYgObcWlrCxSj4MNrsBCN6w3qolQ=;
        b=YRRIQHBWCCF9gecZUE3aojmokHM1oJOT2FzKddLz1Z5daHgdij98S15RNG9EIJLzf6
         NNelZfk1ls6CKRcytOmH61RG1OR1Ik3Nmyi0DE/sAHE75VZVZ9Bq87BmK89Om01o/Upt
         BApFv9bozXSk+Ur42poWxg5eTEIaNLA0e4mK6WgFaYPqalb24kTNl6/MpyTbw1Zs5awj
         6SCJIN9tvWlGgc5IE2eRWHxljgXDD0I7qA0CcnfbwNJtoY7oWfxxOrYTCJBVy/cB84B9
         cH3aWO3dt5FrxQ915zEbuTH+ajDwLo/znov8UalBcVRd1Te3KvArXtGy1Mj+ac5UpuPQ
         EeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=adyX6W5hyc07duanYgObcWlrCxSj4MNrsBCN6w3qolQ=;
        b=oP8Cx8YBs8ph22DAySeCt/QDN8AsV/r0AYsSz3ggMVr0KSc11yU270kUN2ItYZ0JNf
         t1I9clIhyezWg4af/HJXx9+kG8KFjd2IAae9PUDcF6WxkmfKX5xQi7OPqy/nH0cQTfnL
         e0lpJSN12bgi9sDIn7ep7xypIYfSgYCXbo08JM7lQpziSw/TnGdaO/uztO4YDMjj2Ab9
         XkNSoauGCW15FcXryVXuhQ+6vO3k9BUuePSUrfF/Bqy39bXENwkh3YZiK2xIbtlKAvMB
         hP6eAQubylU3ke1Oziag61IF8wY9Wqj0Q+s7lIkEPOQv9T7lL9kjtLjtm+qwTkTAFjUD
         ziQw==
X-Gm-Message-State: AHYfb5j6s86PPLGxi38WgiDXu4S4KIPBpEJ3cK/DNGt/TzqijoS93kAd
        G/uIWfcp/O2ynAGu
X-Received: by 10.84.217.216 with SMTP id d24mr15268695plj.144.1502402391097;
        Thu, 10 Aug 2017 14:59:51 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:f02f:914e:af6e:3f60])
        by smtp.gmail.com with ESMTPSA id w6sm13008455pgt.38.2017.08.10.14.59.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Aug 2017 14:59:50 -0700 (PDT)
Date:   Thu, 10 Aug 2017 14:59:48 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v2 00/25] Move exported packfile funcs to its own file
Message-ID: <20170810145948.60c2b9f8@twelve2.svl.corp.google.com>
In-Reply-To: <xmqq7eyb2k8w.fsf@gitster.mtv.corp.google.com>
References: <cover.1502220307.git.jonathantanmy@google.com>
        <cover.1502241234.git.jonathantanmy@google.com>
        <xmqq7eyb2k8w.fsf@gitster.mtv.corp.google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 10 Aug 2017 14:19:59 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > Here is the complete patch set. I have only moved the exported functions
> > that operate with packfiles and their static helpers - for example,
> > static functions like freshen_packed_object() that are used only by
> > non-pack-specific functions are not moved.
> 
> This will interfere with smaller changes and fixes we want to have
> early in the 'master' branch, so while I think it is a good idea to
> do something like this in the longer term, I'd have to ask you to
> either hold on or rebase this on them (you'll know what else you are
> conflicting with when you try to merge this to 'pu' yourself).
> 
> Thanks.

OK, I'll wait until you have updated the master branch, then I'll try to
rebase on it.
