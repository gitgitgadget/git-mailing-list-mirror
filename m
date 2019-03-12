Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0549E20248
	for <e@80x24.org>; Tue, 12 Mar 2019 02:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbfCLCpu (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 22:45:50 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40745 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfCLCpu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 22:45:50 -0400
Received: by mail-io1-f65.google.com with SMTP id p17so747597iol.7
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 19:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+nz/4cuDj2AcTf1pIeyxoH3FRS6ML5BvntUQeJYUXjk=;
        b=sqBGhSKbeImP8A8/Xb+INNl46tmlYYdOMGPee0iMA5YvDBa4u/dTW4x+HbN8uMPJRY
         FtWEHAhFOw9rxjgKaAuKDequen/E135yiNfGp7RBQvCd8+4b8uBEWJ+8W0fRMN1Qwv9S
         iqkCO6AbdzSvx+3a9RFgDD2l0UxLzdWp6Y669kJAnLrJ5N+VA6eRKctc1ZjGeQr7d6W8
         CLuuhXXOcd5rQX+alBi35eUTu/59tpBBq4YdKWGwEubz6BAcwK77aAUTgeY3cRzYvGkl
         SbJ/3KR3RfjeFS6gns1l8I+G6eanUCyEhk9yu/FISMwjgdPK2Fz9NjnHanE6oSHbru9a
         Cyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=+nz/4cuDj2AcTf1pIeyxoH3FRS6ML5BvntUQeJYUXjk=;
        b=tzBut+xQLoAcIu+JPCZ61vG2+Aoy2h40FzbEkn4W/lF61tbio4SiuBsgRtv1GrUTAU
         JiDIYeNzyG/pr26YDK3Msuj+le3bHrGbODc3DptqmWfPxxsUXcrZUzumuglk4GiKGF3/
         1IxgVwajpfaXqZ5k/OS1IKXjKOmTMGSftrGdjPqtdzdJx700d/zK4WPYFI1MUkxbVgum
         97q4Xm0owoyOVoZRB6AO5kNsoKa0zOBTXI8Dt4+HkkarE1igzAdEGal78QSJ0TbP8S1o
         yb2JpEl5rK3YieZelzofFNcTegrQNdSWHe3DE43o5xPlhKuBaO2gBK01YqmD2aRhuoOz
         PGZw==
X-Gm-Message-State: APjAAAUmzOdPVGst+8Xafb+he1tniZ8y5z+g/VAIkzxXH0rp8ro2UmBL
        kW5HxrNXI+FElsXpiU6fKIbTcnM7
X-Google-Smtp-Source: APXvYqyRWbm6i1eZeV1pgTAqNr8nalqTfj8JYzW4qIjwFrdfciKr+/UJbanXeoJjbdfgwCc+g+QPdg==
X-Received: by 2002:a6b:f812:: with SMTP id o18mr18504144ioh.115.1552358748591;
        Mon, 11 Mar 2019 19:45:48 -0700 (PDT)
Received: from flurp.local (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id 203sm647633itv.6.2019.03.11.19.45.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 19:45:47 -0700 (PDT)
Date:   Mon, 11 Mar 2019 22:45:42 -0400
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: Solaris and sed: Too many commands, last: s/\n//
Message-ID: <20190312024542.GA7411@flurp.local>
References: <CAH8yC8nnFYt0raL+twrG_v8XZn_FDJWyM=tH=QL13Z70_bHRiQ@mail.gmail.com>
 <CAPig+cTCOfDCv=L3EWUqgVZx1VCdqt5ZjmSQMwHLX=R4C4hgTA@mail.gmail.com>
 <CAH8yC8=jtBURyr-mFJSe_cd4zNJfJDt672jZ+izo=z75ZBheug@mail.gmail.com>
 <20190311222805.GA6215@flurp.local>
 <CAH8yC8kHhhWA+ONv17LdLpvy6ubH3CTvJ6=ehP5MQLi_=n1=bQ@mail.gmail.com>
 <CAH8yC8=PKro1_WW=wJQoVHC88cziJPfgkHh6jNKOUxeFn3KVsQ@mail.gmail.com>
 <CAH8yC8kD3XkYP2o6k3ioCcNB_+wwQ=H2=V03z7Han1K8t2aUsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH8yC8kD3XkYP2o6k3ioCcNB_+wwQ=H2=V03z7Han1K8t2aUsg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 10:11:41PM -0400, Jeffrey Walton wrote:
> On Mon, Mar 11, 2019 at 9:55 PM Jeffrey Walton <noloader@gmail.com> wrote:
> > Oh man, you're using GNU make. I thought Git was using that anemic
> > Posix Make. See attached.
> >
> > I think Solaris provides an older gawk. Is this an easier problem:
> >
> >     awk: chainlint.sed:88: :squash
> >     awk: chainlint.sed:88: ^ syntax error
> >     awk: chainlint.sed:91:  s/\\\n//
> >     awk: chainlint.sed:91:    ^ backslash not last character on line
> >     Usage: awk [POSIX or GNU style options] -f progfile [--] file ...
> >     Usage: awk [POSIX or GNU style options] [--] 'program' file ...
> 
> My bad , there was a typo... 'awk' got assigned to SED variable.
> 
> This patch works as expected.
>
> diff --git a/t/Makefile b/t/Makefile
> @@ -11,11 +11,25 @@ SHELL_PATH ?= $(SHELL)
>  TAR ?= $(TAR)
> +AWK ?= $(AWK)
> +SED ?= $(SED)
> +GREP ?= $(GREP)
>  
> +# Fix Solaris tools. These are Posix. GNU tools located at /usr/gnu/bin.
> +ifneq ($(wildcard /usr/gnu/bin/grep),)
> +  GREP := /usr/gnu/bin/grep
> +endif
> +ifneq ($(wildcard /usr/gnu/bin/sed),)
> +  SED := /usr/gnu/bin/sed
> +endif
> +ifneq ($(wildcard /usr/gnu/bin/awk),)
> +  SED := /usr/gnu/bin/awk
> +endif

I think the last assignment ought to be "AWK := ...".

Anyhow, this sort of platform-specific tool customization is typically done by config.mak.uname in the top-level Git directory. In fact, there's already a section for SunOS:

    ifeq ($(uname_S),SunOS)
        ...
        SANE_TOOL_PATH = /usr/xpg6/bin:/usr/xpg4/bin
        ...

Prepending /usr/gnu/bin to SANE_TOOL_PATH might be a good idea as a first step toward fixing the problem you're seeing on Solaris, however, as Ævar mentioned in [1], SANE_TOOL_PATH isn't presently consulted when running tests. But, as he suggested, fixing the tests to respect SANE_TOOL_PATH might be a good solution overall.

So, rather than making platform-specific customizations to t/Makefile, an arguably better solution would be to update config.mak.uname to add /usr/gnu/bin to SANE_TOOL_PATH and then update the test system to respect that value (thus, these GREP, SED, AWK specializations can be avoided).

[1]: http://public-inbox.org/git/877ek0rymz.fsf@evledraar.gmail.com/
