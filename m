Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EB252018E
	for <e@80x24.org>; Fri,  5 Aug 2016 21:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762516AbcHEVun (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 17:50:43 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33343 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S3002490AbcHEVul convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Aug 2016 17:50:41 -0400
Received: by mail-wm0-f66.google.com with SMTP id o80so5491794wme.0
        for <git@vger.kernel.org>; Fri, 05 Aug 2016 14:50:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=H1brZxvNBs0cbkvw7b7SUH+bJ9bE3qpUSXFQg41tVec=;
        b=U5kFxhPJvU4O7EMB5n3nd5OtOmwy/aS2P5LUHcF/05zT5Kt6VTJ46hUPsXqrliqYnC
         qkMSPRVxc88sRbqWHnAsKvpuP6CQ7q2VRVbYEmFW495SQw5S48awTICPV8UV2jHfV5SE
         FQulMg0A7YdGktkUIk9SBqNTR3kTC5Y2scMlBFR302K8Z+3xZgU32usbDYCq3RJDvuIz
         Pjfp2wvlYFn6Tfx/c4oTA2o10VBYrFUf9KM1SAN9SwDcZ2zNeTfQPuKeEKkNl8485dlc
         JdbnUZtFknGR+FYdUXeHaEwYyltfDikbiWqXwBy7XZ6nG0AveF5LK3GOkCuHUVmyKrfw
         a5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=H1brZxvNBs0cbkvw7b7SUH+bJ9bE3qpUSXFQg41tVec=;
        b=WpejdYOyTPSBMjdZYkLMhcvL7Tkfei/8kMn53c0w4TF5BLH6QrRx22rw0DyWOPuHcY
         hakJUwSLR/F/Sbyqb3A/p3n/tilMzp96rguletgB8B6WUfu6R4ykQCMB37KL9+MTIg2L
         6CPAzaGnHqjKFTv9eGzigKYDwRawQRBRzL6PfUi6zgJE4en7ruVDtCSRKTOhXlD45RFC
         eo+DPEx5mIwWWcD6Ofi4Q6sFwrXX0e+0nhZ0ywmgk1A6D7mXvlQLnRIvPe0xUqFXM3n1
         WtxMN2cqnHH2T4tsbvnhFpbfm8ApV7TmH+jDn4D9t6GkE8ic3nawXa+PnimcNT56qbWB
         e6Pg==
X-Gm-Message-State: AEkoouuTf1V+WFHhXRKNdcwUTGEdHXNNJ8maa4KImEMlcv5SfLSjWLPXv/1gXqrTFJC2gg==
X-Received: by 10.194.110.229 with SMTP id id5mr81267716wjb.23.1470433839718;
        Fri, 05 Aug 2016 14:50:39 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB641A.dip0.t-ipconnect.de. [93.219.100.26])
        by smtp.gmail.com with ESMTPSA id 3sm10501963wms.1.2016.08.05.14.50.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Aug 2016 14:50:39 -0700 (PDT)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 07/12] run-command: add clean_on_exit_handler
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <b14c6063-cef8-56b4-eb57-7ab8577ecf0a@web.de>
Date:	Fri, 5 Aug 2016 23:50:38 +0200
Cc:	Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com,
	jnareb@gmail.com, mlbright@gmail.com, e@80x24.org
Content-Transfer-Encoding: 8BIT
Message-Id: <ECE58461-10CC-49C2-9BE7-DB80A6746F88@gmail.com>
References: <20160729233801.82844-1-larsxschneider@gmail.com> <20160803164225.46355-1-larsxschneider@gmail.com> <20160803164225.46355-8-larsxschneider@gmail.com> <20160803212433.zzdino3ivyem5a2v@sigill.intra.peff.net> <826967FE-BFF8-4387-83F7-AE7036D97FEC@gmail.com> <20160803225313.pk3tfe5ovz4y3i7l@sigill.intra.peff.net> <74C2CEA6-EAAB-406F-8B37-969654955413@gmail.com> <20160803231506.h5mo5lah2pgwdvip@sigill.intra.peff.net> <6C522B0F-F8F7-4B51-8BF0-67D9EDC97B3B@gmail.com> <b14c6063-cef8-56b4-eb57-7ab8577ecf0a@web.de>
To:	=?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 05 Aug 2016, at 23:19, Torsten Bögershausen <tboegi@web.de> wrote:
> 
> On 2016-08-05 15.08, Lars Schneider wrote:
> 
> []
>> Yeah it could do that. But then the filter cannot do things like
>> modifying the index after the fact... however, that might be considered
>> nasty by the Git community anyways... I am thinking about dropping
>> this patch in the next roll as it is not strictly necessary for my
>> current use case.
> (Thanks Peff for helping me out with the EOF explanation)
> 
> I would say that a filter is a filter, and should do nothing else than filtering
> one file,
> (or a stream).
> When you want to modify the index, a hook may be your friend.

Agreed. I will remove that feature.

Thanks,
Lars

