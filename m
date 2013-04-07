Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 4106 invoked by uid 107); 7 Apr 2013 18:02:55 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.84) with ESMTP; Sun, 07 Apr 2013 14:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934183Ab3DGSA6 (ORCPT <rfc822;peff@peff.net>);
	Sun, 7 Apr 2013 14:00:58 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:39696 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934146Ab3DGSA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 14:00:58 -0400
Received: by mail-la0-f43.google.com with SMTP id ek20so4758939lab.30
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 11:00:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=IE9exr42gieOqIQpl+uvCRL28Mif6dr6oOsq0mQdoGE=;
        b=YB8KbxFsg81J4GzH1hzexfwHjuKGarIDzj6vFG1Ndxi6LvgmB5xt72/Skx9MqxKk1d
         Hc+RDCEtK/Ykr0m8Gkwg297CUiUGdJVScaZ/TT3YnXNRt0EzoKSZdyBR6qWnW2ZUTGan
         NHymL/f2CwEd4ALsGaL75DEZK/yc1/MRhLzq/bt2Z9crMalSdx7EMKD4lOvcpJzbmjFu
         ZeBmqkZ8HqhXc3Q5L6QnU6ZyP+NJU0b6RET/mfcUIedSBkikYlx/Ccer1QkcnlhoGrXr
         2yDbjIulkJst2KXSOLvSbnFNu9DoCUShUzHajjH3uWc3wAkC1DLdMrpAp/gSobTIJkhW
         eobg==
MIME-Version: 1.0
X-Received: by 10.112.138.5 with SMTP id qm5mr947218lbb.2.1365357656340; Sun,
 07 Apr 2013 11:00:56 -0700 (PDT)
Received: by 10.114.92.105 with HTTP; Sun, 7 Apr 2013 11:00:56 -0700 (PDT)
Date:	Sun, 7 Apr 2013 11:00:56 -0700
Message-ID: <CAPKkNb43bWupbOaAntF8VJQ8ZJjt8SG-mZa3GohxZEAZQm-evQ@mail.gmail.com>
Subject: git-am doesn't apply the rest of the email after a partial patch fail?
From:	"Constantine A. Murenin" <mureninc@gmail.com>
To:	git@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

I'm trying to convert/rebase about 40 local patches from an old
mercurial fork of OpenGrok (upstream used to use hg), to the new git
repository (upstream has recently switched to github).

What I decided to do is convert my old mercurial repo to git (by
pushing with py-hg-git to a git repository, and then checking out with
git), and use `git format-patch` from an old .hg-git.git repository,
and then use `git am` on the new (upstream git) repository of the
`format-patch` mails from an old one.

However, what I've faced with, is that when a conflict happens, and I
resolve, and do `git add`, and `git am --resolved`, then the rest of
the `format-patch` email where the conflict has occurred is discarded,
and the subsequent patch/email now doesn't want to apply either, since
all of the previous patch/email is missing, other than the manually
added changes.

What gives?  Does `git am --resolve` discard the rest of the mail, if
any patching errors occur?  Is one supposed to apply the whole
`format-patch` email manually when `git am` does encounter some
problem with only some minor parts of that email?

% git --version; uname -rms
git version 1.7.6
OpenBSD 5.2 amd64

C.
