Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE19C1FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 19:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754600AbdCaTof (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 15:44:35 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33427 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753702AbdCaToe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 15:44:34 -0400
Received: by mail-lf0-f65.google.com with SMTP id r36so8205704lfi.0
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 12:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=WelVMwnyNYn0QBtf/idFM6AuLVFTAKoIRWC+gg5zv/k=;
        b=kuJhbIvtjE+mKHPhuhMgtCtbZ8HEe7pLE7+Hbjjjni7GVfbl/lImQhQPFj+ftzAoN8
         b884cYjAgZEHl4jbIjaNbmNzbD0veJzR4afwVvo4/V+Lkz4lV2QXW/Hs50W/GLvAs+OP
         0D9VzuXGPG8fwekXnRBkSlU+pbCN3pWvrl81bCcbTllqo6t75LweF2QVjvT5PkpzcDIA
         aAz+u8D/apVpJNkVMuEjTqEw0nAIfwseDDadf2yeEr3RBHhWsqdtE56PrI0kLlF0G6ml
         8wrUTl0asECf2ceas6CMsMgN69LsYppOIV+R+jlIheQQF9QiTNxpSwH0z7Umvy/NNwqP
         NgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=WelVMwnyNYn0QBtf/idFM6AuLVFTAKoIRWC+gg5zv/k=;
        b=D/AXq+TmmhxoaH1OKryita5Gy5snL3xVXa7kdNSznlwuHvQ14BkgvtLqaElwC764y4
         jmRm2i5iboiYPCBKWroDfW2NL2bMx3NEEqdSLD+yFiXVoBfnkI8YXOcJsp0TFOG5r/i9
         RSUEy4THHu12gLFj6e7P6ZaP1NqOL8JKqlu7+q0KxIwpiC6zldaIsNrEKwESZkLlvvxr
         QRJLM/ToE06SnLQG82GVUzFXNYlZ3uWnMM2tr6JKIjuOXc0t/GQIDiB8P+b91XmsL/4V
         rvR66ts1n5T0mri+R5vnYZvzogp9paFFSXxD38FXwsfUTOZeslTwuIadoNVAWOeWpIDo
         vUdw==
X-Gm-Message-State: AFeK/H0O8C1h//BapRzY/+gVfWHWLREICzLTysT01kLcEydf9fSir2Tq5KJvft+cQCI+iw==
X-Received: by 10.46.14.17 with SMTP id 17mr1669020ljo.40.1490989473185;
        Fri, 31 Mar 2017 12:44:33 -0700 (PDT)
Received: from [192.168.1.26] (ewi127.neoplus.adsl.tpnet.pl. [83.20.232.127])
        by smtp.googlemail.com with ESMTPSA id f21sm1086885lfa.27.2017.03.31.12.44.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Mar 2017 12:44:32 -0700 (PDT)
Subject: Re: [BUG?] iconv used as textconv, and spurious ^M on added lines on
 Windows
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
References: <feaeade7-aeb5-fa67-ab29-9106aeadb2a6@gmail.com>
 <264c72d0-9558-fa0d-e5ee-eaca894538be@web.de>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <bbd60ab1-1309-6b1e-9b7f-09764bab5ccd@gmail.com>
Date:   Fri, 31 Mar 2017 21:44:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <264c72d0-9558-fa0d-e5ee-eaca894538be@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 31.03.2017 o 14:38, Torsten Bögershausen pisze:
> On 30.03.17 21:35, Jakub Narębski wrote:
>> Hello,
>>
>> Recently I had to work on a project which uses legacy 8-bit encoding
>> (namely cp1250 encoding) instead of utf-8 for text files (LaTeX
>> documents).  My terminal, that is Git Bash from Git for Windows is set
>> up for utf-8.
>>
>> I wanted for "git diff" and friends to return something sane on said
>> utf-8 terminal, instead of mojibake.  There is 'encoding'
>> gitattribute... but it works only for GUI ('git gui', that is).
>>
>> Therefore I have (ab)used textconv facility to convert from cp1250 of
>> file encoding to utf-8 encoding of console.
>>
>> I have set the following in .gitattributes file:
>>
>>   ## LaTeX documents in cp1250 encoding
>>   *.tex text diff=mylatex
>>
>> The 'mylatex' driver is defined as:
>>
>>   [diff "mylatex"]
>>         xfuncname = "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$"
>>         wordRegex = "\\\\[a-zA-Z]+|[{}]|\\\\.|[^\\{}[:space:]]+"
>>         textconv  = \"C:/Program Files/Git/usr/bin/iconv.exe\" -f cp1250 -t utf-8
>>         cachetextconv = true
>>
>> And everything would be all right... if not the fact that Git appends
>> spurious ^M to added lines in the `git diff` output.  Files use CRLF
>> end-of-line convention (the native MS Windows one).
>>
>>   $ git diff test.tex
>>   diff --git a/test.tex b/test.tex
>>   index 029646e..250ab16 100644
>>   --- a/test.tex
>>   +++ b/test.tex
>>   @@ -1,4 +1,4 @@
>>   -\documentclass{article}
>>   +\documentclass{mwart}^M
>>   
>>    \usepackage[cp1250]{inputenc}
>>    \usepackage{polski}
>>
>> What gives?  Why there is this ^M tacked on the end of added lines,
>> while it is not present in deleted lines, nor in content lines?
>>
>> Puzzled.
>>
>> P.S. Git has `i18n.commitEncoding` and `i18n.logOutputEncoding`; pity
>> that it doesn't supports in core `encoding` attribute together with
>> having `i18n.outputEncoding`.
>
> Is there a chance to give us a receipt how to reproduce it?
> A complete test script or ?
> (I don't want to speculate, if the invocation of iconv is the problem,
>  where stdout is not in "binary mode", or however this is called under Windows)

I'm sorry, I though I posted whole recipe, but I missed some details
in the above description of the case.

First, files are stored on filesystem using CRLF eol (DOS end-of-line
convention).  Due to `core.autocrlf` they are converted to LF in blobs,
that is in the index and in the repository.

Second, a textconv with filter preserving end-of-line needs to be
configured.  I have used `iconv`, but I suspect that the problem would
happen also for `cat`.

In the .gitattributes file, or .git/info/attributes add, for example:

  *.tex text diff=myconv

In the .git/config configure the textconv filter, for example:

  [diff "myconv"]
         textconv  = iconv.exe -f cp1250 -t utf-8

Create a file which filename matches the attribute line, and which
uses CRLF end of line convention, and add it to Git (adding it to
the index):

  $ printf "foo\r\n" >foo.tex
  $ git add foo.tex

Modify file (also with CRLF):

  $ printf "bar\r\n" >foo.tex

Check the difference

  $ git diff foo.tex

HTH
-- 
Jakub Narębski

