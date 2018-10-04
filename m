Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F73C1F453
	for <e@80x24.org>; Thu,  4 Oct 2018 04:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbeJDK5e (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 06:57:34 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:38938 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbeJDK5e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 06:57:34 -0400
Received: by mail-pf1-f182.google.com with SMTP id c25-v6so2380976pfe.6
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 21:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=JBvpsW7I1KfgHTXVdEJ1ByPo44phNTXtfiunRUhEyI4=;
        b=qgPLygqjH6G33gzR73i/2vTSwlsA/r1znFkUCzANnj+8PGNo5FA7sUSvT8P/1tAh1k
         9VNf7UCWTmisOylEJyuaXIsIJ/xxuOFTJ78uA05SlmihpbgMiAFgBYpnt1ny1QuLJV6P
         Jec8CtNaUVv2fztt8pAUkasb7yRQRqLaOzQQ0IXfFo91cNTbWnDVuQQfzV7+3v8fiifX
         HGyoo1mtSxI/hbVNKLHUWi0yWdJ9s7omC5HMiMXxWT2BAFLCONmRtNn8FHfWC/SY3to0
         tOzZpi711XwmJh67gGaqkzBNOxeK0haOEar2gYuMzEHQ6eAVHouy+Z4qJ5TEmGcFAIq+
         agdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JBvpsW7I1KfgHTXVdEJ1ByPo44phNTXtfiunRUhEyI4=;
        b=ROxfkoLNc0IoQlQl6M2DjUOKhqtfTpVydIwAryeRCUzRhr9F14rLFfRd8ZRvKywXUE
         qGi86kDKu3R3x5RYSuNGytSX1lTRMrK7V0YFYPu3qAUoyx+4g0n1cUv2oWgxe9Tc1yNB
         lFFUJSCbf1JFaKiFJloS7hI9YpqNJlKbaq+XnRZ/CQqV4cY/yIRB9Fue+0j050hDZNjE
         fOKR0XD2TP8o5Dye+BpcTRg/Z/mpVYzLeR3eyb2SE1FunMoUUDitY0u/MlrJ6LwjKfH8
         mU3fkVWX1n93khnBEK/3zoUgbbOr/NGjpsyTIwZgkmgDwPHAnOMwuSW9NRaoIA+ygUvI
         Z2Jw==
X-Gm-Message-State: ABuFfohk/mErXh0J5pefFArxxeWIsyvsT72nwaqJ5HEnvC8smK9ivG2n
        nR0u4B68EzqitiwkULgW7OU=
X-Google-Smtp-Source: ACcGV63m7Dv//+lQ7gFqBAEy4kzMSY29vLNOJCVEZXS7/VEj+CYaJQ1lGWqs6NdoTAEMtyclcY84TA==
X-Received: by 2002:a62:9316:: with SMTP id b22-v6mr4880528pfe.193.1538625976967;
        Wed, 03 Oct 2018 21:06:16 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id x69-v6sm4533362pff.175.2018.10.03.21.06.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 21:06:16 -0700 (PDT)
Date:   Wed, 3 Oct 2018 21:06:14 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Stanis=C5=82aw?= Drozd <drozdziak1@gmail.com>,
        git@vger.kernel.org
Subject: Re: git-remote-helper list command question
Message-ID: <20181004040614.GA165126@aiede.svl.corp.google.com>
References: <e63531d2-d0d9-7b37-480b-b7f2a40782e4@gmail.com>
 <384e746b-4ca4-1f5e-0c58-accac06ffaf9@gmail.com>
 <20181002143550.GA24480@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181002143550.GA24480@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Tue, Oct 02, 2018 at 11:43:50AM +0200, Stanisław Drozd wrote:

>> I'm trying to write a fast-import-based git remote helper, but I'm not
>> sure what the output of the `list` command should look like. How can I
>> find an example of the format in action?
>
> There's some documentation in "git help remote-helpers".
>
> For working examples (of this or any other remote-helper stuff), your
> best bet is the git-remote-http helper that ships with Git. E.g., you
> should be able to do:
>
>   echo list | git remote-http https://github.com/git/git
>
> to see sample output.

Other examples to look at:

 git cinnabar <https://github.com/glandium/git-cinnabar>

 remote-testsvn.c in git.git (though it will be moving to contrib/ and
 then out of git.git fairly soon)

These might be more helpful than git-remote-http because they are
fast-import-based helpers.

Thanks and hope that helps,
Jonathan
