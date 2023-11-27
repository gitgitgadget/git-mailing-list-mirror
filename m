Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P85abbcP"
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370E4AA
	for <git@vger.kernel.org>; Mon, 27 Nov 2023 11:42:50 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6cd8ce7bf7fso1327316b3a.0
        for <git@vger.kernel.org>; Mon, 27 Nov 2023 11:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701114170; x=1701718970; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pAXySqyC5MXVMR2eIkMSO1xraE99/6Pc4Anlg3hIxZE=;
        b=P85abbcPMQ3Hghi32g6KTsoAXoCKF8i5M8faj9aJgLoN3MgvL89lLK6N0ugwYELDpX
         u2ckasEQOIiBtgMGpH4ogIVZ+ZYqp3Jm5ERUUoAy6ZHDHVEIRaYrpAgKKVmvUBCGOcb6
         5Cs+gY+fmQxmh1tlxs0V7g8/Ps9TOdVUK5ycX5U642armSw0tVIcpu7jNLwHUJY7Ngdt
         o6pwYkFgAny6V0UMBdVl6oZS3iaBNPl1J/d65lsj7Aj3RnHns89N2Y5NI7InQlY1dLxM
         NncVRacBvKiVKPBCOcqKCiYC+gudUC+I1yowSBFBz2Itkog9faZyqU7u5M6pemd7k1xn
         41eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701114170; x=1701718970;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pAXySqyC5MXVMR2eIkMSO1xraE99/6Pc4Anlg3hIxZE=;
        b=uCAJQWw5LcB8CY+P9mD6NshkUCU0/rwHq3GTCZ2n7nn9mqW5tHcAt2HWWn77lzXBoB
         8t8BBy+ifhUtGt3KvmKPbBwVCqV2DDvmAVoefEOpie7f5W7iVl8sEy1ihivR3mlEplB6
         cD4O3FW59cBwredVE3SETArrKS17mM9LRpghl+th/uX2OFH4A+JwBD3/HjoYVFYS2ViF
         /64/dPJRALccOtAunJUxlcUodGLJZaWZ7vi5QkAqQbrHKy+CSdTjyIszlzG6+nAC+di9
         a7lU5+D+yY9u+ITXL7Nv9sA9zYvUyDsott/Im9C7e/JVELPrwX47++RG8185PekGD8DO
         +mCA==
X-Gm-Message-State: AOJu0YwIZyRzbkAzMKDKL22IKCGG6gf6Q45a/qicJ5njIF0T0vY71pXQ
	Kr6K8M7qvbQEUZ/Z9x9gSTf4kZ4B4k8mBDQf1zEZFw==
X-Google-Smtp-Source: AGHT+IGnFbrjY/k2VHcjb88i9sDDgFFCVdi53yubweynVIv6nLDYxv1WIkySDgmatRGveMCAbleQWg==
X-Received: by 2002:a05:6a20:3941:b0:18b:8d6c:d63 with SMTP id r1-20020a056a20394100b0018b8d6c0d63mr12398620pzg.7.1701114169589;
        Mon, 27 Nov 2023 11:42:49 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:d2e9:e3fe:4455:513f])
        by smtp.gmail.com with ESMTPSA id f35-20020a631023000000b005ac384b71cbsm7848034pgl.60.2023.11.27.11.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 11:42:49 -0800 (PST)
Date: Mon, 27 Nov 2023 11:42:44 -0800
From: Josh Steadmon <steadmon@google.com>
To: Glen Choo <glencbz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Adam Majer <adamm@zombino.com>
Subject: Re: [PATCH] setup: recognize bare repositories with packed-refs
Message-ID: <ZWTxNBcF1wLufJPj@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Glen Choo <glencbz@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Adam Majer <adamm@zombino.com>
References: <20231117202513.20604-1-adamm@zombino.com>
 <20231117203253.21143-1-adamm@zombino.com>
 <xmqqbkbppbrd.fsf@gitster.g>
 <CA+we5Gqp2nhoXyqJKJiXQMDx-ZXcnNGHu3wnwERWREng2XHHuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+we5Gqp2nhoXyqJKJiXQMDx-ZXcnNGHu3wnwERWREng2XHHuQ@mail.gmail.com>

On 2023.11.20 17:31, Glen Choo wrote:
> On Mon, Nov 20, 2023 at 7:24 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Adam Majer <adamm@zombino.com> writes:
> >
> > > In a garbage collected bare git repository, the refs/ subdirectory is
> > > empty.  In use-cases when such a repository is directly added into
> > > another repository, it no longer is detected as valid.
> >
> > Josh & Glen [*], isn't this a layout that we  explicitly discourage and
> > eventually plan to forbid anyway?
> 
> If my recollection of [1] serves me correctly, we didn't come to a
> strong conclusion on whether or not to forbid bare repositories in the
> working tree, particularly because it would leave existing repos (like
> Git LFS) high and dry. Though personally, I'd be happy to see a
> version of Git that forbade bare repositories in the working tree.
> 
> I don't really recall the bare repo tracing bits, so I'll leave that to Josh.
> 
> [1] https://lore.kernel.org/git/kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com/

Yeah, my understanding was that we don't want to forbid bare
repositories outright, which is why we have the config option to let
end-users choose what to do with them.
