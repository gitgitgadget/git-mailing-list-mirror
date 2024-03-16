Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374AF1B949
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710604020; cv=none; b=SJO75/bcpieCN5whfhOq5W/nmKjeTyRpj5FEiZaRwx5bOOa6Fhob1HHlvNyTr6wYPua6s/itsr/4oDhvTbR5rco25HQwnVwADWkdyKl5cos0Hp9wlvch+XOjfnJ2+GhATC4msXlvGq5zkwAj6Kchck9oIn4aqgcQ9Kn1KCCQD1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710604020; c=relaxed/simple;
	bh=wOyIYSi7Hxb249XTAuvK8dQVxo48zkvvxg2T6XJR3w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2/Z0+KzuaX+GwfVu2QV+WOkUuiZBkynYPm7jaF2v93KbphfO8Zg6YcdQ8dQ83Lk7iRJ74q/dC8yqJr3mg+R35UpwhHEuc2YMbg11YOO3JsaK5uyBXri9SNK2/YlHIeDDwoOGX84zD6o8II3bozhWIi2NDzk/5G6eia1fJYzrnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=RFnBgFpL; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="RFnBgFpL"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6ddf26eba3cso2111653a34.0
        for <git@vger.kernel.org>; Sat, 16 Mar 2024 08:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1710604018; x=1711208818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KuIagAtFDyh640xw+ofewvqYfTUPg6vShP53V241/M0=;
        b=RFnBgFpLRKuX7s2qF/KKxj/kFMx+Tv+bHbDq71jLKcJ8zMI6G1R2wsW3A3zDlxnkUe
         tkjfa8FOKFWZn1uWdElqsp8byhCQVn3wdLFxgBLUUrGoNkD4zKlTcHl+qYjsW9WNGLKf
         3FLnLAilhsuQvjHIzbvc8UBZLsTzmUeUDsxpxYttr0flcxZ+uLbfc3aWs79PBq1SYGIg
         hGNwvM2lLrBOXwL6/m2sgSFQt1Ujq5q+sy4Iy/riVa2+69HXTsV2ClGEmWVW31SqaQfD
         EaNr+I2ZhjOfHmeNrjO6GKk8/gHt4/ep0Y7Ms73kQC1qYGakbecB+Wgr/UzDzoPfNnpi
         MLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710604018; x=1711208818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuIagAtFDyh640xw+ofewvqYfTUPg6vShP53V241/M0=;
        b=VXeu5N/uT34Kr4c1n2IxbrkfstCj2bHYoBMx8tJEwUnKd3D9sgt3woSY+7bw8KJdPp
         tkiTA3vYoOwhOkzGs5JUSSxxJZPbIIPGtItQa9Btp2ONo5t9SV8IGhnC3ZvNIwzTL3nB
         TbMS9A7oyWldv4lYtENFlLs1dqybtz+9PaycOkONicvK4yE3/orZ+n305VEwdM3C2diu
         6z0mQt2sGEwT/ldzlxGmPOM0zbVkxwGGptpSzjqaThe4tXwhLtxF82YLHuSEo2EG3udc
         JM0H0J1T6ab1X0zx4BJuBjHFtA7DivMy1zOE4Scy1dCTtvQlxkIbQZyXD/Hc9js/PZd4
         pktw==
X-Gm-Message-State: AOJu0YwCyk8EXN63s+wO0O4EuppkW3qUfQLXkEDaOn8Bfv/otqLi/+PT
	GiRWJbIMYhW03xj2NwWjhZ0iE6Un7dy5FrdYXTsB/7G6FC3+fLJ9/xjomdzK/gN3pDPR7Rr0Mxo
	ES1k=
X-Google-Smtp-Source: AGHT+IFnitahCX+OxQQSFJWRUzmvfQWh7GlYlMKVF33gVzZuYe5lMOTWABYgDH26ooaSJef7K/De4A==
X-Received: by 2002:a9d:65d2:0:b0:6e6:7dde:d048 with SMTP id z18-20020a9d65d2000000b006e67dded048mr4390020oth.15.1710604018320;
        Sat, 16 Mar 2024 08:46:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id gg8-20020a056214252800b00690befbe5a5sm3253319qvb.74.2024.03.16.08.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 08:46:57 -0700 (PDT)
Date: Sat, 16 Mar 2024 11:46:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Beat Bolli <dev+git@drbeat.li>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 16/22] t/t3*: merge a "grep | awk" pipeline
Message-ID: <ZfW+8GTKlxq1S1Tx@nand.local>
References: <20240305212533.12947-1-dev+git@drbeat.li>
 <20240315194620.10713-1-dev+git@drbeat.li>
 <20240315194620.10713-17-dev+git@drbeat.li>
 <ZfT6xxBnQs6ppYB2@nand.local>
 <5aacb015-c01a-4c6f-8e37-931581aa71b6@drbeat.li>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5aacb015-c01a-4c6f-8e37-931581aa71b6@drbeat.li>

On Sat, Mar 16, 2024 at 11:09:47AM +0100, Beat Bolli wrote:
> On 16.03.24 02:49, Taylor Blau wrote:
> > On Fri, Mar 15, 2024 at 08:46:13PM +0100, Beat Bolli wrote:
> > > Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> > > ---
> > >   t/t3920-crlf-messages.sh | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
> > > index 5eed640a6825..50ae222f0842 100755
> > > --- a/t/t3920-crlf-messages.sh
> > > +++ b/t/t3920-crlf-messages.sh
> > > @@ -97,7 +97,7 @@ test_expect_success 'branch: --verbose works with messages using CRLF' '
> > >   	git branch -v >tmp &&
> > >   	# Remove first two columns, and the line for the currently checked out branch
> > >   	current=$(git branch --show-current) &&
> > > -	grep -v $current <tmp | awk "{\$1=\$2=\"\"}1"  >actual &&
> > > +	awk "/$current/ { next } { \$1 = \$2 = \"\" } 1" <tmp >actual &&
> >
> > I think that using `next` here is fine to ignore lines that match
> > `$current`, but the canonical approach would probably be using the
> > `!` operator instead to negate the match, like so:
> >
> >      awk "!/$current/ { \$1 = \$2 = \"\" } 1" <tmp >actual &&
> >
> > Not worth a reroll, of course, just something that I noticed while
> > reading.
>
> Except it's not the same :-) This was actually my first try, but then I
> realized that awk continues to evaluate patterns and actions until the end
> of the script. The "1" at the end is the "always true" pattern that causes
> the default action "print $0" to run.
>
> So the "next" is needed to discard the current line.
>
> Having said this,
>
>     awk "!/$current/ { \$1 = \$2 = \"\"; print \$0 }" <tmp >actual &&
>
> would work, and it would also remove the obscure flow detailed above.
>

Ah. Thanks for the explanation. These details would not hurt to have in
a commit message, but I think that this change is fine as-is. Those
curious enough can likely find this thread on the list for this
particular instance.

But these sort of less-than-trivial details are exactly the sorts of
things we like to capture in a well-written patch message.

Thanks,
Taylor
