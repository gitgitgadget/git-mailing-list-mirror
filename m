Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DA6E1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 13:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732035AbfHZNvS (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 09:51:18 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35441 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731873AbfHZNvR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 09:51:17 -0400
Received: by mail-ed1-f67.google.com with SMTP id t50so26637764edd.2
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 06:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yN9pv+Bexip0pjaI3Bl6Xc+ADXSQuN5sve4WWDV3y88=;
        b=N+fdym4r/4+BQZmMwfqRis/AFZpdYnpdDixuRdZuoK/D1IAYpM6KrCYLIyQ4uEzkwP
         AdOUe667eekG3ynV+MEWMRXhnewkcUPIyqyQpaQQYIjbZHwJeZibKfTT0Mv7GrVCmtA8
         7vRZyy/lj/RRYDKWN5HLwfOj3C6GQ2SvANQVrDmUg1NNx47fZV+bzluvuThgzcMpyPz2
         NyAz8uuwZ9qkWlgzsvYnwP8AJF3bBgTa4ZPnp55jwBYYjjK7aETFVi8k9acpd2TARTyR
         +usncx+ssBXEG2NfZEZaFO/fy7omWoXmGN7LpW+DZBeBBwkqC2lbrvGKffZKbXpJYuoH
         yYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yN9pv+Bexip0pjaI3Bl6Xc+ADXSQuN5sve4WWDV3y88=;
        b=Og6i+fOLqZ3zGXbr9ZKwws6xjziF+7DZzOjK10txJvM3bXcRn5xSXu3fviTonJLmXR
         OGZlJRl1/+3tjOVrW24o/4ZAR/gqeU/ZuqrOKJjat7FuR8zctWHI7+PA7T/f8AnFlK9j
         F3LfZvt1q27hsae41UPNyh4QnSHd7RtuplXCcoAe1C2X1RJ3tSBjuiXqK0cI1AaIFJpd
         28jUgdkMZpfG2UlFczm17bDI5rVX2NcyTupnZWk1VuNj1/emRdhJsXfUXBTJOAAWPDeh
         u0zn1wawxgNhodVVXU+sbCgx+4Fb+Et9gxN92J+q+eAfr3UGIE0F2NIuaDTzhwe9wDj6
         6Jtg==
X-Gm-Message-State: APjAAAWGubsKo/HBMnTZOWmUaeA+pjdz8fnFijYNrFGmlahKbViCpybY
        IPjRzKZKQTfr10RV1j4450lPtEgiN0PEGvlEQUsE0SnJNQc=
X-Google-Smtp-Source: APXvYqyHsl8+6GlKjD9bfONOA5XRih5fCXIpDFvW9L2ZL0Q/YMImyDmaAxNdpvnFTkQck0hIDsJGS2sLT44G3SDUZsk=
X-Received: by 2002:a50:fc8c:: with SMTP id f12mr18855031edq.191.1566827475887;
 Mon, 26 Aug 2019 06:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.303.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.303.git.gitgitgadget@gmail.com>
From:   Git Gadget <gitgitgadget@gmail.com>
Date:   Mon, 26 Aug 2019 15:51:06 +0200
Message-ID: <CANg4QoGSVQWG3QXzoiA8oDsjXaXGoZ+WMNLSPpu75eJWdrWxLQ@mail.gmail.com>
Subject: [PATCH 1/1] git-p4: auto-delete named temporary file
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Philip.McGraw" <Philip.McGraw@bentley.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Philip.McGraw" <Philip.McGraw@bentley.com>

Take new approach using the NamedTemporaryFile()
file-like object as input to the ZipFile() which
auto-deletes after implicit close leaving with scope.

Original code produced double-open problems on Windows
platform from using already open NamedTemporaryFile()
generated filename instead of object.

Thanks to Andrey for patiently suggesting several
iterations on this change for avoiding exceptions!

Also print error details after resulting IOError to make
debugging cause of exception less mysterious when it has
nothing to do with "git version recent enough."

Signed-off-by: Philip.McGraw <Philip.McGraw@bentley.com>
---
 git-p4.py | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index c71a6832e2..33bdb14fd1 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1160,13 +1160,11 @@ def exceedsLargeFileThreshold(self, relPath, contents):
             if contentsSize <=
gitConfigInt('git-p4.largeFileCompressedThreshold'):
                 return False
             contentTempFile = self.generateTempFile(contents)
-            compressedContentFile =
tempfile.NamedTemporaryFile(prefix='git-p4-large-file', delete=False)
-            zf = zipfile.ZipFile(compressedContentFile.name, mode='w')
-            zf.write(contentTempFile, compress_type=zipfile.ZIP_DEFLATED)
-            zf.close()
-            compressedContentsSize = zf.infolist()[0].compress_size
+            compressedContentFile =
tempfile.NamedTemporaryFile(prefix='git-p4-large-file', delete=True)
+            with zipfile.ZipFile(compressedContentFile, mode='w') as zf:
+                zf.write(contentTempFile, compress_type=zipfile.ZIP_DEFLATED)
+                compressedContentsSize = zf.infolist()[0].compress_size
             os.remove(contentTempFile)
-            os.remove(compressedContentFile.name)
             if compressedContentsSize >
gitConfigInt('git-p4.largeFileCompressedThreshold'):
                 return True
         return False
@@ -3514,8 +3512,9 @@ def importHeadRevision(self, revision):
         self.updateOptionDict(details)
         try:
             self.commit(details,
self.extractFilesFromCommit(details), self.branch)
-        except IOError:
+        except IOError as err:
             print("IO error with git fast-import. Is your git version
recent enough?")
+            print("IO error details: {}".format(err))
             print(self.gitError.read())

     def openStreams(self):

--
gitgitgadget
