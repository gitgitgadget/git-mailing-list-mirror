Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C60D2035F
	for <e@80x24.org>; Wed, 31 Aug 2016 20:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759800AbcHaUlt (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 16:41:49 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:36699 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753487AbcHaUlf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 16:41:35 -0400
Received: by mail-it0-f49.google.com with SMTP id i184so31523490itf.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 13:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redfrontdoor-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=sPqdvE8/+cHeM7MrIa/Z48F8ngxjTdSV51VXt4MOIh4=;
        b=DSSktPkGRml8GGc4oKBgpx2+3MjqKd+9kpNyrlKWXO3Q3dm1Qc4EHqoBtYsXOpmNTv
         u7pqt4a0Ybbguw+Tf4KUSmuOPLnc3CH5dr+wJnZYhHYOYEFRt6bStMS6N5ypFNLJt3K5
         QAkVHq7WtCnhGaLUQJRzKDVptzFC93JdcgCqgs8Wn1vG00+H3BdTnaowBWgr62ITPKUt
         7DfVyrU9pmVMsUwa0c9mblhcctzFVcp63celW5DMXPULMstxKzEdYYyyXot5aOlE9Rjg
         zwghAFpvZDHpoAqm5+SajmOV5nm9uO07W4EOc2wNHUkyM/0Ug1gEhksMfX/hT8StreYZ
         Nqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=sPqdvE8/+cHeM7MrIa/Z48F8ngxjTdSV51VXt4MOIh4=;
        b=Uqgj5uH5lVCTQOR/+yyVEbO9OkhBK20PcPk4niNYX4LjHuurx53oGleoJClAdlhUWq
         EO5iwvnEqbC4qpmxW9x4u8v7dYNUli1zFbXlLx0NcW8ySekJmziEDOHEmUe3Emvniw/S
         aDcoJMBW8VApsGld5oMWZQMG2fjztr0AAsuaUcWdd2J5gjmYnCcab0BhLovhBAlCzA6f
         Haq1qnl6PuSN9e+TdC4glpAd5HO7MccZUqA8pkXfL6uAT5h0nvkkTRrqi3gkJHcLlG5N
         9vDO9yOxj6sagd8rmZ8RZg35moI7jWqarxMFAJ0Fkr8Hx1MaRwKHWroYUU7eAlqGMW3Z
         /ZkQ==
X-Gm-Message-State: AE9vXwOlSYdtrZ3fs2OVhgPbKxAxb5aF3bJuOSP++Zdish29r5Wy3Xj+ZjBol1k1EIFCcRNb2VnZOYW9p7nFvA==
X-Received: by 10.36.23.142 with SMTP id 136mr16408994ith.73.1472676093984;
 Wed, 31 Aug 2016 13:41:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.17.207 with HTTP; Wed, 31 Aug 2016 13:41:33 -0700 (PDT)
From:   Ben North <ben@redfrontdoor.org>
Date:   Wed, 31 Aug 2016 21:41:33 +0100
Message-ID: <CAHG0eJVk6HF5Mz3wz08sjgL05zB4cAjmZ=FR=jf5G4kh-ChV8A@mail.gmail.com>
Subject: Literate programming with git
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've recently been experimenting with using git to make software more
human-readable.  Presenting software for humans to read is not a new
idea (Knuth's 'literate programming'), but I think git can be a new
tool for showing the development of code in a structured way.
Merge-commits can break a flat sequence of commits into sections and
subsections, in the same way that a document's paragraphs are
arranged.  The hierarchical organisation is helpful when reading the
history, and also allows that history to be rendered into a structured
document explaining the code's development.

As a demo, I've created:

    http://www.redfrontdoor.org/20160813-literate-git-demo/index.html

This was generated directly from the git repo of the project, using
tools I wrote:

    https://github.com/bennorth/literate-git

For working with hierarchical git histories, I wrote another tool:

    https://github.com/bennorth/git-dendrify

The READMEs of the two projects give more details of these ideas.

This is at the prototype / proof-of-concept stage --- any feedback welcome!

Thanks,

Ben.
