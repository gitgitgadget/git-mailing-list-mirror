Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C56D1F454
	for <e@80x24.org>; Fri,  1 Nov 2019 04:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfKAEtz (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 00:49:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45781 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfKAEty (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 00:49:54 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1so5662944pgj.12
        for <git@vger.kernel.org>; Thu, 31 Oct 2019 21:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OVQBIIjXlT0VxyAs3SGokzOWLevPvTt58LKPgkwb7EI=;
        b=KwTbmZVZQNrOK5+WUKXCZy05KB14tYeXIm9aXBtxykECja5zhYlTohDz3nZjCGM4E7
         2BUH8ThModipqsYrH6hjP7lIF3UygWIB9+58QiytUup5LkVALnyaqk47prVqhBIwBwZk
         xIOlcyaOLQwM1u7s1YD5Biqw4T7OKLp73TyjbIwy8omeKX9C9L3obdXO5TkN9WGV6/Fa
         +rrtANxdSipTJ9G3wJ8SD1JBz0+dwsVC3XlOSyPwtk5+CJdB66Fyoo/rpAyrG2WJFGPO
         IbZZonqR54vzQ449qHsHpZ+Fm0lUt0JotMcVVrZmHoqqa7cEkWc22U5SY7cqsnRsWRsW
         m/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OVQBIIjXlT0VxyAs3SGokzOWLevPvTt58LKPgkwb7EI=;
        b=WTGORvSjEVFNrmYkm6BYZwh5uCpY5LQ0bl58utRSDUvO8K79LMSto7WdFxAHr2vEeo
         byYVs8cqqBZiEAm7lOyfaT3la7gAnlpTjf22oBcgDHKGo/thdYS/jdSkrWAhi1RSYzRR
         p7jovkHCJc1eUARcQhRuXbdnVTsRpJ6R4mTwcjA7BmxecyPOvMXQaS844jbnLzLZ+27F
         3y9l0ld4v5dJEzgl2cbe4npsAWBiF0wLIwMHPFxZ2Z9/vZe1MdGt/5kBznetk6bIVU0c
         5iyifgdVwq91anNui/DogV0h4GgMZKl3Z9HmzDDKUwK4tDicI1OR6XFzCFP7RE1tTkLT
         n0ZA==
X-Gm-Message-State: APjAAAX2HjbpAF/htf81ulXH0oVOrspdSehrt2bqizf7b87XEIUrU+si
        PVFDW67D6kjQcOmUOs8+/Os=
X-Google-Smtp-Source: APXvYqxsJ1jSDAw++HFAL2G8lEtWt8YYoGl5FXH6Fud+lirafjFtzID2IcmpGga47SZsOGo0jvtDpw==
X-Received: by 2002:a63:a05c:: with SMTP id u28mr11506033pgn.333.1572583792509;
        Thu, 31 Oct 2019 21:49:52 -0700 (PDT)
Received: from localhost ([2402:800:6374:2d45:2809:9830:be60:8e46])
        by smtp.gmail.com with ESMTPSA id y11sm6339830pfq.1.2019.10.31.21.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 21:49:50 -0700 (PDT)
Date:   Fri, 1 Nov 2019 11:49:49 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] sequencer: reencode to utf-8 before arrange rebase's
 todo list
Message-ID: <20191101044949.GA26545@danh.dev>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <20191031092618.29073-4-congdanhqx@gmail.com>
 <nycvar.QRO.7.76.6.1910311134011.46@tvgsbejvaqbjf.bet>
 <20191031192650.GA12834@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191031192650.GA12834@sigill.intra.peff.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-10-31 15:26:50 -0400, Jeff King wrote:
> I'm confused about a few things here, though. I agree with you that the
> subjects here are only used for finding the fixup/squash relationships.
> But I don't understand the musl connection.

You're right.

Because of musl's iconv implementation, the problem is being shown up
earlier.

> Wouldn't failure to reencode here always be a problem? E.g., if I do:
> 
>   for encoding in utf-8 iso-8859-1; do
>     # commit using the encoding
>     echo $encoding >file && git add file
>     echo "éñcödèd with $encoding" | iconv -f utf-8 -t $encoding |
>       git -c i18n.commitEncoding=$encoding commit -F -
>     # and then fixup without it
>     echo "$encoding fixed" >file && git add file
>     git commit --fixup HEAD
>   done
>   
>   GIT_EDITOR='echo; grep -v ^#' git rebase -i --root --autosquash
> 
> then the resulting todo-list output (on my glibc system) is:
> 
>   pick 3a5bace éñcödèd with utf-8
>   fixup aa9f09c fixup! éñcödèd with utf-8
>   pick 6e85d32 éñcödèd with iso-8859-1
>   pick 3ceac05 fixup! éñcödèd with iso-8859-1
> 
> I.e., we don't actually match up the second pair, and I think we
> probably ought to.

Yes, we ought to match up the second pair, and after changing
get_commit_buffer to logmsg_reencode, we do.

> 
> I guess the test in t3900 is less exotic; it uses the same encoding for
> both commits. And it's just that "foo" and "!fixup foo" can (and do in
> musl) end up with different encodings (because of the specific language,
> and the vagaries of each iconv implementation).
> 
> Would we have similar problems in all of the other functions which use
> get_commit_buffer() without reencoding? For instance if I do this:
> 
>   echo base >file && git add file && git commit -m base
>   for encoding in utf-8 iso-8859-1; do
>     echo $encoding >file && git add file
>     echo "éñcödèd with $encoding" | iconv -f utf-8 -t $encoding |
>       git -c i18n.commitEncoding=$encoding commit -F -
>   done
>   git checkout -b side HEAD~2
>   git cherry-pick master master^
>   cat .git/sequencer/todo
> 
> then the resulting todo file has a mix of iso-8859-1 and utf-8.
> 
> It seems to me that we should always be working with the subjects in a
> single encoding internally,

I'm in favour of this idea.

> and likewise outputting in that format
> (which should probably be git_log_output_encoding(), for the instances
> where we show it to the user).

This is git's current behaviour but it's get_log_output_encoding()
instead of git_log_output_encoding().

> I.e., we should always call logmsg_reencode() instead of
> get_commit_buffer().

-- 
Danh
