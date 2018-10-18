Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F1541F453
	for <e@80x24.org>; Thu, 18 Oct 2018 18:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbeJSClB (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 22:41:01 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:37463 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbeJSClB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 22:41:01 -0400
Received: by mail-pg1-f202.google.com with SMTP id u43-v6so15124464pgn.4
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 11:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kq9UxjoERGNW4jksFWUYlqB2PHUw2ML24mY9io35lAU=;
        b=KEbZV/jkJbRWAfzDJtX4A1H8Fn5u/qnVzuB98qv79b61VUgVstknhNPAO6QRpYF58T
         bV71pAeEon38WOn6AwgJkgO8PT3dTQ5BpHsxB8PW8lArplB0zpryVuq9f4tMJ4m+1piV
         mdkW9aU6cVKpVi1iRH4aYNqUF6QV4pwNMoQgJAJqbaMCrrpI01izR4qK01ySS6jA7euo
         DXUj/zrToB3IbxHThwxVJLVYsUxmqJFzHfVvEyNj4DH1v3ZDIBk5PhjIMLyeJSf8i2Om
         RjA24yz4RL4QnP/hc8UOrILXQ2RRoudyagacklmLrTUp/Eq47nWQ83lgN2LhsQNEcKwG
         Puqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kq9UxjoERGNW4jksFWUYlqB2PHUw2ML24mY9io35lAU=;
        b=Qq/6SF8vzIqFs3Kbap1FhsWtGSJhl7aKF8qLcmY2NvKsA19xZOMCACVaZ4lvEmai+t
         HLfNLr9viPu+a9g3mGkQwAK4bufvF6H/qXqWgvm12oniO4aUvkL1Cejs6tfMtauoUOZn
         QeIazXxrLZ5bufMfGzgxvd8Dm9ODKcjrFhFk4dEzE5lDXtUdtN3d2m6HMZD1IuhdVvDo
         U3HQ75NwWyiDhnxpf74Sob9bZBZ8X9nrPqnwXoaGT5sVm6cbvRTXOUJvgjGGc7nHntfU
         qE6gw4sWmlsskP227JmLXnTW5+lMLYH90dGwxWcWn8ejHkXh5MlNqrOVS+gZ0kf/08uA
         bx/A==
X-Gm-Message-State: ABuFfojH5M8hv+9OW9BbqWLgcDgMc7ky4W2+rxB9Q0BElLFKG1Wf2Gae
        F3FsnzdSCclyhJ0igqc2ARs2W67FNE39
X-Google-Smtp-Source: ACcGV63wWcWN+l5HkYdmKyDFDiZfoDbEjIoIsUFPtkoOMDTG9u2WBFQQ9KmwI5PYFICzD/YCLR/y1XFjrS98
X-Received: by 2002:a62:a9b:: with SMTP id 27-v6mr15101433pfk.56.1539887923504;
 Thu, 18 Oct 2018 11:38:43 -0700 (PDT)
Date:   Thu, 18 Oct 2018 11:37:56 -0700
In-Reply-To: <CAGZ79kbpXQURMsZY15_k3rJ-dyH0i4qAGDv8umM8Hmx10ZdMMA@mail.gmail.com>
Message-Id: <20181018183758.81186-1-sbeller@google.com>
Mime-Version: 1.0
References: <CAGZ79kbpXQURMsZY15_k3rJ-dyH0i4qAGDv8umM8Hmx10ZdMMA@mail.gmail.com>
X-Mailer: git-send-email 2.19.0
Subject: [RFC PATCH 0/2] Bring the_repository into cmd_foo
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Wed, Oct 17, 2018 at 5:41 AM Derrick Stolee <stolee@gmail.com> wrote:
>> I had one high-level question: How are we testing that these "arbitrary
>> repository" changes are safe?
> [...]
> Or instead we could accelerate the long term plan of removing a
> hard coded the_repository and have each cmd builtin take an additional
> repository pointer from the init code, such that we'd bring all of Git to
> work on arbitrary repositories. Then the standard test suite should be
> okay, as there is no special case for the_repository any more.

Demo'd in this RFC series for git-merge-base.

The core idea is found in patch 1,
and the proof of concept is found in patch 2.

What do you think?

Thanks,
Stefan

Stefan Beller (3):
  repository: have get_the_repository() to remove the_repository
    dependency
  builtin/merge-base.c: do not rely on the_repository any more

 builtin/merge-base.c  | 67 ++++++++++++++++++++++++++-----------------
 repository.c          | 10 +++++++
 repository.h          | 13 ++++++++-
 t/t6010-merge-base.sh |  3 +-

-- 
2.19.0

