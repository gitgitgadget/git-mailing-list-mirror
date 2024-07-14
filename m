Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2F5FC11
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720983306; cv=none; b=RCbldbDA33epsQrFbs2D7TCCMYQ3GL1kmwbteYMp10ykWAJALfD5usK5giJKwbuYHSlpQztuVBUR4f9J5WcY6JKUXDHbd3DOthGsaMplvIly5ahcyn50g1VnDZ8cknyZXA5n+GqKVmpwyGq8utM1xpJ5Z2WkogkAhziUdHlGLOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720983306; c=relaxed/simple;
	bh=UzVOWOC0nV3VU+jL0Ko2faEUsZfNz6pL1UK42y4hMiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P37BzVFD/K3fQAwO0dTcKtiHTOsGvP7qpGwY2Gwq+JDCzaDZQfe6pao6oRJo+ZCLT00iYXlrrTGX1k1v/VhNCWVqYCm31/keogKzuAP5A1wruhqYRZFwgw/FZvsOsFkjnLTupNkH+CP/l3aosQpmBl+ZrrWPjQdvoJDmgossyCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0LN/8b7; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0LN/8b7"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5cce7626c87so856478eaf.2
        for <git@vger.kernel.org>; Sun, 14 Jul 2024 11:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720983304; x=1721588104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W98dBmupMUqy1Co9FY+3uKcFqxkdjGDVNWtckj7sgfY=;
        b=N0LN/8b7aLkiKiTxregVun0t9N4ZOorBUxHHG+9I9l3ShuUN8W53b8bV+vDa0OKxHS
         fFo0nJVJMqPVEk/15TTxpmUtN5gToCkPY13o7ZJyZzl28gvCyNpvcH6nFUQwwZeO3oNw
         ebR+qKIIsFtDfb9clYveEDDas4TcgIPibQX9a8MwJlU59d5d46CzIZK1u73FOn7JIZ5h
         fMDqCAa1QzOaAofPPnAIHz3Og6LLD5GjEXaxrh9OTDn+cVzfmMe/zMz8zy756tHsJBuz
         cjOXY2vfAMmnVwipoJevLRXB8llvTQZaehXnf8eCBHnAvDnyYfR/pOmndGAEpQGVzKYW
         lCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720983304; x=1721588104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W98dBmupMUqy1Co9FY+3uKcFqxkdjGDVNWtckj7sgfY=;
        b=AgsBESJ7j1NmnuyowesujL+HIbT9RrR4aTNSjHZD/2tF/zkO0zzKD0a4SeK9cPl7mf
         uzPdXQa+MDW0Ck2R2jlhoGTzDYwUm1ejQ0TqBEJBBY66HLUQXVc0RtXFlXxVl5A3SiVr
         91tng+4OuX/XM3YSI28GDCza3Raaa8BrZWZuYEq01DOOwV9AydVyIq0KuCbsDCJMnw1i
         fgEk7AfWYegO0tF6QlzsemsSm6c/gB8lKy5FBpEPSkI9GcNgGczb62cnU3tIlVleYCPw
         WEycc4+wo329/pJvosYKEYvDOfUDIDcjhhHMPHCAIANyYGCus0byHIOroWmbBLFhlHN4
         PNsg==
X-Gm-Message-State: AOJu0YzixoAyuOH/Ibv2TZSHKs5RBUp/lP46WpN7FL+B/giu9Ae14VHe
	9snxmA/DPDF8ZSyG3MFWHFKwfjycamMZGw8wZ3/pK+orsQKHD+lL
X-Google-Smtp-Source: AGHT+IHoqullLm+Q4ygHQYHfJol1X6W8/03wUCMPPqUosmtAnVuBlHPdUrZrjPnzDI6dkerlmE9fdg==
X-Received: by 2002:a05:6820:983:b0:5c4:57d:691e with SMTP id 006d021491bc7-5ccdd1e0386mr7542855eaf.2.1720983303944;
        Sun, 14 Jul 2024 11:55:03 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ce75998a7dsm553974eaf.21.2024.07.14.11.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 11:55:03 -0700 (PDT)
Date: Sun, 14 Jul 2024 13:54:28 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: clarify post-receive hook behavior
Message-ID: <zftb6xcmweatgzmhl44k3z5f7ga3wt64eryen3pvgbb6dpqaae@74h5fz3ffo5q>
References: <20240712224748.56843-1-jltobler@gmail.com>
 <xmqq8qy6jjdc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qy6jjdc.fsf@gitster.g>

On 24/07/12 04:11PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > -This hook executes once for the receive operation.  
> > +For a receive operation, this hook executes a single time at most.  
> 
> Hmph, maybe we can strike this sentence as we already said "once" in
> the previous paragraph.  The intention of the original description
> that said "only after" was to convey two things:

Ya, I competely agree that this is repetetive and should be removed. 

> 
>  (1) it runs only once, and
>  (2) it does not run before all the ref-update requests have been
>      processed (either successfully or unsuccessfully).  
> 
> If the "only after" was not serving the original purpose of
> conveying both of the two, then perhaps we should remove the word
> "once" from the previous paragraph instead and keep this sentence.
> 
> My preference is revert your "once after" -> "once if" to get back
> to the original "once after", and then remove "this hook executes
> once for the receive operaiton" of the original, without adding your
> "For a receieve ... at most".
> 
>     The hook executes on the remote repository once after all the
>     proposed ref updates are processed and if at least one ref is
>     updated as the result.
> 

Thanks for the suggestion. This more clearly conveys the two points
mentioned. Will add in V2.

> > -It takes no
> > -arguments, but gets the same information as the
> > -<<pre-receive,'pre-receive'>>
> > -hook does on its standard input.
> > -It
> > +takes no arguments, but for each ref successfully updated, it receives a
> > +line on standard input that follows the same format as the
> > +<<pre-receive,'pre-receive'>> hook.
> 
> This part of the update is great.  The "but" there is annoying, but
> that badness was inherited from the original and not a fault of this
> patch.  If I were writing it from scratch I would probably have said
> something like:
> 
>     The hook takes no arguments.  It receives one line on standard
>     input for each ref that is successfully updated in the same
>     format as the pre-receive hook.
> 

I also agree that it is better to break out these two statements. Will
adapt this for V2. Thanks again.

-Justin
