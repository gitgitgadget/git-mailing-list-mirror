Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDADA207D6
	for <e@80x24.org>; Tue,  2 May 2017 00:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750863AbdEBAib (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 20:38:31 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33206 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750712AbdEBAia (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 20:38:30 -0400
Received: by mail-pg0-f51.google.com with SMTP id y4so46755216pge.0
        for <git@vger.kernel.org>; Mon, 01 May 2017 17:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O6A4ZhLBtzSxaGRO3MCX2hxf1dTQx1GCpqrFN0Kitug=;
        b=UuRJmLMCD52ojQY6zRsa2dE+F9seT9HMTRSmPXRXATDDBxZX2IxlC5GE3m/WhPHY9d
         UTPZ5ApfGUmdLmBMnB4sSmSPw/HGiwFejW3lpiXtpa4zdvNraYsr7mkuE9WZZPEqVP4Y
         5FPwzQA3mcbj4BBT/g6bq5WZ6aa1JbTS8XYGsDzzNmMOV+qWjhXJCJSyN75Iu2wabkM8
         0Md7yNqL26qDVCM+e5D/fQMOLKHfjX7kRyIAcb1irvVKkC6gLPGnua6knvWcaLiWWQW+
         IAjtw1j8TW/qDTDZ5QFSV8a81svKDCHRUmi2ynee4sdW7E2RZhOzV/XOQSMeRb5eqnCY
         NihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O6A4ZhLBtzSxaGRO3MCX2hxf1dTQx1GCpqrFN0Kitug=;
        b=HDy79vyxJ6XYATOt7cqAU/rAvoYANYUNdgHhDG2Q2p77yIowpqrV1Nv/mRRRBN60/c
         ecfm5++GWOE6T4UjW6b1ud1a82lCzMTvqrc8z1MPG7Oane9CfK1IJQl9lXq5T0G6Gl8g
         ZJnwOtkSTzzGk4vu5Ijg1/fpgGWn1qaBVNl8R6v7+mf/mSMgUeUcHgsstZuGGsozudVi
         MNZDzigrNYqf5nhLnoVx7SyYvD8BVyEQD7cljjrMYHIyor3FN+riEK6kp46NMuNB3lk+
         dB7nOD+p1Ji4tm/SFny4NXeZZsvPuHq5xQp6weyyyyFs88PnSyFtHmeObCOZE9H+0byD
         bIlQ==
X-Gm-Message-State: AN3rC/7U5zsemcAVaosIKYAlnPSIkZPzVLM07cYhit/Yv3hQbzhrMJ1F
        kxDFMtyfudIg4gRL
X-Received: by 10.84.211.136 with SMTP id c8mr9662046pli.115.1493685509323;
        Mon, 01 May 2017 17:38:29 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:61ee:b5d7:71fe:5285])
        by smtp.gmail.com with ESMTPSA id b5sm23105261pfb.21.2017.05.01.17.38.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 17:38:28 -0700 (PDT)
Date:   Mon, 1 May 2017 17:38:27 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        markbt@efaref.net, git@jeffhostetler.com, kevin.david@microsoft.com
Subject: Re: Proposal for missing blob support in Git repos
Message-ID: <20170502003827.GB154031@google.com>
References: <20170426221346.25337-1-jonathantanmy@google.com>
 <xmqqinllgrfl.fsf@gitster.mtv.corp.google.com>
 <193d1d84-2386-c4c8-81ef-0042f0d8bb02@google.com>
 <xmqq1ss8gnqn.fsf@gitster.mtv.corp.google.com>
 <c0c8a0c3-582c-cf3b-3833-c918a0630f9f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0c8a0c3-582c-cf3b-3833-c918a0630f9f@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/01, Jonathan Tan wrote:
> On 05/01/2017 04:29 PM, Junio C Hamano wrote:
> >Jonathan Tan <jonathantanmy@google.com> writes:
> >
> >>Thanks for your comments. If you're referring to the codepath
> >>involving write_sha1_file() (for example, builtin/hash-object ->
> >>index_fd or builtin/unpack-objects), that is fine because
> >>write_sha1_file() invokes freshen_packed_object() and
> >>freshen_loose_object() directly to check if the object already exists
> >>(and thus does not invoke the new mechanism in this patch).
> >
> >Is that a good thing, though?  It means that you an attacker can
> >feed one version to the remote object store your "grab blob" hook
> >gets the blobs from, and have you add a colliding object locally,
> >and the usual "are we recording the same object as existing one?"
> >check is bypassed.
> 
> If I understand this correctly, what you mean is the situation where
> the hook adds an object to the local repo, overriding another object
> of the same name? If yes, I think that is the nature of executing an
> arbitrary command. If we really want to avoid that, we could drop
> the hook functionality (and instead, for example, provide the URL of
> a Git repo instead from which we can communicate using a new
> fetch-blob protocol), although that would reduce the usefulness of
> this, especially during the transition period in which we don't have
> any sort of batching of requests.

If I understand correctly this is where we aim to be once all is said
and done.  I guess the question is what are we willing to do during the
transition phase.

-- 
Brandon Williams
