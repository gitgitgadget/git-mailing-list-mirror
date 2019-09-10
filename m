Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A1D71F463
	for <e@80x24.org>; Tue, 10 Sep 2019 18:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730683AbfIJSPj (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 14:15:39 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:33215 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730558AbfIJSPj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 14:15:39 -0400
Received: by mail-pf1-f201.google.com with SMTP id z23so13694523pfn.0
        for <git@vger.kernel.org>; Tue, 10 Sep 2019 11:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wovxqhbAsqYYx8p20WsMzGqcYmajmfjZ2h1ogPl5Y6g=;
        b=VsXR/yJe2IXa0+g9JczOzGplmspDsj1GY6ZJ9l4zY7GoyC3DRhAKs+h48s/YYKbxnU
         ZzXvXCrut06vlzQku5MvGpBprdyqYkYfBaJR7/A2WtZYKhM3Tr2L5bNnUCodSru3jxZE
         G1M2bRxQK1+1cit5W7Pa0BXO2ITeW1m/3Eu5iTOT01af+i1ELuq+BYetPRKRlW4YAfQn
         wZwSKdmSUGkWcRFoS9pqo41v90iaepyxUq49eCU3ZnH5MaSg5J2ZIGcuyg9LJC1v9zpQ
         wStb2PGDHOyuPADmdu0jdu1s+eHJtzcU5m3GJS8DCWvIKUJXvejOMMNr7FyvAMjwPUU3
         j9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wovxqhbAsqYYx8p20WsMzGqcYmajmfjZ2h1ogPl5Y6g=;
        b=rQjMy9pdLtF08tLAiVmDEptyQdfAttQNLik+/ShF+boo73P05w7yPgCUOLacPxiAr9
         iwnfrs+Hvoydlpqtln6+3L4SY7csw0nHmO84Cg82cMebULUQZbVYk+mxt8B1hJSt/PPZ
         6+uPEoTXa2By0+hxPPMThTf0Eh9LjJ02K2hN8k6+p8y58d2uLoOUD2cywVlitih6cRax
         0WDY82Mz33vxObg1uYmLkGONH8i1Ybf9e9mI2cRk5PkQwVo+Mwd2WQ7DzZ8npaSULp+T
         mgAnO/FWaZuLSbmeblD5j5F8C4e42EkS5K2PLTpVAlDuPpeEDPxgcnIBnG1L4Of1qzlI
         OYmg==
X-Gm-Message-State: APjAAAVXxyPmM/Ma9pSB4IXFwsBOKmOq3USEUu88SPT637iGjr7cBRwc
        0P3VX4JylGx+NPXzboikr/AxYPVZNkGR8+5HLnWt
X-Google-Smtp-Source: APXvYqzkKR3tDoAMyVyavlobsZ0qSeDwdXvVG2E4tniyt3Revlr5/Lc6Mun3awXz+Qv2JA7riTyDD6ItEGeG38D1ScMw
X-Received: by 2002:a65:5082:: with SMTP id r2mr28619717pgp.170.1568139337881;
 Tue, 10 Sep 2019 11:15:37 -0700 (PDT)
Date:   Tue, 10 Sep 2019 11:15:34 -0700
In-Reply-To: <xmqqef0pi3im.fsf@gitster-ct.c.googlers.com>
Message-Id: <20190910181534.134890-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqef0pi3im.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
Subject: Re: [PATCH v2] cache-tree: do not lazy-fetch merge tree
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Isn't that what is going on?  I thought I dug up the original that
> > introduced the has_object_file() call to this codepath to make sure
> > we understand why we make the check (and I expected the person who
> > is proposing this change to do the same and record the finding in
> > the proposed log message).
> >
> > I am running out of time today, and will revisit later this week
> > (I'll be down for at least two days starting tomorrow, by the way).
> 
> Here is what I came up with.
> 
>     The cache-tree datastructure is used to speed up the comparison
>     between the HEAD and the index, and when the index is updated by
>     a cherry-pick (for example), a tree object that would represent
>     the paths in the index in a directory is constructed in-core, to
>     see if such a tree object exists already in the object store.
> 
>     When the lazy-fetch mechanism was introduced, we converted this
>     "does the tree exist?" check into an "if it does not, and if we
>     lazily cloned, see if the remote has it" call by mistake.  Since
>     the whole point of this check is to repair the cache-tree by
>     recording an already existing tree object opportunistically, we
>     shouldn't even try to fetch one from the remote.
> 
>     Pass the OBJECT_INFO_SKIP_FETCH_OBJECT flag to make sure we only
>     check for existence in the local object store without triggering the
>     lazy fetch mechanism.

This commit message looks good to me. Thanks for writing the commit
message - I thought that the justification in the commit message I wrote
would be sufficient, but it makes sense to look into why the check was
done.
