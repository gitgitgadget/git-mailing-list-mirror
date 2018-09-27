Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6ECF1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 22:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbeI1Ex6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 00:53:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43978 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725728AbeI1Ex6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 00:53:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id q19-v6so2940125pgn.10
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 15:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TUsq9E45WrUom4T4bXw9z8WX6mVsIPBBNor49L4GY0Y=;
        b=oFbj1jr/PTKnZXHkCjAFAbG3tIT2/vJ3DsYhEtTWQPXYOxbDy5BtokIK/dydBSwJ+R
         0WHHcBnt2dBv1ZP72dtA9+t8e45mSeHR8bmBEhMADiNpWORToYUabKA1Vf4Re1fFWCff
         GSEjnq9Z6n8bXg2QGflONhWiu4Cbr8zaTeOEBdEVA7WLa4pRRdzGn5kc/H7t5GpcdCbZ
         DLDC8lC53RBoC0xnTNAQ4a0r7SCsR/R8x2+7jQHx3aJmE82vrdtCoDAp7Q0DDzvS8ljN
         bpGEpL83i2vPfzLkqVf11s25dKlxv8Nf9ek4u2Bp9K4lMxMRC/ImWI4o6VAelR/p048d
         ZKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TUsq9E45WrUom4T4bXw9z8WX6mVsIPBBNor49L4GY0Y=;
        b=gVGY1vzVBAAbqi3sNR7xDgxmVOokNRvQZ7+y8ug8vJpeLLp5ue90mFz/KVYU24OQoL
         925Uv4ZjIREQX4oPdqfvo5oTpl0/IwzwrkULIyBCkJrvMBa5uIFtRyq6jCImQL+wKzdP
         VF5F9RCQzTrsLM4jGBh2Y3VBQQYwiDFjNLGwpOtjxMX7y1bCYrMu8WgzMyYUevH/NSWH
         5Q7wxqguoE+voeWBXjRb+h2ZXTs06DNO9yLhmnfcdiAiN0G0iAep13Aidc1y/ZWfwdxL
         Mv8BUztQQ4thGIN+cYWSO+Y3yrACD14R7YFgmJxpBsoR4kM7vz9o3pqJLG5iq18L08sI
         y9Qg==
X-Gm-Message-State: ABuFfoiSoSAfkZ7+KLbsF6jnml6+9K8xzv8VEc2n7M2yhcnewvHpFBMU
        U4KlQmbat9VaB/SfEFWN71BBbw==
X-Google-Smtp-Source: ACcGV63Ryda0tXNvzR/IB60ZERtdX+StrnUGQAkyW2wGccnZLNMSei69AQfZF0p7Utsk/mlAppSAwg==
X-Received: by 2002:a63:a40a:: with SMTP id c10-v6mr12439176pgf.140.1538087605517;
        Thu, 27 Sep 2018 15:33:25 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:79fb:7d7a:4d6b:acb7])
        by smtp.gmail.com with ESMTPSA id l9-v6sm4567228pgg.79.2018.09.27.15.33.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 15:33:24 -0700 (PDT)
Date:   Thu, 27 Sep 2018 15:33:14 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Add proto v2 archive command with HTTP support
Message-ID: <20180927223314.GA230445@google.com>
References: <20180912053519.31085-1-steadmon@google.com>
 <20180927012455.234876-1-steadmon@google.com>
 <CAGZ79kaBvHwUUf0rXeAwBY-M+Oi9JjsQnLs4v3FAvx4a9ZRbSA@mail.gmail.com>
 <20180927183017.GD112066@aiede.svl.corp.google.com>
 <xmqq1s9efuqc.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq1s9efuqc.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1+54 (2af6caa1) (2018-07-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.09.27 15:20, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> >  1. Clients sending version=2 when they do not, in fact, speak protocol
> >     v2 for a service is a (serious) bug.  (Separately from this
> >     series) we should fix it.
> >
> >  2. That bug is already in the wild, alas.  Fortunately the semantics of
> >     GIT_PROTOCOL as a list of key/value pairs is well defined.  So we
> >     have choices of (a) bump version to version=3 (b) pass another
> >     value 'version=2:yesreallyversion=2' (c) etc.
> >
> >  3. This is likely to affect push, too.
> 
> Do you mean that existing "git push", "git fetch" and "git archive"
> sends version=2 even when they are not capable of speaking protocol
> v2?  I thought that "git archive [--remote]" was left outside of the
> protocol update (that was the reason why the earlier attempt took a
> hacky route of "shallow clone followed by local archive"), so there
> is no "git archive" in the wild that can even say "version=$n"
> (which requires you to be at least version=1)?

Yes, the version on my desktop sends version=2 when archiving:

∫ which git
/usr/bin/git
∫ git --version
git version 2.19.0.605.g01d371f741-goog
∫ GIT_TRACE_PACKET=${HOME}/server_trace git daemon \
  --enable=upload-archive \
  --base-path=${HOME}/src/bare-repos &
[1] 258496
∫ git archive --remote git://localhost/test-repo.git HEAD >! test.tar
∫ grep version ~/server_trace
15:31:22.377869 pkt-line.c:80           packet:          git< git-upload-archive /test-repo.git\0host=localhost\0\0version=2\0
