Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0366A1F45F
	for <e@80x24.org>; Mon,  6 May 2019 15:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfEFPel (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 11:34:41 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40143 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfEFPel (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 11:34:41 -0400
Received: by mail-io1-f67.google.com with SMTP id s20so1762836ioj.7
        for <git@vger.kernel.org>; Mon, 06 May 2019 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CMMELclvNjXhfIIozD5GOIDdgf1lbp6vnJftDgrMEas=;
        b=t+enr5d46s3nIH7F4BhM7BjolAowDCLhduD33NRPjr8tZucryjHwD1wovS9bCb5mWG
         hpo5NOGrQjpXAQMo+zrSu9bxcnTaG3arxaZxzR33MH+i4gftgF+ioPfqcXRqEsdgoUDG
         HwEMN5rxr6pBkYwLHZhMRLss4C0evacL013386qqIKKWbkQeDIKBzENoJOOLj2Cxumdt
         3yjT+/QeurUFP9WqCOrjr/PklhZMAFudfjt9FmgJTL7m7F86TfI9Z7LeaZKBoW2rGfyx
         Oe/iob630yxcLnHyD9/68aWoSrrq3CQoWv6jRKnuxAIl8MDiHkOhpA/Z+q8CYMFYDm4g
         XrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CMMELclvNjXhfIIozD5GOIDdgf1lbp6vnJftDgrMEas=;
        b=VYRTBFLTmk/ZjvuGqsaPZ1Fyx7/ki9vdray8MWiMruOzMUuM/hYzzUHnlwTSQUU7Z8
         oOj61aKcTSncQgTADFMLSOmjL2nq0qaMFl2OW0msPxt7g+6cAs3Y9IWsmIe58uzdl9X8
         YgmWBjGzbL7y1gDPNEhtAP160u2j/iIAMGbZJIwnL8fdB/Q3aEPtgxEPRa/NsZvV56UJ
         jd6hmnKUGnr746M4aO22SZ8V6pGJt2n6+QvTSsAmtBgDBbmzBTc/sFGDpAqvfKePyKVw
         5qo+2Wng4EBeHc4LuFSN4WhL8LjKOLXmaCDQnurkLo6w9GwzB/NvgFffQiq8FfCRH8fd
         dZmA==
X-Gm-Message-State: APjAAAVdX/8gXKh0we/LN/lpLea0s5JChtm39OXn8B/NlT4KUWpFsTSY
        Z0+ylybr/Q6xj399uM4TPFM=
X-Google-Smtp-Source: APXvYqw0pdpCiv3Lp5vLlmdnVPp2DEeggAw0oE12fBU6wYUSIe2wZtFigF/je8m42D5NLnpq8pcvXw==
X-Received: by 2002:a6b:8ed0:: with SMTP id q199mr11465576iod.181.1557156880692;
        Mon, 06 May 2019 08:34:40 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:700:2553:5cea:cc9b:df9d])
        by smtp.gmail.com with ESMTPSA id m3sm3811664ion.69.2019.05.06.08.34.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 08:34:39 -0700 (PDT)
Date:   Mon, 6 May 2019 11:34:37 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v5 0/3] *** SUBJECT HERE ***
Message-ID: <20190506153437.GA1170@archbookpro.localdomain>
References: <cover.1556062365.git.liu.denton@gmail.com>
 <cover.1556526308.git.liu.denton@gmail.com>
 <20190429083042.GA22366@archbookpro.localdomain>
 <877eb3j145.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877eb3j145.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 06, 2019 at 01:03:54PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Apr 29 2019, Denton Liu wrote:
> 
> >> Subject: [PATCH v5 0/3] *** SUBJECT HERE ***
> >
> > I forgot to change the subject... Embarassing.
> 
> Do you use git-send-email with --force? We should detect & stop these
> being sent out otherwise. See a03bc5b6ad ("send-email: Refuse to send
> cover-letter template subject", 2009-06-08).
> 
> Don't worry about the E-Mail itself, shit happens :) Just wondering if
> that detection case is buggy, or if you used --force, or maybe sent the
> E-Mails through another method than git-send-email...

No, when I started doing work on Git, I couldn't get git-send-email to
work and, since then, I've just used Mutt to send my patches. So the
only bug is in my workflow ;)
