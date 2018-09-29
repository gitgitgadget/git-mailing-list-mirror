Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D6951F453
	for <e@80x24.org>; Sat, 29 Sep 2018 18:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbeI3BE3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 21:04:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41720 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeI3BE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 21:04:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id j15-v6so9582483wrt.8
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 11:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=F3gwwwgDG4eB3lk3PT33A4HR5IYHWush21WwPM7ElBA=;
        b=pBL+MucyUSCySwzZFBmj/H3zoEt5AYAZRr+28f03kq1IWo+5fg+BpPldkildIbFc+l
         FnQoqTPr3giqBfCZ0H2O+YQM5oMrlzUhhJSIguPlKdeVMrYL0uE9ILzBzwYA1TQJfDdv
         AuAkslpv/A6qOVgRHQs69s7A5RtMXnBn14gDBvA/gvb+73siRc2XlpB1YX6LWAdtjtYe
         LHOJWe3yk2gEZ51tJE54RpZiUgcxngi79aje0fYGGNl2A/55js0InoTT3eCHDhac2OhK
         cXGRG3rvTKfFHL0i5R/jmEQ1uprGQCYtgfz5XIuwwLSUZsYovDPUmVtaqfKby0ZflabH
         EzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=F3gwwwgDG4eB3lk3PT33A4HR5IYHWush21WwPM7ElBA=;
        b=p8EOZTtrHTPTZ1bpLN23YrIauLW+bAs8GsvyvTUp+Wrt9hj1IyzpFU03zEAefzVQpd
         hFM+65qE6GeL6vQzHnvXijiVbpvsYh7ZzGPtTUY+r1X/XYK4VP2vNwEQEqm3VzgPJfJ2
         1gwGP8IUcwaZOImNl49n14e7Lyq9PJi0YVNO7ONXlijdd/xbSJoi499lP4rA2X/CxLaL
         2EUoVWkrbTcmpqGVyU9kpv+yjIdBKDDIr5iqXgGqTcp2sWOZHOyDG/62KGuCbxufOnBh
         Muge+oV9sh/JUPPIYER03FcT7D20kzYVBi/qw/coQwu7q3t/jzulWEle9MS7Z/pmXB4s
         Q/fg==
X-Gm-Message-State: ABuFfogk8l76hD7N5lSoKGgblQrY6fm+3ErDucnNJI2kThrpa0wz/xnK
        CErulg+yFZvSbg4wOjqaHtNSsQ9h
X-Google-Smtp-Source: ACcGV62Dki88wfpBPdHtHOezrnwyRKdJssr/iS48dj3A19KRbMXh4YHaKOW5ZqQ2JHeEsDuvrkPMiw==
X-Received: by 2002:adf:fe83:: with SMTP id l3-v6mr2591863wrr.322.1538246100268;
        Sat, 29 Sep 2018 11:35:00 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d2-v6sm6509475wrn.20.2018.09.29.11.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Sep 2018 11:34:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] fetch: fix compilation warning
References: <4d868114-a7a5-a39b-d6d4-5a436419f105@ramsayjones.plus.com>
Date:   Sat, 29 Sep 2018 11:34:59 -0700
In-Reply-To: <4d868114-a7a5-a39b-d6d4-5a436419f105@ramsayjones.plus.com>
        (Ramsay Jones's message of "Thu, 27 Sep 2018 23:08:38 +0100")
Message-ID: <xmqqr2hc884s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> You probably already know, but I had to add this on top of the 'pu'
> branch to get a clean compile tonight (your 'jc/war-on-string-list'
> branch).

It was not just about squelching a warning but simply broken code
that deserved to be warned/errored.  I think what we have in 'pu'
now is already fixed.

Thanks.

>  	}
>  	hashmap_free(&remote_refs, 1);
> -	string_list_clear(&remote_refs, 0);
> +	string_list_clear(&remote_refs_list, 0);
>  }
>  
>  static struct ref *get_ref_map(struct remote *remote,
