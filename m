Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DF31E876
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 20:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706300419; cv=none; b=bX3+xpVTBcGUiBKg6KgLO4RIW32N5fzXyQtYZ9MAcEY4ai3uA9hwZDVdaHMEw71agMecVTIFv9nbHgvFw1Y/dekUVMdQCHgeJ+FXvlefPbh5f9Ad+lnBacdRLB54MJ+g5AvZDkWFxY64+/KONoVw9nXC0+86Oh3yt758s9TXDEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706300419; c=relaxed/simple;
	bh=88wwf8ajlXon6u2M8pW7FGXw3vemjiJNM1ByiKL8fkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQsq8TITnA9MgNJrutfT9gkxQ7GZL8qz3Syy3/wAoaqXYm+0JAT9gN0rO7rALzPWx0A3FXr8U6DFbYRgdmlIZWJZPqjTxCYzlS0/oIe6sM92RfbnFP8Zo/dp+fz6gXtvDqNfg9yTn3Wsdgm3IK6Z8yazlFdGlNL2EUuuniOEJgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbACrDNF; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbACrDNF"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3394dc75eadso818864f8f.2
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 12:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706300415; x=1706905215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o7c3z6AsgvYl5b7wCXywOy1WVGwjwHquQY4oDA18VQ0=;
        b=VbACrDNFYPJ6glHYz6IWZZMdM2SWdV8bafVnkWXUMccihMzSUNZ2tCA3+u0a4fEr8k
         qZ4IA3h6ACV1Q3wouCPyTTpxSTDbxvr6g+gbwFW+cETcmFXReCSNkzfwPQ3E4DR2rA97
         OOSGyp28dLSVxlAA6ubFna9f5jOr4/x2GQkwgwu+Y14dQGAi6YTt4+QyU+PAGHyfDZAu
         4gbcLNNYXvdPiHpUKt1gHn0H5zssg2jstnBeFDj1e4Gx3GQ3UgHIANmIVGCVkfcxb9Ci
         p6DXWV4O8MzopyaskQ0SGMphEsl1xJUUPBDLI8moPTkShJH3LS9ZzH+aET3TKcnQFt9I
         HONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706300415; x=1706905215;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o7c3z6AsgvYl5b7wCXywOy1WVGwjwHquQY4oDA18VQ0=;
        b=G/wglqRrmrzm780yQVAbfmxB7VoeGx58ixFJRMVpCCzj8UcxXbEKCWCWkUoHUQPV88
         Zl6zssu6wZjyLX5IQ5A8bg1uyz2oUDpiiZHuOE4X2DTKItbi5ZCu0T2zbmHuuGBfzZ4p
         Bd44EcJrKKMCc0nMHnY5XHy6l8HlTmWi+4JF/9ka0R1OKkEHaWbsFKhsDynAhAhtIoBq
         9KOoaUVWHwKbNXrUE3WkhCPGY/WFWzWhDeKmjidM8JzP0pWazRl6ZxOLgsPe2IkMGd4U
         DgiQLyeouxqj2/fPIoY1YuDBPRx0kvH5AMfOICLdYDH2J+ZnR6tkjcxzhDBz/TdTt1RP
         EOrQ==
X-Gm-Message-State: AOJu0YzKonXpo3ApSuZQGl//39QEyiw89ic0FZKD1pPRkeDyVK4Qm8L+
	EAsnFYG7czgs8YMhZGfilbkNSYj/GAP9ZQwe5MbGSPlp5CZcEkYX
X-Google-Smtp-Source: AGHT+IEgzh4rK0WnFxMMSGgUL/yoADrx7ZeXrjCNvf8VNvxIdwWI2/AJljGg2lTDkSmQASKdbfcwkw==
X-Received: by 2002:a5d:5946:0:b0:337:b38d:6070 with SMTP id e6-20020a5d5946000000b00337b38d6070mr120929wri.2.1706300415559;
        Fri, 26 Jan 2024 12:20:15 -0800 (PST)
