Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E3171F667
	for <e@80x24.org>; Tue, 22 Aug 2017 19:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752868AbdHVTNY (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 15:13:24 -0400
Received: from mout.web.de ([212.227.15.4]:59644 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752991AbdHVTNU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 15:13:20 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MgwSG-1dxWH909PU-00M25b; Tue, 22
 Aug 2017 21:13:19 +0200
Date:   Tue, 22 Aug 2017 21:13:18 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Ben Boeckel <mathstuf@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Cannot checkout after setting the eol attribute
Message-ID: <20170822191318.GA22118@tor.lan>
References: <20170822174918.GA1005@megas.kitware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170822174918.GA1005@megas.kitware.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:fuSE9WHgXeOasdz2HKnUKtdbUvQb5hTGW2UQC8ejNSuSzoAIrit
 xm0AE5FC9ynmiN+xhTGDA+/6WDgIjkV4f2yaYKSCdQWljuw0i3HQXdXqrqrT6fODMr720/z
 NlbUX4nq+//sBLC8lFdrA6SEvZFXWpVwuCH0TorSkaZ4U7Z8v+B7Vn/n+Dtc9PtCWqvwTTe
 mVGEjNP0Ud4wk8cXjQUcw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bhfaOy4Xjqc=:yumcrsoiAr//V9QHij0maV
 JQVfTRXK0Zc+H+nQgPbV78RLnYcQdHjWkjYAzoL+0PRjFreO0rwX5s+GE8UW9nNHVJ4+UgvQS
 FEPlDVFZ+CSZykIrbaYMbcGr908FcG9v9aWDesQX0qykU+BhIuehCjp5/NfE9zvVhcUFSGSji
 9um6obMUi2pDduYLaqRSfTWnSWsEiTDV8Zw24C2KH6cdzq++LqGr4YxDafLUx4koIWVESzFtV
 Ok7ia2xyKD1BUVy/tebqecGF6bTEM5yJRN+kuGl+VyyyebE1SP8LruQyNo0DPMy5/Lkczd3Rm
 vU8V7rQvJuFcQ0JFB4JZXc3lm8YrPJzHDu7gT/OO2ITZsYNVwX7qpsXZS4ofCTcCTjYkUZFmV
 Jj934GcmAs70DmlBLyW5rOTuQDztdzSRyN34fduI+hr2P1GiNTL83qf/XUpyzi0HJOqml4aDg
 afqmqot6con9SskVeJR+FOvBTU8XrUSJlW7ni0d2o+tYCDhEh2pe+S/YUkN/oX7SnQyUqm5Nz
 VKUzu2Rhf9sKIC8YtHYlwhIatxjO3z9SzgykwFgXm8aAovVNQqA3vElAUr5Ok4hU0C9aaLRz5
 WmXqozJMGIr2OPKxxs10W2e4zYunX5EkdOkmjDveGFwCDBV9pT6X8rm352H1nCb4DiVg/4fjx
 ybbFh5qJjF8voPVnYGn58oNoXb460siyIcYWPJBPlKKt40EWZtviouC41Pe8UkGQFfAwkWTSg
 iyEqMOZzTM4NYoApMPQy98GCzK8eLopMl9SKQtfPdBmMonMF7PFFHoe1EAToAecNRJ1+DToMj
 ja8B43m0UZaOpK2LUFsLxvnNfC2Gw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 22, 2017 at 01:49:18PM -0400, Ben Boeckel wrote:
> Hi,
> 
> I specified the `eol` attribute on some files recently and the behavior
> of Git is very strange.
> 
> Here is the set of commands to set up the repository used for the
> discussion:
> 
>     git init
>     echo $'dos\r' > dos
>     git add dos
>     git commit -m "dos newlines"
>     echo "dos -crlf" > .gitattributes
>     git add .gitattributes
>     git commit -m "add attributes"
>     echo "dos eol=crlf" > .gitattributes
>     git add .gitattributes
>     git commit -m "set eol attribute instead"
> 
> The following behaviors are observed:
> 
>   - `git reset --hard` does not make the working directory clean; and
>   - `git rebase` gets *very* confused about the diffs in the working
>     tree because `git stash` can't reset the working tree;
> 


> There are probably other oddities lingering about as well. If I commit
> what Git thinks is the difference, the diff (with invisibles made
> visible) is:
> 
>     % git diff | cat -A
>     diff --git a/dos b/dos$
>     index fde2310..4723a1b 100644$
>     --- a/dos$
>     +++ b/dos$
>     @@ -1 +1 @@$
>     -dos^M$
>     +dos$

Thanks for the goos example!
This is by design.

When you set the text attribute (in your case "eol=crlf" implies text)
then the file(s) -must- be nomalized and commited so that they have LF
in the repo (technically speaking the index)


This is what is written about the "eol=crlf" attribute:
	This setting forces Git to normalize line endings for this
	file on checkin and convert them to CRLF when the file is
	checked out.
And this is what is implemented in Git.

Long story short:

The following would solve your problem:
   git init
   echo $'dos\r' > dos
   git add dos
   git commit -m "dos newlines"
   echo "dos -crlf" > .gitattributes
   git add .gitattributes
   git commit -m "add attributes"
   echo "dos eol=crlf" > .gitattributes
   git read-tree --empty   # Clean index, force re-scan of working directory
   git add dos
   git add .gitattributes
   git commit -m "set eol attribute instead"
   git ls-files --eol


> 
> Seen in 2.9.5 and 2.14.0.rc1.
> 
> --Ben
