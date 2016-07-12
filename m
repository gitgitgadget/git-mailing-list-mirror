Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3032A2018E
	for <e@80x24.org>; Tue, 12 Jul 2016 09:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbcGLJaM (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 05:30:12 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38153 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbcGLJaK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2016 05:30:10 -0400
Received: by mail-wm0-f52.google.com with SMTP id o80so17438864wme.1
        for <git@vger.kernel.org>; Tue, 12 Jul 2016 02:30:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XrSEdLfINJJBQxMbPhkngMsWBXCYQEPFieTCcY83AZI=;
        b=ADVZ2kuJWxFa4rP2fHFCKXJcfd0KV/A0Y2s3hrmrtEItwBLMMlXYpCoYop5E1Yb4Ts
         P34NAo9SYILB0g7bwIPA61F0lICjgNBVdEa4De5aelAz/RM8GLoZ+CtxcixR0GQayy1r
         ZdPvzRdCUHEycW8NsiYaR4opgmshaj66FDxOLRkQi+JGW7yBkJOdO0KEdCrzkW5hm+HA
         6/6C+U7DYIG+q4fAxaWc2H+2oNwkjFpoTFLiRkkBhvEdJWXbCV8IffryXtplyCqQdKIy
         ktm+5HxtHjKxmVFyS6MZSZfGJa5s8US9Ay6OfdpAjQTla5VR0xcuGWzGZq+kGWMM2Cg7
         IZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XrSEdLfINJJBQxMbPhkngMsWBXCYQEPFieTCcY83AZI=;
        b=jbWBJrdffYPYHjJ+WznXnh5ujAneS4oVNZBy5vRYcwDajAOtwjzYV67ZftUvQaazrg
         lWxiw1oVmaWp9pMX2qI4u3sVpbos5jjUof3T+c7nkafGIrHJVoAtkaLPJQbA6+0VvXIA
         sCVaw/QedEyjADU9uKLFaar0V4Q/3OBu5DgdF+GrHEuB//6DflQ5xK34hZ58r6fMwm1v
         ZXp8nRTnl2eZOPQtjYkQFAPKJgYTWgrKXTv56X0UdX9mZjjrh7a1BGkQ8cFt24HnxDGZ
         Bh7wBV5fybpecw90EeHL5f6MwKjAO3vfdOdF+YxB5IoLzSMKzAo7cYzXcuiExY1nX31S
         j1Qw==
X-Gm-Message-State: ALyK8tJFgsLxTnVICE67ON/4lqFqA2qbfTIebU5v+jgrB8oWu1QakiPyNLkpXsK2FGkqVA==
X-Received: by 10.28.138.18 with SMTP id m18mr19580373wmd.63.1468315808758;
        Tue, 12 Jul 2016 02:30:08 -0700 (PDT)
Received: from [10.32.249.127] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id x83sm27482404wmx.9.2016.07.12.02.30.07
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jul 2016 02:30:08 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC] Long running Git clean/smudge filter
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160710151046.GA7306@kitenet.net>
Date:	Tue, 12 Jul 2016 11:30:06 +0200
Cc:	git@vger.kernel.org, joeyh@joeyh.name, pclouds@gmail.com,
	Johannes.Schindelin@gmx.de, gitster@pobox.com
Content-Transfer-Encoding: 8BIT
Message-Id: <4947BBA2-6260-4546-9641-E639A8C70174@gmail.com>
References: <1468150507-40928-1-git-send-email-larsxschneider@gmail.com> <20160710151046.GA7306@kitenet.net>
To:	Joey Hess <id@joeyh.name>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 10 Jul 2016, at 17:10, Joey Hess <id@joeyh.name> wrote:
> 
> larsxschneider@gmail.com wrote:
>> (2) Joey's topic, which is the base for my patch, looks stalled for more than
>> 2 weeks:
>> http://thread.gmane.org/gmane.comp.version-control.git/297994/focus=298006
>> I would be happy to address Junio's comments and post a reroll. However,
>> I don't want to interfere with Joey's plans.
> 
> I've been on vacation and plan to get back to that in the upcoming week.

Good to hear :-) ! I hope you had a great vacation!



>> @Joey (in case you are reading this):
>> My patch changes your initial idea quite a bit. However, I believe it is an
>> improvement that could be beneficial for git-annex, too. Would you prefer to
>> work with me on the combination of our ideas (file clean/smudge + long running
>> clean/smudge processes) or would you prefer to keep your interface?
> 
> Long running filters mean that you need a more complicated protocol to
> speak over the pipes. Seems that such a protocol could be designed to work
> with the original smudge/clean filters as well as with my
> smudgeToFile/cleanFromFile filters. Assuming that there's a way to
> tell whether the filters support being long-running or not.
> 
> Note that the interface we arrived at for smudgeToFile/cleanFromFile is as
> similar as possible to smudge/clean, so the filter developer only has to
> change one thing. That's a big plus, and so I don't like diverging the
> two interfaces.
I understand, thanks for the clarification. My plan is to implement long running 
filters only for smudgeToFile/cleanFromFile (at least initially) as this should
solve the major pain point already and is relatively straight forward.

What do you think about this kind of config? Any idea for a better config name?

[filter "bar"]
    clean = foo1 %f
    smudge = foo2 %f
    cleanFromFile foo3
    smudgeToFile foo4
    longRunning = true

I think it would be easy to support both of our interfaces in parallel. Do
you understand why the "async" API is necessary?
https://github.com/larsxschneider/git/blob/74e22bd4e0b505785fa8ffc2ef15721909635d1c/convert.c#L585-L599

Would you be OK if I implement smudgeToFile/cleanFromFile as separate
"apply_filter" function as I have prototyped here:
https://github.com/larsxschneider/git/blob/74e22bd4e0b505785fa8ffc2ef15721909635d1c/convert.c#L1143-L1146
https://github.com/larsxschneider/git/blob/74e22bd4e0b505785fa8ffc2ef15721909635d1c/convert.c#L402-L488


Thanks,
Lars
