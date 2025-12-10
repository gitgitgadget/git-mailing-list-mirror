Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C881826738D
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765380255; cv=none; b=eZvNFnI1L87R/jPJAjbwjuX/GFA3p71o1Updt5MxYU7bFyX7yWq0c5zs5wULJZ32cp36P4GzWtXYqkihHevBzW111RVEBOqenDNYntVWIDGYUkvBXVJbhtMBMwXu3m++s+WmR4er3W1VSakmhxn61Jbcv79asdBlJpy3irDNK8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765380255; c=relaxed/simple;
	bh=pyddP49gvw6MpTxSE0yVnKyzXFI41NOXBLP+BAH8NAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QC9TdEiSkLh2HtM59yojwNf0WX80Dns1d+2ZsbmXC20erO6eTj95A/7SDbmwFuIGSwgAjNWLP2yok+3yJ+0Ej8uivVEy7Uccn9tDcZKXPOKaxAIGB+jBMV7gZdotAz2PlUBsv4c7Zowq59O1G7mfshOv7j2GyWPuhNJwioP4FRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLzHIaCK; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLzHIaCK"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-3ec3cdcda4eso5550210fac.1
        for <git@vger.kernel.org>; Wed, 10 Dec 2025 07:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765380253; x=1765985053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qLWPVpP7i1AQ56YavjMq6QyxuD55/wpxgQFGZNd2Wlg=;
        b=ZLzHIaCK4vOs/z/nzfOm6tNma1sTcPF+/quBdgtkl33r8u7PsjQXUxd570iokkC4pi
         fISF9lSlZ5mXX3r0Xl42Gu/NzmZBBDGHwBxyp2ZSsvhDbuuu0yqrtqSN5vrfRTNeT2lv
         qVb7NxJ1/COpt3ESaX4KcquG4sE7e8H2eEwyylEHsrQO/pqJClnQtqsDMvhpo/D4ijIW
         tfzdIMBkP1nN17jOOgU2OEusMYBQv+XtuBWnZV4xW7H9GT+5h470V7j+HVXCU/8KIxas
         tw26+lo/9Kx6Htc0hiIRreO0qXzQCsVQK+76RLK+1O0rMtuevDi168jSRY/Qi/s49Fst
         laBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765380253; x=1765985053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLWPVpP7i1AQ56YavjMq6QyxuD55/wpxgQFGZNd2Wlg=;
        b=E94xZ55FHIKwoJLT72PN7MTzBKI3sQWsBbFGkHVB03r9d0HGCw7RTMtk1vksoh44T5
         YHqdErwGQVw7E4I3wZcZ2A3taT13+ow2SHizv4u5KbBF5q5DLXW2m3yTJ+1XRcXe4mex
         HORvfftz8yONmH+pHEZMJP7QvGinK4wvGWW1ilL2sfiAQ4DN33mWsnV3DnxKm8cfO6NO
         yp5Q8TMQ7H2l7QIF6hUIDUL3ZfdYP1lVkr6w20tMObzveMF4ka3UzWHumJlgsaJz+YLP
         1zdbN9xLQC25pO+It1KcTegS0WGrzD/9QhXOk6XHXhXDJtVxtEpf4HtAPqjpcKMa9m7O
         HnFQ==
X-Gm-Message-State: AOJu0YxPyUUxKPWiLIPHOaf7TwTkK+l7ca4f+aVG/+0Nl9F7zYTdd63l
	dIVL0KhPAfKPQV66iduvX6fnuc3eeVny4PhL4jT7i1z9Xg9zNOQ/ndLhOunPxA==
X-Gm-Gg: ASbGncthQnkb4y4Nu7YOXsOkCLys54Dm2tBeMuEp+0kXwV2RPsUoJgvDKRte6Gw/ooJ
	ulfOIBIv3HDFsB5NLreDytwu4Cl1eHMuzzgPkEIJ7NBtngfo+UCu4BHV4WpOG9Ze8LRv2uVgaO4
	plmOjiWekXsoGnIG/79BwQXNFAkNU4r7moh9vtn+7HUH3nBuLJGcmWg9lGMxvsYQvVJZ+ZGKxga
	V1cBvAG7Xm5XUQdLrwOFzGvHKVsJvKj0mGWwNFR4zO7mmSBLJyjVdUKY6qQXsQQUkGtU/sACOnj
	eY89VG+a1khGpM00bLHBgvT1eBxPnPvd36u2p6z2eYT9X1PT6gXINxOePV4u8rItflB1unZaa3e
	n5C3045irSi2HpkZfxNn6Io7A6nZsAD5F+S99m7vBgazxA/EVLcwIEWneAHL09JwU84+7X8DrOj
	cabUNi
