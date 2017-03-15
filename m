Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23EB0202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 21:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754130AbdCOVwK (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 17:52:10 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33679 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751848AbdCOVwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 17:52:09 -0400
Received: by mail-pf0-f170.google.com with SMTP id w189so14542583pfb.0
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 14:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0cP8AGIWO+b7JxEL6WQvf6A9r7k+KRBIY25tWKVMnco=;
        b=jiqoVAqMq/5lMQNAbh+0yH/MhvVE0UoEUSOS0UtJ3DnBeg1XiNE3G1yIzH1tl5MVAQ
         6urgriffWEQZ7fzNa1iOponuqWbEHbvpg7rVew+TWOlpBxM7oasy7T/kL9gNIGOUnf24
         ajAHpDoFSjp4pZ2wPT0byX0oQrT6yATBhwKwTlB7klI3HDKEXonQ1zMhOceDlOqCy9DU
         jC2P805LRx9OKlywksE7Zn5WkqwJxgPFRtIwWXdm5kMWIpipwIKJ0SITsqfOpXy21Sqz
         HoBE+asedMehCnX+/rf5GvGcMBVLSez8N/uTydBntahJlD5BNJbrV7Nd6hvsiCNCPcFu
         w+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0cP8AGIWO+b7JxEL6WQvf6A9r7k+KRBIY25tWKVMnco=;
        b=tyiT/9MRFsUpAjwGcp2NmYaGu9iW3Q+dfRBJOLeH0NornSqUpxLkameP2AXbRCmmQr
         N7Io5oFnHjfH3BEYZNuXWWLg6S0MO9UuuBC4J2uGOd8uBZaXVUmW40XPWa6tbcVXh2tv
         6DdR7cMrG5/x1lKKHQh0mNOLR21IJIJ9xlm7ljc4qyN9DAYI9i66FslZEHllu6OWbnJP
         GuHo6ycCVSVXjZzabNbS7gK7n/bOWJqkZT7p/znuMikIDPwDcyK666x9NUb7f5UZb9R6
         MSw4iPTDUFtz34R26+D5MZ1wbRmKl7gDu0zhfd1Nb+s/vS3pV9q8zXPnMiSODPYdG0BF
         QMaw==
X-Gm-Message-State: AFeK/H02i6RXd/k+mK1v9o92wOVJObAiBISbjqUWGOqbHOeKjIbyMtn4ap6bdYWCMhy1SpDA
X-Received: by 10.98.192.151 with SMTP id g23mr6174252pfk.254.1489614727895;
        Wed, 15 Mar 2017 14:52:07 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:e5fd:c660:1f84:47a3])
        by smtp.gmail.com with ESMTPSA id q194sm6084650pfq.43.2017.03.15.14.52.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Mar 2017 14:52:06 -0700 (PDT)
Date:   Wed, 15 Mar 2017 14:52:05 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v3 06/10] submodule update: add `--init-active` switch
Message-ID: <20170315215205.GE159137@google.com>
References: <20170309012345.180702-1-bmwill@google.com>
 <20170313214341.172676-1-bmwill@google.com>
 <20170313214341.172676-7-bmwill@google.com>
 <xmqqvarbis4j.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqvarbis4j.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/14, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > +--init-active::
> > +	This option is only valid for the update command.
> > +	Initialize all submodules configured in "`submodule.active`"
> > +	that have not been updated before.
> 
> You mean s/not been updated/not been initialized/ here?

Yep you're right, the documentation is a little stale too so I'll update
it.

> 
> > diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> > index f38e332c5..a3acc9e4c 100644
> > --- a/builtin/submodule--helper.c
> > +++ b/builtin/submodule--helper.c
> > @@ -270,6 +270,34 @@ static int module_list_compute(int argc, const char **argv,
> >  	return result;
> >  }
> >  
> > +static void module_list_active(struct module_list *list)
> > +{
> > +	int i;
> > +
> > +	if (read_cache() < 0)
> > +		die(_("index file corrupt"));
> > +
> > +	gitmodules_config();
> 
> To this codepath, it probably would not make any difference, but in
> general, calling gitmodules_config() after you did git_config()
> would be a bug, right?  Otherwise, gitmodules_config() would
> overwrite submodule.* configuration you read with git_config().

gitmodules_config() doesn't interact with the git config, unless you do
git_config(submodule_confi, NULL) to overlay the two.  But yes it
doesn't effect this codepath.

> I have a feeling that we need to make this function hard to misuse;
> it is not a fault of _this_ patch, but still any and all additions
> to any of the submodule*.c files needs careful vetting.

-- 
Brandon Williams
