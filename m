Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FD951F661
	for <e@80x24.org>; Wed, 12 Jul 2017 20:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbdGLUi1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 16:38:27 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33607 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751862AbdGLUi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 16:38:26 -0400
Received: by mail-pf0-f178.google.com with SMTP id e7so18371704pfk.0
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 13:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u9CeYCYQM1MRBS1zhQ/CuCtE+U6xYg0J0k4053ci+DU=;
        b=A/TUbfI5fIVN9ywXdIE/qN6M3W8s3r+yEZsgC6eWIRT342dfoToH7fhLwes1Jb3c3X
         BdBm8i7djaCJTfzt5Sla8G6ochJ1RXE+VQlgIyQw3oiZfIvy6uZjvDt+HUKvHrwyX/J2
         dbIm2NMMJ/NdoVNPVj1eB9s0Nh9FBzl+7OKgihibN07KNhlj5NiEzdtYUYHckOU/u3So
         91smXF8nyAU0Xp+Esgy1O6yif+pTmYJ92IV4cqtqHA22Vaj1Ni7+Trcg8bNXZCy8T1AA
         w7Zg1y+9Rqwb59St1ZNiXPv/Xw0/E2zbxF5dPHhr0nqjVAyKXxWKz8sCwwP2yd6EO2Z1
         lGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u9CeYCYQM1MRBS1zhQ/CuCtE+U6xYg0J0k4053ci+DU=;
        b=KM9phQuXn+aXzMYmNlyN98ruDmM3xp8vFnSp7GOGrFLx7h6TV/LF+XDF6ug5tDl7Az
         qOQu5X38Sk8J2J85R/nIPbJIcmaG53CkCGDzaQktCTaA5FX+6wwoghzp/fhLicFS2hAk
         ODUBhRK9xyoBnQJM+CO+V+ahY95WudNktf4imNvoWBju1xTcoIcQ6yAN37X+AkMqMNvq
         IW6q6TyJYaMHrVH/x8f5CI4id5Ij1yq7/yxAzY02UvUbarqvjRCeFnUp+vwQlcS1ii60
         kPS6ExwApwlArPICi4SgdpZ0ceDW1UHRRZsmzm1rBXFKK4ViO4+FBlgkh4Tzo66841sg
         n5kQ==
X-Gm-Message-State: AIVw110Vz/ST9wAptQhRkKPfGoasOT358JmSheymuh3KKSkU5IWkoJPZ
        FwrTYp3dbhE7r52pCeY=
X-Received: by 10.98.97.66 with SMTP id v63mr37199422pfb.230.1499891905807;
        Wed, 12 Jul 2017 13:38:25 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:25ad:9264:1cd0:bb62])
        by smtp.gmail.com with ESMTPSA id i27sm7896749pfi.82.2017.07.12.13.38.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 13:38:24 -0700 (PDT)
Date:   Wed, 12 Jul 2017 13:38:22 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] sha1_file: add promised blob hook support
Message-ID: <20170712203822.GH93855@aiede.mtv.corp.google.com>
References: <cover.1499800530.git.jonathantanmy@google.com>
 <34efd9e9936fdab331655f5a33a098a72dc134f4.1499800530.git.jonathantanmy@google.com>
 <8366d1de-3552-50fc-7a6c-7cfc3219181b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8366d1de-3552-50fc-7a6c-7cfc3219181b@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ben Peart wrote:
> On 7/11/2017 3:48 PM, Jonathan Tan wrote:

>> Teach sha1_file to invoke a hook whenever a blob is requested and
>> unavailable but is promised. The hook is a shell command that can be
>> configured through "git config"; this hook takes in a list of hashes and
>> writes (if successful) the corresponding objects to the repo's local
>> storage.
>
> This would seem to work well for promised blobs but does it
> currently support other object types?  In our large mono repos, we
> have to support missing commits and trees as well.

Can you elaborate on this?  This is the first time I've heard about
it.

Are you omitting commits and trees today?  How does that work with
commits --- is it something different from shallow clone?

[...]
> There are a couple of related patch series in flight that are
> playing in this area. We should definitely coordinate these various
> efforts.

In that spirit, I've created
https://github.com/jrn/git-large-repositories so we have a shared
place to keep track of pointers to the mailing list, etc.  I'll push
the links mentioned to there now.

I'm also usually available on IRC (channel #git-devel on freenode,
username jrnieder) for real-time conversation.  Logs are available at
http://colabti.org/irclogger/irclogger_logs/git-devel.  You can
prepend a message with [off] if you want it not to be logged.

Thanks,
Jonathan
