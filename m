Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D422BFC7B
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772267898; cv=none; b=IQCNm58C1io2mMnRf7ffTJ31yVCycPzlmUSGGxTeBxJ/j8MxrmX1Bmgoy71IkcoApQVxYp5aKo8Zv8SCBTNTqkrNn7J9Pjq7uKJBMPuDdeNXcLeH1p5a+wtI0rf5OQ2QUit1isV4lbebpEpYKD2Yl4rn4zJRBcuZP0Tg9TJnT7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772267898; c=relaxed/simple;
	bh=jvEpAMHj2ofjrnXlp83BbqHNyzY6Oo73iDkEN15KJN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qy4fMrscG6nTzqZMAuqC6gSrQHAcuPjuy9m+kdB1v75brd5BGUqa7KQMnFx+P+0qOIQCFKZZEddZ7dtnnnm+Z+GblyExWQHmmU7SrLh1/PvuVlZgGiIMX+YUdzCiKKXqSVP1lYpSbPHbwlylI5UqwGIVv3OAPusVZjC1xsgAjrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqEDYiPB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqEDYiPB"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aaecf9c325so18998995ad.1
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 00:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772267896; x=1772872696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMIdpTiQMC8bngwHjcl2W3JCfMSdHyzT1Qa2tCJDEkM=;
        b=OqEDYiPBZjGf1y5OIJ4FIXe1LJQ3VeaS4ypO0ZUysVcmsNWMDD+I39VpZK9EMBPnlL
         qaFk8Dfm8E7UApmVvXeirS/NE/hKSap7e1xY4Jn+CHfh7Ko2YJdD9oPSTCbYPMKfyPEk
         7MY7tEfKTqV+JSst5qlab+KOw7Taw6EgATyksazUUL17aRNPd94iQnP2xaiF42XbLDy2
         tA2l9OAYJTitO5Lf5Neg0m6P8FNNUiorpCMD8oYZvLyPhlQumxxiAXjCcpxdlrDhuVUC
         WIToM9RL0CgEoONoGAwpd2nY82b0Oa20fAEr1AwK9NaZ1YzayAzH/22lUiApkZN/C3iL
         Ninw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772267896; x=1772872696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NMIdpTiQMC8bngwHjcl2W3JCfMSdHyzT1Qa2tCJDEkM=;
        b=TNMGzH3MsJuTuiFLR5uPsHtZzSy+LrLIUo9+tiFmqFEPisH/U5cktxRcUIt/2nypjL
         YcJSs5YADR3dPyXSSJYqcDQcU0MJJ7I6pNqnLd0AHjHm0ycsr5fjWfToKAQO/N+4Q+cw
         bdaICyLEXA41fDzb3VG0M7tp055GQSZbhDvWmnRczLoz1cEb2VQKMg2OA4Haa+4jJthH
         ACTmqDBM0vWU1XG+8kzhbUilY1Wuv1lLZaGibP7w4eEMAevhwE2E+gPkSIJ6YtYmKWXl
         UmypWQRTw2c2T1h/Bk8g/oZdTTek5ogu+mSVAmTkiff+2hN5ojU+ETo6XhAxl11Ncpej
         qZoA==
X-Gm-Message-State: AOJu0YxNJA5b4+C6swOKJxVSFxx0IDZipP8WtFjxgReWz47kSxLce3VP
	3wFAJIx0fh3rs+1zwh+KcrRWI+HgA6WsgM0Ayjihbw5WLz9lIqCTYd4V8O7k/g==
X-Gm-Gg: ATEYQzyN7TuNXGCdM2+N0I9RrmgRWNGNvdFMKPruw06NboGG2Idjsg6DeqBQ5q+Tp9j
	/5DZjM6zH5tBAiAMRV4BrGcT7VjpAsRVSHDVOtLLLZEf0fCMkw0y9TRGPc7NlqnHGtigNA9leaD
	4IMziG0L44DxAv25Ec7g4Yhpp+llJe29adCXE3lfuf/jCnJWJtEeS/+wiYbKGSoMJpPf6tt2Iko
	8FGsjThts3IQjPBPWZL8YfCYR7KeUQ78guLEZpF59mSLRvr2gbnF0tR4zIOXZRQ0wzZ/X08ZjEY
	o2kLBzsEHayv6nmqa+qDmonxAJIZJCjQvbpZuvk2O5Il0D2FRXHaJRRbWiu6F+t6Sm8ZUUYTlvV
	3sfP6zfJUCRznSCuilLRGY28TRpLbFFZfFx4DjrDucqiD3aCkbODyf6D1ZpI2fEnxt1w+y/dCDg
	MnVPHJlNzrI2VAsR9M0UBAoBNAidKwDW/xbrZasxSYKaUq1wARXuPTdkQ8xA==
