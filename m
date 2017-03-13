Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3441620373
	for <e@80x24.org>; Mon, 13 Mar 2017 22:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751662AbdCMWi3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 18:38:29 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33187 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932251AbdCMWi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 18:38:26 -0400
Received: by mail-pg0-f52.google.com with SMTP id 25so71794338pgy.0
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 15:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ww2hWhWNC+DkSKrblMOQ/HKYRG90tszi6a43CsSyCMg=;
        b=ZDNpK8mrjm8JPdPaND8/urFmtCOziaQW3alt3I9RRw36jIT9XU+4BiB0Rlk+A00rzo
         +rC2VgX+fFJ6dON8AJLcoOCMNDECP6Eq73cCQnzl/kAq14u9f9MF4xre+K9ECZZobBW1
         HsCwWUmwa4sQ/v5JvdXW95Rslt7EHpU2YRJfC/e7l8biYMKIyxD0zMZibqjna23MLf+G
         JwCftjhq34M+Dt13+wsn4BT7UeNRM8YhGoPLvh9vwgsWaE7dTqaHgsy7za6j74qIE2MO
         xQf9k7QC78xxgsCvt+VtrsDeOvrsT7axRaR8OgRu+Q9dp1gtikEiG+Zt9B3XB6oZtHQk
         I8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ww2hWhWNC+DkSKrblMOQ/HKYRG90tszi6a43CsSyCMg=;
        b=MVA4fTFUfWUWgXxLTdHZlRPxuWnHbqO6IBOF0csV6iwAuHfTedXG1X40q2iqupY0VK
         /lbzjiy78d0cVQoeGa0knMpWLzvIV6uvMhjrqWdmjLxIPbuHDaJkGrINdTPL7cPlc9Po
         U1pG6ewIPzhEAPlPh4KBL4khTjdUJzJ+VfK5TxyVIs8ZvBG5uWOhYx4zOQAnWEzflSf0
         M4bfmPveR8cbPEHlEjkIEFErTogvCeoNYEuGk/Pzk2ol8WVHwhtfhQCJzqxvHpWxsyUK
         qq7Kcih2Go83jRaTsDRSzBE6XD8uRY8k4M/AEUHgDfUWlPT5lsjMN2b4sFylajC16HBi
         WBtw==
X-Gm-Message-State: AMke39n+vtaIo84dS2+lRcs3VmQcHBefYyRrEWH/TwGnyIp1DpjI8aCxaXi9sW8PPbwTAl2m
X-Received: by 10.99.172.2 with SMTP id v2mr39381093pge.100.1489444704933;
        Mon, 13 Mar 2017 15:38:24 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:ac5e:90c6:a609:7ab8])
        by smtp.gmail.com with ESMTPSA id g64sm34508589pfc.57.2017.03.13.15.38.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Mar 2017 15:38:23 -0700 (PDT)
Date:   Mon, 13 Mar 2017 15:38:22 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v3 0/2] bringing attributes to pathspecs
Message-ID: <20170313223822.GB66601@google.com>
References: <20170310185908.171589-1-bmwill@google.com>
 <20170313182322.27539-1-bmwill@google.com>
 <xmqqbmt4n71d.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbmt4n71d.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/13, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > v3 fixes some nits in style in the test script (using <<-\EOF instead of <<-EOF)
> > as well as fixing a few other minor things reported by Junio and Jonathan.
> 
> Thanks.  Will replace.
> 
> I think this is ready for 'next', so let's ask reviewers to really
> pay attention to this round, wait for a few days and merge it by the
> end of the week at the latest.

Sounds good to me, Thanks!

-- 
Brandon Williams
