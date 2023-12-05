Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Xu5esnEa"
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02B21A4
	for <git@vger.kernel.org>; Tue,  5 Dec 2023 11:26:20 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-58d54612d9cso3970734eaf.1
        for <git@vger.kernel.org>; Tue, 05 Dec 2023 11:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701804380; x=1702409180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wXR1WxesSwmwZpuXzWq1EHNnpF6gmcvEMig3/rE/6hc=;
        b=Xu5esnEaClDo9+mQh+GBL7fDIM758TqBfqZtaUowhkNPXRwygNfJFY1bS5p+la9Kxx
         ShIT5HhVsVVjbay8mMwEnWmJNcydli1YDLvWx0TTVOUVKuce01pTgz2/gAByvh9h54nO
         XWw9+CBHTOjty2/xzq3CL1+iEi4DTOTFtcWwJK1GRFErEwjH5/+gZqpTXRE8giToQnMq
         VTdL9VGpIB+1YBmzfmAjE0ObpfBYpPkhqTPDP+SVBam9tlEHot2wGE4UIL3LJGqM2JCn
         2V1ABqFrCi/aa/qfpgwZSqFqMg2ESyEnzjRj71PneJbfQ8zKZd1xnKWDbk+DOZGwbFzy
         0W0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701804380; x=1702409180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXR1WxesSwmwZpuXzWq1EHNnpF6gmcvEMig3/rE/6hc=;
        b=J56d+oB0Q/wkr6CKSjJ6EQw2WFK6Hkr6FMEeOg/04QmMJQN6gBhSB24mbU7guokm7+
         tkOC/WVwfXRD8frigj7/UhcKQDokCJypy/t2s4IYJ0WkzqqHOqgtslf+37cdz+KrszWf
         gTXK0I1Tix3gSTSHnqrvqTKNS/BnLgIAqYwg0361puNFf78Ha0nWBXkvBegTIyL8z0f/
         Q39pIDOeuI3Snv6fOE/rSzarChv4PJFFbOZAg5OlxQPxXQkEn0o6pYVIL9vCp9f1zgQT
         +skjRpmhryCMMfmpsQUGO2vV2fQ50eJHMmV8g7bHexhGMFxiX+jLj/psUu/flMeZdb9c
         hzTg==
X-Gm-Message-State: AOJu0Yy2qERRRZ0quVtHSd2772jY4iPssfKDTIJBteb49i/iHymCxEbm
	+pg2sUNsGn+9dYzDsl7kpCR/5LELu3ByMu8AsNY=
X-Google-Smtp-Source: AGHT+IGFa4jEAMi1JYXsMVPmkkF2rbW+Yi1t7jvaQA12KdFFdRQ0XShKlUVBvnAl5nPc9SQPEHLZ2A==
X-Received: by 2002:a05:6358:60c1:b0:170:697:a3c3 with SMTP id i1-20020a05635860c100b001700697a3c3mr5819207rwi.9.1701804380115;
        Tue, 05 Dec 2023 11:26:20 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w2-20020a0c9c42000000b0067a4a0a7e6fsm2149667qve.108.2023.12.05.11.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 11:26:19 -0800 (PST)
Date: Tue, 5 Dec 2023 14:26:17 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 05/24] midx: implement `DISP` chunk
Message-ID: <ZW95WSErCXvkfrAG@nand.local>
References: <cover.1701198172.git.me@ttaylorr.com>
 <c52d7e7b27a9add4f58b8334db4fe4498af1c90f.1701198172.git.me@ttaylorr.com>
 <xmqqjzpv4ecg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjzpv4ecg.fsf@gitster.g>