X-Received: by 2002:a17:902:d489:b0:2a7:c188:bd1b with SMTP id d9443c01a7336-2ae2bbddf43mr51045925ad.25.1772267895846;
        Sat, 28 Feb 2026 00:38:15 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:2af:8eed:2c20:6d15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5e1174sm78965595ad.41.2026.02.28.00.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 00:38:15 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ben.knoble@gmail.com,
	gitster@pobox.com,
	philipoakley@iee.email
Subject: Re: [PATCH v3] send-email: validate charset name in 8bit encoding prompt
Date: Sat, 28 Feb 2026 14:06:15 +0530
Message-ID: <20260228083803.238503-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0.154.g7c02d39fc2.dirty
In-Reply-To: <xmqq8qcf2vk8.fsf@gitster.g>
References: <xmqq8qcf2vk8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[...]
> > +sub confirm_ask {
> > +	my ($resp) = @_;
> > +	my $term = term();
> > +	return 0
> > +		unless defined $term->IN and defined fileno($term->IN) and
> > +		       defined $term->OUT and defined fileno($term->OUT);
> > +	my $yesno = $term->readline(
> > +		# TRANSLATORS: please keep [y/N] as is.
> > +		sprintf(__("Are you sure you want to use <%s> [y/N]? "), $resp));
> > +	return defined $yesno && $yesno =~ /y/i;
> > +}
>
> This is a bit incosistent with what "sub ask" (the only caller of
> this sub) does, isn't it?  Before entering the loop that makes a
> call into this, it does this:
>
>         sub ask {
>                 my ($prompt, %arg) = @_;
>                 my $valid_re = $arg{valid_re};
>                 my $default = $arg{default};
>                 my $confirm_only = $arg{confirm_only};
>                 my $resp;
>                 my $i = 0;
>                 my $term = term();
>                 return defined $default ? $default : undef
>                         unless defined $term->IN and defined fileno($term->IN) and
>                                defined $term->OUT and defined fileno($term->OUT);
>
> If $term is not usable for interactive prompt, it uses the default
> setting.  But the new confirm_ask always says "no".
>
> confirm_ask does its own "check term() to see it is usable" because
> it is called from another code path which does not have its own
> logic, but it may be a wrong abstraction to give uneven interface.
> It would make it more clear what is going on if you just do the
> interactive $term->readline() thing in "sub ask", instead of calling
> "sub confirm_ask" that does tghe $term thing redundantly.
>
> Can't the other confirm_ask() caller call a normal "sub ask"?
>
> I am not sure why we want to add a dedicated sub, just to ask "are
> you sure you want to use X [y/N]? ".
>
> > The intended flow is,
> >
> >         Declare which 8bit encoding to use [default: UTF-8]? foobar
> >         warning: 'foobar' does not appear to be a valid charset name.
> >         Are you sure you want to use <foobar> [y/N]?
>
> It somehow looks uneven to have three lines, two of them
> capitalizing their first word while the other one is all lowercase.
> I wonder if this would be simpler?
>
>     Declare which 8bit encoding to use [default: UTF-8]?  foobar<RET>
>     Do you really mean 'foobar', not a valid charset name [y/N]?
>

Actually that makes sense, because if we need to add a special warning
in between the two prompts (what I was aiming for), either we need to
modify ask() to add the warning into the flow, or we had to seperate the
confirm_ask because we have to change the flow in any case, but if we
drop the additional warning, and instead warn/confirm together in the
second prompt we dont need this abstraction.

>
>
> So, taking all of the above together, perhaps:
>
>  * Discard changes to "sub ask" and addition of "sub confirm_ask".
>
>  * Tweak this part a bit to call ask().
>
> > +	while(1) {
>
> Style.  missing SP before "(".
>
> > +		my $encoding = ask(__("Declare which 8bit encoding to use [default: UTF-8]? "),
>
> Overly long line.
>

my bad. will fix.

> > +		valid_re => qr/^\S+$/,
> > +		default  => "UTF-8");
> > +		next unless defined $encoding;
> > +		if (find_encoding($encoding)) {
> > +			$auto_8bit_encoding = $encoding;
> > +			last;
> > +		}
>
> > +		printf STDERR __("warning: '%s' does not appear to be a valid charset name.\n"), $encoding;
> > +		if (confirm_ask($encoding)) {
>
> Use ask() to ask
>
>     Do you really mean 'foobar', not a valid charset name [y/N]?
>
> here, perhaps?
>

Understood. I am hoping now this doesn't need any additional
abstraction as Ben suggested.
Sorry for the delay in response to the review.
I will send a reroll.

Thanks,
Shreyansh
