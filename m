Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8FFB1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 18:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752582AbeDXS4r (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 14:56:47 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54778 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752518AbeDXS4n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 14:56:43 -0400
Received: by mail-wm0-f67.google.com with SMTP id f6so3059698wmc.4
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 11:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=3gUDQAVuBpbKDCB4PSclBwIWi+4WixYqE5WECu0fMBc=;
        b=YSny8CKBbp6YrtgmG+T4giQpcY5j5+GgvJOsSlzDJr7X55KXU+14jXHN16IOy36nJL
         8gwyJWjS1keQ5U/jIpGBz2Yv8/P7BWknFqHtpWsLeA2Tk9iod87cmhIb2W0WuoFyqQYT
         aCfW9LJxIdkv18UEMZM3qtf20thpL9e6zWWRgvsnxtZ5qL3rqGauovcHW+qkGZZN/+Ty
         6Gwz2VrdrVC/7dNWRffHY/+YK/PCZ7PemKfWEqUU7GMpbpl4fNQbHDOP+Ps/0XJAdkls
         MIF6Toj+E38BdjEn3GWkTyRwL0S2aU4Na/4GBNVOk/W0MrLUJ8P7ozz56OnKLSOWlsbD
         YJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=3gUDQAVuBpbKDCB4PSclBwIWi+4WixYqE5WECu0fMBc=;
        b=jGVBwhhqqqIa909vPhiTW4oBu8lV6Qp1WJL/OgkVGpmIYgjLng+GBmGvBS7U8tHhoS
         nPP99QV7P2GBh00ebednK+a3ArKJCCRZZTeKWAMl9Gl+y5M+Rvy8cDJeYe+jmggXBwL3
         PSvyEHICstlR6g9NoXDa7mWCaRWjuUeq7J7SqkSMi4YTt9IAbcZR0SMes1j39TRBo4ZA
         4tQjkP09mw8VJecENx48J5OuNNNuy2gRdS++8hEgYVNMZLpUBwIp/OIalWt7bZhK0xyL
         ceA0xnVcqCedbuoe7s5GLYT2+tzfpY1OXFqwrtcGOZBp8Cv78mEjepfyKMs5AUF+2O5I
         pU9Q==
X-Gm-Message-State: ALQs6tBILDJLxuIf5bRHxfdXSA1OOAIxuW9HoNHaYuqbXKgUFqzObYLV
        f97vvoLIsC9Gx4QJnL6VK2o=
X-Google-Smtp-Source: AIpwx4+h8ywSy14PdDx5FeFvqUgpOkyXRAhFZXtF27c1gUFLfbfvv0PAu6jphQ1GFl/jChoeN8bA1w==
X-Received: by 10.28.41.130 with SMTP id p124mr12492348wmp.127.1524596201556;
        Tue, 24 Apr 2018 11:56:41 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egc153.neoplus.adsl.tpnet.pl. [83.21.66.153])
        by smtp.gmail.com with ESMTPSA id z5-v6sm713187wrm.61.2018.04.24.11.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 11:56:40 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        "peff\@peff.net" <peff@peff.net>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "sbeller\@google.com" <sbeller@google.com>,
        "larsxschneider\@gmail.com" <larsxschneider@gmail.com>,
        "bmwill\@google.com" <bmwill@google.com>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "sunshine\@sunshineco.com" <sunshine@sunshineco.com>,
        "jonathantanmy\@google.com" <jonathantanmy@google.com>
Subject: Re: [PATCH v3 5/9] ref-filter: use generation number for --contains
References: <20180409164131.37312-1-dstolee@microsoft.com>
        <20180417170001.138464-1-dstolee@microsoft.com>
        <20180417170001.138464-6-dstolee@microsoft.com>
        <86r2ncgrcs.fsf@gmail.com>
        <48f910b6-8762-f34b-b644-d6c7ff99499f@gmail.com>
Date:   Tue, 24 Apr 2018 20:56:40 +0200
In-Reply-To: <48f910b6-8762-f34b-b644-d6c7ff99499f@gmail.com> (Derrick
        Stolee's message of "Mon, 23 Apr 2018 10:22:22 -0400")
Message-ID: <868t9cfn6f.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:
> On 4/18/2018 5:02 PM, Jakub Narebski wrote:
>> Derrick Stolee <dstolee@microsoft.com> writes:
>>
>>> A commit A can reach a commit B only if the generation number of A
>>> is larger than the generation number of B. This condition allows
>>> significantly short-circuiting commit-graph walks.
>>>
>>> Use generation number for 'git tag --contains' queries.
>>>
>>> On a copy of the Linux repository where HEAD is containd in v4.13
>>> but no earlier tag, the command 'git tag --contains HEAD' had the
>>> following peformance improvement:
>>>
>>> Before: 0.81s
>>> After:  0.04s
>>> Rel %:  -95%
>>
>> A question: what is the performance after if the "commit-graph" feature
>> is disabled, or there is no commit-graph file?  Is there performance
>> regression in this case, or is the difference negligible?
>
> Negligible, since we are adding a small number of integer comparisons
> and the main cost is in commit parsing. More on commit parsing in
> response to your comments below.

If it is proven to be always negligible, then its all right.  If it is
unlikely to be non-negligible, well, still O.K.  But I wonder if maybe
there is some situation where the cost of extra parsing is non-negligble.

[...]
>>>   @@ -1618,8 +1623,18 @@ static enum contains_result contains_tag_algo(=
struct commit *candidate,
>>>   					      struct contains_cache *cache)
>>>   {
>>>   	struct contains_stack contains_stack =3D { 0, 0, NULL };
>>> -	enum contains_result result =3D contains_test(candidate, want, cache);
>>> +	enum contains_result result;
>>> +	uint32_t cutoff =3D GENERATION_NUMBER_INFINITY;
>>> +	const struct commit_list *p;
>>> +
>>> +	for (p =3D want; p; p =3D p->next) {
>>> +		struct commit *c =3D p->item;
>>> +		parse_commit_or_die(c);
>>> +		if (c->generation < cutoff)
>>> +			cutoff =3D c->generation;
>>> +	}
>> Sholdn't the above be made conditional on the ability to get generation
>> numbers from the commit-graph file (feature is turned on and file
>> exists)?  Otherwise here after the change contains_tag_algo() now parses
>> each commit in 'want', which I think was not done previously.
>>
>> With commit-graph file parsing is [probably] cheap.  Without it, not
>> necessary.
>>
>> But I might be worrying about nothing.
>
> Not nothing. This parses the "wants" when we previously did not parse
> the wants. Further: this parsing happens before we do the simple check
> of comparing the OID of the candidate against the wants.
>
> The question is: are these parsed commits significant compared to the
> walk that will parse many more commits? It is certainly possible.
>
> One way to fix this is to call 'prepare_commit_graph()' directly and
> then test that 'commit_graph' is non-null before performing any
> parses. I'm not thrilled with how that couples the commit-graph
> implementation to this feature, but that may be necessary to avoid
> regressions in the non-commit-graph case.

Another possible solution (not sure if better or worse) would be to
change the signature of contains_tag_algo() function to take parameter
or flag that would decide whether to parse "wants".

Best,
--=20
Jakub Nar=C4=99bski
