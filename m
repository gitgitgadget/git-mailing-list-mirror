Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 052C51F6BD
	for <e@80x24.org>; Fri,  3 Feb 2017 18:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751366AbdBCS4I (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Feb 2017 13:56:08 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34640 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbdBCS4H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 13:56:07 -0500
Received: by mail-pg0-f65.google.com with SMTP id v184so2640998pgv.1
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 10:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gCmDIzbDzZS6+2T/IHF2hA0HucCbLrf7VXh64d+QDgQ=;
        b=f9lj0cCwyutMFGd0CrK2V/OMtQ8UCjhpB2chQsaDNb39FRqoXpY8KZQiz+b0smqwb1
         c9Qh/+EHIhBH8Qn1AmPno5xMIZE7Fkd7eABMUE4jxLjiQvjdF5Lr+5vs/mLka08oe6ge
         O8aV7Qg30uAs2NZ7jwuHyh+WnPtoo8Unh30ojERfe7yAZXlkg19z4GNmwWWuBTf+J8kL
         1VNJZyIYtllGPQT+XShIz0HIKibvb78BTyXUIykw061pycWCI0mvuqiev3O2m3pWtJja
         8IbUTCk7kChqZVmln5/qX+M31650SciOZWnolzhrZ7TIx96rhPZm7IeUOenMG3gQ5HTL
         abXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gCmDIzbDzZS6+2T/IHF2hA0HucCbLrf7VXh64d+QDgQ=;
        b=Quy1JYLm/Ny3OexSivAJp99FMcm1fUUFn9u7A1J6FuVPFRyiOFA9ZJjLN6JiPOLuxQ
         lCxaHr6OX9InePfnvzPc5g/ylOUAT3IgZRbCpJ1TChvNdNRRVUoWGpmLBe2yPdC8B4I6
         d/2lQsDonjpWVGONtVFWknTEY0nNf1erhf46CEZCCMhMdR+fwRJwHq+oyjHzlN/GT3Bd
         dLZd6UxCNfHMf7s09YKNSUxGjcZSD7ol/pP5x05gkIAhA/AL/L8Dx1LXeN86byGagYhX
         obSJpqSpUiDOU63Jui/4FdSkk4U+j2ey6YdwuB/+n52OVRUH334gdzrIvNO2aXhSRfCN
         MCvA==
X-Gm-Message-State: AIkVDXIdmSVz8WONK7L9wiqn70hgGVFhQU9KaILQ4zfalHt/iRIioNo3P4h9rzXh9kAOJg==
X-Received: by 10.98.102.21 with SMTP id a21mr19688981pfc.29.1486148166486;
        Fri, 03 Feb 2017 10:56:06 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:dd9f:576d:b8fa:253a])
        by smtp.gmail.com with ESMTPSA id a1sm7403621pgc.14.2017.02.03.10.56.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 03 Feb 2017 10:56:04 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 00/11] nd/worktree-move update
References: <20170202085007.21418-1-pclouds@gmail.com>
        <alpine.DEB.2.20.1702021015160.3496@virtualbox>
        <CACsJy8B3bdokeYVt6aEyZVSzO50PiQRn+0sid9mSDTZ9q-mnww@mail.gmail.com>
        <alpine.DEB.2.20.1702021043110.3496@virtualbox>
        <CACsJy8A-tuea7W+tj6rNddtM0j_374FODjQqKsT8eHfeZ0qDZg@mail.gmail.com>
        <alpine.DEB.2.20.1702021136210.3496@virtualbox>
        <CACsJy8CBG_a_nX_syXKrdG2-ren=NO9CNxe6tm94FGnEo1HZLQ@mail.gmail.com>
        <alpine.DEB.2.20.1702021223320.3496@virtualbox>
        <alpine.DEB.2.20.1702021330040.3496@virtualbox>
        <xmqqmve4s5r2.fsf@gitster.mtv.corp.google.com>
        <CACsJy8Cq8sY1hL75Xs_MMr9r_+jjr7p+58D+0GhT3mgSgiUEtg@mail.gmail.com>
        <xmqqtw8bf7xn.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 03 Feb 2017 10:56:04 -0800
In-Reply-To: <xmqqtw8bf7xn.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 03 Feb 2017 10:25:24 -0800")
Message-ID: <xmqqpoizf6ij.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I do not recall seeing that.  I however deliberately ignored another
> statement because I thought it enough to answer, which was:

Oops.  "because I didn't think I thought it enough to answer" was
what I meant.
