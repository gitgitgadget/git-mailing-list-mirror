Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E959D1DC985
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784367083; cv=none; b=fXXYGq0nTSYyYPHJqQuC13o3imwQm9X0tu4o/Gk+AwAQstn6iIfDnsuuATTEvMvE+s52f5YJ2bDBoN31AABNI87PBXEV93LrwTbV5DZohec++LU0jJBCMCjZyKMzEISBz8/q//HWidzem9zGswjALXsAae9iCbbzV58+ejGggm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784367083; c=relaxed/simple;
	bh=+UFWZpDqQ6gmghtwuN8qAxtGG829i6u3TkQlUWqA9kA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZS8OBzm4d6ow8OBtsMvHRrhXsOdtx5s95MP9JBdzL+LWtJ2GQLAW/asd8fw3KUP/sk+JBeedPp/T9qlV5nCDU7XiPVFNGxAsWxq2lojve8b4XEDbaAbcpJOP+nd/VM7nbvNUi6VZR23SFSJPrGFPyPX4VlwX8nRtpnfp/PetMDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7igSHu4; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7igSHu4"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47de0093c42so4190715f8f.3
        for <git@vger.kernel.org>; Sat, 18 Jul 2026 02:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784367080; x=1784971880; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uYonUyG/+69Em40vYr0MgtbDI6kHw85iWvcfgb2M8ug=;
        b=Z7igSHu4PxI9p8tj0MODqp+zQksOjuJHEh+EKrJjSF12AFmKkZBxezR5ydWqOXE9+2
         ZwMvHh2vQzy3A9QanUmSB1VH7067qgLt3p25kjXeVc21Er/1byocsTa+GqrOqEC92kxa
         X3How89kwXBOEKFZjmwMp+3AmUVIEwCu3xSe3HrVj+//TKJrDDDdxgfdvTYFCEkxK4zl
         ca7KcpCvZfmrLQP3rh4QjneWat1QpBPYPs2/4I3Voh0mVU9VQK72OBnZpo9Ag0DYJQQg
         Ag2afqQUL8YjERZPaqabLXTiOBB1ibJCtOAtNYlWq7dhImVqXLOnLX58BCyR9AG0piYa
         m6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784367080; x=1784971880;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uYonUyG/+69Em40vYr0MgtbDI6kHw85iWvcfgb2M8ug=;
        b=rhk56tFP04e0TYZeqV8Iv1gpHuCt+WyHeiwmgGOTid+rKoIXODGcIU7iTdFK1g1K+Z
         Z4IrO8T2hNkNHJkqxnA7VT9qdkCfkI9y5f/xqm88U8HgrxqMwbshRDWzyr6mqfXTpFee
         OeyB7y4MoE3fXfaXa0rE8ICurvD6ElJLsMrMydKAvccZ3JG7H0iTcNdwI9xkuxLDsWFw
         I+zhVBB8Pl6tHZdCjTCuqXDhEvrKOVbx0Ysqmswa46TpSGWF9yqszg6pXX+2+CxiQKKK
         rbXbkGijdIE5dvThkezQnH9bYNsy6tSyK+meGsY/XU15w59Xwd3sxAFojrrI0GfJ6l6k
         mVnw==
X-Forwarded-Encrypted: i=1; AHgh+RoW94yaF8pFJUEJkUu5qajCg4AB3bSY4PIVAnfFay1t6VMacOnu4qHNIMi9eScc6sTo4lY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7wJGEevZ47Loa2v2PEUv95xNyQIcDXqjobDCNAlVJeEW+okEI
	6VMI5DUhRDy92NJIPZs8eaP0XjWzauhsm94mos+2KlhG/NS1xltrB3DjE5dJFw==
X-Gm-Gg: AfdE7cmSm+ffN4ZdaVqap4OBSUVNvQA+mVsNi1EGqU8ZkGoq4SCeZM29yjPYi3b8C8v
	E+cC6iAdRtJvEsVys9LcUj4zYvfPpsormoYLD4uxQbeCdXht7DOEeL8h5pZGQR1KDKWmjLSnRuj
	IieW7UyJeMs1urL2eG50spd/Ug0ZIuBoCOvgSW2+H0z8tGot7oQT0GR57Sm75H/KWagXNCXeNxf
	IQFhRTuDjVCqOKi6N4JaisfV8uwRiFicmE+ZCUIvQ1fvVxE3lDk4C8FOxnd4/dGLrNUD/APCB4L
	i0AUxoJ4lYRwFGe68XykL+jOXIW0Ir93xayQatUED6rK5EdSN/Q3Tsv3iaLrpRf681moCnE05gd
	Y1zLEplKsMW6GLrhNyMQYmHIy7gvSB+6/gGywZuTWqSgbz/GTl+XZlWTqWp6oV0lL2TEiCumtvN
	n0HRSNyRMFYV9c25O70GhGxBwNBR+l5gA+DCrx1i5QRquul/htM4cPvLgO
X-Received: by 2002:a05:6000:3111:b0:467:f84c:4ca0 with SMTP id ffacd0b85a97d-47f622f9437mr7687345f8f.22.1784367080008;
        Sat, 18 Jul 2026 02:31:20 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63edda9bsm10957992f8f.31.2026.07.18.02.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jul 2026 02:31:19 -0700 (PDT)
Message-ID: <e7dbcede-4486-459c-aa64-e44690e01fe0@gmail.com>
Date: Sat, 18 Jul 2026 10:31:18 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git-history(1) fixup broken with worktrees?
To: Toon Claes <toon@iotcl.com>, Patrick Steinhardt <ps@pks.im>,
 git@vger.kernel.org
References: <87jyqt1m6g.fsf@emacs.iotcl.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <87jyqt1m6g.fsf@emacs.iotcl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Toon

On 17/07/2026 19:54, Toon Claes wrote:
> 
> Imagine this repoducer:
> 
>      $ git init
>      $ echo Hello > README
>      $ git add .
>      $ git commit -m'initial commit'
>      $ git worktree add ../feature
>      $ echo world >> README
>      $ git add .
>      $ git history fixup HEAD
>      $ cd ../feature
> 
> Now running git-status(1) in that other worktree gives me:
> 
>      $ git status
> 
>      On branch feature
>      Changes to be committed:
>        (use "git restore --staged <file>..." to unstage)
>              modified:   README
> 
> And:
> 
>      $ git diff --staged
> 
>      diff --git a/README b/README
>      index 65a56c3..e965047 100644
>      --- a/README
>      +++ b/README
>      @@ -1,2 +1 @@
>       Hello
>      -world
> 
> 
> So suddenly my other worktree is dirty? With staged changes?
> And I didn't even touch it.
I think what's happening is that the branch "feature" is updated because 
the commit it points to is rewritten, but the index and working copy in 
the work tree "feature" are not. Rebase's --update-refs option refuses 
to update branches that are checked out in other workers by default to 
avoid exactly this problem[1]. As you can see in that thread there was 
some discussion about updating the index and working copy when the work 
tree is clean instead. I think that is a friendlier approach as it 
preserves the relationships between branches and avoids materializing 
changes in other worktrees.

On a related note, rebase refuses to rewrite a branch that is being 
rewritten by another rebase running in a different work tree. That's an 
important safety measure that I think the history command is missing.

Thanks

Phillip

[1] 
https://lore.kernel.org/git/9354d1d3-c1b7-3baf-215f-30659ad48b22@github.com/

> Now the commit history is correct:
> 
>      $ git log --graph --oneline --all
> 
>      * 16ef548 (HEAD -> feature, main) initial commit
> 
> 
> 

