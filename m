Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D23B1F461
	for <e@80x24.org>; Wed, 28 Aug 2019 08:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfH1Ieb (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 04:34:31 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56154 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfH1Iea (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 04:34:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id f72so1785294wmf.5
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 01:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gw1SnnRU6t7gZK5mqsmqgUdYUhb7ONjmJwMdIZly1eo=;
        b=gkwalmLNOLJNYvwj/rdMH5Gt9F53/SEnvtFh8qZBFh0PWRkYG1GFceVK5BhRlvCzU+
         XIlAp5gjm54Df4Z60TESjwxJWNvmbCkGeIQKadjeGU2W80ASuyNlHnTkIBxomKVpoGAo
         OlA0yU7molbdQdwFpOYCG+FdRWMaRGtpYEec0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gw1SnnRU6t7gZK5mqsmqgUdYUhb7ONjmJwMdIZly1eo=;
        b=bO0R+FLRqhzMjsFoFOzoNzxH8EqXU0Hg6GdGJdHtFeviTGrsMCyPf4Wv3Jc3g/yqwE
         uRsLdjSfmKHT/BLU2F7aYdA5i0FLwIQfU2vQTpHOhacRcWSlDYyzRS9UeqzbGNjrwn1f
         DVMK+6wsPayB5+zyXQrieFDojvBmAGVJellFYxH38EGa8F7r16han+Um749uHf4nKh4S
         OC55z9V6cBmKMMKBPveEMPTtH0EzpE1dt1vvYQS4ETtSk3w/HFsiK4/YFNKvOjR6o7AR
         wOydYV/1kkoW+VPtIQAE994Bgf/EAPO02CUNDSBtP5BJltIsvKPT3CStvwk62lVCX4G1
         zrxQ==
X-Gm-Message-State: APjAAAW4a3KVO9ZyUiydBfXeF3HWi1kbKZodQh+CagpXsOjCwrESOtIB
        tVla5Pkl65fPDo6o1VWqFvI7pcSeHlOhVr2giAHk0Q==
X-Google-Smtp-Source: APXvYqz6ASpPn2wb9EaysxYgpC4qkkJx/fMbdoW7CkEUkl6njzrXP80c8CGbbkwu5gEEpnteqkTEw1NT4EiLpWHW3As=
X-Received: by 2002:a05:600c:21d8:: with SMTP id x24mr3241625wmj.11.1566981268476;
 Wed, 28 Aug 2019 01:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.303.v2.git.gitgitgadget@gmail.com> <7e59b5cec2f267820feeeeb63a20814fe67d61e3.1566876175.git.ahippo@yandex.com>
 <xmqq1rx62qbe.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1rx62qbe.fsf@gitster-ct.c.googlers.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Wed, 28 Aug 2019 09:34:17 +0100
Message-ID: <CAE5ih78iSO+yu0KC8gg450iv5iY1gJusN33uatFdRgp_1ToALw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] git-p4: auto-delete named temporary file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andrey Mazo <ahippo@yandex.ru>,
        "Philip.McGraw" <Philip.McGraw@bentley.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Andrey Mazo <ahippo@yandex.com>,
        Git Users <git@vger.kernel.org>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 27 Aug 2019 at 23:31, Junio C Hamano <gitster@pobox.com> wrote:
>
> Andrey Mazo <ahippo@yandex.ru> writes:
>
> > From: "Philip.McGraw" <Philip.McGraw@bentley.com>
> >
> > Avoid double-open exceptions on Windows platform when
> > calculating for lfs compressed size threshold
> > (git-p4.largeFileCompressedThreshold) comparisons.
> >
> > Take new approach using the NamedTemporaryFile()
> > file-like object as input to the ZipFile() which
> > auto-deletes after implicit close leaving with scope.
> >
> > Original code had double-open exception on Windows
> > platform because file still open from NamedTemporaryFile()
> > using generated filename instead of object.
> >
> > Thanks to Andrey for patiently suggesting several
> > iterations on this change for avoiding exceptions!
> >
> > Also print error details after resulting IOError to make
> > debugging cause of exception less mysterious when it has
> > nothing to do with "git version recent enough."
> >
> > Signed-off-by: Philip.McGraw <Philip.McGraw@bentley.com>
> > Reviewed-by: Andrey Mazo <ahippo@yandex.com>
> > ---
>
> Luke, does this look good?
>
> I know Mazo is the only other contributor who has multiple commits
> to git-p4.py in the past 2 years, to make Reviewed-by carry some
> weight ;-) but as we have so small number of people touching this
> script anyway, I'd rather see what the main contributor in the past
> 2 years thinks.

I think it looks reasonable.

Ack.


>
> Thanks.
>
> >  git-p4.py | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> >
> > diff --git a/git-p4.py b/git-p4.py
> > index c71a6832e2..33bdb14fd1 100755
> > --- a/git-p4.py
> > +++ b/git-p4.py
> > @@ -1158,17 +1158,15 @@ def exceedsLargeFileThreshold(self, relPath, contents):
> >          if gitConfigInt('git-p4.largeFileCompressedThreshold'):
> >              contentsSize = sum(len(d) for d in contents)
> >              if contentsSize <= gitConfigInt('git-p4.largeFileCompressedThreshold'):
> >                  return False
> >              contentTempFile = self.generateTempFile(contents)
> > -            compressedContentFile = tempfile.NamedTemporaryFile(prefix='git-p4-large-file', delete=False)
> > -            zf = zipfile.ZipFile(compressedContentFile.name, mode='w')
> > -            zf.write(contentTempFile, compress_type=zipfile.ZIP_DEFLATED)
> > -            zf.close()
> > -            compressedContentsSize = zf.infolist()[0].compress_size
> > +            compressedContentFile = tempfile.NamedTemporaryFile(prefix='git-p4-large-file', delete=True)
> > +            with zipfile.ZipFile(compressedContentFile, mode='w') as zf:
> > +                zf.write(contentTempFile, compress_type=zipfile.ZIP_DEFLATED)
> > +                compressedContentsSize = zf.infolist()[0].compress_size
> >              os.remove(contentTempFile)
> > -            os.remove(compressedContentFile.name)
> >              if compressedContentsSize > gitConfigInt('git-p4.largeFileCompressedThreshold'):
> >                  return True
> >          return False
> >
> >      def addLargeFile(self, relPath):
> > @@ -3512,12 +3510,13 @@ def importHeadRevision(self, revision):
> >          details["time"] = res["time"]
> >
> >          self.updateOptionDict(details)
> >          try:
> >              self.commit(details, self.extractFilesFromCommit(details), self.branch)
> > -        except IOError:
> > +        except IOError as err:
> >              print("IO error with git fast-import. Is your git version recent enough?")
> > +            print("IO error details: {}".format(err))
> >              print(self.gitError.read())
> >
> >      def openStreams(self):
> >          self.importProcess = subprocess.Popen(["git", "fast-import"],
> >                                                stdin=subprocess.PIPE,
> >
> > base-commit: 1feeaaf26bff51996f9f96c6dc41ca0f95ab5fc4
> > Pull-Request: https://github.com/gitgitgadget/git/pull/303
