Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4F4A1F42D
	for <e@80x24.org>; Thu, 24 May 2018 19:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034454AbeEXTG6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 15:06:58 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37621 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030244AbeEXTG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 15:06:56 -0400
Received: by mail-wr0-f195.google.com with SMTP id i12-v6so5041299wrc.4
        for <git@vger.kernel.org>; Thu, 24 May 2018 12:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dNxKRvr5Y0FJaU7nnmIqd9ZCflMlbSqUPOZzXJxQCp4=;
        b=rQ44P426D8/ngt/3QdbX3GP1SKY9gUMQoAI4xKX3PzXOz4ErXpGBNjWVcpvIy6Fbz6
         1UM9M5VNbWVzEnQAsMUVV3/afJkkOjOKDF2gBLDtb1Piy7yB+spVKTLjqY7RlTn7830P
         xoVqdINrESf+WaugpntLHfIU2HGs3J+AEC4tA9OJyCA5UsrG1v/UlNfwrqsHXrsoDXWO
         HMYi58n4f4MTvs5m64MlC091oq1AbLuWjv03O3p/MZlmCnk6ALcTJ5rvqSv+mJOXmx6n
         nmmSr5+Ccn2E214xkwuvrp0J0TnY5rPWU87o5CNLD5LZ0srbV5lAq9P+6z+vIGPN8m+b
         Jg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dNxKRvr5Y0FJaU7nnmIqd9ZCflMlbSqUPOZzXJxQCp4=;
        b=Jo4QnLWn9EcdsVj31Lc06/N0S898kFtqmY2GSXrqsMkZecu1pyyqcZVAZCtuzjMhkL
         V6vy+6wQdlQVqShtdmBu/6E166eZXcHEGU2H8rLEMEt0Wg8zcWKEdfjOu63ZiV27106Q
         uljPUnebp3LCZOfPxIQDUSc3csIEto7XNvso0g0P5qcEHhmWCL19IPT8hLGJAkLZKRYT
         /1ThVHloVTlZTc8U9GYNP1t7zTaaVaX5Ect6hVfvWEf7XYsLNJ1FBbyn25fjaj0V8gWO
         eT6CP0fgFkjwFUvZ+WkcYpa3vfxANINXQ7nBHVu+4GrWLTHRyaNNOKn3WlOlZujXSXiZ
         +QTw==
X-Gm-Message-State: ALKqPwf3m8MawM813jAiVblHxTeJyHIFtGnYpCIto/Wf3+uv9D9pshla
        s6bzaVqi3Tp5Lg9ccrt0An2508VV
X-Google-Smtp-Source: AB8JxZqrxzoSasgDDgd1Qb3bMcGBOsmDpNOxJaboYCQeS7lqPUCOsvRwVNM0aDJhxGEqgFp5B3qgpw==
X-Received: by 2002:adf:80d0:: with SMTP id 74-v6mr8415468wrl.273.1527188814864;
        Thu, 24 May 2018 12:06:54 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id d9-v6sm18302494wrn.71.2018.05.24.12.06.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 12:06:54 -0700 (PDT)
Date:   Thu, 24 May 2018 20:07:24 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH 7/7] rerere: teach rerere to handle nested conflicts
Message-ID: <20180524190724.GC18193@hank.intra.tgummerer.com>
References: <20180520211210.1248-1-t.gummerer@gmail.com>
 <20180520211210.1248-8-t.gummerer@gmail.com>
 <xmqqefi1qrpj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqefi1qrpj.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/24, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > No automated test for this yet.  As mentioned in the cover letter as
> > well, I'm not sure if this is common enough for us to actually
> > consider this use case.  I don't know how nested conflicts could
> > actually be created apart from committing a file with conflict
> > markers,
> 
> Recursive merge whose inner merge leaves conflict markers?

Thanks, lots of stuff in Git I still have to learn :)

> One thing that makes me wonder is that the conflict markers may not
> "nest" so nicely.  For example, if inner merges had two conflicts
> like these:
> 
> <<<
>  <<<<<
>  A
>  =====
>  B
>  >>>>>
> ===
>  <<<<<
>  A
>  =====
>  C
>  >>>>>
> >>>
> 
> where one side made something to A or B, while the other side made
> something (or something else) to A or C, I would imagine that the
> outer conflict could be "optimized" to produce this instead:
> 
> 
>  <<<<<
>  A
>  =====
> <<<
>  B
> ===
>  C
> >>>
>  >>>>>

Yeah, I do think that would be a nicer merge conflict to solve.  But I
think that should be done in a separate patch series if we decide to
do so.  When this one lands rerere will be able to handle the conflict
either way :)