On Sun, Dec 03, 2023 at 10:15:11PM +0900, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
> > index 3696506eb3..d130e65b28 100644
> > --- a/Documentation/git-multi-pack-index.txt
> > +++ b/Documentation/git-multi-pack-index.txt
> > @@ -49,6 +49,10 @@ write::
> >  	--stdin-packs::
> >  		Write a multi-pack index containing only the set of
> >  		line-delimited pack index basenames provided over stdin.
> > +		Lines beginning with a '+' character (followed by the
> > +		pack index basename as before) have their pack marked as
> > +		"disjoint". See the "`DISP` chunk and disjoint packs"
> > +		section in linkgit:gitformat-pack[5] for more.
>
> Makes one wonder who computes the set of packfiles, decides to
> prefix '+' to which ones, and how it does so, none of which appear
> in this step (which is understandable).  As the flow of information
> is from the producer of individual "disjoint" packs (not in this
> step) to this new logic in "--stdin-packs" to the new "DISP" chunk
> writer (the primary focus of this step) to the final consumer of
> "DISP" chunk (not in this step), we are digging from the middle
> (hopefully to both directions in other steps).  It is probably the
> easiest way to explain the idea to start from the primary data
> structures and "DISP" seems to be a good place to start.

Thanks. I found that laying out this series was rather tricky, since all
of the individual pieces really depend on the end state in order to make
any sense.

Hopefully you're satisfied with the way things are split up and
organized currently, but if you have suggestions on other ways I could
slice or dice this, please let me know.

> > +	    Two packs are "disjoint" with respect to one another when they have
> > +	    disjoint sets of objects.
> > + In other words, any object found in a pack
> > +	    contained in the set of disjoint packfiles is guaranteed to be
> > +	    uniquely located among those packs.
>
> I often advise people to rethink what they wrote _before_ "In other
> words", because the use of that phrase is a sign that the author
> considers the statement is hard to grok and needs rephrasing, in
> which case, the rephrased version may be a better way to explain the
> concept being presented without the harder-to-grok version.
>
> But I do not think this one is a good example to apply the advice.
> It is because "In other words," is somewhat misused in the sentence.
> Two "disjoint" packs do not store any common object (which is how
> you defined the adjective "disjoint" in the first sentence).  "As a
> consequence"/"Hence", an object found in one pack among many
> "disjoint" packs will not appear in others.

Thanks, I'll replace this with "As a consequence", and try to follow
that general advice more often in the future ;-).

> OK, so it seems they really need to be strictly disjoint in order to
> participate in the reuse of the existing packdata.

I think that's generally true, though there are some exceptions.

I think the real condition here is that the *reused sections* must be
disjoint with respect to one another, not necessarily the packs
themselves. So having the packs be disjoint is a sufficient condition,
since we know that no matter which section(s) we reuse, they are
guaranteed to be disjoint.

I think that there is opportunity to be more clever here, e.g., by
allowing for different disjoint "groups" of packs, or mandating that you
can only reuse certain sections from different combinations of packs in
order to satisfy this property.

That's part of the reason why I left more space than is needed for the
"disjoint" state in the DISP chunk (it is 32 bits, of which we're only
using one of them). I'm not sure that we would want more relaxed
constraints here, since they'd be harder to satisfy. But my hope is that
we would be able to learn from running this in production to figure out
whether or not such a thing would be useful.

> > +  - All objects stored as offset- or reference-deltas also include their
> > +    base object in the resulting pack.
>
> Are thin packs obsolete?

No, I think I should clarify this to make it more obvious that this only
applies to non-thin packs.

> > +		find $objdir/pack -type f -name "*.idx" | xargs -n 1 basename | sort >packs &&
>
> That is an overly-long line.

Thanks for spotting.

> > +test_expect_success 'non-disjoint packs are detected' '
> > +	test_when_finished "rm -fr repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +
> > +		test_commit base &&
> > +		git repack -d &&
> > +		test_commit other &&
> > +		git repack -a &&
> > +
> > +		ls -la .git/objects/pack/ &&
>
> Is this line a leftover debugging aid?

Indeed, thanks.

> > +		find $objdir/pack -type f -name "*.idx" |
> > +			sed -e "s/.*\/\(.*\)$/+\1/g" >in &&
>
> Lose "g"; it adds unnecessary cognitive burden to the readers if the
> patterh is expected to match multiple times, and you know that is
> not possible (your pattern is right anchored at the end).  This may
> apply equally to other uses of "sed" in this patch.

Thanks, I dropped the 'g' in both instances.

Thanks,
Taylor
