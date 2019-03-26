Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 523D620248
	for <e@80x24.org>; Tue, 26 Mar 2019 19:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbfCZTb2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 15:31:28 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:48365 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfCZTb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 15:31:28 -0400
Received: by mail-qt1-f202.google.com with SMTP id 54so14608642qtn.15
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 12:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OjQsOQLBuHS38JcJu9RCZdDDnnjQyQ9aheRyQ8hBYOc=;
        b=q+skm+m8Z60ggteOPk4wMYk2W3lC6EbCL41uiiWzHLQ1azeIudzumMeMcCK6SMVFgp
         oYuDZ4hS88hfLTOk+A/UXqSEMiXQgOSx0f4RVJNb4iQjuZFl0q5owPApVftCfLnz0bgN
         X3VovXEqZzZiL0Wt7jRHUNcXAzBsnva35bDIaqjiCVX2qhXkI4mzMNmGupaDn2VYWxct
         Esf1tH0aKIL3MNJANRYObXQX0JoqW4HTm94GeeSOLJyA12aSnSghW9bMIf2Yj+wV7v2I
         hRTLWqMZ+4GXaPlHsBee3ITfGBOYVctDlBip6TiQ9WOl0BF/pv0ucFj8hD+9vLeMO085
         VdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OjQsOQLBuHS38JcJu9RCZdDDnnjQyQ9aheRyQ8hBYOc=;
        b=R6DL50uYcKkHf1OXBsdzjC8czfklLGSwm6b1Gf8Iq3X6pjXNamMATUKlcG6sYTpx6M
         LbGD7jllXWWdx886KJD6QEMz9yg/Iv1m37qOwZb0Yk8zA7uFNl8SYh1SIHx9NQ8VW43t
         3YLNsihXHScYfY/s1i5z8o88lvfyK7QNUwGtpOGdVekLkoxfH7GlB6rjjn92CkL72oho
         rJWejRTIm3JCi2jbVYg0xf43jmdalVkwJUMAkUH2UELyIZLWn7Ig2J13FkakBZr4+iwO
         gn1tEIE6k75gJTh+ttMgC/6IVHRy4CmTdieDcCSlLiSAbZaQMbp1B7V6Ds8Qyg/A8Yft
         pRDg==
X-Gm-Message-State: APjAAAVVNcv95ljnQfk6+yunsyDcDHt/g7OrnelKw8fa0Je1fqXM4sm3
        N1w9oywEyP08UhdnNWp5MumgBU6LLsMVcoHNDWycbaMkQudGI10IKKnYokSSnpcs2NeASoFPjxh
        DK9hWaV6swzibSPuB2Y7E0yihlAiipuJwzWyQwOOPmeLKVTloKJ8OS5EksTMv5wLbb2Xf+rbJVY
        It
X-Google-Smtp-Source: APXvYqwMvNECnpwssG4tE5SpylPVp2AwG3sZwTNC7ZMZXV+5koZIxc9vT77Mu2OxUkJNkcZoA9L64yHcCXY1Kt2jgldW
X-Received: by 2002:a37:790:: with SMTP id 138mr25706818qkh.271.1553628687575;
 Tue, 26 Mar 2019 12:31:27 -0700 (PDT)
Date:   Tue, 26 Mar 2019 12:31:19 -0700
In-Reply-To: <cover.1553546216.git.jonathantanmy@google.com>
Message-Id: <cover.1553628494.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1553546216.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.21.0.155.ge902e9bcae.dirty
Subject: [PATCH v3 0/2] Last big GIT_TEST_PROTOCOL_VERSION=2 fix, hopefully
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peff says in [1]:

> But isn't this line:
> 
> >     + 	if (version == protocol_v2) {
> >     +-		if (shallow && shallow->nr)
> >     ++		if (shallow->nr)
> >       			BUG("Protocol V2 does not provide shallows at this point in the fetch");
> 
> added by patch 1? It's added with "shallow &&" in patch 1, and then
> modified in patch 2.
> 
> I think the "it's never NULL" property is true even before this series,
> right?

Ah...yes you're right. I've updated it here.

Thanks for your review.

[1] https://public-inbox.org/git/20190326182047.GB24105@sigill.intra.peff.net/

Jonathan Tan (2):
  fetch-pack: call prepare_shallow_info only if v0
  fetch-pack: respect --no-update-shallow in v2

 commit.h     |  4 ++++
 fetch-pack.c | 51 +++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 45 insertions(+), 10 deletions(-)

Range-diff against v2:
1:  d2eb101709 ! 1:  64f44a18ad fetch-pack: call prepare_shallow_info only if v0
    @@ -38,7 +38,7 @@
     -	prepare_shallow_info(&si, shallow);
     -	if (version == protocol_v2)
     +	if (version == protocol_v2) {
    -+		if (shallow && shallow->nr)
    ++		if (shallow->nr)
     +			BUG("Protocol V2 does not provide shallows at this point in the fetch");
     +		memset(&si, 0, sizeof(si));
      		ref_cpy = do_fetch_pack_v2(args, fd, ref, sought, nr_sought,
2:  943b1cbc61 ! 2:  3f65698610 fetch-pack: respect --no-update-shallow in v2
    @@ -120,11 +120,6 @@
      	fetch_pack_setup();
      	if (nr_sought)
     @@
    - 		die(_("no matching remote head"));
    - 	}
    - 	if (version == protocol_v2) {
    --		if (shallow && shallow->nr)
    -+		if (shallow->nr)
      			BUG("Protocol V2 does not provide shallows at this point in the fetch");
      		memset(&si, 0, sizeof(si));
      		ref_cpy = do_fetch_pack_v2(args, fd, ref, sought, nr_sought,
-- 
2.21.0.155.ge902e9bcae.dirty