Received: from gmail.com (77.red-88-14-198.dynamicip.rima-tde.net. [88.14.198.77])
        by smtp.gmail.com with ESMTPSA id bn24-20020a056000061800b0033947d7651asm1960498wrb.5.2024.01.26.12.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 12:20:15 -0800 (PST)
Message-ID: <dd106d87-3363-426a-90a2-16e1f2d04661@gmail.com>
Date: Fri, 26 Jan 2024 21:20:07 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] completion: reflog with implicit "show"
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>
 <5991b58c-770c-4aaa-bce5-f396d9f7f16f@gmail.com> <xmqq8r4cnfju.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqq8r4cnfju.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26-ene-2024 09:57:25, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > When no subcommand is specified to "reflog", we assume "show" [1]:
> >
> >     $ git reflog -h
> >     usage: git reflog [show] [<log-options>] [<ref>]
> >     ...
> >
> > We are not completing correctly this implicit uses of "show":
> >
> > With ...
> >
> >     $ git checkout -b default
> >
> > ... we are not completing "default":
> >
> >     $ git reflog def<TAB><TAB>
> >
> > And we are incorrectly returning the "subcommands" when:
> >
> >     $ git reflog default <TAB><TAB>
> >     delete expire show
> >
> > Let's use __gitcomp_subcommand to correctly handle implicit
> > subcommands.
> 
> As with a good bug report, if you are showing an "incorrect"
> behaviour, you should also illustrate what you think is the
> "correct" behaviour (see below).
> 
> >   1. cf39f54efc (git reflog show, 2007-02-08)
> >
> > Signed-off-by: Rubén Justo <rjusto@gmail.com>
> > ---
> >  contrib/completion/git-completion.bash | 9 ++++-----
> >  t/t9902-completion.sh                  | 8 ++++++++
> >  2 files changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> > index 5f2e904b56..c41f25aa80 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -2448,13 +2448,12 @@ _git_rebase ()
> >  _git_reflog ()
> >  {
> >  	local subcommands="show delete expire"
> > -	local subcommand="$(__git_find_on_cmdline "$subcommands")"
> >  
> > -	if [ -z "$subcommand" ]; then
> > -		__gitcomp "$subcommands"
> > -	else
> > -		__git_complete_refs
> > +	if __gitcomp_subcommand "$subcommands"; then
> > +		return
> >  	fi
> > +
> > +	__git_complete_refs
> >  }
> 
> So, when we see something that could be a subcommand we complete it
> as a subcommand and return.  In your example, how should
> 
>     $ git reflog def<TAB>
> 
> work?  We try to see if there is a subcommand that begins with
> "def", we see nothing matching, and then run __git_complete_refs?
> What if the branch you created earlier were not named "default" but,
> say, "delmonte", and you did "git reflog del<TAB>"?  Shouldn't the
> user be offered "delete" and "delmonte" as potential completions?
> 
> >  __git_send_email_confirm_options="always never auto cc compose"
> > diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> > index aa9a614de3..231e17f378 100755
> > --- a/t/t9902-completion.sh
> > +++ b/t/t9902-completion.sh
> > @@ -2618,6 +2618,14 @@ test_expect_success 'git clone --config= - value' '
> >  	EOF
> >  '
> >  
> > +test_expect_success 'git reflog show' '
> > +	test_when_finished "git checkout -" &&
> > +	git checkout -b shown &&
> > +	test_completion "git reflog sho" "show " &&
> 
> IOW, shouldn't this offer both show and shown?

What should we do?

When the user have a branch "show":

   $ git checkout -b show
   $ git reflog sho<TAB><TAB>

And with:

   $ git reflog <TAB><TAB>

Should we suggest the subcommands alongside the branches?

I thought about this, and it's a can of worms.  I concluded that a sane
an instructive for the user approach is to first try the subcommands and
if no option is found, then try the implicit "show".

Maybe I'm overthinking it ...

> 
> > +	test_completion "git reflog show sho" "shown " &&
> > +	test_completion "git reflog shown sho" "shown "
> > +'
> > +
> >  test_expect_success 'options with value' '
> >  	test_completion "git merge -X diff-algorithm=" <<-\EOF

Thanks.
