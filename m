Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EEEB1FAA8
	for <e@80x24.org>; Tue, 16 May 2017 19:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751855AbdEPTbg (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 15:31:36 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:35521 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751571AbdEPTbf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 15:31:35 -0400
Received: by mail-vk0-f51.google.com with SMTP id h16so71655487vkd.2
        for <git@vger.kernel.org>; Tue, 16 May 2017 12:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=wxFwgcLxVO0Zx7LIeyXyYNADMThZIuaUf50Tt7tezfw=;
        b=lio+DMalXRyolONHFKI3uV+wSpoy6qIPbYVEr8q997A9CNp6/f2VtdOSRQgBFyZRUk
         mMSwjog2PROQ/8pcJtKk+P1OaSiiPi5LVvhlnntRYaMRot/NUt71+Q9QFMW9bFM9EQJ/
         RgSgsgHkkuGyT5QQaEmsciIkjXRF0l2QvdBwTYzjPu2Lr3AwWk2vc3vlZql2KH43kzBX
         XcZqHaw0D2gDGRiaX+XrmobIuaRLUdgQ87I7xie9n07bTK8+kZ4lIk2+3kLE/Cs5ya4a
         BKrH4BU3qtaizz9/ZOY/jG23l85b8rry6f50/6jf9JPWhGTeM5KaNSa9Zwq4r+jv7YNr
         sPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=wxFwgcLxVO0Zx7LIeyXyYNADMThZIuaUf50Tt7tezfw=;
        b=MjFzL8TdI8SS86GEbb+OC7nokV34jNl2rfyHG1u8XEHSowVEUUS7tCkjHuEZyCQ9xT
         R30ynI/4jWEqpqCo3JkwqtDFGREFjpltbYCrV8SeST2UQEqpAxrWVybEw7j2FtAmAJAL
         ysjXy1gIQZbUJV1c1ERTPykIh1uE0GPGayHNjI/kOQCIVxT488loZRXIM4bVsWu34wNW
         hcdphCB+b0yBJ9+QmoXecLycEP33ZjpYtlEw4DoQwF2Lrv23+3fcyVov7bGJb3xjy5K8
         XEa5GB5w8OEOdBsegwPk7kFKWAJE3lbHWMrlz4+0JXqsMssrfKVZFUqxI1Z/1MUvDrwi
         cjJQ==
X-Gm-Message-State: AODbwcA8V+zS9/UFkx2Mury46N+AeDATQY2bYIT8p97qxb4hKy2pZG3A
        5b0dHlTuePW+1GlqtaG1L1NiO3HnV+u1
X-Received: by 10.31.188.21 with SMTP id m21mr6207230vkf.81.1494963094143;
 Tue, 16 May 2017 12:31:34 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.159.55.163 with HTTP; Tue, 16 May 2017 12:31:33 -0700 (PDT)
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Tue, 16 May 2017 14:31:33 -0500
X-Google-Sender-Auth: LFA2tsoulXT1hwG65JEd5LUbMY0
Message-ID: <CAHd499ADTbO09OJhH_wWBbAcXZeLRLFAqOw5eTe6=abN-JUrUA@mail.gmail.com>
Subject: Diff topic branch + working copy changes?
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So for a topic branch based on master, I can diff ONLY my changes on
the topic branch by doing this simple command:

$ git diff origin/master...

However, this does not include uncommitted working copy changes. To
work around this, I can do this instead:

$ git diff origin/master

(No three-dot notation above)

However this implies a ".." notation which will include changes on
master that have been made after I branched my topic (I use three-dot
to exclude those).

Is there a way I can do the first diff but also include working copy
changes? The reason I'm wanting to do this is because with difftool in
particular I like to make changes on the "right" side of each diff and
have those changes carry over to my working copy as edits I can
commit. This doesn't always work, especially if those same files are
already modified in my working copy but not committed.
