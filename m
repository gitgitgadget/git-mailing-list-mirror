Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E3211FC44
	for <e@80x24.org>; Tue,  9 May 2017 01:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753449AbdEIBvp (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 21:51:45 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34043 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbdEIBvo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 21:51:44 -0400
Received: by mail-pf0-f170.google.com with SMTP id e64so41445471pfd.1
        for <git@vger.kernel.org>; Mon, 08 May 2017 18:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4BK/AWekrOCu+qckJ1VmdLK7NiViEhk+7732KOpNo+w=;
        b=imHGe8CCBRFslgMrUyI8wahr1xq4lD+NPbuSSx/g9XZoAwBfM6XzTzP9SfoHEOSla0
         vNo0syqkTJd6Owj8dfCUcT0QhqvJph/S61d45HC4FQVIgvPnJKDGkN40JEusAo6fw68i
         SMwU29cFOG0XQ8lwAM/ug/F5pxW2duww1KHDjuQBGkw0XqVb3HeWLg0J/sSm6TCN3T10
         J/Fp0/QXXs5yVQ6FZqQrXGFABKMGUGAMBV4nYXDhRIImMAVE/iUZWc1svR6vYWNlTYtr
         8lzClBEUYo1re8ho/sVcG+BGePLcalLkdhINS/XQlxKdrzdn6XQPAuE9PsNfRocFsJcO
         moMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4BK/AWekrOCu+qckJ1VmdLK7NiViEhk+7732KOpNo+w=;
        b=tBj3ZMqPot7EQKLYWCRFdzACCftiwIPmhxyv9Q/mKV9tkSP26Hs3+B0Ptg6iwUYa9r
         B0tYnMQTSq5lqVIPRfBLI1ntP+wkL1bga6xoZEtOkmQ1cR+2lVtT5rsWgPyAhN1+8/ef
         if6oFOTBNaX8fIfnW6MqbOed+I4FvZ6jstmUKpa2FkYA67G0zYGyTpigSpP1kQZRzTbN
         CytdcYcCgU7atwJkmC/U+wwSKIFF94P1+mB6HM2i2fG0cWWwic1jJQLkfBbmrNifwruT
         S55515uLjNM8CgrVd50vqDQyQAVNBjOWk8DLgS76QY1uLNPmAhUNv8iKPijLizcPFdIC
         rkKQ==
X-Gm-Message-State: AN3rC/7+TRrAivbOXLcsIftf/xjJiWg2tJbSPAMirvTvxwyzMGH0NL/g
        ZCs01cVc6rH0yA==
X-Received: by 10.98.34.5 with SMTP id i5mr35286244pfi.228.1494294703611;
        Mon, 08 May 2017 18:51:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2823:d4da:fd9a:464a])
        by smtp.gmail.com with ESMTPSA id e16sm28043840pfk.100.2017.05.08.18.51.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 May 2017 18:51:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robertson\, Todd" <Todd.Robertson@alere.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Questions about validation/verification done for Git Software
References: <504208edac024b2dba0c1743dc86683e@AMUSATLWP20005.alereinc.com>
Date:   Tue, 09 May 2017 10:51:42 +0900
In-Reply-To: <504208edac024b2dba0c1743dc86683e@AMUSATLWP20005.alereinc.com>
        (Todd Robertson's message of "Mon, 8 May 2017 17:14:51 +0000")
Message-ID: <xmqqshke6bm9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robertson, Todd" <Todd.Robertson@alere.com> writes:

> Is the software FDA certified?

No, Git is toxic and are not approved for human consumption ;-).

