Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E5C10A17
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 10:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msLBVyli"
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D2BBE
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 03:06:58 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40566f89f6eso22890225e9.3
        for <git@vger.kernel.org>; Fri, 13 Oct 2023 03:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697191617; x=1697796417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vxR8iDkKOKK/cCPWppOI84l0BqSGza2H3SjcMsECSs0=;
        b=msLBVylivqTutSI3GHpqQ1GtjoM+AdTNvejxUqWksx1Tdng0DnKwiEBGZfSJ08L8yK
         zmzmEIsC2bJ/Ys6oBIez9X4JL0SAXEPJj/NbrmRiTFeGIXmAZ64A9wQz3j/08XaNJaD6
         KNv8DVKAjmxpYRufCqpBEYvmROs8TR1XJjoZWqTkFX5+x+bNCzge+tVpw9LtW/9IjbOU
         85Vh7Dm54Oh9AX8+Vl1+tny0XGmdxM5izOOrZ25pQcLDNXRnDCn1/SMEOygJPIC+l+Zw
         Vx5V1nDE98iCEzfvaNkklAWk3G5Zas6ibt1xbLjqj5ujrAlWZNNaHyodravc1TIUiYYk
         16pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697191617; x=1697796417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vxR8iDkKOKK/cCPWppOI84l0BqSGza2H3SjcMsECSs0=;
        b=rmVc6rcvr0StfQw3iYBL6XijIo+U7wY9TjcArRxxJnrLFRZZlzDiTHZOCOQoOo++Bc
         WdV6rF6xTQG/6cbNctBo9XVHUJ1JsjZsokea2rX/pFV+VSMWaLMVKe/c6GKhu7xhkDuA
         hiHt8iGb1vrYVRNV1N24FPJW1M4vvvHj2gQkM3oWrY2l904C5Hk//3mSjprLBz9Ta8mz
         D2ctEMqdhML9d482pRvO7thJKPki4EKBmb4jO4YOa3L4pJY2HUM/XgYU8a6silTikvfU
         6wEeCrbOimOYhkcgv5lm5l0DQ7wRWpqBVSlVQLb60ZCrujtOatvA3cga15tzHXQEKhyb
         bwvQ==
X-Gm-Message-State: AOJu0Yz7HTn74CibY0nYoRJKC3BNeFM+eKALOLfMLa/eHadOzpXcZoql
	uqxtk8aMC0eAMS4Zk93KKFg=
X-Google-Smtp-Source: AGHT+IG4o7nUhRoRGdmDc+E4HCGNWK2+xd7iBJNcvsnoygvNCNHhoY2RETRKPDzo8Yg1tBECUKX0sg==
X-Received: by 2002:a05:600c:3657:b0:401:b0f2:88c1 with SMTP id y23-20020a05600c365700b00401b0f288c1mr23738818wmq.29.1697191616941;
        Fri, 13 Oct 2023 03:06:56 -0700 (PDT)
Received: from [192.168.1.12] (host-2-102-115-95.as13285.net. [2.102.115.95])
        by smtp.gmail.com with ESMTPSA id p16-20020a1c7410000000b0040586360a36sm2082697wmc.17.2023.10.13.03.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 03:06:56 -0700 (PDT)
Message-ID: <0deee2bc-1775-4459-906d-1d44b3103499@gmail.com>
Date: Fri, 13 Oct 2023 11:06:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC] Define "precious" attribute and support it in `git clean`
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 Sebastian Thiel <sebastian.thiel@icloud.com>
Cc: git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>
References: <79901E6C-9839-4AB2-9360-9EBCA1AAE549@icloud.com>
 <xmqqttqytnqb.fsf@gitster.g>
 <0E44CB2C-57F2-4075-95BE-60FBFDD3CEE2@icloud.com>
 <xmqqttqvg4lw.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqttqvg4lw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 12/10/2023 17:58, Junio C Hamano wrote:
> Sebastian Thiel <sebastian.thiel@icloud.com> writes:

Sebastian - thanks for raising this again, it would be really good to 
get a solution for handling "ignored but not expendable" files

> I have been regretting that I did not make the quoting syntax not
> obviously extensible in f87f9497 (git-ls-files: --exclude mechanism
> updates., 2005-07-24), which technically was a breaking change (as a
> relative pathname that began with '!' were not special, but after
> the change, it became necessary to '\'-quote it).  A relative
> pathname that begins with '$' would be now broken the same way, but
> hopefully the fallout would be minor.  I presume you picked '$'
> exactly because of this reason?
> 
> I do not think it will be the end of the world if we don't do so,
> but it would be really really nice if we at least explored a way (or
> two) to make a big enough hole in the syntax to not just add
> "precious", but leave room to later add other traits, without having
> to worry about breaking the backward compatibility again.  A
> simplest and suboptimal way may be to declare that a path that
> begins with '$' now needs '\'-quoting (just like your proposal),
> reserve '$$' as the precious prefix, and '$' followed by any other
> byte reserved for future use, but there may be better ideas.

One thought I had was that we could abuse the comment syntax to annotate 
paths something like

#(keep)
/my-precious-file

would prevent /my-precious-file from being deleted by git clean (and 
hopefully unpack-trees()[1]). It means that older versions of git would 
treat the file as ignored. If we ever want more than one annotation per 
path we could separate them with commas

#(keep,something-else)
/my-file

Strictly speaking it is a backward incompatible change but I doubt there 
are many people using comments like that. I also wondered about some 
kind of suffix on the file

/my-precious-file #(keep)

but that means that older versions of git would not ignore the file.

Best Wishes

Phillip

[1] Of the cases listed in [2] it is "git checkout" and friends 
overwriting ignored files that I worry about more. At least "git clean" 
defaults to a dry-run and has in interactive mode to select what gets 
deleted.

[2] https://lore.kernel.org/git/xmqqttqytnqb.fsf@gitster.g

