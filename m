Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 810A21F461
	for <e@80x24.org>; Fri, 30 Aug 2019 14:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfH3ORS (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 10:17:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35591 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfH3ORS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 10:17:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id g7so7174236wrx.2
        for <git@vger.kernel.org>; Fri, 30 Aug 2019 07:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tIQP2U2dhkyC5eW24zU3hF0/p6qxcB8ZFcUVheWpjDc=;
        b=cv1HlKRi9/5HuqN/ZGEdylL9QLu5SRQbwPC76N+ZAC8T+IEv0usJI0yLjkQc5oqTB6
         kWhFhE+9evKdyKCfjqQbjuEBgzZneCwPMqyGDKu4zX3b62PZYCyhs+Vc06kbHsS5KiBM
         UpwG5G9+f37LuoRJLFecabv/OhKEcn9A8hR5PRBdvJ/h8cMzMJgwpHZZmPEhd1GUI+Be
         VrIP0LDqnYRnSBjjlzlOrO8XI8GQB/EyhCfFum1vdRvzeGRvR+yB0lLMnw2UOzU2c9Gw
         WCx5z6rcFZE1Csq82rcQsbWOA18t/WfYJ7V6XLd9l2VxXB7W21b7icgMu34eSFZnBpTE
         Apfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tIQP2U2dhkyC5eW24zU3hF0/p6qxcB8ZFcUVheWpjDc=;
        b=GP5F4Vd6liQDzrFxOdSPOrSVDEjNTCjD8KR9GBcdrZyqJOOC+6Zoou/DYsYGTf4NYC
         E8z2iaNmgFrQKwP+6tH+1i2loTd+mYMEttPj5p8iQqFTtmgVZmR8HfVQXzCYY81skEZb
         9vRJDxzZF2LJBzV9Rk6ZF9xd4lPrioQFNRWSoHO0OuY6UIxe8BK9tJ+5G8wUyfyQxzJN
         B4L/cIm+iZSl1Bye9WE9gu0HXpID5qQTCB8/tCkY2mSNqBoACJnzSt2nOBVBJL2EKCqE
         YWNGGlfCvHat1mZuZuqfk1OrQwjMu4S9RtVMRcqc5zcmepIAz3jiU8zc0mdcUUe42OQU
         vafw==
X-Gm-Message-State: APjAAAVXjxGBd0keAnIVMK2xfC4/gvbqndw3MRhZifwMqDZFav0m+SWb
        926rSmu0Uu6P9Y5DLdNXHgO0Seav
X-Google-Smtp-Source: APXvYqwEejSfu2HJFNWxxt/OL7AZed+JVI2FtYzLXm23KNz8myZiX+wTQHJxbEJ8axxcMvuEdPBypw==
X-Received: by 2002:a5d:5005:: with SMTP id e5mr4061641wrt.79.1567174636141;
        Fri, 30 Aug 2019 07:17:16 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-2-29.as13285.net. [92.22.2.29])
        by smtp.gmail.com with ESMTPSA id h32sm4129681wrh.62.2019.08.30.07.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2019 07:17:15 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git-diff passes <rev>:<path> args to GIT_EXTERNAL_DIFF
 incorrectly?
To:     Dmitry Nikulin <pastafariant@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <CAH53SykX12SN83=gey8KS_x3cGkXH758sfEieskXnnvos8DMcA@mail.gmail.com>
 <xmqqtva0zkvu.fsf@gitster-ct.c.googlers.com>
 <CAH53SymNwjrh_CzXVVtU5xABuGQWMsXhRDYyRzyHEwuxLWA2NQ@mail.gmail.com>
 <9c280a3f-6a1a-61d1-a255-1dcf0671d39c@gmail.com>
 <CAH53SykQWLtjt0gWVrz5KyH-9WyqaQ0GtkhmyLt09QEqcAS_dw@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <968253c6-d517-3391-4790-9a07a03fb980@gmail.com>
Date:   Fri, 30 Aug 2019 15:17:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAH53SykQWLtjt0gWVrz5KyH-9WyqaQ0GtkhmyLt09QEqcAS_dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/08/2019 14:23, Dmitry Nikulin wrote:
> On Fri, 30 Aug 2019 at 13:16, Phillip Wood <phillip.wood123@gmail.com> wrote:
>> I'm not sure why the last argument is being split in
>> your example. It is not split in the example below
> 
> I have replicated the splitting issue on my small demo repo [1]:
> 
> $ env GIT_EXTERNAL_DIFF=./print_argv.py git diff -M origin/branch1
> origin/branch1-mv -- file1.txt file1-mv.txt
> ['./print_argv.py',
>   'file1.txt',
>   '/tmp/EWaCSc_file1.txt',
>   '2bef330804cb3f6962e45a72a12a3071ee9b5888',
>   '100644',
>   '/tmp/mtEiSc_file1-mv.txt',
>   'f8fd6737fbe5a45c97ba9c9de495dc46ff11eccd',
>   '100644',
>   'file1-mv.txt',
>   'similarity index 90%\n'
>   'rename from file1.txt\n'
>   'rename to file1-mv.txt\n'
>   'index 2bef330..f8fd673 100644\n']

That's strange - What OS are you using? Does python do any 
pre-processing of arguments with newlines in them?

> This is, however, tangential to the original problem: documenting the
> external diff CLI interface for diffing two blobs. Here is what I am
> seeing:
> 
> $ env GIT_EXTERNAL_DIFF=./print_argv.py git diff
> origin/branch1:file1.txt origin/branch1-mv:file1-mv.txt
> ['./print_argv.py',
>   'file1.txt',
>   '/tmp/n9USvy_file1.txt',
>   '2bef330804cb3f6962e45a72a12a3071ee9b5888',
>   '100644',
>   '/tmp/Zst0uy_file1-mv.txt',
>   'f8fd6737fbe5a45c97ba9c9de495dc46ff11eccd',
>   '100644',
>   'file1-mv.txt',
>   'index 2bef330..f8fd673 100644\n']
> 
> The meaning and origin of the last arg remains mysterious, and the
> other args do not conform to the published documentation[2], which
> states that the args should be:

The documentation is incomplete it should document the extra fields 
passed when it detects renames.

>      path old-file old-hex old-mode new-file new-hex new-mode
> 
> Instead the args that are passed are:
> 
>      path old-filename old-file old-hex old-mode new-file new-hex
> new-mode new-filename something

I think what is happening is that because you're passing different 
filenames in to get the blobs the 'pass rename information' code is 
being triggered so it shows the new filename as the name used to get the 
  second blob and then passes the header which only has an index line as 
there isn't any real rename information.

Best Wishes

Phillip

> [1]: https://github.com/dniku/git-external-diff-argv
> [2]: https://www.git-scm.com/docs/git#Documentation/git.txt-codeGITEXTERNALDIFFcode
> 
