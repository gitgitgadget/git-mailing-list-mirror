Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14A4F20A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 22:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbeLGWob (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 17:44:31 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34278 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGWob (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 17:44:31 -0500
Received: by mail-pg1-f194.google.com with SMTP id 17so2329921pgg.1
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 14:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9DpAptFXn3mMrE+gvdFUTN8Sr8SxxJbYPqysLuIdf0o=;
        b=vUd8zQkwPgWW+KrGZOHCgCJ0H1C1y6E7T1z1yCuH1CsMRjyWk4zp74CthvMzR5V8V4
         Mc0ZGaF/OcB7fFYF9GnAv2PFu+ssqfTTiMplTh9NlbOhbHRjsVgKj1qtHnS/9xcI7qdi
         YRX6COg0xuUaL/0ov50jRDTdmXzLIxxo59Tgy2ACIOqhSqYt6p5eohO2f3tJVqPeB3eo
         escmhHyL1NMP5KVTcUp37G7yHruJz4ntET7GNLylXciwU5lr+YUqbuh1K8H4o+6i3Vdd
         uXaeEk74UsblwyZ9OIBB1CnYwTHivl7dTYk/QKsuRFGDN5TKf5z3+YE+yquOk0fUoajv
         BQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9DpAptFXn3mMrE+gvdFUTN8Sr8SxxJbYPqysLuIdf0o=;
        b=Lz+ZGwYWOCfARJOWqnCSL5aA9ZU5/HD8YLIUQYi1Ya1wicdIyqt1nipdqnFGUj/0iE
         ey4ff9PwzmgJKfb0hruxTWvV7g7rFIZ748lOKZpIjtdQe8DKJYLHohdruAsLTl7fAqeh
         duyGKrxNiZFcdOFzUcepUabc895EJYA1ZHjV1dcvFbQsvr10Kc6bDZ1Cx8OQyPUiVp8c
         bZD9yXqMfjbMZNP2y55hjnCmzBpZjeAkI7StH/ghNAzOPM52KvRcC0e4Z8EKpcQW3xAO
         PYclSQ2cufEQp1tpUY/fTScSrLYIYKSvetiRq3A8cdQu6nJX1KbljoECSeyXdhe5lXR2
         pNOg==
X-Gm-Message-State: AA+aEWbJardzQrC/PO4hNObPo6Vo6wkl8X6ni83igtzPlj+3Y0zkmaN4
        fS7sI4Zu+uSZLAWQMGG9yL+msSDw
X-Google-Smtp-Source: AFSGD/XLW/3RtB+oT2oPFmOlidAq858J42ONt3zfDLvpQCj4Um+0CZYsHBsf2meSCrljQ5qS0dWmSA==
X-Received: by 2002:a63:1a0c:: with SMTP id a12mr3483334pga.157.1544222670463;
        Fri, 07 Dec 2018 14:44:30 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id i72sm6042658pfe.181.2018.12.07.14.44.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 14:44:29 -0800 (PST)
Date:   Fri, 7 Dec 2018 14:44:28 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     William Hubbs <williamh@gentoo.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, chutzpah@gentoo.org
Subject: Re: enhancement: support for author.email and author.name in "git
 config"
Message-ID: <20181207224428.GE73340@google.com>
References: <20181206181739.GB30045@whubbs1.gaikai.biz>
 <CAN0heSp2g0A82YYvMw-RaERESXFtj3TgPKA3RysC07Lf=tHBcg@mail.gmail.com>
 <20181206191737.GA31091@whubbs1.gaikai.biz>
 <nycvar.QRO.7.76.6.1812062318570.41@tvgsbejvaqbjf.bet>
 <20181207222147.GA22590@whubbs1.gaikai.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207222147.GA22590@whubbs1.gaikai.biz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

William Hubbs wrote:
> On Thu, Dec 06, 2018 at 11:20:07PM +0100, Johannes Schindelin wrote:

>> There *is* a way to get what you want that is super easy and will
>> definitely work: if you sit down and do it ;-)
>>
>> Please let us know if you need any additional information before you can
>> start.
>
> Which branch should I work off of in the repo?

"master".

Also, please make sure the documentation (e.g. in
Documentation/config/user.txt) describes when a user would want to set
this option.

See also:
- Documentation/SubmittingPatches
- the DISCUSSION section of "git help format-patch"
- [1]
- https://www.kernel.org/pub/software/scm/git/docs/user-manual.html#hacking-git

Thanks,
Jonathan

[1] https://github.com/gitgitgadget/gitgitgadget#a-bot-to-serve-as-glue-between-github-pull-requests-and-the-git-mailing-list
