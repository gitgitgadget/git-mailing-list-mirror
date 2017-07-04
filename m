Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C32BF202AC
	for <e@80x24.org>; Tue,  4 Jul 2017 19:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbdGDTQo (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jul 2017 15:16:44 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34104 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752212AbdGDTQn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2017 15:16:43 -0400
Received: by mail-pg0-f68.google.com with SMTP id j186so28407796pge.1
        for <git@vger.kernel.org>; Tue, 04 Jul 2017 12:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=d83+nB8CT0tbCbalTdreZeNkEWQZLNhHEbUXgF6GRxQ=;
        b=n6muLgzDESng+8MbPXzuWgbKoOO4iDyGfhl4moFooZBypYHTjG7RaadjoLAjwJIR5p
         naNRzLHQaP2/Y8bX4uF7GmNZJu5enXlXY+O3VnvZK5yTLflKC7fRqRz/j/mD1B/5FqxS
         BpO4LcpJfpRVPaR4gtlVkkFXU+NAOi9jVIf/ZCLwwa3hAbWvPprHjNI5f8Y7qzEYYm78
         Xgb5ZaL+xl1zWG5PqvVsJl10IUI56WpnxCZNijCXf4GWTn8WhyeOn2cPR6cF47kP5ts+
         KG7mFQXJhB5ntfwP1QMsPho6nFaz0zHEXZIr7E3ng6o0y9QA4yBo8U730bbbfEMJDOgh
         bvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=d83+nB8CT0tbCbalTdreZeNkEWQZLNhHEbUXgF6GRxQ=;
        b=VD2LhJcsQl7J4VsGfUv6NaSL5ywbjiBqwZRs9DGWKS83SJKJgX4u+rimNsoFBVCmWW
         XQs1wgKMJX1Gf0DV/mKy7rgWBPLcIbS7MC12D9nHT6LJg/E8RvFCHrtqpGAHs4F+OiPa
         qsn7KwruJCavTQanfs2RVOYvlQ7O6Ty/X3Hi/g1VZfk8AVONd5nP0j7jUnCuV0R4u+NY
         YAP+2idC0kqUuxkW0ueo7av29k40zakjoiq6qQjKAiNHVkaPjPov8EH6T77iAlSyhYnv
         mD2Nhdz5O8kiXKSexg5EQovbwdEqixOhUrdkibV/055UM1U0GK9cv+4DpK1sCoM8lpjQ
         2PjA==
X-Gm-Message-State: AIVw110qbGxRtnEnqrexYmE7hjltQt31sMyNHdCw9QJoG5n/52ml0omF
        dwdOnyLckc3FBg==
X-Received: by 10.84.133.7 with SMTP id 7mr13040591plf.32.1499195802732;
        Tue, 04 Jul 2017 12:16:42 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id e90sm42669516pfd.75.2017.07.04.12.16.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Jul 2017 12:16:42 -0700 (PDT)
Message-ID: <1499195804.6428.2.camel@gmail.com>
Subject: Re: "git intepret-trailers" vs. "sed script" to add the signature
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Date:   Wed, 05 Jul 2017 00:46:44 +0530
In-Reply-To: <xmqqh8ytmp7y.fsf@gitster.mtv.corp.google.com>
References: <20170630154306.26993-1-kaarticsivaraam91196@gmail.com>
         <xmqq1sq1togq.fsf@gitster.mtv.corp.google.com>
         <1498918546.4321.1.camel@gmail.com> <1498925790.4321.7.camel@gmail.com>
         <xmqqh8ytmp7y.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2017-07-03 at 09:58 -0700, Junio C Hamano wrote:
> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
> 
> > So, it seems that excepting for 'commit' it has quite a nice
> > spacing. I
> > guess we could add something like the following to fix that,
> > 
> >     # Add new line after SOB in case of "git commit"
> >     NEW_LINE='\
> >     '
> >     if [ -z "$2" ]
> >     then
> >       sed -i "1i$NEW_LINE" "$1"
> >     fi
> 
> Isn't "sed -i" GNUism that is not portable?
> 
It does seem to be the case. Then the alternative would be the
following,

    if [ -z "$2" ]
    then
      sed -e "1i$NEW_LINE" "$1" >"sed-output.temp"
      mv "sed-output.temp" "$1"
    fi

Actually the GNU's sed documentation tricked me into believing '-i'
wasn't a GNU extension. The '-i' option works with the '--posix' option
of GNU sed which made me believe it isn't an extension.

> > I'll send a typical patch that uses "git interpret-headers" as a
> > follow-up.
> 
> When you say a "typical" patch, what do you exactly mean?  Does
> anybody else send typical patches (or atypical ones for that matter)
> to the list?
> 
I apologise for the inconsistent wordings. I try to mean a patch which
I'm not sure is acceptable (or) not. I guess that's [PATCH/RFC] in the
language of this list. I'm not acquainted to the wordings as I'm an
"off-list" person trying to help and get help! I'll try to use
consistent wordings as far as I could. Once again, please excuse my
ignorance.

-- 
Kaartic
