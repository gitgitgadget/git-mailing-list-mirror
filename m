Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A7DD20193
	for <e@80x24.org>; Thu, 27 Oct 2016 13:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936445AbcJ0Nzb (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 09:55:31 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:33686 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934542AbcJ0Nz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 09:55:28 -0400
Received: by mail-qt0-f174.google.com with SMTP id p16so14933440qta.0
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 06:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TQ3zo/ZTSfhwYJAEs4jjaLShtWctBgYa4TBbHUDfQ2s=;
        b=UmeOqIEcigC8xFLysclK0CE0aJusY0mEgK72jLwa9UBQ/LebB6wx9Bg9BPUD3+g5rx
         yX8qzh4vc7dR48oztf9hZ303KZP8vwNxa9TUQQApWR4hc1Xy4CTpL+hl1tuqwz7msd9L
         QWAuDadty7V+DBQaNjNOZPiPxGePDgsg09DSTSyf0QTBq0Ts2t3Xah7TTwDNDFqmUFYx
         Ys6ahqkXb8e4FFFuOPh4r0+qSO0de4cwVOCmstEwSduQFbbSNarpEMcfTpyJ+/C5oJzq
         R0Rh5cdqbgT1RtAPanIGtfZY+7e5fSwWGjnFjg5ZmIdLf1ztO4dT3ukwA6PHkNGO6wVs
         0VRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TQ3zo/ZTSfhwYJAEs4jjaLShtWctBgYa4TBbHUDfQ2s=;
        b=UA6r5933au+yaa8OQhoo1ePg1rwJXUe5r7EQeHc+4d3l7TLN5v7U/2H1cVf5KYyIj2
         1TWRFC+qCDVu25TjgJ44M+cwFn9JcD8fsrzBtbCI+CvF2dEbEXriv+SpGmlu/CtzZcgX
         blwOA/e3y/KTGrxSdYha+9zzOPAp/wxsVngfBgn3zHFNQj0290MmFU9kWorxgluVS16e
         IEdwSfXU3CD6kqjczgmimisSPa+waVn3KgPfViMsPPdEt4mFb1IW+i1U4XbRGjTVQOGa
         4YuL3Do/+pqXFnUTAjMQ461RlJl9fOhGcuM18sAGYYq1YqkAgmZlxhiFI6S97c6f7whY
         3hIg==
X-Gm-Message-State: ABUngvdpqcoMB2Vdh31TPNmz+wACn3ZMTKXIAs5NDrEjksps2XErFk1i88YXf4zRGxQ9DYBDx8VlYEg+L5uYtQ==
X-Received: by 10.36.122.18 with SMTP id a18mr5070249itc.99.1477556367095;
 Thu, 27 Oct 2016 01:19:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.5.212 with HTTP; Thu, 27 Oct 2016 01:19:06 -0700 (PDT)
In-Reply-To: <80919456-7563-2c16-ba23-ce4fcc2777de@pelly.co>
References: <80919456-7563-2c16-ba23-ce4fcc2777de@pelly.co>
From:   Alexei Lozovsky <a.lozovsky@gmail.com>
Date:   Thu, 27 Oct 2016 11:19:06 +0300
Message-ID: <CALhvvbYqeWw+q=TPxTpve6JKoy0URYeWxj2vVOnzrA_g3Z3esA@mail.gmail.com>
Subject: Re: Expanding Includes in .gitignore
To:     Aaron Pelly <aaron@pelly.co>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I'm thinking something like ". path/to/include/file" in an ignore file,
> and/or creating .gitignore.d and/or allowing $HOME/.config/git/ignore
> and $GIT_DIR/info/exclude to be directories. Or some sane and consistent
> mixture of these things.

I think the rc.d-like approach with directories is better as it
does not add new magical filenames (what if I absolutely do need
to name my directories ". path", with a space? :) keeping the
syntax of gitignores themselves simple, and allowing us to think
of files as still being separate entities. This can be useful
for the following case:

> In the case of a directory the plan would be to add links to files
> stored/sourced elsewhere. This does pose a precedence question which I
> haven't thought about yet, but probably makes it too hard for the
> limited value it brings.

As I understand, the precedence only matters for negative patterns
(the ones that start with an exclamation mark, !). For example,
suppose you have files 'foo1' and 'foo2'. This .gitignore

    foo*
    !foo1

will ignore foo2, but will show foo1. However, if the lines are
swapped:

    !foo1
    foo*

then both foo1 and foo2 will be ignored.

Now, if we consider the case of multiple .gitignore files, it
could be unexpected and possibly annoying for negative patterns
in one file to affect the patterns added by some other files.
I would find it more conceptually simple to apply individual
.gitignores one by one, as opposed to parsing them all and
creating one giant exclusion rule. (In technical terms, this
means keeping one struct exclude_list for each .gitignore,
not merging them all into one single list.)

In this case there should be no precendence problems as applied
gitignores only add new ignored files, without un-ignoring
anything previously ignored by other files.

However, if we allow textual inclusion, then it means that we
can put a gitignore into our gitignore so that we can unignore
while we ignore, which again brings us the question of whether
it is actually needed and expected.

> I would like to know the desirability/practicality/stupidity of such a
> feature as I believe it is within my skillset to implement it.

In my mind, this feature definitely has utility and it can be
implemented in backwards-compatible way, so why not.

However, I do not recall any precendent of git using rc.d-like
configs. And some can argue that your goal can be achieved by
generating the .gitignore by some external means and symlinking
the result into .git/info/exclude, so this is not Git's problem
and we should not be overcomplicating things with something as
simple as a list exclude patterns. This line of argument also
can be used to opposes any textual inclusion as well, because
it can be expanded into 'why don't we add a Turing-complete
programming language then to specify the patterns to ignore'.
