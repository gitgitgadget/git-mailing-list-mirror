Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27D5F1F404
	for <e@80x24.org>; Thu, 13 Sep 2018 18:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeIMXUN (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 19:20:13 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:50444 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbeIMXUN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 19:20:13 -0400
Received: by mail-yw1-f74.google.com with SMTP id u12-v6so2315311ywu.17
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 11:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NskFo35drB692uzzyEUAouMmaL+LF8x0xRvhR+StDCc=;
        b=GjGjr1j0us5PXxKALMLe+nJsOBRDk1JQSmXgbf9sglLJwtuLsNh/gw10ixSBnYFn3u
         ATOoeYhnJikfZ/wasw+HQF2KZ7X8itDauFBR0LK9N2xdYEMfWttLRvRc0EX4Jp0W+vii
         XZACKDbJLmlnwYYWnfb1HrJEKLnho5jDXLCMiaRR1O6ng5lN7ia3a3MhAJFcMSG3hn3P
         cWXjAp0dQmz9VmkEVJVR9PS2YzngGyufnz6rzaVCp+fpRUN8RAYjZzSMbOi4QGxbb5KB
         +xyatnNv72NCt0LJ+jMa0zKi37O7w31v/6dFT2GhF35lAOvhUNNw1Tfaa0V3blId4+pW
         riWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NskFo35drB692uzzyEUAouMmaL+LF8x0xRvhR+StDCc=;
        b=haSJjy1AQR00q9Of+jjo6D6IyEcciKEzykoeryLMY11Ud/djiaBW38bgdXgfWU6QON
         KxpeHGrwdrd73B+g102Q2EBBboqi4AZw6Q0H3V7at+7XTRG4uP3JDadjwPv+0c7mt7Hv
         dYii5DyhqsoGyHNATRibaCy4e24v9mVCPtA27gDE6R21h5sricERLJwOP46QUdJ4beg5
         fiPCJN6lJWl4XY5jpEwtHBt9zR6P4ksfmK7E+bDMqj30N88RkILYnVWXY/qskeTPMKsK
         sJah7K6NkmSE42GdHzE2bMYwEKeZ75k3fK0/L0aPPtuPviAF/tseXyDxHE6rGvhdDNsz
         vVtw==
X-Gm-Message-State: APzg51C0zgvqvLb9G/XgLDyvhe+yMcLC9pnsQZ90c/4ce1idiSFKk4B7
        O4KqIcqVz52Y+yekX9ZMMBdIlJeuF4lhSjcuoueH
X-Google-Smtp-Source: ANB0VdZy43UcD8zWWzkUde6J4XCcTLa5w7gfwbV0XQtIm9Mub04ZxWqJP8iP0zXlnCaK8r8rTy8By8YPN63dxYCXrwwj
X-Received: by 2002:a25:844e:: with SMTP id r14-v6mr1422486ybm.16.1536862176772;
 Thu, 13 Sep 2018 11:09:36 -0700 (PDT)
Date:   Thu, 13 Sep 2018 11:09:32 -0700
In-Reply-To: <xmqqefdyjsgh.fsf@gitster-ct.c.googlers.com>
Message-Id: <20180913180932.93341-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqefdyjsgh.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
Subject: Re: [PATCH 1/2] fetch-object: provide only one fetching function
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Instead of explaining why the new convention is better to justify
> (2), the above three lines handwave by saying "more flexible"
> twice.  We should do better.
> 
> 	fetch-object: unify fetch_object[s] functions
> 
> 	There are fetch_object() and fetch_objects() helpers in
> 	fetch-object.h; as the latter takes "struct oid_array",
> 	the former cannot be made into a thin wrapper around the
> 	latter without an extra allocation and set-up cost.
> 
> 	Update fetch_objects() to take an array of "struct
> 	object_id" and number of elements in it as separate
> 	parameters, remove fetch_object(), and adjust all existing
> 	callers of these functions to use the new fetch_objects().
> 
> perhaps?

Thanks - your explanation is much clearer than mine. Let me know if you
want a reroll (or if you can update the commit message yourself, that's
fine too).
