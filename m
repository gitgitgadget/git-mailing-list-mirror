Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4C0D1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 20:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeI1DNw (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 23:13:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45850 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeI1DNv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 23:13:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id m16so4052241wrx.12
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 13:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=USNKKgUlrWuyttctIO9PIox+wd22ud+ySWfnrlCJ4z0=;
        b=r73FpX3Hr7UbGDYMKRcgkG7vOip4y9xQslpI/kh6YCyrLPJubM8kYrXLd/lJzN0LvO
         ms+YtiXJ0WNZh0SRDMincDHNl+KvJMkVL6Nce6HBhalaGicwTEGjdjOuQBwzEzpY8AeD
         OMx3IsT0mJQTGgg1taAJrFmvaAz9jgBLsUAXFZtBTCdMaoo4ydZrUIJG/N4jOvtqS+An
         ZciukliHSh7RqjwdQSnu2dqPwD8CsAzZIy2eB5p9C+muUhh3XUH/L1IVxVtoKdYAsUB+
         EZ28G6JLJPRDTLaxfDbDzDtFnsTMhpufZL1Kt03jaxokJ8Xa2s8+e2ycAc5IVKB3shpC
         juLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=USNKKgUlrWuyttctIO9PIox+wd22ud+ySWfnrlCJ4z0=;
        b=iIbN4Xv5bn8NHglzTVA7tvrDyph2IRgq8YA3RIT7AT/KrC8NSuaFQHJsgNvr2JCARV
         dXBmP5A3Ai6bNbnbqMZ9Aj+Jtu/02WlNyGDSgXIhD/+jQcCFs1DfWD+PdXSrgifc9b06
         q/BTmKyhb0RkHhLxSmcYiFKpbuxYngQHqr6sM3uok7yUpP1JZ7l/Varoi5iQ65+BXtIN
         SwB8yNo+XngEUL/XWueXRP+tSi/UiMFKCRXdp/9z7wpA70J0urlOZUzi7aVYKzCC3Ihw
         BIZUoty0fid1K3WR/dAUs502rnR6No9ZyhObvMQRRl3AUoEwkqgqk4lHk5tGD+LFTn1f
         V2SQ==
X-Gm-Message-State: ABuFfogENhjVgTnuU4xPQw5Ip/PxQaZak4xQsAcqiEe3Nce7LjHuVpL3
        A7yCIG9dKHwGhZOPd9zanyo=
X-Google-Smtp-Source: ACcGV63XZqiAj325aEwaa145nQxOLjwqNNS0Gu9gbCo0+kNSBi0chGoSVmGigmqIqdhenajplTpxPQ==
X-Received: by 2002:adf:c98d:: with SMTP id f13-v6mr10186626wrh.148.1538081620830;
        Thu, 27 Sep 2018 13:53:40 -0700 (PDT)
Received: from localhost (x4dbd8656.dyn.telefonica.de. [77.189.134.86])
        by smtp.gmail.com with ESMTPSA id r140-v6sm203544wmd.7.2018.09.27.13.53.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 13:53:39 -0700 (PDT)
Date:   Thu, 27 Sep 2018 22:53:37 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Alexander Pyhalov <apyhalov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: t7005-editor.sh failure
Message-ID: <20180927205337.GK27036@localhost>
References: <CALOYryFX4PPR+=1L+sjEqPsdmNh_+vNxGf0wwuAgoYzau=GShw@mail.gmail.com>
 <CAN0heSrhaaP0ds8K92g9w5DAnbwuq8mM6WLKrTQ7e_a8Fku9KA@mail.gmail.com>
 <CALOYryEMB5HoCXbVKnc49KLkk2ySZjn4DG9RbJjQAvPn1H5K6Q@mail.gmail.com>
 <CAN0heSpUhzbTjceVhBxk_jjE=vOAVTzXGFQ=UL9Y+muJHe0S6w@mail.gmail.com>
 <20180926121107.GH27036@localhost>
 <xmqqlg7oktto.fsf@gitster-ct.c.googlers.com>
 <xmqq36twkr27.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq36twkr27.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 12:16:16PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:

> > I quote >"$file" (but not var=$var) because the CodingGuidelines
> > tells me to:
> >
> >  - Redirection operators should be written with space before, but no
> >    space after them.  In other words, write 'echo test >"$file"'
> >    instead of 'echo test> $file' or 'echo test > $file'.  Note that
> >    even though it is not required by POSIX to double-quote the
> >    redirection target in a variable (as shown above), our code does so
> >    because some versions of bash issue a warning without the quotes.
> >
> > ;-)

Oh, indeed, I didn't notice that.

> Subject: t7005: make sure it passes under /bin/bash
> 
> In POSIX.1 compliant shells, you should be able to use a variable
> reference without quoting for the target of the redirection, e.g.
> 
> 	echo foo >$file
> 	echo bar >$1
> 
> without fear of substitution of $file getting split at $IFS.
> However, some versions of bash throws a warning, especially when

I would say it's an error, not a warning.

Regarding the "some versions", it's unclear when Bash started to apply
word splitting to the filename in redirection.  The changelog of
version 2.04-beta2 contains the following entry:

  When running in POSIX.2 mode, bash no longer performs word
  splitting on the expanded value of the word supplied as the filename
  argument to redirection operators.

so it must have started earlier, but I found further no sign of it in
the changelog.  In its man page the first ever mention of word
splitting affecting redirections came only later, in version 2.04.

v2.04 was release in 2000, so it's bordering on "since forever".


> they are invoked as /bin/bash (not as /bin/sh).  Those who build
> with SHELL_PATH=/bin/bash and run t/t7005-editor.sh triggers an

The grammar here confused me a bit...  maybe s/triggers/trigger/ ?

> unnecessary failure due to this issue.
> 
> Fix it by making sure that the generated "editor" script quotes the
> target of redirection.  
> 
> While at it, update the way to creatd these scripts to use the
> write_script wrapper, so that we do not have to worry about writing
> the she-bang line and making the result executable.
> 
> Reported-by: Alexander Pyhalov <apyhalov@gmail.com>
> Suggested-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t7005-editor.sh | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
> index b2ca77b338..b0c4cc4ca0 100755
> --- a/t/t7005-editor.sh
> +++ b/t/t7005-editor.sh
> @@ -20,11 +20,9 @@ fi
>  
>  for i in GIT_EDITOR core_editor EDITOR VISUAL $vi
>  do
> -	cat >e-$i.sh <<-EOF
> -	#!$SHELL_PATH
> +	write_script "e-$i.sh" <<-EOF

This can't be <<-\EOF ...

>  	echo "Edited by $i" >"\$1"

... because here we have to expand $i, and, therefore, we need both
double-quotes and \-escaping for $1.  Ok.

>  	EOF
> -	chmod +x e-$i.sh
>  done
>  
>  if ! test -z "$vi"
> @@ -112,8 +110,9 @@ do
>  done
>  
>  test_expect_success 'editor with a space' '
> -	echo "echo space >\$1" >"e space.sh" &&
> -	chmod a+x "e space.sh" &&
> +	write_script "e space.sh" <<-\EOF &&

But here it can be <<-\EOF ...

> +	echo space >"$1"

... so here we don't need the \-escaping.  Good.

> +	EOF
>  	GIT_EDITOR="./e\ space.sh" git commit --amend &&
>  	test space = "$(git show -s --pretty=format:%s)"
>  
