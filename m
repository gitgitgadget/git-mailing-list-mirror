Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B1881F462
	for <e@80x24.org>; Mon, 10 Jun 2019 05:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387431AbfFJFP0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 01:15:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42032 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbfFJFP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 01:15:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id l19so1766235pgh.9
        for <git@vger.kernel.org>; Sun, 09 Jun 2019 22:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lP/6o4sLT7P1s04x41pMcb7+V13kpsWYWSHIiqn4NwE=;
        b=MqWASsPDPijDtH6aqArsTLGs7/TAAV7yfWyqgoeiA39Hp2zqtOYp51rN9P8QUirbRY
         j9SdeoqzAdSC4M7TbHUs187C6uL9tbYNpN8Kumhrz0T4nZIRdjcZ78lgSQsu4drLhpiO
         jEHDs9ALBsCLR57SuKZ4ttjYUnc3XQ59N4ogWUM+eDNG4Fbjt4r5x1ANXPfQ/JFbKkP+
         1+nZI9VRxcw8rnXjEBUYrP6KQxC33rTjEcCPTNLjN5kfOLgna+Q+Ru/ofoSWL/zIXFIY
         FRORHHg37UGalK7fs4VDXSc6Oo1rNOG6GD87fEvXjklQ/gnxJLMi2NWJg5hdqMUIsqvX
         0Dsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lP/6o4sLT7P1s04x41pMcb7+V13kpsWYWSHIiqn4NwE=;
        b=KfnYfPVJjhFWkNHkMfApuat8OIqtA890SX2gYehgIUkC86zc6ynbdsMKrKFxDHoZfX
         3WCLZWFIhVejoFti15dkaOnAZhLC/fkl9TlE6ZCvg+rSxULq0GL2thCv/n4nXsBX3Y6h
         ilptaz/7zUeG6UNWwuySdLwsUxXBSg5DRcLBV7ketsHGZ3jwFnW5NLjzi9i92YfBajFB
         ybDso3gOqUmN7KaGus9U133TFid2VFDbRC2sELLLAOoWTf3na6V+2YAjrV0MXDzDnXRB
         KYoAXcrKEhRXeI0AT8z6Ku+OjU89dvED4GTmRktLlS7In2tk4cU5Z9Gin+1ZwCLOFI3q
         csFA==
X-Gm-Message-State: APjAAAUUy0zpPxQWhOE3GBmtcSIIa4epbWJIQ+28B2rASrzEGXcFB1pb
        b+Puy2YoPRkoMXyfSjKQkgQ=
X-Google-Smtp-Source: APXvYqx2eAIDvo4idCKmalIkDFfXFwR3t87THQGeX2cWbgNzUc9UlxhCA1/dD6/oeXwr5u/85vIEIg==
X-Received: by 2002:a65:41c6:: with SMTP id b6mr13803577pgq.399.1560143725208;
        Sun, 09 Jun 2019 22:15:25 -0700 (PDT)
Received: from ar135.iitr.local ([2401:4900:3108:4602:68f6:50e8:cfb8:76b6])
        by smtp.gmail.com with ESMTPSA id b23sm9416807pfi.6.2019.06.09.22.15.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 22:15:23 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     phillip.wood123@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, rohit.ashiwal265@gmail.com,
        t.gummerer@gmail.com
Subject: Re: [GSoC][PATCH 1/3] sequencer: add advice for revert 
Date:   Mon, 10 Jun 2019 10:43:13 +0530
Message-Id: <20190610051313.16222-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <2007ef79-1791-4f77-f9e4-34c59b4f0c36@gmail.com>
References: <2007ef79-1791-4f77-f9e4-34c59b4f0c36@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip

On 2019-06-09 17:52 UTC Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Rohit
> 
> Congratulations on your first GSoC patch series!

Thank you very much :)

> On 08/06/2019 20:19, Rohit Ashiwal wrote:
> > [...]
> > @@ -2655,6 +2655,7 @@ static int create_seq_dir(void)
> >  	if (file_exists(git_path_seq_dir())) {
> >  		error(_("a cherry-pick or revert is already in progress"));
> >  		advise(_("try \"git cherry-pick (--continue | --quit | --abort)\""));
> > +		advise(_("or  \"git revert (--continue | --quit | --abort)\""));
> 
> I agree that it's a good idea to add advice for revert as well, but it
> would be better to call sequencer_get_last_command() to find out if
> we're running cherry-pick or revert and tailor the advice appropriately.

Firstly, signature of `create_seq_dir` doesn't allow us to call
`sequencer_get_last_command()`. Changing that for the sake of a
better error message is too much task for this patch as it is a
subject of discussion on its own. (Also changing signature only
makes sense if this patch series gets merged). FWIW, I think we
should left this to further discussions for now and decide what
to do later on.

> Best Wishes
> 
> Phillip

Thanks
Rohit

