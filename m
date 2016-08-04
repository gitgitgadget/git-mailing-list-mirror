Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DEF51F855
	for <e@80x24.org>; Thu,  4 Aug 2016 22:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965762AbcHDWJn (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 18:09:43 -0400
Received: from mail-yb0-f176.google.com ([209.85.213.176]:34636 "EHLO
	mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965241AbcHDWJm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 18:09:42 -0400
Received: by mail-yb0-f176.google.com with SMTP id x196so9123431ybe.1
        for <git@vger.kernel.org>; Thu, 04 Aug 2016 15:09:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZINe2BBuphRObnFcIE1BHpowyxu3Tw5+GyIZy5ooNJE=;
        b=B3FZzBbPQsBosyRcTbro5lH8CrbaSKiPLq/lVRLxnjnR4siN6efbZqZQB6ALSMFwRB
         zrvcbfqjs7e69o8SflkKe+LLBFEUTTVkq+Hiy1h5Qo6Y/S/OIWzudUp57NiyHIt1G8Za
         K3EfthBiseiJoiGp7pMCp2K96HO7xAaoSchE0K3XGunh7Vi9dCUP47JdkGobbbhDSGV+
         wa5AiZHrWVS1ocx4LoWF6L3VuvjiW0YWXZzYgYqx1P35wGYdBTYPO4hB62iPeYX8kCp+
         nYY5Gm5BY2DPpEI9GmH2rDl6yRrFN+wScbXX3rOzGb1JBjpNCuaZGFtraex0iULi/LyV
         eVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ZINe2BBuphRObnFcIE1BHpowyxu3Tw5+GyIZy5ooNJE=;
        b=kVw4jQbfZlbx/0lHXiMFpytIeljvLyzP4ElwDi9kLoCVPGoKk6UwFmn7qmcXeVStnZ
         ijyG61sSu032BYgrgzJkhPtPTW11NgfqQSHf1kzg3DVSXuO6K7gw9t9gO/yO4tjfkq2L
         m9vBmtbh3/Uqcu7CDJnyreKzse0cXjtdaYjl2Pp1iIhg6xtO9JMno+8re/4xJdfxljuj
         FGcBE0znIm4bl/mA2KMN5DO0df2untaXb/b3pyOnaXt9R9yU9IVy0/VZ+zRi2KPIMb1c
         X50hemu50R8mqVDH9kt6SlTUqlsq0kPpmEqnRlaOYKY+epwiQ7x0jdO3Bo7KFavfI/3M
         XDSQ==
X-Gm-Message-State: AEkoous2YXtNf60GgeBHURXI/q6IgeC0frA0TuwPItqANieU7487j/GK2jcyyoEFk5Ol7B72lVdhVZWlum5Ulw==
X-Received: by 10.37.66.147 with SMTP id p141mr23883492yba.28.1470348581559;
 Thu, 04 Aug 2016 15:09:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.250.4 with HTTP; Thu, 4 Aug 2016 15:09:21 -0700 (PDT)
In-Reply-To: <CACi5S_2j+PXFwE755CSiE01=sYALx-17Hk1k8zJOR9_Fj7y9Pg@mail.gmail.com>
References: <CACi5S_0QGEgnijGyaBeZxOSobdwfA+d-wa-jrHs64Va097mnRQ@mail.gmail.com>
 <xmqqr3a8goka.fsf@gitster.mtv.corp.google.com> <CACi5S_2j+PXFwE755CSiE01=sYALx-17Hk1k8zJOR9_Fj7y9Pg@mail.gmail.com>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Thu, 4 Aug 2016 15:09:21 -0700
X-Google-Sender-Auth: OBOAKBICCHt6gZRB7m0UT1ylynU
Message-ID: <CAPc5daVPpeCTLbo4t7gRbKbP=BMnhHHtE68uXjanQDS2nKc4dw@mail.gmail.com>
Subject: Re: git grep -P is multiline for negative lookahead/behind
To:	Michael Giuffrida <michaelpg@chromium.org>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 4, 2016 at 11:54 AM, Michael Giuffrida
<michaelpg@chromium.org> wrote:
> On Mon, Aug 1, 2016 at 2:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> I do not think "git grep" was designed to do multi-line anything,
>> with or without lookahead.  If you imagine that the implementation
>> attempts its matches line-by-line, does that explain the observed
>> symptom?
>
> No. If it worked line-by-line, it would produce more results. It is
> not producing the expected matches because it *is* considering the
> previous line in negative lookbehind, when I don't want or expect it
> to. Thus it throws out results that should match.

If that is the case I do not know what is going on; perhaps
somebody more familiar with the pcre codepath can help.

Sorry.
