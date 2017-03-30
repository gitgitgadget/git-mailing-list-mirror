Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB0F120966
	for <e@80x24.org>; Thu, 30 Mar 2017 19:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934791AbdC3Tfk (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 15:35:40 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33419 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934067AbdC3Tfi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 15:35:38 -0400
Received: by mail-lf0-f49.google.com with SMTP id h125so33457470lfe.0
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 12:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=7QPqHwGvC3636Ev51hej19PjdE1nAhXnSIG8uh0muvY=;
        b=kHkI9aMNf7CmNyWcdWYdMNRi4Jre+glJmzlwzPZprVetrDKuOv2nbshiTOTx7GTdCG
         DET7Nl58+e47vnJczAanhDt0VYU6ZvXxCXmpVzlzmFuQgtisVTrOk2HUaEPTF73OPVK4
         cBqkwFZ9Z9GmtSKqHNXFFvSBiEnkF7lqHY2rv5DF1gYLHQUDfmasqbSd2JLkzQda9HTK
         M8dYj7e8MXkIx7dBydMVgvzi5C18KPfKkGB06s/h6JE7WUs/TdtKO0ZaGpJYz3+ZruCp
         463fiDp2GUaAgMCyEkNkEYIwbWNM67TyzExhs4RIFDiZ0qWaQOOUEwFBP+Z4qY19aieb
         s07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=7QPqHwGvC3636Ev51hej19PjdE1nAhXnSIG8uh0muvY=;
        b=cA4Xbg+tNwE8cs4TCCpZt1leYtOZciHuv01T2X+netm5dsazmvHptwQFIDMx5lhgqr
         K+UAkk7m31oa8pTLdX4uEGTCN/zBdN8K8THV/ngoNSfTodnSBcvfI9ucgOGk66oTEr31
         fhs2RNHWLT11AIlMieLyY2h1pAd49ToeBdGa2DJgsIHnO4KwNJk7I6Wyqx/VNaYeJP1/
         arcalepfptashLzsaVQRSaJMQ7plwllGUtAQH44IdT4AsEPRx+H/AjinxoeBGdQzZQR7
         GO0VrlRpYqKPsyV+MXSjn1teilUK2/5q6paUNDnpP+oOzmVbzpv8iiTZiD5DjrMopBzi
         Y49g==
X-Gm-Message-State: AFeK/H1SRpkrHXaeC6cAw/8+F9NbItjBrsX1GjJzrMOdyLGT/9x9ZovRfhoJSFRIiurR/Q==
X-Received: by 10.46.14.9 with SMTP id 9mr530327ljo.27.1490902536264;
        Thu, 30 Mar 2017 12:35:36 -0700 (PDT)
Received: from [192.168.1.26] (ewi85.neoplus.adsl.tpnet.pl. [83.20.232.85])
        by smtp.googlemail.com with ESMTPSA id i1sm531295ljd.47.2017.03.30.12.35.35
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Mar 2017 12:35:35 -0700 (PDT)
X-Mozilla-News-Host: news://news.gmane.org:119
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Subject: [BUG?] iconv used as textconv, and spurious ^M on added lines on
 Windows
Message-ID: <feaeade7-aeb5-fa67-ab29-9106aeadb2a6@gmail.com>
Date:   Thu, 30 Mar 2017 21:35:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Recently I had to work on a project which uses legacy 8-bit encoding
(namely cp1250 encoding) instead of utf-8 for text files (LaTeX
documents).  My terminal, that is Git Bash from Git for Windows is set
up for utf-8.

I wanted for "git diff" and friends to return something sane on said
utf-8 terminal, instead of mojibake.  There is 'encoding'
gitattribute... but it works only for GUI ('git gui', that is).

Therefore I have (ab)used textconv facility to convert from cp1250 of
file encoding to utf-8 encoding of console.

I have set the following in .gitattributes file:

  ## LaTeX documents in cp1250 encoding
  *.tex text diff=mylatex

The 'mylatex' driver is defined as:

  [diff "mylatex"]
        xfuncname = "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$"
        wordRegex = "\\\\[a-zA-Z]+|[{}]|\\\\.|[^\\{}[:space:]]+"
        textconv  = \"C:/Program Files/Git/usr/bin/iconv.exe\" -f cp1250 -t utf-8
        cachetextconv = true

And everything would be all right... if not the fact that Git appends
spurious ^M to added lines in the `git diff` output.  Files use CRLF
end-of-line convention (the native MS Windows one).

  $ git diff test.tex
  diff --git a/test.tex b/test.tex
  index 029646e..250ab16 100644
  --- a/test.tex
  +++ b/test.tex
  @@ -1,4 +1,4 @@
  -\documentclass{article}
  +\documentclass{mwart}^M
  
   \usepackage[cp1250]{inputenc}
   \usepackage{polski}

What gives?  Why there is this ^M tacked on the end of added lines,
while it is not present in deleted lines, nor in content lines?

Puzzled.

P.S. Git has `i18n.commitEncoding` and `i18n.logOutputEncoding`; pity
that it doesn't supports in core `encoding` attribute together with
having `i18n.outputEncoding`.
--
Jakub Narębski


