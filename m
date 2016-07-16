Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9273D2018F
	for <e@80x24.org>; Sat, 16 Jul 2016 14:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbcGPOta (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 10:49:30 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:35077 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbcGPOt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2016 10:49:28 -0400
Received: by mail-io0-f171.google.com with SMTP id m101so127312955ioi.2
        for <git@vger.kernel.org>; Sat, 16 Jul 2016 07:49:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6OtMbm9SUod+rdX88JO/HEr+CDHAXLTb9sRTtqk8kfE=;
        b=EZB+KWFVLTKgYBFIcCsM6kjdcoftohgUi+vI6M8V9sPYYCj81kn0tMKme2DYfiRPxU
         SdTh1WiDk+1qtk5/pchoW0+tZPrISKjA7zKbWJOlJGAyGMevkrrmX9SEGvu+YShEwESK
         bS3fbnj4yTGhaDvjyybAzq/MHKKRKjC0SHjbWuDqbLtPK5JvcSegJNlk9Fj3O7ILshPG
         x9W66zcsfazeeZw9BjYkL3OjBOXbc4CS85gyk34tIJQJ99Sfg/OG5RAqasZoDBB6adq5
         L8Hp/ALJu6uv/zRLhrJ7INO/5rFJrVqTJILOGyvz9A8xiTyJCJw+1CO8YH9kl7XiPAjE
         lwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6OtMbm9SUod+rdX88JO/HEr+CDHAXLTb9sRTtqk8kfE=;
        b=lWZnUtYC1kt+NBdpChhcnB8Ynh+CQ2Tsn8P4aJXFctf1A5AJbfy/0b+fTbZl/hGeTy
         r6qQHC0PXePhID8VV4e/Z3m1UezR0wVB7XRM37QbKg2k/4F7H0hPSTF5HDhpw2MBj+dR
         XGSFMbqdkF1sXtGwT0k6al1/7h4xlUhGFa3aTEcTAjoaKBFDrp3h0xumbUe4G5hVwOqR
         L9OBl7Mu595DhZYps9z2T8r85rNWo6Kvs836Jm7fnmN7rAOUwLcfVIIJ6VSrCZxQX+9r
         25Hl0G/WWpEzXULnakPg8LCrmS0HxHGVnqOSSwPW1vuU9i/WD+dOmiHROAgd9IAXy8TD
         lgWA==
X-Gm-Message-State: ALyK8tJLTIa9yX87Ez6wH8RV6OXCYYGT/OVcihY5v2FzbDxA56WtOKqgvYvOu7Qqz2CHZJ4TWTV/9oFnzW4IsQ==
X-Received: by 10.107.8.140 with SMTP id h12mr27395710ioi.95.1468680567948;
 Sat, 16 Jul 2016 07:49:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Sat, 16 Jul 2016 07:48:58 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1607161507250.28832@virtualbox>
References: <20160712164216.24072-1-pclouds@gmail.com> <20160714153311.2166-1-pclouds@gmail.com>
 <alpine.DEB.2.20.1607141750190.6426@virtualbox> <CACsJy8AjVX1Say0srEq+ezGg=CzmbjBAt4PnuikXiqdnVC4G6g@mail.gmail.com>
 <alpine.DEB.2.20.1607161507250.28832@virtualbox>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sat, 16 Jul 2016 16:48:58 +0200
Message-ID: <CACsJy8AvxC-p9=no+tYBc80-MWfApQ_QBagk0x7NXJDG9D=ZRw@mail.gmail.com>
Subject: Re: [PATCH v4] config: add conditional include
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 16, 2016 at 3:30 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> As an alternative solution to your problem, you could of course avoid all
> conditional includes. Simply by adding the include.path settings
> explicitly to the configs that require them. Now, that would make reasoning
> and trouble-shooting simple, wouldn't it?

I can't. Repos can be created and destroyed often (it's in the
process), and there are many of them. Using a wrong identity (among
other incorrect config settings) is a serious problem and I cannot
guarantee myself that I will never make a mistake, forgetting to
include stuff on new clones.

>> > I still fail to see what use case this would benefit,
>>
>> It allows you to group repos together. The first mail that started all
>> this [1] is one of the use cases: you may want to use one identity in
>> a group of repos, and another identity in some other. I want some
>> more, to use a private key one some repos and another private key on
>> some other. Some more settings may be shareable this way, like coding
>> style-related (trailing spaces or not...)
>>
>> [1] http://thread.gmane.org/gmane.comp.version-control.git/273811
>>
>> > and I already start to suspect that the change would open a can of worms that might not be desired.
>>
>> You can choose not to use it, I guess.
>
> Sadly, as the maintainer I am unable to share in that luxury of yours.

I need this. And I post it because people may need it too. But if it's
a bad thing, I guess I'll keep this patch on my tree then.
-- 
Duy
