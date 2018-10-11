Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BB9A1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 22:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeJLGKZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 02:10:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39584 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbeJLGKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 02:10:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id 61-v6so11382827wrb.6
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 15:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0+gkzfMN0XMZULrTH0Jlr2vq4bjN78SCnj88IHu4elQ=;
        b=qA5pgTru1V4fYv853PqQlWmVghUhtFFyFfWXH6H3urL3ErwMSc119tKUYkKCP0QOzI
         IVpHvpDTI5J0zDg8JLgPjtUdt8wwDeFUZjniRaek+iPr8NJFwPfLaGFK4kptD+WgKdUq
         QyU3B3+RWA13UAQp6tbfgyGbeMQ76wIJHIzepscHEZ3VBpgJNnyTnEBfrTKD71BAFNzT
         IfsRO0PUks41bjYRppUlyU2kYXQC9jIp4zPXXjzObhuM34h6wjdH6ZPeNUj6ZR+w7TjG
         C5cLNF1WR6LcocsVxCsCiPDSigNqNvo/g3bXPPp/TJa9+WDtirDyF20qavcunS2Qmqj0
         dVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0+gkzfMN0XMZULrTH0Jlr2vq4bjN78SCnj88IHu4elQ=;
        b=GxQTWR0sRm94AQaHLvoRnIkrUG62bM9Xx772z9mtJMocEDfAFsLAAwXnf+UVOpj8Wf
         +rWyT6eaqxHO8LmibeMrYr0m5XzhzXQGXZA8PO7NWHhKLFVcDsSo8+Oo+BxBPBkm1U7W
         XYBw3My7ZigoUhzjKI/nf+nhPpvnNbk6Dl39Pqu6TDS7Ij3C4OFPKA4XtoGt/ilnfRrJ
         9d4vtR0Fi39yjVv1/9EJsAb4mOtI7plZr/THJIZC8BVDL5CEnJ8kwFA4uJHWMVemRCmK
         m6pKFMIra6UiLVBR4Ij18jfnbFppioChWS1W0kvNRCAk7oJVgNu4iZVNoI+H5PlH1bQq
         jEwg==
X-Gm-Message-State: ABuFfojUdvpw/mV6MEpKM0O3zx4we9TwVKUDCCkd+I9m+Zm5CZcPvU5h
        HG5QsCr9iayeGlP3cZjJfxA=
X-Google-Smtp-Source: ACcGV60FCwBvtz2lmi9XjvUt7/YVirWUpkn/R5xlhmrfWwD057tb6kyb2yg61ea7YYBZ1E+kFWLR8Q==
X-Received: by 2002:adf:81e1:: with SMTP id 88-v6mr3556290wra.19.1539297661558;
        Thu, 11 Oct 2018 15:41:01 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c14-v6sm23656094wmh.44.2018.10.11.15.41.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 15:41:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: What's cooking in git.git (Oct 2018, #01; Wed, 10)
References: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
        <42930bb1-502b-b168-be12-92aee526a258@talktalk.net>
Date:   Fri, 12 Oct 2018 07:40:59 +0900
In-Reply-To: <42930bb1-502b-b168-be12-92aee526a258@talktalk.net> (Phillip
        Wood's message of "Wed, 10 Oct 2018 14:58:39 +0100")
Message-ID: <xmqqa7nkf6o4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> On 10/10/2018 06:43, Junio C Hamano wrote:
>> Here are the topics that have been cooking.  Commits prefixed with
>> '-' are only in 'pu' (proposed updates) while commits prefixed with
>> '+' are in 'next'.  The ones marked with '.' do not appear in any of
>> the integration branches, but I am still holding onto them.
>>
>> * pw/diff-color-moved-ws-fix (2018-10-04) 5 commits
>>   - diff --color-moved: fix a memory leak
>>   - diff --color-moved-ws: fix another memory leak
>>   - diff --color-moved-ws: fix a memory leak
>>   - diff --color-moved-ws: fix out of bounds string access
>>   - diff --color-moved-ws: fix double free crash
>>
>>   Various fixes to "diff --color-moved-ws".
>>
>>   What's the status of this topic?
>
> I think it is ready for next - Stefan was happy with the last iteration.

This is not about your fixes, but I was skimming the color-moved
support in general as a final sanity check to move this forward and
noticed that

	$ git diff --color-moved-ws=ignore-any master...

does not do anything interesting, which is broken at at least two
points.

 * There is no "ignore-any" supported by the feature---I think that
   the parser for the option should have noticed and barfed, but it
   did not.  It merely emitted a message to the standard output and
   let it scroll away with the huge diff before the reader noticed
   it.

 * After fixing ignore-any to one of the supported option
   (e.g. "ignore-all-spaces"), the color-moved feature still did not
   trigger.  I think the presence of --color-moved-ws by itself is a
   hint that the user wants --color-moved to be used.  If it turns
   out that there are some valid use cases where --color-moved-ws
   may have to be set but the color-moved feature should not be
   enabled, then

	diff --color-moved-ws=ignore-all-space --no-color-moved

   can be used to countermand this, of course.

Am I missing something or are these mere small sloppiness in the
current code?



