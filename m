Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3283315FA74
	for <git@vger.kernel.org>; Thu,  2 May 2024 19:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714677987; cv=none; b=b2On2i/OfNDOwrXE51tHlLYn0v66I1ZlGiSTZHnZ2xsSGeJQjgFFLnOwet4EUCpcWW7T8X1N1CGBHbzn7WpsIAJFbDDrkYCuKzJ5CtjF0+9+9gX/QuKqWLZ/xet5Mbvfn4taEyGQY0myaEQh9dxHo9ngjBjBXe4oF7gyGIk6iOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714677987; c=relaxed/simple;
	bh=5+cF/P78UQVW4BHeEg97WBn409ggiw6qRp9PCUeXaMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKkOkX+OQK3lLjDM1zTYt/nirbGKowOgTYU2OCS2MYhrLAuAcGVBPReCoS5V/jSRpVTqS6Ab/kqmyfhgUzS2S7rcVKEspcbZEp1XNyzGiRbMysyNGOczLr0G3LnFT2qdbwGcAJ6zD0eeD53RZSMbP+I3ur84wdzA0gJF0SZZhJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlSqT2zm; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlSqT2zm"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41b79451145so52023315e9.3
        for <git@vger.kernel.org>; Thu, 02 May 2024 12:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714677984; x=1715282784; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=URhJI3KILfC4RQOkPp4kNulxPFgJ6KZf+wtxv4hZvfM=;
        b=hlSqT2zmDyN+PtaVIl7+/d8Z2ki1OPb1Gw/kQS6HYOuEfrsfmjYOO7Yj59F+bly8Fs
         Nlb+nO3n2w8MBpZq0qdVFZRzrMsrwSEJEl5omnakG9qqQFuGoQAgr7dtnf0oOEkqjB5r
         c3IxqWw1mCpZpFyeMl68DLfpAcjCRHBm4jD8kWPcR1VLNjWl5j/wleNDVkg5jhSgQbcP
         TjEssZdenCtPAdoC4oLI+3y4uw8N5R+DaJC2Hz4Dn7J/yaJKYF6gp6bfkw5813S3C9Sa
         XbNuA7jlCvDdjJ90vyYR00TJHldq8n/ksm0A7iIWKFRIkgJdUQa0gZ9d8vTBHH3N6ydR
         ihVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714677984; x=1715282784;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=URhJI3KILfC4RQOkPp4kNulxPFgJ6KZf+wtxv4hZvfM=;
        b=H3D/MXmfF0RDAriYJjMvYs5l/71oFxjW+i++Ocgkzis5tXN11iuC+vw7elRzdXm1uY
         3WvfrP5I6eqVhJk2dUwL06WgL+guJDf4tNpabjt12Hc/LB544WQIbhiSBfP3IrUvHpTz
         vU8IbPtlkxmG8hbvNWXGQbczV9CFFCXI1DwjhvDSx2KbAK6fHjxd3BufxD299Emv/cN5
         MbtgRl2rdcu7Atv1d0/hS63Q+ItVmUDx3zmozIpQNxwGEmV2zds1DN11tmOQVSLbuUB2
         5w1eE9HO/pnpL94ZSkja617EBC9ChnJO2hAo7TtstYGjXXsvVoj9zVJMDNKENrIGbKhJ
         8DlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2KxOYNseV1VHpsv770HcepTPBX20EmQIW4h85S18SBCJmCmO/t41Oujz4g6sjWWeN0WF6a8rtLwb7WPks+HMi20HN
X-Gm-Message-State: AOJu0YzK4KLmZO36ltMU78O9BA5oRXgSOCe3LfdIw80jqjpOsGNEmpsT
	i8ECwNUYhA5Fyqsuv6nrI/1gz0LO2FuNP5/YkiWQnU3UtiLLL+l4
X-Google-Smtp-Source: AGHT+IGvyNy729jLIw3TsDQYScrb99AyZ6MIsTZUIA48GofWKnoAv/ff3418gt24lvAm2Jhk6jbu/Q==
X-Received: by 2002:a05:600c:1913:b0:41b:6cf6:61f8 with SMTP id j19-20020a05600c191300b0041b6cf661f8mr481200wmq.11.1714677984317;
        Thu, 02 May 2024 12:26:24 -0700 (PDT)
Received: from localhost (62-165-236-221.pool.digikabel.hu. [62.165.236.221])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0041bd85cd3f2sm2908196wmp.19.2024.05.02.12.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 12:26:23 -0700 (PDT)
Date: Thu, 2 May 2024 21:26:22 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: t4216-log-bloom.sh broken ?
Message-ID: <20240502192622.GA1841@szeder.dev>
References: <xmqq8r0ww0sj.fsf@gitster.g>
 <20240502055621.GA29945@tb-raspi4>
 <xmqqsez0fbam.fsf@gitster.g>
 <20240502185903.GA11895@tb-raspi4>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240502185903.GA11895@tb-raspi4>

