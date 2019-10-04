Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15A8D1F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 21:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731822AbfJDV5q (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 17:57:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43478 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731789AbfJDV5p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 17:57:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id a2so4682004pfo.10
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 14:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3UjgZw0iiOYzpiPNuMMGNv1HLs+wNKAlf7ZZV+hpowk=;
        b=lKGA+DH3KEYJE2s6C5BJXnsbXyd75xGEvaHIZg0IvYU+/LLsHLadTWQJuXQV50JV1K
         rvepVou8ZffRVmAb17Oi06Q4n7D6gY6+8rRPMeqhSm1ZK6EqG2fsF7998isFobG1vedj
         XaaAhGnebZZ+B7niV8RVbKUS+kqeya4AA5zkpnvPmx7tazkJ9+wTUorBYdIKjSkdnTbi
         Eu/ct092NgBB7Q6UQvGGVx8xAW1x68+oJXnIM6Tddvh2tI4q2g0qmn9xnXxs26HJPVDi
         XcmR/1UKuJhYdPjof5OuPSZJlyhR1xQebqJGPlL7Hf3PylTlnoOHEtvMBFiCCEYaWIbo
         Ylcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=3UjgZw0iiOYzpiPNuMMGNv1HLs+wNKAlf7ZZV+hpowk=;
        b=OHXJV4v2lC0UsV72JFB0JiI0O8PHu/OxI7fAugVxR21ESpV1qN4l23tYs58C4kdft+
         18vQWyg8/vA0XEUrrnSJTyamlYCUtK0394Qq8EBVOPNxoHADj9WCxwGnKkFC7ENApy61
         KR4hxvPF4c10nyinBWhtounJHK3sMWC1Igd19pGtNC1aYFiTx9vUoSTnF+Nj+paA2+tI
         yZD0d6ujeLhSD3MJoCLV4cPvhfjjzFlXwCK4R2YrRoCMz1WkUNPjXDI/I12lKHREwLTc
         Pjr1p28N2SB2j7z9d3e5eIORqAp+eVBH0UIpuIiTFoIhkvOWl9AEhU9PdZsixbtTF5z7
         h4lA==
X-Gm-Message-State: APjAAAVWxfmOMatQwjta2BgNv/BML9pKbxAE0IU6N/HArbZpOZ8Xl4PM
        sCUtVctdAT4IIT2kr+u4Ss6g7w==
X-Google-Smtp-Source: APXvYqwtub6NhO0FNOscBUs3VHjK+W8Sv1wKXMD6EznpSaBwXjJB6VLPo09IUR9imnvoCpN00OMk9Q==
X-Received: by 2002:aa7:8492:: with SMTP id u18mr19550545pfn.247.1570226264147;
        Fri, 04 Oct 2019 14:57:44 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ece8:7fe:c1f1:a20f])
        by smtp.gmail.com with ESMTPSA id y2sm8679272pfe.126.2019.10.04.14.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 14:57:43 -0700 (PDT)
Date:   Fri, 4 Oct 2019 14:57:38 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, stolee@gmail.com
Subject: Re: [PATCH v4 3/4] trace2: don't overload target directories
Message-ID: <20191004215738.GB224668@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        git@jeffhostetler.com, stolee@gmail.com
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
 <cover.1570144820.git.steadmon@google.com>
 <98a8440d3f0ef3cd3cdd0291051d976d4a659cc4.1570144820.git.steadmon@google.com>
 <xmqq1rvt9x13.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1rvt9x13.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.10.04 09:25, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > trace2 can write files into a target directory. With heavy usage, this
> > directory can fill up with files, causing difficulty for
> > trace-processing systems.
> 
> Sorry for not mentioning this, but "don't overload" is a suboptimal
> keyword for the entire topic and for this particular step for a few
> reasons.  For one, "overload" is an overloaded verb that gives an
> incorrect impression that the problem you are dealing with is that
> the target directory you specify is (mis)used for other purposes,
> which is not the case.  You instead refrain from creating too many
> files.  The other (which is probably more serious) is that it is
> unclear what approach you chose to solve the "directory ends up
> holding too many files".  One could simply discard new traces to do
> so, one could concatenate to existing files to avoid creating new
> files, one could even cycle the directory (i.e. path/to/log may
> become path/to/log.old.1 and path/to/log is recreated as an empty
> directory when it gets a new file).
> 
>     trace2: discard new traces when a target directory has too many files
> 
> or something would convey the problem you are solving (i.e. "too
> many files" implying negative performance and usability impact
> coming from it) and solution (i.e. "discard new traces"), if it is
> the approach you have chosen.

Understood. Reworded in V5, which will be out shortly.

> > +	/* check sentinel */
> > +	strbuf_addbuf(&sentinel_path, &path);
> > +	strbuf_addstr(&sentinel_path, OVERLOAD_SENTINEL_NAME);
> > +	if (!stat(sentinel_path.buf, &statbuf)) {
> > +		ret = 1;
> > +		goto cleanup;
> > +	}
> > +
> > +	/* check file count */
> > +	dirp = opendir(path.buf);
> > +	while (file_count < tr2env_max_files && dirp && readdir(dirp))
> > +		file_count++;
> > +	if (dirp)
> > +		closedir(dirp);
> 
> So, until we accumulate too many files in the directory, every
> process when it starts tracing will scan the output directory.
> Hopefully the max is not set to too large a value.
