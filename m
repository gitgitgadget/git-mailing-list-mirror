Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E202D211B4
	for <e@80x24.org>; Sun,  6 Jan 2019 18:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbfAFSSx (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Jan 2019 13:18:53 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52337 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfAFSSx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jan 2019 13:18:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so5246050wml.2
        for <git@vger.kernel.org>; Sun, 06 Jan 2019 10:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=59p7xm/s+dv6u+kIXAVYmMZhR/EP2kjx2rPSFDMSnb8=;
        b=c1n9NvhFFzu1syyAZ5Fo2z03xEo46+07T2QXSqaqQHYaZN7wGwo+FxXrK5aaILj4bG
         u8rh0xdfKrk2/cPFb+OHM8gvH9TiFPC+vOdVuPCl6/Cdp6mQMNdQXEtPEe+tMjRBLsPx
         YfVI7ybitFCkTSSrtrOi1l+Y4mEsoorfPCq9dF3mL3gv1zCShLcvwJchZN5zYP6aV0cS
         TQlBAFI5ByUeKxU/zLL5R4iwf+Pv4eptHEfoMPuNB/SRTcjSCFr0vuyEVF/F9CvW6N3H
         duYYnv+wXIU+PBqyIy1gz2cJrgSy3/m+aUfim+ekTcjIoS7K3jQY3guEiPjoP5yetxTn
         G+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=59p7xm/s+dv6u+kIXAVYmMZhR/EP2kjx2rPSFDMSnb8=;
        b=uZZ/V8PdKHj5tpqY44mwD+8g1N7DU+NGLJsNRm/Nl5uiVz9CTYCF1Xz9UaM/d18Ox8
         tQD+uVCGNgkr/1Tlj2sSrQuMVEIpM29eDo4jnqLd8920cCCHq2duboMlJIMJ7gY3hEev
         TY3Idhrp3UFAuBW8VpBTLsvTLE5FPOkiWehrwFDzJEgAokmViWtZvUdWhfiVPifIxGrx
         4Xu8paGHvgPPKVtgAe6nBWZuyQpsHspcLSaTNQhOUhDLT/UIOdV4BJDSy+yzFCuSk4o2
         H4KtQ29ZErdeuHKM0UFpqt3kShlN2d34aMWYkoMq3N7E9+cfnCeGWVauf6GXSv36eusg
         XMTA==
X-Gm-Message-State: AJcUukcFYZId0GkVrhRxcSp73tHFAyFL9jWTKEtL5DJefSPHiBVzsj5E
        /sVPnO3uHIM4azSlMukyVuj58ENP
X-Google-Smtp-Source: ALg8bN5AbG0xUpA67kWEubvUCVzoN/TyOC8QMggJE5Ot1A1RLrP5rlPW/vHvDJDPNAJ61yxekQZrYQ==
X-Received: by 2002:a1c:8c05:: with SMTP id o5mr6256077wmd.29.1546798731695;
        Sun, 06 Jan 2019 10:18:51 -0800 (PST)
Received: from localhost ([2.24.105.63])
        by smtp.gmail.com with ESMTPSA id x3sm46934265wrd.19.2019.01.06.10.18.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Jan 2019 10:18:50 -0800 (PST)
Date:   Sun, 6 Jan 2019 18:18:50 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 7/8] checkout: introduce --{,no-}overlay option
Message-ID: <20190106181850.GG25639@hank.intra.tgummerer.com>
References: <20181209200449.16342-1-t.gummerer@gmail.com>
 <20181220134820.21810-1-t.gummerer@gmail.com>
 <20181220134820.21810-8-t.gummerer@gmail.com>
 <CACsJy8B-jB6o2XYG_6UdTrhrGbos-+5rs98qqQQuJYYV+6W+SQ@mail.gmail.com>
 <CAPig+cSOyCQZXiG7sJWb12WzzujM-nsqqpt+cFZTFvXB1+-SVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cSOyCQZXiG7sJWb12WzzujM-nsqqpt+cFZTFvXB1+-SVQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/23, Eric Sunshine wrote:
> On Sun, Dec 23, 2018 at 3:05 AM Duy Nguyen <pclouds@gmail.com> wrote:
> > On Thu, Dec 20, 2018 at 2:48 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > > +--[no-]overlay::
> > > +       In the default overlay mode files `git checkout` never
> >
> > -ECANTPARSE. Maybe "files" should be removed from this line?
> 
> Also, add a comma after "mode".

Will do, thanks both.
