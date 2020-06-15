Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BD9C433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 20:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A59FE207D3
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 20:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbgFOUm2 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 15 Jun 2020 16:42:28 -0400
Received: from elephants.elehost.com ([216.66.27.132]:18373 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgFOUm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 16:42:27 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 05FKgN2g087095
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 15 Jun 2020 16:42:23 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'S=C3=A9rgio_Augusto_Vianna'?=" 
        <sergio.a.vianna@gmail.com>,
        "=?UTF-8?Q?'Alexandru_P=C4=83tr=C4=83nescu'?=" <drealecs@gmail.com>
Cc:     <jrnieder@gmail.com>, <johannes.schindelin@gmx.de>,
        <don@goodman-wilson.com>, <git@vger.kernel.org>,
        <msuchanek@suse.de>, <newren@gmail.com>, <philipoakley@iee.email>,
        <sandals@crustytoothpaste.net>, <simon@bocoup.com>,
        <stolee@gmail.com>
References: <20200615180744.GB135968@google.com> <3cef6084-e632-c9ce-c0da-a2c250c2f512@gmail.com> <CAAwdEzDgJuoQJAZsrT0piuZPVP6nJTSB9RCbcuXO03-BYTnmOQ@mail.gmail.com> <8f9193aa-43bf-2ad3-d067-6330385e1788@gmail.com>
In-Reply-To: <8f9193aa-43bf-2ad3-d067-6330385e1788@gmail.com>
Subject: RE: Rename offensive terminology (master)
Date:   Mon, 15 Jun 2020 16:42:17 -0400
Message-ID: <048501d64355$791a82b0$6b4f8810$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIIOsKfXbaWWkX+z+UjHlA8JMhOngIxLQiCAj1JNpMBueFHG6hE6GXQ
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 15, 2020 3:38 PM, Sérgio Augusto Vianna wrote:
> Subject: Re: Rename offensive terminology (master)
>  >But the people that contribute to the code and to an open-source project
> are the owner of that project so they get to get the calls.
> 
> Ignoring everyone else's opinions and needs and just exerting your authority
> is the very definition of authoritarianism. Yes, they do have the right. But if
> they ignore the users, they can just use a fork that does what they want.
> Have anyone considered that a breaking change in git might very well result
> in a fork?

Without seeing the whole context of this response, I will answer simply as a repository manager, not a platform maintainer.

While I fully understand the requirement to change the term "master" (and I think it should be changed), the situation must be put in the context of the available technology. In all major players, whether git itself, or GitHub, BitBucket, GitLab, or AzureGit (there are probably others, but I'm trying to cover 95%-ish), the repository manager/owner has the freedom TODAY to change the default branch to anything they want, within the limits of the character set encoding and name contents. No change in code is required to make this change in one of your repositories. Action is required, some configuration, but it is not a difficult or lengthy activity, to change the default behaviour.

As happened with Jenkins as an example, I expect that the community will handle this change over time as is practical to cover all the (previously mentioned hundreds of) touch points without braking the one DVCS that manages much of the current set of production operating system code (a.k.a. git).

My team still has a just few legacy repositories that still publish "master" as the main branch because if the impact on our deployment infrastructure - which is critically customer facing. We will address them when we can do that without impacting customers. But we are standardizing to a more GitFlow approach with "development" and "release" as our main branches and "bugfix/*" and "feature/*" as topic branches - with "development" published as the main branch. That is our choice. You can do something similar as technology stands today in the git ecosystem.

I cannot comment on OpenSource or commercial git clients who might have limits on their own naming standards, but the bulk of them should be agnostic to the published default name. However, scripts that use git (and there are a huge number of those) should also respect the default branch as published without hard-coding the term "master" to allow us repository managers to seamlessly change what we publish for our communities (yes, I am guilty of not following my own advice today looking back historically because I did not know better some 8 years ago).

With Respect,
Randall

