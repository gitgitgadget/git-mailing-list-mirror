Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0754417
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 22:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NPfftZD1"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37047FE
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 15:24:04 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5afa77f9a33so55337067b3.0
        for <git@vger.kernel.org>; Tue, 31 Oct 2023 15:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698791043; x=1699395843; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wkT93QatE45aIQTwkuoXH31m+Wgp8ZdW5lpik0Zb0/Q=;
        b=NPfftZD1HA6N0IpT4rQ/MJaAITp36vHc4LfnhElFg3qqN/P6jiEgDPphQY4Yt+noes
         vzv5O8H02CmhE93BCNmNFsIyPJTRVe/zcEOhAwuW9vbQPhDfGEKI1L7qBoVyH9e2aqyG
         Po+Axtbym4mGx+MhuYwkynjccC3mWXjev4pjy/Qa5U4cyNkZqadQae16lGCgF8F5qrAP
         i6MvC8TMP6ftvgho5JsJrFlrtSnpqm0a9NyOXn7wUeXMrLEQ3vkWdwAigb0W8HJOiiAe
         UKHRo9PNTVoleMioL5nFBpC1YxS5sLAfd5ips2f4KiP0VcC8EFpv4H5unEJyHFf1Vy/7
         eFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698791043; x=1699395843;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wkT93QatE45aIQTwkuoXH31m+Wgp8ZdW5lpik0Zb0/Q=;
        b=v3a2pg6uZumhDNoqkdsAY9R+6cTXOTAX4bePcRlfZK+BL4lEPNWXJVEotzVqjE3om4
         LPLjGIKmvlV7E4AUr5XroDvpgoQDH+BvlpOByQpx+gjBSIB/Hx/nTymOCyDa/ay0+mE+
         VuMzHTL/qLRoP7HzjmPpzbmEj+lqGdFv2+GIwLLEz7CQx36p/Gp0VzByvY0tNa78E3kr
         Qq365pkewI3lKj0gzbQtuu+oVeohK4kCRCh3jzfs29yFhHAN0B5dBH2bQGAgf975A+1f
         geaWGwoc4orktFwILnkH+ZllD09eLJDwo+n7NvoBUds0JQxfkUSvOYY9b/+v6kLfv/az
         2TSQ==
X-Gm-Message-State: AOJu0YzPF6vMfXLNV8mH5EjNVSBuwC9JrLJ091EFvs1rTuXTKWAhPLfF
	8AuIbDpAqLoON96fMEkpjhJj+8BNWPIxk6i072JY
X-Google-Smtp-Source: AGHT+IFf8FYzJoMU/cp4iImuEB1ZP18Wgpq2TJyCtzf6/Z5wEGZpi4fyggTw3RTFa2jII/BiR8+ZcG0jw3WfkoNYjbjv
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:70a1:f59a:2e01:c62e])
 (user=jonathantanmy job=sendgmr) by 2002:a25:50cc:0:b0:da0:4cef:b1be with
 SMTP id e195-20020a2550cc000000b00da04cefb1bemr266408ybb.4.1698791043381;
 Tue, 31 Oct 2023 15:24:03 -0700 (PDT)
Date: Tue, 31 Oct 2023 15:24:00 -0700
In-Reply-To: <xmqqh6m74bdo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231031222400.2048688-1-jonathantanmy@google.com>
Subject: Re: [RFC PATCH 2/3] strbuf_commented_addf(): drop the
 comment_line_char parameter
From: Jonathan Tan <jonathantanmy@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Dragan Simic <dsimic@manjaro.org>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:
> This moving of the helper function does not belong to the "fix
> commented_addf() not to take the comment_line_char" step.
> 
> The series should be restructured to have the two patches from me
> first, and then your moving some stuff to environment.c, probably.

This means that #include "environment.h" will be added and then removed
in the same series, but I don't feel too strongly about that. I'll send
an updated set of patches.
