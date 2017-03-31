Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E154D20958
	for <e@80x24.org>; Fri, 31 Mar 2017 07:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932676AbdCaHpk (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 03:45:40 -0400
Received: from smtpq2.tb.mail.iss.as9143.net ([212.54.42.165]:35597 "EHLO
        smtpq2.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932395AbdCaHpj (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 Mar 2017 03:45:39 -0400
Received: from [212.54.34.118] (helo=smtp10.mnd.mail.iss.as9143.net)
        by smtpq2.tb.mail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <git@jessiehernandez.com>)
        id 1ctrFY-0001Kb-LN
        for git@vger.kernel.org; Fri, 31 Mar 2017 09:45:36 +0200
Received: from 53546d64.cm-6-5b.dynamic.ziggo.nl ([83.84.109.100] helo=jessiehernandez.com)
        by smtp10.mnd.mail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <git@jessiehernandez.com>)
        id 1ctrFY-0007rw-JZ
        for git@vger.kernel.org; Fri, 31 Mar 2017 09:45:36 +0200
Received: by jessiehernandez.com (Postfix, from userid 112)
        id CCDC820267; Fri, 31 Mar 2017 09:45:35 +0200 (CEST)
Received: from mail.jessiehernandez.com (localhost [127.0.0.1])
        by jessiehernandez.com (Postfix) with ESMTP id 5005720263;
        Fri, 31 Mar 2017 09:45:02 +0200 (CEST)
Received: from 217.150.190.17
        (SquirrelMail authenticated user jessie)
        by mail.jessiehernandez.com with HTTP;
        Fri, 31 Mar 2017 09:45:03 +0200
Message-ID: <ff7628d7c69ecd3d212b29fec33f6ba1.squirrel@mail.jessiehernandez.com>
In-Reply-To: <20170331103330.5d7c414b6a0273cefb8508f2@domain007.com>
References: <0fc69c73-73aa-5355-264b-a7c55377eec2@lanl.gov>
    <916067befdc828e5d33dd3c1817989e7.squirrel@mail.jessiehernandez.com>
    <20170331103330.5d7c414b6a0273cefb8508f2@domain007.com>
Date:   Fri, 31 Mar 2017 09:45:03 +0200
Subject: Re: ttk error when starting git gui
From:   "Jessie Hernandez" <git@jessiehernandez.com>
To:     "Konstantin Khomoutov" <kostix+git@007spb.ru>
Cc:     git@jessiehernandez.com, "David Shrader" <dshrader@lanl.gov>,
        git@vger.kernel.org
Reply-To: git@jessiehernandez.com
User-Agent: SquirrelMail/1.4.23 [SVN]
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-SourceIP: 83.84.109.100
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.2 cv=f8Y4PK6M c=1 sm=1 tr=0 a=O0j+lLEKKvAiBX9A7DJArw==:17 a=8nJEP1OIZ-IA:10 a=6Iz7jQTuP9IA:10 a=CdBCPKDxAAAA:8 a=UuFpKptc-gYuQ0rYkc4A:9 a=wPNLvfGTeEIA:10 a=lDjxF1AZmdN7bNtopFhl:22
 none
X-Ziggo-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Fri, 31 Mar 2017 08:44:27 +0200
> "Jessie Hernandez" <git@jessiehernandez.com> wrote:
>
> [...]
>> I also got this problem when I wanted to build and run git 2.10.x.
>> I have added the following change to git-gui/git-gui.sh
>>
>> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
>> index 5bc21b878..5ce59ef94 100755
>> --- a/git-gui/git-gui.sh
>> +++ b/git-gui/git-gui.sh
>> @@ -894,7 +894,7 @@ set default_config(gui.fontui) [font configure
>> font_ui] set default_config(gui.fontdiff) [font configure font_diff]
>>  # TODO: this option should be added to the git-config documentation
>>  set default_config(gui.maxfilesdisplayed) 5000
>> -set default_config(gui.usettk) 1
>> +set default_config(gui.usettk) 0
>>  set default_config(gui.warndetachedcommit) 1
>>  set default_config(gui.tabsize) 8
>>  set font_descs {
>>
>>
>> If you guys want I can submit it as a patch.
>> But i assume that 'fixing' this by disabling the feature is not really
>> what we want.
>
> It's possible to have ttk with 8.5 as well (say, here on Debian 8.5
> ships with ttk enabled).
>
> A proper patch would be
>
> -set default_config(gui.usettk) 1
> +set default_config(gui.usettk) [namespace exists ::ttk]
>
> Could you please test it on your system?
>

Yeah that seems to work.
Thanks for this.

I have tried it with git 2.12.2

Jessie Hernandez



