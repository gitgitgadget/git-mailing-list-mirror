Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711F32D61B
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 22:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="akS7qmzA"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E71AB0
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 15:50:08 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a828bdcfbaso67635717b3.2
        for <git@vger.kernel.org>; Tue, 24 Oct 2023 15:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698187808; x=1698792608; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9CI+90FzZHOtdPkZx1+1lAdlxDSpTD1iSmeY7TzTpG8=;
        b=akS7qmzAGM40QTq4RIqggQVyXjOeqtSipRUcVkicStiRr+vRM3Q6I4F5QiKSQ99cgi
         fVhKegJs7dJGYvIK8jwnYBmtvvtI2sWhGc4vZA5fD/FyzFWxF4lE3wXu3epIfDqJAI7U
         YsMG9cZNQhkbNGB3bsO+gCFLSMhvdVBFfANwWxpwMUkCeSaqAGNLPOcdgp29W7QAhtlN
         v/R8dsTOVmsElh7kFTgumkC1NsUqOcTAnYeIgc95JxKaQunDkP/FhfnJxm9vxDskz+J3
         eGd0+p3kz7BuVz/BQBRkq/UakLU3J5WDfgxhbwoqGAbXHpObY5E9izBYV87/QYqssM2T
         4Tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698187808; x=1698792608;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9CI+90FzZHOtdPkZx1+1lAdlxDSpTD1iSmeY7TzTpG8=;
        b=dtpCkgusFhMvWFnjhjTAy+z148YPeDrmwsDn7dCKQAXqLSgml+TpuEU1ME1vYN9Wex
         C/jWtlRrHseTJ3mJTMyjN3GnEQtTx2jS6mAh3c9dqqzLjf4nJ4epIDbG6Eum8j5JmDZI
         XDnbDJYX5rpuzl/VT8vBSloVPkG0QGi6qMoqP+1KqcLgdegbliJAMLPXhhrPzeQ0Tut8
         se0ug2oxny4gs1m24EL7M8ec6PX2NCQoxtukT9MRlv3oES2b2fv+UPgLXL0N89DlcJVR
         11Ko90a1TfaxSr1D3sDyISBie8r0oiZfsZpPLMtwgRAZ/SRE2ycY15JZrEw+ZkZifsx2
         Fuhw==
X-Gm-Message-State: AOJu0YxjtnUuxmWDb3a/qV9FrLWPs0DMC1XOf8mdBZiEA4VyBBt4vHcd
	yDdM9pjYVCv0tTTX/UvCpIriPI/+5kWaWs6aW6UT
X-Google-Smtp-Source: AGHT+IFIv8YfEFyTZwUms4j/R0TKJyKt+dAwx4SrYT173aWdQdlZDCTstRIsaIS9wiOJDhhkT29kwty4mgYkeHvisux5
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:edb9:f7d1:6b9c:d86b])
 (user=jonathantanmy job=sendgmr) by 2002:a05:690c:288e:b0:5a8:205e:1f27 with
 SMTP id ee14-20020a05690c288e00b005a8205e1f27mr233083ywb.6.1698187807766;
 Tue, 24 Oct 2023 15:50:07 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:50:05 -0700
In-Reply-To: <ZTbK3QTJYXxYj/M6@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024225005.1191555-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 0/5] config-parse: create config parsing library
From: Jonathan Tan <jonathantanmy@google.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, Junio C Hamano <gitster@pobox.com>, 
	Josh Steadmon <steadmon@google.com>, git@vger.kernel.org, calvinwan@google.com, 
	glencbz@gmail.com
Content-Type: text/plain; charset="UTF-8"

Taylor Blau <me@ttaylorr.com> writes:
> But I am not sure that I agree that this series is moving us in the
> right direction necessarily. Or at least I am not convinced that
> shipping the intermediate state is worth doing before we have callers
> that could drop '#include "config.h"' for just the parser.
> 
> This feels like churn that does not yield a tangible pay-off, at least
> in the sense that the refactoring and code movement delivers us
> something that we can substantively use today.
> 
> I dunno.
> 
> Thanks,
> Taylor

Thanks for calling this out. We do want our changes to be good for both
the libification and the non-libification cases as much as possible. As
it is, I do agree that since we won't have callers that can use the new
parser header (I think the likeliest cause of having such a caller is
if we have a "interpret-config" command, like "interpret-trailers"), we
probably shouldn't merge this (at least, the last 2 patches).

I think patches 1-3 are still usable (they make some internals of config
parsing less confusing) but I'm also OK if we hold off on them until
we find a compelling use case that motivates refactoring on the config
parser.