X-Google-Smtp-Source: AGHT+IGSE58669XiWGEJlY6ZOpf6X1lvEhILx3yYMigH40G0sP5diHGXtb1t936FuiyXfRYlmEU86A==
X-Received: by 2002:a05:6870:288:b0:3f4:fed5:d88b with SMTP id 586e51a60fabf-3f5bdc002b1mr1717532fac.35.1765380252797;
        Wed, 10 Dec 2025 07:24:12 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f50b510088sm13329169fac.11.2025.12.10.07.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 07:24:12 -0800 (PST)
Date: Wed, 10 Dec 2025 09:24:11 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/6] builtin/repo: add disk size info to keyvalue
 stucture output
Message-ID: <zq7iwyz6jhhj4bf5th2dwoe3ldtmtxeqqgrhx2mc4dgiaujzaa@frsaxmwmdzps>
References: <20251209225820.2861276-1-jltobler@gmail.com>
 <20251209225820.2861276-6-jltobler@gmail.com>
 <aTkTCplQuSX_Y3oG@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTkTCplQuSX_Y3oG@pks.im>

On 25/12/10 07:28AM, Patrick Steinhardt wrote:
> On Tue, Dec 09, 2025 at 04:58:19PM -0600, Justin Tobler wrote:
> > diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
> > index 0ae96e6bbf..a98c651f1d 100755
> > --- a/t/t1901-repo-structure.sh
> > +++ b/t/t1901-repo-structure.sh
> > @@ -35,6 +35,37 @@ test_expect_success 'empty repository' '
> >  		git repo structure >out 2>err &&
> >  
> >  		test_cmp expect out &&
> > +		test_line_count = 0 err &&
> > +
> > +		cat >expect <<-\EOF &&
> > +		references.branches.count=0
> > +		references.tags.count=0
> > +		references.remotes.count=0
> > +		references.others.count=0
> > +		objects.commits.count=0
> > +		objects.trees.count=0
> > +		objects.blobs.count=0
> > +		objects.tags.count=0
> > +		objects.commits.inflated=0
> > +		objects.trees.inflated=0
> > +		objects.blobs.inflated=0
> > +		objects.tags.inflated=0
> > +		objects.commits.disk=0
> > +		objects.trees.disk=0
> > +		objects.blobs.disk=0
> > +		objects.tags.disk=0
> > +		EOF
> 
> Do we maybe want to adapt the keys to be "inflated_size" and
> "disk_size"?

Good suggestion. I'll update in the next version.

> > @@ -106,16 +137,12 @@ test_expect_success SHA1 'keyvalue and nul format' '
> >  		objects.tags.inflated=132
> >  		EOF
> >  
> > -		git repo structure --format=keyvalue >out 2>err &&
> > +		git repo structure --format=keyvalue >out.raw 2>err &&
> >  
> > -		test_cmp expect out &&
> > -		test_line_count = 0 err &&
> > +		# Strip object disk usage from output due to platform variance.
> > +		grep -v "objects\..*\.disk=" out.raw >out &&
> >  
> > -		# Replace key and value delimiters for nul format.
> > -		tr "\n=" "\0\n" <expect >expect_nul &&
> > -		git repo structure --format=nul >out 2>err &&
> > -
> > -		test_cmp expect_nul out &&
> > +		test_cmp expect out &&
> >  		test_line_count = 0 err
> >  	)
> >  '
> 
> We could test disk sizes here test if we use git-rev-list(1) to compute
> disk size by type:
> 
>     git rev-list --disk-usage HEAD --objects --filter=object:type=blob
>     git rev-list --disk-usage HEAD --objects --filter=object:type=commit
>     git rev-list --disk-usage HEAD --objects --filter=object:type=tag
>     git rev-list --disk-usage HEAD --objects --filter=object:type=tree
> 
> The `--disk-usage` option also supports `--disk-usage=human`, which we
> can use in the next commit to verify that our computations are the same
> across git-rev-list(1) and git-repo(1).

Thanks! I hadn't considered this. I'll try to update the tests in the
next version using this.

-Justin
