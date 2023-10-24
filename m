Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F9833D0
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCp/FhKO"
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86C41721
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 02:26:31 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4083cd3917eso33912145e9.3
        for <git@vger.kernel.org>; Tue, 24 Oct 2023 02:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698139590; x=1698744390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kpAb+TV8bpLbmxf5zVYzbZRWOr6CfwfZ+wibPxzvZC4=;
        b=KCp/FhKOJc+x8Awm/qs252M+ul40N2rZigtNbDQXwmP/dyqw7rESMLclDcaWKKMqk8
         OVF+JsqeeZHSpsyr6rZjGQcqd8/q4qSwbdczdNRZcROD5WQ3uSWLC7ajrh2t30GH73ap
         SMSLi/aUIcluT0hwkYB9yp8hA6Mn9qk4zFvtZv0iXYIwn4Z4C1bY/b8lf3vibEqk8VG7
         /VvhNtFDsF5TTCD/1W0m57TkwWKiW3oC89RUlaMLbq/IMZRR69v6Kwo6+v7f9YIhXPXf
         qH8GCIXVP61GXFf9K94CvsJjQ0t5nl8sCaEazWb8oFCqMWTeYT2Z38WEDf71efhzmP8o
         IY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698139590; x=1698744390;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kpAb+TV8bpLbmxf5zVYzbZRWOr6CfwfZ+wibPxzvZC4=;
        b=WnBITdh/EvwUxZjaC3OMEP+YZ4xV89t+034/3JaqSB9gF7PSs89SiT5+QsPpVCSFfs
         eQ5oWG81cTsIpWyWAuHObwdkClwYZJN9qEczd4AC1PkEOLEcWHllUe6uwtkM8eIfO7ee
         0sRbtoeIiT+YR2BQOqVsBShsqF2y8ahdsZo7sC89UWtHy1dtXztZ0VYJqw7KLlJGH15+
         E7VJriysHJ93O9ExLNI0vW09mk4qmG4wy2DcJk7VyOfCaj3JlKHrGiIL+d8iuOlXwy/4
         03t64qs7Z5ddKKPGF5SuhvjOjyyVdLM+whoj3257tGkn3JGMBKzzXoYDCKYbN+/n2oST
         8kkA==
X-Gm-Message-State: AOJu0Yxusbpit2yHN1j+0WvuEyZwucPism5IHbcG6pn33BEMWhLAc3nL
	rPi71AAf75FXkv4aQCL6R/q6RvDDAoE=
X-Google-Smtp-Source: AGHT+IEHsd7tzVinqepZD5rlfL7tvzTMgxIus7J4j8VMxN82QWJHZj04lVsrXjkD8pC28Kt0eyk29Q==
X-Received: by 2002:a05:600c:4747:b0:405:359a:c950 with SMTP id w7-20020a05600c474700b00405359ac950mr9072551wmo.19.1698139589927;
        Tue, 24 Oct 2023 02:26:29 -0700 (PDT)
Received: from [192.168.1.12] (host-2-102-115-95.as13285.net. [2.102.115.95])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c310e00b0040813e14b49sm16305442wmo.30.2023.10.24.02.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 02:26:29 -0700 (PDT)
Message-ID: <a99b16a8-a06c-4d38-bb78-46ce17411597@gmail.com>
Date: Tue, 24 Oct 2023 10:26:29 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: using oldest date when squashing commits
Content-Language: en-US
To: Johannes Sixt <j6t@kdbg.org>,
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: git@vger.kernel.org
References: <YjXRM5HiRizZ035p@ugly>
 <9fae5292-d58f-95da-245b-6e205383cb50@kdbg.org>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <9fae5292-d58f-95da-245b-6e205383cb50@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/03/2022 08:05, Johannes Sixt wrote:
> Am 19.03.22 um 13:48 schrieb Oswald Buddenhagen:
>> during interactive rebasing, i sometimes find it necessary to move a
>> hunk from one commit to a later one in the branch. now, if that hunk
>> cannot be re-ordered with the later commit due to conflicting with it,
>> it becomes necessary to squash the later commit onto a temporary commit
>> created from the extracted hunk, not the other way around (or using a
>> stash). unfortunately, this causes the author date of the later commit
>> to be reset, which can rather seriously falsify the date if the branch
>> is long-lived.
> 
> You want `fixup -C` in the todo-list. See the hints near the end of the
> todo-list.

Unfortunately "fixup -C" only copies the commit message not the 
authorship (that's usually a good thing but not it means it wont work 
for what Oswald wants to do). Maybe we should add another flag for 
fixup/squash commands to take the authorship from that commit. In the 
meantime creating the temporary commit with "git commit -C" is probably 
the easiest way to keep the original authorship.

Best Wishes

Phillip
