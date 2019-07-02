Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0515D1F461
	for <e@80x24.org>; Tue,  2 Jul 2019 00:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfGBAPc (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 20:15:32 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:45860 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbfGBAPb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 20:15:31 -0400
Received: by mail-pf1-f182.google.com with SMTP id r1so7320875pfq.12
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 17:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KcqyqFHSYYCw60DckRtDsY0A5tGUuQnQE+q0fsW4NGs=;
        b=F1ZFu11FdCxA7pX9+k2JtSuEV/+j/n8O9c7okGdoRTFHBvKpEVZGMg/Yo4f+R6T5UV
         sTDblvj06DO6fV85cds1FEyhbDm2ciK2wpRiQ6Q5n5lSizJsXBKgfhaaCTLZivGvdvbN
         g6fuPbcVhmuHOzKrIUgHggIr9YB7VeosW2Y7MlEn6sQ6Z+m7wuWx0qtOUwMWo2wEXR3x
         8RfoiF9yLeohd+bpLHESRIomD4Jv4Wpj6Kqo96apDzgW32dGqkH65hMASjS00BE/6DUT
         BJfXBUUxKIJ7VSfaDo2BT2x/HM+pW/OTOMJmJZ5WxT5Uv84guev0KbWyUheYOWdAZ78K
         qRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KcqyqFHSYYCw60DckRtDsY0A5tGUuQnQE+q0fsW4NGs=;
        b=TT74Xzup+mOAGbtNS8RDLsVLz96pkHW5xEUpdFPP3v504745XDpxaYz94PvcGKEhWb
         Ie56RdVZGO/018v7Xm/Fw9G19y8u7k9zz2ApmaZqIlQHK8aC14w9snlYd2p8hoqYfZmT
         8OoaryTDOcUUNSaove3r2FKXEaomLxUW8xmWi+7mpcc6ZDJ3rJ0+kZ8aZhinn5KJ5VjO
         qlkeJCivF1h9g4TkpPKf/78Uueo4oR8fDLQq6u+cxvEVEYZnTv+oRbbYmSZx2k/oK5qe
         aw8HcynbvJjGuA1E9iHHCB7/jUwz5xu6WeC6Ui19Xxk+linp8LhMnyYvvvBLZilC4JOh
         QfYw==
X-Gm-Message-State: APjAAAVZ84/4xXFwVNL7YxZbj0eXG5qXvS7ckGjHCurZOza9YJk6HQ02
        ln0dq9cqUIX8EnxNU4T+dkZV5v/L
X-Google-Smtp-Source: APXvYqxzrZ8I6fGwi+B2RydkVANuOxLCrsUebTRDQ1tm9/Sj6a6RvewswyuX7UBKEmAosm8+4f8tHg==
X-Received: by 2002:a17:90a:bb94:: with SMTP id v20mr2251596pjr.88.1562026530804;
        Mon, 01 Jul 2019 17:15:30 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id u3sm531351pjn.5.2019.07.01.17.15.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 17:15:29 -0700 (PDT)
Date:   Mon, 1 Jul 2019 17:15:28 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Anton Ermolenko <aermolenko@atlassian.com>
Cc:     git@vger.kernel.org
Subject: Re: [QUESTION] Git fails to detect merge conflict?
Message-ID: <20190702001528.GA94153@google.com>
References: <E42B8D46-0CA0-44E0-946F-8ADA96993629@atlassian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E42B8D46-0CA0-44E0-946F-8ADA96993629@atlassian.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anton Ermolenko wrote:

> My understanding is that recursive merge here won't consider that situation to
> be a merge conflict as the changes have been introduced in different spots in
> the file.

Yes, that seems right to me.

Do you have more details about the context?  What do these files look
like?  Are there other cues that we could use to discover that the
customer intended the changes to conflict?

Thanks,
Jonathan
