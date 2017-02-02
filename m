Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C1CC1F4E2
	for <e@80x24.org>; Thu,  2 Feb 2017 20:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751570AbdBBUDN (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 15:03:13 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34861 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdBBUDM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 15:03:12 -0500
Received: by mail-pg0-f65.google.com with SMTP id 204so2652892pge.2
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 12:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uEmLkgMVxpKAuLHQgwosgbtFo79cJmLSlKPj4WjgZZg=;
        b=DHXTHgygJOIaCqSDestGOYx362ouTgZGSkrRhJ2XUE8Tv9kwJ3s1xfKgNXBY9wFg3i
         XSiFHtUEA8D+Mt5gKMpUJ+ndaC3cBmI/Z5TdzlSPMFDXYFzBCQMxnRYujvHnkJgAj1ks
         r28F3u/PqueVERMVRzCLP9uZ8ZxzuDS7hsE0XhKEP1jlQWJk7/f2ky+kkGLVQPgM/zkx
         HA5fU4aioWxy9YAUYsVQJpB6wFntO+mKnS60rmSMRchhj2cX2ioaTH6u1efIcdmG4snX
         RQEIJefGKgnfhR89n92BGivnq5hCct1pEbQ9LN60Vuec0BO0WKAZQ6w5p1wQeclnz+0A
         GGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uEmLkgMVxpKAuLHQgwosgbtFo79cJmLSlKPj4WjgZZg=;
        b=o3Whd7FOincTPYFPy3cNXquNW9u7/dN8B8beVHUuiLgA+N3E/nACc6Qm7MirQsHwOs
         yeskW8K51VXJcLM7fQKsQgWnmG2We06jnLAzrnRFnsYZLtVcmgAZBvBMq+2a476KCsCI
         OsQky3sIKO28DdM1S+o4U1bxEPJw9kvDpuvXoiomCsuJFZpipY33q8yj8tAC/5f52mFj
         kXuKogK/h7M9dL+2uv98ArMZYs0+Aq2eta6Mb2qdiMFKWUwXt+c/vD2mQOdvlZvE2syN
         EojSlO1CYstgolphjjapuj0FFy0k1GE3J2o+ugiR/xp5GBVUUxCVpdok5OINDRhtxHQR
         8m8A==
X-Gm-Message-State: AIkVDXLDEWcMEl7xH7CJPqsL1nYPPstJSR2e9OX0+bRI3joFi8d8GGztXmOUZBI49liOoA==
X-Received: by 10.99.95.16 with SMTP id t16mr12842334pgb.212.1486065791596;
        Thu, 02 Feb 2017 12:03:11 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:358d:de5e:fbec:baab])
        by smtp.gmail.com with ESMTPSA id n28sm271605pgd.5.2017.02.02.12.03.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 12:03:10 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] ls-remote: add "--diff" option to show only refs that differ
References: <alpine.LFD.2.20.1702021143470.21619@i7.lan>
Date:   Thu, 02 Feb 2017 12:03:09 -0800
In-Reply-To: <alpine.LFD.2.20.1702021143470.21619@i7.lan> (Linus Torvalds's
        message of "Thu, 2 Feb 2017 11:49:50 -0800 (PST)")
Message-ID: <xmqqshnws6ma.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> My main use of "git ls-remote" tends to be to check what the other end
> has when some pull request goes wrong (they forgot to push, or they used
> the wrong ref name or whatever), and it ends up being hard to see all
> the relevant data from the noise of people just having the same basic
> tags etc from upstream.
>
> So this adds a "--diff" option that shows only the refs that are
> different from the local repository.  So when somebody asks me to pull,
> I can now just trivially look at what they have that isn't already my
> basic branches and tags.

Most downstream folks seem to care about refs/remotes/origin/$branch
and I think in that context "git ls-remote --diff [origin]" that
compares their refs/heads/* and refs/remotes/origin/* would make
sense.  Your has_ref_locally() seems to return true by comparing
their value with the value of the local ref without any the fetch
refspec mapping.

When one contributor asks you to pull refs/heads/master you want to
go and see if it is different from refs/heads/master you have?

> Comments?
>
> +static int has_ref_locally(const struct ref *ref)
> +{
> +	unsigned char sha1[20];
> +
> +	if (!resolve_ref_unsafe(ref->name, RESOLVE_REF_READING, sha1, NULL))
> +		return 0;
> +
> +	return !hashcmp(ref->old_oid.hash, sha1);
> +}
> +
> @@ -105,6 +121,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  			continue;
>  		if (!tail_match(pattern, ref->name))
>  			continue;
> +		if (diff && has_ref_locally(ref))
> +			continue;
>  		if (show_symref_target && ref->symref)
>  			printf("ref: %s\t%s\n", ref->symref, ref->name);
>  		printf("%s\t%s\n", oid_to_hex(&ref->old_oid), ref->name);
