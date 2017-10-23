Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40EF1202A0
	for <e@80x24.org>; Mon, 23 Oct 2017 23:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751200AbdJWXNE (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 19:13:04 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:44177 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbdJWXND (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 19:13:03 -0400
Received: by mail-it0-f50.google.com with SMTP id n195so6966184itg.1
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 16:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v75IgA4tXp2RLQlEMActl26L6dqmlB9T9gah8eZmY7w=;
        b=nhrJu0tUpP266Yn/qOpFK2+zNenTDVemmlCVIPxNsx0MvvvV/nHhwaNm7MYfwMc1SD
         T5Z+0SMXxjSpVOStzKPk+5vXDU85oijNzLqJmZVBr4+815YfIydkHo9DHFyKsrei4Wvx
         LrCpmVsBOBJ5St1JCryl9O9jkiAd8p9BMihAD0OiOigHUe4d6UXFUmF7118ITv14x4G/
         inUWX/022AvRPdL0p6EZKK0/144J8zmS03qrvua5Dcbl4tfkG0DyWzKGX/fBFpqhOUE3
         GxbdF84sl8fIZe/H+APZdovIqNftBn9YvQXzWTaucIZjLZ9NrTc2vhZ3hJA/zCqUwfeE
         slzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v75IgA4tXp2RLQlEMActl26L6dqmlB9T9gah8eZmY7w=;
        b=aN5OuUkY0ZBpYwsNysE1vlCpipakaawCtP53mWrGc+p+AVwKjupBbC2gLDRSrzgi1n
         PAPjcw3sWkrPhP3ykrCpCFE4XYXjySkwcmw5UJc12HYlfVrcphrUSQx0TwW6niGXvR5g
         BuUrWiTgc6VCVhtB2jK3dw53Wncg7ZxQFjL1eE39IRvI8h87R12HfM3IALXc2h4/SnPJ
         YAHipF/i4xwgvZ9NBUva1573SJAkQJvznyIm07ZCIVUbJvw0mqTsEEEtwNJnYMdBCb/h
         xSePk9srdTwJvyJ937NSkzlgYBUqAHe+E5pmxJ82XvGyS7miDX2E9wajxW3QJevgAZQD
         UUjw==
X-Gm-Message-State: AMCzsaUXHHl2DH6yLSNPYMK0Dn/JNR4joF+bNIpmIFdwQdLObg6aT+up
        RfByPfqEUVZ+WPq1nPm78PQ=
X-Google-Smtp-Source: ABhQp+QRoVFvMe6Z2Y2VG/79dzVB4UDtimFfhtMtjqihc+B1zX+dupLcXIJhhpo/SNye93Yzols8BQ==
X-Received: by 10.36.211.71 with SMTP id n68mr11925093itg.88.1508800382336;
        Mon, 23 Oct 2017 16:13:02 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 81sm45287itl.20.2017.10.23.16.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Oct 2017 16:13:01 -0700 (PDT)
Date:   Mon, 23 Oct 2017 16:12:59 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        bturner@atlassian.com, git@jeffhostetler.com, gitster@pobox.com,
        peff@peff.net, sbeller@google.com, William Yan <wyan@google.com>
Subject: Re: [PATCH 3/5] ssh: 'auto' variant to select between 'ssh' and
 'simple'
Message-ID: <20171023231259.ohrpcnxpaznpgkbl@aiede.mtv.corp.google.com>
References: <20170926235627.79606-1-bmwill@google.com>
 <20171003201507.3589-1-bmwill@google.com>
 <20171003201507.3589-11-bmwill@google.com>
 <20171003214206.GY19555@aiede.mtv.corp.google.com>
 <20171016171812.GA4487@google.com>
 <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
 <20171023213159.eitrjrqrh277advm@aiede.mtv.corp.google.com>
 <20171023151929.67165aea67353e5c24a15229@google.com>
 <20171023224310.o7ftwmbr7n74vvc6@aiede.mtv.corp.google.com>
 <20171023225106.GA73667@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171023225106.GA73667@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:
> On 10/23, Jonathan Nieder wrote:

>> Separately from how to document it, what do you think a good behavior
>> would be?  Should the "auto" configuration trigger command line based
>> detection just like no configuration at all?  Should the "auto" value
>> for configuration be removed and that behavior restricted to the
>> no-configuration case?
>>
>> I'm tempted to go with the former, which would look like the following.
>> What do you think?
>
> As a user having some variant as 'auto' doesn't make much sense, i mean
> isn't that exactly what the default behavior is?  Check if my ssh
> command matches existing variants and go with that.  What you are
> proposing is the make the existing auto detection better (yay!) though I
> don't know if it warrants adding a new variant all together.
>
> Instead it may be better to stick this new improved detection at the end
> of the existing variant discovery function 'determine_ssh_variant()' as
> a last ditch effort to figure out the variant.  That way we don't have
> an extra variant type that can be configured and eliminates some of the
> additional code in the switch statements to handle that enum value
> (though that isn't really that big of a deal).

Yes, if git config allowed e.g. ".git/config" to unset a setting from
e.g. "/etc/gitconfig", then I wouldn't want the 'auto' value to exist
in configuration at all.  But because git's config language doesn't
have a way to unset a variable, this series provided "auto" as a way
to explicitly request the same behavior as unset.

In that spirit, the patch I sent was broken ("auto" meant something
different from unset), so thanks for pointing the issue out.

Sensible?
Jonathan
