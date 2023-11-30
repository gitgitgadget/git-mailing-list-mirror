Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="R4LepSzC"
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D2ED40
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 11:29:55 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-423c28db22eso20218831cf.1
        for <git@vger.kernel.org>; Thu, 30 Nov 2023 11:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701372594; x=1701977394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EYA3YOToX17fxExUhQ4IK/EQF+H4lmHO1Qhq/hGUFT4=;
        b=R4LepSzCuUr0oD6Iue27anM2c1uVrcrvImxHsBohjazBN6GxtC/bhvsXH/nxA1h932
         VtAMitldLq90FslOGw4MjcqxDQ2EWU0iqu+mSS8e4nDfMGb42lbEQQG1wLhnHnkeXuEV
         aWSYSFDPKPtT9KR6xHGT83hqptdaq+qRLgerHq6AaZGA1OMlLjwaZ+00ZkPVLnwaCnuA
         CzNIs1NEZBNzhfvhsc7vRH7KFGwBHetDjTUSzeZKNckgeH1fJ054g/L7YC2FF1tvOhSD
         I4ccDeHsfeCOdZD0wsPiQ3gdePYhFRg3biSsw6RKsnMHW96Vuye55811c2YRuWy3nZti
         Fo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701372594; x=1701977394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYA3YOToX17fxExUhQ4IK/EQF+H4lmHO1Qhq/hGUFT4=;
        b=tLYfsAujHb2PFgcUahYyvL3yN6zxrh+osh6HFWABOvV1u53o3LdVXN2gl1ldsPu6ur
         0zvuIynIGSrHfTsNU/0dXHqhSra6BQKwPG7ew6fnY7Q0lxljvSMNccB6GmciEYNGZtU3
         BXMLRgvvea/4RQ+qmSg9i2xevTfOk6dvhY64EmHT/Qo68978E9hT/bGA7ibeXjb4xB4I
         hgvRiJ0VTilJoC4AqizVgk/VPnyw+N/lB5Hq4a0eDSbVkbUTnJVFyEm0dQvpZFH+7vfS
         BJCgcj1KtgEQ/Ed8HTssgSTCWg6N+lN7Xu18TR+pdH2MJr4yasHjo4N3105AOivQdXRQ
         Gu9Q==
X-Gm-Message-State: AOJu0YwswT+hGQkmlMrB8qjwgBG6ChbU7SZoFUQAkKZQNs7niVuQAo4F
	Q3ZqcNAbm3A89rgjIxYv+eWzhQ==
X-Google-Smtp-Source: AGHT+IFgEYdTWGPrZREXFdTRo8wOc7DXbVtSoY/doG2gglJwS5r/k2WSMhZ3il2rlNoJ6zi86rpzjw==
X-Received: by 2002:a05:622a:54e:b0:412:3d25:9019 with SMTP id m14-20020a05622a054e00b004123d259019mr33473350qtx.6.1701372594225;
        Thu, 30 Nov 2023 11:29:54 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id br5-20020a05622a1e0500b004240481cee0sm50159qtb.58.2023.11.30.11.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 11:29:53 -0800 (PST)
Date: Thu, 30 Nov 2023 14:29:52 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/24] midx: implement `--retain-disjoint` mode
Message-ID: <ZWjisIgiuziMvBph@nand.local>
References: <cover.1701198172.git.me@ttaylorr.com>
 <3019738b52ba8cd78ea696a3b800fa91e722eb66.1701198172.git.me@ttaylorr.com>
 <ZWhhi15VpeCRflDB@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZWhhi15VpeCRflDB@tanuki>

On Thu, Nov 30, 2023 at 11:18:51AM +0100, Patrick Steinhardt wrote:
> > diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
> > index d130e65b28..ac0c7b124b 100644
> > --- a/Documentation/git-multi-pack-index.txt
> > +++ b/Documentation/git-multi-pack-index.txt
> > @@ -54,6 +54,14 @@ write::
> >  		"disjoint". See the "`DISP` chunk and disjoint packs"
> >  		section in linkgit:gitformat-pack[5] for more.
> >
> > +	--retain-disjoint::
> > +		When writing a multi-pack index with a reachability
> > +		bitmap, keep any packs marked as disjoint in the
> > +		existing MIDX (if any) as such in the new MIDX. Existing
> > +		disjoint packs which are removed (e.g., not listed via
> > +		`--stdin-packs`) are ignored. This option works in
> > +		addition to the '+' marker for `--stdin-packs`.
>
> I'm trying to understand when you're expected to pass this flag and when
> you're expected not to pass it. This documentation could also help in
> the documentation here so that the user can make a more informed
> decision.

I think there are multiple reasons that you may or may not want to pass
that flag. Certainly if you're not using disjoint packs (and instead
only care about single-pack verbatim reuse over the MIDX's preferred
packfile), then you don't need to pass it.

But if you are using disjoint packs, you may want to pass it if you are
adding packs to the MIDX which are disjoint, _and_ you want to hold onto
the existing set of disjoint packs.

But if you want to change the set of disjoint packs entirely, you would
want to omit this flag (unless you knew a-priori that you were going to
drop all of the currently marked disjoint packs from the new MIDX you
are writing, e.g. with --stdin-packs).

If you think it would be useful, I could try and distill some of this
down, but I think that there is likely too much detail here for it to be
useful in user-facing documentation.

Thanks,
Taylor
