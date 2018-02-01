Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40CB01F576
	for <e@80x24.org>; Thu,  1 Feb 2018 09:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbeBAJyF (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 04:54:05 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:44430 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751522AbeBAJyE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 04:54:04 -0500
Received: by mail-qt0-f174.google.com with SMTP id l20so25577333qtj.11
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 01:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=hpkW64RzLNDNZSAsvtlh2oaT05pNh9T9Ad+6LWDOrw4=;
        b=nSV/1By6/UIetoHbeEctjootHPH72ehgfI6chadqRlSF3TR45dvz7acYE0mbxcRbF+
         jyk0AbhgkaQ7g7l2swvxP9E/vN5Bcly7KS7mSGJ44Z6+uQ7e4sXM54jhazviwcI4KSUY
         xAmBOSKS0oMDH60mDUjpMJg7b3jYbQoV2tQB7tMg4ny6mTTUohrgluXojLX2H/CkvOIi
         pUy/+x37lVj3yG2hy88PCAkF43fxHfn3p/An5Om6BhTtpJCUidl3gucPuEK8Go5pA6e9
         s6+dxpDXDN30GdfkZmGMClx6ETTdf5VYg9o9UwCGdj16eiqfjFouSYmEXPZzlw4+SENs
         l4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=hpkW64RzLNDNZSAsvtlh2oaT05pNh9T9Ad+6LWDOrw4=;
        b=lI2LAZ+WXNHaV2miCNnfCXhodXoKllwpw9zBQEqbQdn1Detty3CT3rhjXaaGh8nImJ
         i1WPgakWQ//QTn00q81lGGM+Owtv+usJ3/EQN9AO1TYQw6r9EwHBsxIQK3D9cc9bzSlN
         12F69LVg77wHKL1MA2wKd5tTT1yHC+yejbpwCfGWcfv+5H2dHKd5cpHv+2udGcTJC/zZ
         ZIPGpL1mwMI8nd28HIYCNzsg59c7yOo/AQPJmkCOcSRriuKsflmngQPpYxZBCr8nuzDR
         yuDkHIhGteJ2fLef+GaAb9lIea9djh+HFEeg4vxq0J4KrSM0r/3EQ/4NQz1YnJxr/hYp
         wdnA==
X-Gm-Message-State: AKwxyteC/MObM18hjxOqlbfG+TLKFUr96GkR0cj2YahaZuDl0BgFtXyw
        NbD0RUbtgUZLOSigNymbaTK6GXUsfOVVeQwiM9KftA==
X-Google-Smtp-Source: AH8x224Y8KC8+g+9TzH8gk/svb3epdRYd8DH6JUyjx7B+k1cMBbzqTuOKYU9vOsb8YM0SjEf5lE1X39LJUWGKDU+1Ag=
X-Received: by 10.200.27.91 with SMTP id p27mr16786766qtk.254.1517478843140;
 Thu, 01 Feb 2018 01:54:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Thu, 1 Feb 2018 01:54:02 -0800 (PST)
In-Reply-To: <CACsJy8B0D=u5fGA2QWuG6QG-fmReg=GayC54+pSFjXHDrnKh3w@mail.gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com> <20180131110547.20577-2-pclouds@gmail.com>
 <CAPig+cT5GkhFJ9XFDSirGjfoji4qUCM8LA6abdRsaT=g3prznQ@mail.gmail.com> <CACsJy8B0D=u5fGA2QWuG6QG-fmReg=GayC54+pSFjXHDrnKh3w@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 1 Feb 2018 04:54:02 -0500
X-Google-Sender-Auth: zkELSQZejHsiURnRUqfUrtOMPbA
Message-ID: <CAPig+cSLYDJaxCyAH_zK0cat2-60OZGWGy_ZLHwitHfZ7oA78w@mail.gmail.com>
Subject: Re: [PATCH v2 01/41] parse-options: support --git-completion-helper
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 31, 2018 at 7:05 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Feb 1, 2018 at 4:04 AM, Eric Sunshine <sunshine@sunshineco.com> w=
rote:
>> On Wed, Jan 31, 2018 at 6:05 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
>>> Dangerous/Unpopular
>>> options could be hidden with the new "NOCOMPLETE" flag.
>>
>> I wonder if this option should be named DANGEROUS rather than
>> NOCOMPLETE to better reflect its intention.
>
> It's not only for dangerous options (I forgot to mention this in the
> commit message, I will in v3). The --continue|--abort|--skip should
> only show up when you are in a middle of rebase/am/cherry-pick.
> git-completion.bash handles this case separately and only put them in
> the completion list  when appropriate. --git-completion-helper must
> not include these or the trick done by git-completion.bash becomes
> useless.
>
> Interesting. So we now have two classes of "no complete". One can't be
> configurable (--continue|--abort|--skip) and one can. I'll use two
> separate flags for these, though I'm not adding the configuration
> option right now.

I don't see that as convincing argument for two classes of "no
complete". Since git-completion.bash already special-cases
rebase/am/cherry-pick for --continue|--abort|--skip, it is not far
fetched that that special-case treatment can be extended slightly to
also filter out those three options from the list returned by
--git-completion-helper.

So, if that special case is handled entirely by the completion script,
then that leaves only the "dangerous" options, which requires only a
single flag.
