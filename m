Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="1B1/JldY"
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855B8131
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 09:36:33 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-67a0d865738so6736176d6.1
        for <git@vger.kernel.org>; Thu, 30 Nov 2023 09:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701365792; x=1701970592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nMF/Md58TRPk41icfMUS2SH+RYLwqPJuy+Ep55h7G84=;
        b=1B1/JldY6767/K5ylNbtm1TOILUqTx6rlKqQQQdd2PEhKoGYy50dZF1kZK0t4CQKFX
         R+rMOi0yily51wtTIHzZnE1w60DayUOpAafQEvCZ+TLfCMN5eu02T+RKc0xu1IN5Rrvf
         74eDz8PVHB89Q3/6/VE8hAglGvIdUVwS09SYRcXqVY0EJJYMWLlSuQSIULBVL2mm9hhl
         y2JmplSpzysTeHSdIVhJbvL5ZbYVvFd6h3TQ7+R9xfWQM59E3TP6TUCjwwihnSTyIERp
         mk2HX+LSEQb8sXWmj9JKd/IJm697xOZIV9HtNmZoS6/y/daT17m4sfHqMzYSKBwP2hef
         0Tfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701365792; x=1701970592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMF/Md58TRPk41icfMUS2SH+RYLwqPJuy+Ep55h7G84=;
        b=uOKbvvLdP8hB0Ggpl7ajP9vZZv/AeLmNUmuNfmFNCXMSomXUYcF+ju083bnHKy/i5Y
         9rNlj8J2zYMBCN1Julxy7oWvdyrXTNqnMvIGeof4QVdRdI0VgaEm2iQPOV3jIwJNc7Tu
         jebrcxsdZgDkOyZjg0vlz+4DFRGtvI1snYhVxkeXFUEeiTv1IXDjdUedNfF7LLsFKUli
         Tr7ncvGisyrx5lnON36bjtKnVtxMFNKw2Lwkueai7commRFXkbNngQxAR7MC4ASWCHoZ
         y14S94XtpBWiMPxV0yW/G5cOB1fRXuxa77X74uLWbZaAEMVcfbeJh3M8wvMmcAWd0N+n
         LKAw==
X-Gm-Message-State: AOJu0YxQAXwgVLwHYa7z10cqH1E/27fK0dDgqKm1Agp1ZJs17MT73oeX
	Kh+C1Itd1vBNHG6lpt8/f9lgFQ==
X-Google-Smtp-Source: AGHT+IF+047KhwMlFuoBm/fe4jDvEtpnyEuT30BoEdg/wqBj+QYzcR8tZERgkCdAKuYTjiWMSwbrTA==
X-Received: by 2002:ad4:50a6:0:b0:67a:33fa:ebb3 with SMTP id d6-20020ad450a6000000b0067a33faebb3mr17441825qvq.58.1701365792675;
        Thu, 30 Nov 2023 09:36:32 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s5-20020a0cb305000000b0066d12d1351fsm675651qve.143.2023.11.30.09.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:36:32 -0800 (PST)
Date: Thu, 30 Nov 2023 12:36:31 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, hanwenn@gmail.com
Subject: Re: [PATCH 1/4] wt-status: read HEAD and ORIG_HEAD via the refdb
Message-ID: <ZWjIH9sj5cI8OBLq@nand.local>
References: <cover.1701243201.git.ps@pks.im>
 <35b74eb972eed7e08190e826fabcf6b7a241f285.1701243201.git.ps@pks.im>
 <ZWew3CP4QJ4XDnHj@nand.local>
 <ZWg8-HW6yCa6-tnS@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZWg8-HW6yCa6-tnS@tanuki>

On Thu, Nov 30, 2023 at 08:42:48AM +0100, Patrick Steinhardt wrote:
> > Are there any other gotchas that we should be thinking about?
>
> Not that I can think of. As you say, a repository with malformed HEAD
> will run into other problems anyway. And `read_ref_full()` would return
> errors if these refs were malformed, which would cause us to exit early
> from anyway. So unless "rebase-merge/amend" and "rebase-merge/orig-head"
> contained the same kind of garbage we'd retain the same behaviour as
> before, and that shouldn't really be happening.
>
> One interesting bit is that we don't set `RESOLVE_REF_READING`, so
> `read_ref_full()` may return successfully even if the ref doesn't exist.
> But in practice this is fine given that the resulting oid would be
> cleared in that case.

Thanks for thinking through these. I agree with your reasoning and think
that this is fine as-is.

(Off-topic, but can you please trim your replies to only include the
quoted parts/context that you're replying to?)

Thanks,
Taylor
