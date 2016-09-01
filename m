Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4CA41F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 23:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751583AbcIAXWB (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 19:22:01 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32913 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751225AbcIAXWA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 19:22:00 -0400
Received: by mail-wm0-f65.google.com with SMTP id w207so611856wmw.0
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 16:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=V22riKXBJdBaE0pM+tXyyxwRdPbmhrlYQvYQadBMVTU=;
        b=yEg4TWJG3Z0yA7hUNkGNibk0gDXOy64ELjG575bTTXqnXb8mbcMuSbXmRrPcHyFRiS
         U6b1NMK7z4djy+4tnyk1qxoqlvCas2kFXMFjvxqujYf00UTg7Z5fPphAnxkZHcVyNsJB
         HyOZ0St2x8LSTteCE1ohCn3dUDB9xHL+Q5EmQKudq+MS04DF1H9l4ZA1LPG6xKOx32pr
         k2NdMZ1HndJolohS/EdaX0D6KltxjuJSKAH2T9mPGUiTvG1fEuQngtnZyMNwGn1dF4W9
         drR8ln/HAoF/hnzsNPsOoqpb5sCDobSBIybzGS3QafuyS5b6WBudMsNeHhOWJhb8l9MT
         HOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=V22riKXBJdBaE0pM+tXyyxwRdPbmhrlYQvYQadBMVTU=;
        b=F0l8z3vIuIoLYf3Pk1YF0/0DUS3MhuzE1YZvh83Mp1yjL4gpB598N9qUZr2Il4xRjr
         kLDmak1Wjsx5F/UXaI/i8INQWZ88c7kJto84aP3uMFd/+bOuDq3s+EgnbgLg+yemLCdK
         vfTRtfGwyEBfO24qJhoG8/xNKi6Iv5Qw9JsAJsCAjU0q7tggheFwTu+5tISQ0yAsTcOp
         BZzVGqcc3nkTN1qZ8ZXNtaYe+m1SUouiBiCEaM/y9uQ3dj/3fwneJ3ZJdXUNZfOOEk2g
         CbiDNXmIu4MV5bjI10Lv24CnC26/iYlCH7RPuDNpVVPOZUSAcQ/HKzHEENGuo6OlSMqX
         nRvg==
X-Gm-Message-State: AE9vXwN0N/TwodOc/GJ44lu2Rxgrb3YqHzFFxTBZdx2LreUkpJ3mnyPrrWEVXLwBaylDNQ==
X-Received: by 10.194.87.34 with SMTP id u2mr18456109wjz.118.1472772118910;
        Thu, 01 Sep 2016 16:21:58 -0700 (PDT)
Received: from [192.168.1.26] (abrf30.neoplus.adsl.tpnet.pl. [83.8.99.30])
        by smtp.googlemail.com with ESMTPSA id x203sm686817wmg.0.2016.09.01.16.21.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2016 16:21:57 -0700 (PDT)
Subject: Re: [PATCH 16/22] sequencer: prepare for rebase -i's GPG settings
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <c6a37af958f59390c00429a5b38b34d34c9a5b95.1472457609.git.johannes.schindelin@gmx.de>
 <104de15c-77e8-9474-9579-4934ca8a4323@gmail.com>
 <alpine.DEB.2.20.1609011516080.129229@virtualbox>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <528839ae-a0dc-e40f-a9a5-e1f25e8b3cc4@gmail.com>
Date:   Fri, 2 Sep 2016 01:21:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1609011516080.129229@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes,

W dniu 01.09.2016 o 15:33, Johannes Schindelin pisze:
> On Wed, 31 Aug 2016, Jakub Narębski wrote:
>> W dniu 29.08.2016 o 10:06, Johannes Schindelin pisze:

>>> @@ -471,17 +487,20 @@ int sequencer_commit(const char *defmsg, struct replay_opts *opts,
>>>  
>>>  	if (IS_REBASE_I()) {
>>>  		env = read_author_script();
>>> -		if (!env)
>>> +		if (!env) {
>>> +			const char *gpg_opt = gpg_sign_opt_quoted(opts);
>>> +
>>>  			return error("You have staged changes in your working "
>>>  				"tree. If these changes are meant to be\n"
>>>  				"squashed into the previous commit, run:\n\n"
>>> -				"  git commit --amend $gpg_sign_opt_quoted\n\n"
>>
>> How did this get expanded by error(), and why we want to replace
>> it if it works?

After writing this email, I got an idea on how it could work:
git-rebase script calls some C helper, which outputs above, and
output of this helper is eval'ed by script (with gpg_sign_opt_quoted
variable present in the environment)...

> 
> It did not work. It was a place-holder waiting for this patch ;-)
> 

... but it might have been simply copy'n'pasted from shell script
to C, literally.

>>
>>> +				"  git commit --amend %s\n\n"
>>>  				"If they are meant to go into a new commit, "
>>>  				"run:\n\n"
>>> -				"  git commit $gpg_sign_opt_quoted\n\n"
>>> +				"  git commit %s\n\n"
>>>  				"In both case, once you're done, continue "
>>>  				"with:\n\n"
>>> -				"  git rebase --continue\n");
>>> +				"  git rebase --continue\n", gpg_opt, gpg_opt);
>>
>> Instead of passing option twice, why not make use of %1$s (arg reordering),
>> that is
>>
>>   +				"  git commit --amend %1$s\n\n"
>> [...]
>>   +				"  git commit %1$s\n\n"
> 
> Cute. But would this not drive the l10ners insane?
> 

Shouldn't, as l10ners need to deal with arg reordering, because in different
languages the order of words might be different: %s %s in English may be
%2$s %1$s in other language, see example in
  https://www.gnu.org/software/gettext/manual/gettext.html#c_002dformat-Flag

Best,
-- 
Jakub Narębski
