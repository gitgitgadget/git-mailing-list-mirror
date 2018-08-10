Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90A131F404
	for <e@80x24.org>; Fri, 10 Aug 2018 18:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbeHJVOu (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 17:14:50 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:50836 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbeHJVOt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 17:14:49 -0400
Received: by mail-qt0-f202.google.com with SMTP id e14-v6so7913986qtp.17
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 11:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=O9A1zsdmRGCLSCWEMYnwA0A8lEMY9G6IhIVViLn33Ig=;
        b=NYfZDZLTivVsL9cVEf/K6k/3lWdy849Su7QWjTQcVPmT4sXxw7f2xLMV4xdPKhMRih
         YSBk8+TnXXhBAZJAVsEU/qEiHgy/p104FcP4BGsMgFVOr8QszZzhBUZPKjvr1tZdDbAo
         yJCIgVuUaMosd2DWkDKd/l5eOcG4b78DLEiX4waTLONcUrOstt/wWDSQazze1yDaCi2V
         QqtfXj+UCbpRkOiOy/zxslwU4OiBw5sYNoa09nmZIuesrlouVeiPW3Qm7CnaZljccVei
         +KmRnbZ9k6aTCQwaxbmTShL/vGYSKQsyWhq4oOZxw/7FSuakIVN7/ph9S+/1bnFYJJI6
         gzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=O9A1zsdmRGCLSCWEMYnwA0A8lEMY9G6IhIVViLn33Ig=;
        b=KMBmDXALOpRShduECAae52yNUowsHAhdAKZ1uDNRxtEqOvbB98gJNI7uHhb+yl1AD0
         cvxeBEj2/aEc/Sx7cWLfX1aZgW1enXu7BJu3zF1v8M5zs+F6Z4Q7/LHyuetZCPs8QlPu
         /QcwYqp2PudMSOP9HZqNqTP2H5yvQ4lcQyfNltxcpCWB2y6L3/uhjeLYoaOS60mA9C+r
         QKEhBJzc7ZrLJM7XYb3H9Qqg1GFOwQ+1mvyI84Zy76BNnnt1+HMWm2zaw9FAMhC+8m0o
         Qvbk9kt+LiJCoa9ALZZNd6jVyfSpYjArthMEEMzNjaOwpBirIB+DUV2HA7flC4+NlRbm
         IedQ==
X-Gm-Message-State: AOUpUlHX8Ct2mABX1TqbuBEN+8/sojBH3CHbG19G173zpYCNOKSxkbbC
        R7lprP2dLvJ2c0IWonAy44Sr2yIF+kzCT7S1E6lE
X-Google-Smtp-Source: AA+uWPwSS23ndGAY3ApaNdXHBWnhd510x8/qR/cXY//XGVLCLSSB1O1iJic8FC5h6TeJ1O1DIMVAEzHAjSbCvXnpr133
X-Received: by 2002:a0c:9e55:: with SMTP id z21-v6mr3792904qve.16.1533926625690;
 Fri, 10 Aug 2018 11:43:45 -0700 (PDT)
Date:   Fri, 10 Aug 2018 11:43:41 -0700
In-Reply-To: <87799036f82793b691e899bda4fb882a4b231c3a.1533854545.git.matvore@google.com>
Message-Id: <20180810184341.208183-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <87799036f82793b691e899bda4fb882a4b231c3a.1533854545.git.matvore@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: Re: [PATCH 1/5] revision: invert meaning of the USER_GIVEN flag
From:   Jonathan Tan <jonathantanmy@google.com>
To:     matvore@google.com
Cc:     git@vger.kernel.org, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Abandon the previous approach of mutating all new objects implicitly in
> add_pending_object by inverting the meaning of the bit (it is now
> NOT_USER_GIVEN) and only setting the flag when we need to.
> 
> This more accurately tracks if a tree was provided directly by the user.
> Without this patch, the root tree of all commits were erroneously
> considered to be USER_GIVEN, which meant they cannot be filtered. This
> distinction is important in the next patch.

After rereading this patch, I think the thought process is:

 - the existing code inaccurately makes root trees of commits USER_GIVEN
 - instead of trying to fix that, it is easier to invert the meaning of this
   flag, and since we only need to track trees and blobs, let's do so in this
   patch

So a better commit message might be:

  revision: mark non-user-given objects instead

  Currently, list-objects.c incorrectly treats all root trees of commits
  as USER_GIVEN. Also, it would be easier to mark objects that are
  non-user-given instead of user-given, since the places in the code
  where we access an object through a reference are more obvious than
  the places where we access an object that was given by the user.

  Resolve these two problems by introducing a flag NOT_USER_GIVEN that
  marks blobs and trees that are non-user-given, replacing USER_GIVEN.
  (Only blobs and trees are marked because this mark is only used when
  filtering objects, and filtering of other types of objects are not
  supported yet.)

The patch itself looks good to me.