On Thu, May 02, 2024 at 08:59:03PM +0200, Torsten Bögershausen wrote:
> On Thu, May 02, 2024 at 09:06:41AM -0700, Junio C Hamano wrote:
> > Torsten Bögershausen <tboegi@web.de> writes:
> >
> > > There are 4 test cases in t4216-log-bloom.sh, that do not pass on one
> > > Mac here (they pass on another machine)
> >
> > Another machine being another mac?
> 
> Yes, different mac, different MacOs, different $PATH probably.
> 
> >
> > > expecting success of 4216.141 'Bloom reader notices too-small data chunk':
> > > 	check_corrupt_graph BDAT clear 00000000 &&
> > > 	echo "warning: ignoring too-small changed-path chunk" \
> > > 		"(4 < 12) in commit-graph file" >expect.err &&
> > > 	test_cmp expect.err err
> > >
> > > ++ check_corrupt_graph BDAT clear 00000000
> > > ++ corrupt_graph BDAT clear 00000000
> > > ++ graph=.git/objects/info/commit-graph
> > > ++ test_when_finished 'rm -rf .git/objects/info/commit-graph'
> > > ++ test 0 = 0
> > > ++ test_cleanup='{ rm -rf .git/objects/info/commit-graph
> > > 		} && (exit "$eval_ret"); eval_ret=$?; :'
> > > ++ git commit-graph write --reachable --changed-paths
> > > ++ corrupt_chunk_file .git/objects/info/commit-graph BDAT clear 00000000
> > > ++ fn=.git/objects/info/commit-graph
> > > ++ shift
> > > ++ perl /Users/tb/NoBackup/projects/git/git.pu/t/lib-chunk/corrupt-chunk-file.pl BDAT clear 00000000
> > > ++ command /usr/bin/perl /Users/tb/NoBackup/projects/git/git.pu/t/lib-chunk/corrupt-chunk-file.pl BDAT clear 00000000
> > > ++ /usr/bin/perl /Users/tb/NoBackup/projects/git/git.pu/t/lib-chunk/corrupt-chunk-file.pl BDAT clear 00000000
> > > ++ mv .git/objects/info/commit-graph.tmp .git/objects/info/commit-graph
> > > override r--r--r--  tb/staff for .git/objects/info/commit-graph? (y/n [n]) not overwritten
> >
> > Is this failure preventing the later steps of the test work as
> > expected, I wonder.  Is there something curious with the permission
> > bits of /Users/tb/NoBackup/projects/git/git.pu/ directory or its t/
> > subdirectory?  Is there something curious with the "umask" of the
> > user running the test?  Are they different from what you see on your
> > other mac that does not exhibit the problems?
> >
> > Thanks.
> >
> >
> 
> mv is /bin/mv, that seems to be good:
> 
> $ type mv
> mv is /bin/mv
> 
> $ alias | grep mv
> 
> $ which mv
> /bin/mv
> 
> $ umask
> 0022
> 
> I don't know, why we see
> r--r--r--  tb/staff for .git/objects/info/commit-graph
> 
> But, the "-r--r--r--" may be part of the problem, here is another one:
> $ find . -name commit-graph -print0 | xargs -0 ls -l
> -r--r--r--  1 tb  staff  1792 May  2 12:12 ./trash directory.t5318-commit-graph/bare/objects/info/commit-graph
> (And some more 6 in total. All with -r--r--r--)
> 
> Which means, yes, t5318 does not pass either:
> t5318-commit-graph.sh not ok 101 - reader notices too-small oid fanout chunk
> t5318-commit-graph.sh not ok 102 - reader notices fanout/lookup table mismatch
> t5318-commit-graph.sh not ok 103 - reader notices out-of-bounds fanout
> t5318-commit-graph.sh not ok 104 - reader notices too-small commit data chunk
> t5318-commit-graph.sh not ok 105 - reader notices out-of-bounds extra edge
> t5318-commit-graph.sh not ok 106 - reader notices too-small generations chunk
> 
> Same problem here:
> ++ mv full/.git/objects/info/commit-graph.tmp full/.git/objects/info/commit-graph
> override r--r--r--  tb/staff for full/.git/objects/info/commit-graph? (y/n [n]) not overwritten

'mv' in macOS doesn't conform to POSIX, and asks for confirmation when
the destination exists (is read-only?) even without '-i' and even when
its stdin is not a terminal, which it won't get as its stdin in our
test suite is redirected from /dev/null.

This is a recurring issue, see e.g.:

  https://public-inbox.org/git/20180616143513.10086-1-szeder.dev@gmail.com/
  c20d4d702f (t1450: use "mv -f" within loose object directory, 2017-01-24)

'mv -f' did the trick in the past.

