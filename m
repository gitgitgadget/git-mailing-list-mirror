Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A4D81FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 19:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755244AbdBGTWQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 14:22:16 -0500
Received: from mail-ot0-f182.google.com ([74.125.82.182]:33083 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754585AbdBGTWN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 14:22:13 -0500
Received: by mail-ot0-f182.google.com with SMTP id 73so94063409otj.0
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 11:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=KEEcp7nUEtDjjFbYi+2eNCEXFPVRnmROEvyXVENSpkM=;
        b=G1Xo2xyis6lamMPzaU2qG+7r/755kBn79O5qFAlhHH0pQffLZwEtIsv/WAmIZUW4ef
         bhGaopNBSokvU2HmUvtuSM0wgZ5RSkzCYykfXd58qN0M9WsRZk6P8ClJ6iac1C2ml3ao
         JhuC8cidOVgVy9IjEYpFe+tp4+SPE3gxacOVRy41nG8j4FY17K6NmjEBLt91+AJRzMNU
         nlWg6du55vj4uijJ/4lGeHUyzJh4WuQ8gepXKW0hEgjuSHmsR1zJkQwg4gzgBuCOjjaA
         AiTgldg3FYETULabKTql5/bcQMojXKg2IP7nxytTQfNdcCQklyrjKrEC0TThpw4bIT2T
         rg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KEEcp7nUEtDjjFbYi+2eNCEXFPVRnmROEvyXVENSpkM=;
        b=d8SKljbKEMPUSXk9IN3lTurJajM7BZlGnvlewywtzyadCJgbKOee4I4XjlxgOIEXQs
         oRf9HQgxIJCLUWyNd82uCmvemI/zhbaqEZWKE8kegm27JZA3OJJFfXhaCUXYURlfeybE
         lqniCSvPebXHpsygma/KiRWq1+sWK3V/Z4Lz25Rqm4gVvyzXd/Lz4LdpsuyFai2+TQsG
         ueY8CJ4kqDbKmV04FgpSYwSQ5BGwj34IkDtcaab3xDVN4LX52w/mwd0jNhfjO6C5gObc
         x3xGMAs8E2jzMbJQYOBz1iClDDwtkofiDTOnjiVDHsTvREu5FbE2fx/4aG323p9aHe6l
         L1ww==
X-Gm-Message-State: AMke39n2Z+5+J7Q7DKlyzethzOh1jydDcDJfLogsUsdAWvPdUE8kMEQpjTZosraa5f+WiMf8VgBff+2TEWrOQw==
X-Received: by 10.157.51.19 with SMTP id f19mr9614992otc.18.1486495273638;
 Tue, 07 Feb 2017 11:21:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.13.38 with HTTP; Tue, 7 Feb 2017 11:21:13 -0800 (PST)
From:   Jack Adrian Zappa <adrianh.bsc@gmail.com>
Date:   Tue, 7 Feb 2017 14:21:13 -0500
Message-ID: <CAKepmajNz7TP_Z6p_Wj17tOpiMOpKkvQOBvVthBkEiKabAppjg@mail.gmail.com>
Subject: Trying to use xfuncname without success.
To:     git-mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm trying to specify a hunk header using xfuncname, and it just
doesn't want to work.

The full question is on SO here:

http://stackoverflow.com/questions/42078376/why-isnt-my-xfuncname-working-in-my-gitconfig-file

But the basic gist is that no matter what regex I specify, git will
not recognise the hunk header.  Am I doing something wrong or is this
a bug?

For those who don't want to jump to the SO site, I've copied the text below:

-----8<--------8<--------8<--------8<--------8<--------8<--------8<--------8<---

I'm trying to setup a hunk header for .natvis files. For some reason,
it doesn't seem to be working. I'm following their instructions from
here, which doesn't say much in terms of restrictions of the regex,
such as, is the matched item considered the hunk header or do I need a
group? I have tried both with no success. This is what I have:

[diff "natvis"]
    xfuncname = "^[\\\t ]*<Type[\\\t ]+Name=\"([^\"])\".*$"

I've also added to my .gitattributes file (even though I'm not
positive that it is necessary):

*.natvis diff=natvis

I've tried \t instead of \\\t as well as replacing the entire regex
with just <Type.* with no luck. I'm using git version 2.7.0.windows.1
on Windows 8.1. EDIT: I upgraded to git version 2.11.1.windows.1 on
Windows 8.1 and even tried git version 2.8.3 on cygwin64 on Windows
8.1 with the same results.

As a test file, I have the following test.natvis file:

<?xml version="1.0" encoding="utf-8"?>
<AutoVisualizer
xmlns="http://schemas.microsoft.com/vstudio/debugger/natvis/2010">

  <Type Name="test">
    <Expand>
      <Item Name="var">var</Item>













      <!-- Non-blank line -->
      <Item Name="added var">added_var</Item>


      <Item Name="var2">var2</Item>
    </Expand>
  </Type>
</AutoVisualizer>

with the <Item Name="added var">added_var</Item> being the new line added.

I'm really not sure why this is so difficult.

EDIT:

Here is a sample output of what I am getting:

$ git diff --word-diff
diff --git a/test.natvis b/test.natvis
index 73c06bc..bc0f549 100644
--- a/test.natvis
+++ b/test.natvis
@@ -18,6 +18,7 @@


      <!-- Non-blank line -->
      {+<Item Name="added var">added_var</Item>+}


      <Item Name="var2">var2</Item>
warning: LF will be replaced by CRLF in test.natvis.
The file will have its original line endings in your working directory.

Even using xfuncname = "^.*$" I would have expected that <!--
Non-blank line --> would have shown up as my hunk header, but I get
nothing. :(

EDIT:

I've tried the solution proposed by torek, but to no avail. It's like
it doesn't know what to do with the xfuncname entry. :(
