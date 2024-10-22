Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227D5136345
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729615081; cv=none; b=X1gwHeUGTZ3sNj/eGsz23FDl+sq/t66TT78PtPEZHxTNZTHAl8KO8AuHzJyuWIQGZhnIv4JfJ8WN1j82EqqjITh0cAqsyTfGUgNTmeW7cW6cd4SAWN7oNTfoROdoUoOUNOxDc3CyNECh5ufaGEpd8C/EBRPIL7xCkhdwYJsU1q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729615081; c=relaxed/simple;
	bh=H+qOr7xidLZTkS+CoBRBm6t52qcL4SLi3fPAGaihpeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnqHdJeNPFJjjM3ad1erqFAKCusqK4VPR0je/bGO6STMgtET9Mmt6+WSC5R7xhoS8n+LNNtcwWn91rIlOfAQFSh1YwnNwzJKaWft/XRJuj8ZUZyyRadHUc96tAXpM7NE/vkJ6cdMp27sGwl4gtAbwkjRTjZ6tCA5c+gZNYKSC2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=z4dy0hzO; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="z4dy0hzO"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e29327636f3so5808160276.2
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 09:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729615079; x=1730219879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iyeYd4ihNxQdZXSHpMF9YS7KrIUW94DmhLowzHy3VoQ=;
        b=z4dy0hzOWylMpxtV0SP/a6wTqPtZ+SKahh6b3sXzWPJQw2rzJkUaLv0DUE5CtsCejB
         CJ5hqADXl/u67IKYVMsbF+oYRQCbxhUzh4Mn3cEm7iit76aMZ8Iakemsb8W6z+jXHv8E
         0vz+v9aH8W7RAUW7run1J5mEdgINfXaxQb/vUy0pedmKp8meuOO36CBU33ijH/EM+vHw
         zX+8PEcS+50XvVl8NR+KPKYa8fU+uiRz5slISqNevFc1opT48k2GROXAPX4WJ88r4cdS
         jGA970KlnIQpF39xG/rtLmqRwacy2kVB1e8876WpIWJCv5QtLglgZNLbIWx9FSqGAjne
         ZdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729615079; x=1730219879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyeYd4ihNxQdZXSHpMF9YS7KrIUW94DmhLowzHy3VoQ=;
        b=QqSQl0DgHWxjz6SACMD+lNChNXXtF6prjQVQ5u9mHjGXic6NC9raw3qzeOiU0clzvx
         KNjFlYoYyVfcPZruxXA/EM61qcsfg2zykmML5Y4USEpd7VbwIXBX2mbNwYSJs6trYHDa
         ltQetqPsor3USLrl6oyJ1VvZhqzlibb+aIZWG7UEf1UXPyzrHpNZwt6ErdMZfoBcJa67
         WFdI7G4DeG16DFpLH8oFXoqqptBPeXD6M50RaUaW1fjk23D+15QUgamoYWGwsawGnaeN
         b6dxSVnbFyieAl7D9j+JNhEV2+Le0aSwS1c4hkQnB3eaogrDnQ39YZvclsT1hoT3mjTG
         QsCA==
X-Gm-Message-State: AOJu0YyaW4cB0bS0CBZCPyY+qxyRU3cxCG0JQZ0Mj9zZsmMqHCJe3Cgz
	NnmfvnUgGAYiOIiUIuIp6KCA2GDZpj8gE9gZc6ttFFeo6sRq0XeWf+bJ9JPgq+s=
X-Google-Smtp-Source: AGHT+IEkzB96jV7NXaqZ1IW+CRwJ8q1EgzHr+zRLqEtqWwVqCGfmKQagT5AT8CS5opX89ZgBG85PIA==
X-Received: by 2002:a05:690c:fc1:b0:6e5:e6e8:d6b7 with SMTP id 00721157ae682-6e7ef101965mr826247b3.1.1729615079114;
        Tue, 22 Oct 2024 09:37:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5ccbaf0sm11437437b3.75.2024.10.22.09.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:37:58 -0700 (PDT)
Date: Tue, 22 Oct 2024 12:37:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/20] packfile: pass down repository to `odb_pack_name`
Message-ID: <ZxfU5c2fwD+HWtPf@nand.local>
References: <cover.1729504640.git.karthik.188@gmail.com>
 <c8cc21c2eeb9d1e0bc261143e642eff38fe33888.1729504641.git.karthik.188@gmail.com>
 <ZxbCWvFo8ZdwPgJd@nand.local>
 <CAOLa=ZQPH_rd65-zW6dRJAiAA747htXR---icS5aV9zupH2aGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQPH_rd65-zW6dRJAiAA747htXR---icS5aV9zupH2aGw@mail.gmail.com>

On Tue, Oct 22, 2024 at 04:51:04AM -0400, karthik nayak wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Mon, Oct 21, 2024 at 11:57:44AM +0200, Karthik Nayak wrote:
> >> diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
> >> index 5809613002..60f806e672 100644
> >> --- a/builtin/pack-redundant.c
> >> +++ b/builtin/pack-redundant.c
> >> @@ -688,7 +688,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, s
> >>  	pl = red = pack_list_difference(local_packs, min);
> >>  	while (pl) {
> >>  		printf("%s\n%s\n",
> >> -		       sha1_pack_index_name(pl->pack->hash),
> >> +		       sha1_pack_index_name(the_repository, pl->pack->hash),
> >>  		       pl->pack->pack_name);
> >>  		pl = pl->next;
> >>  	}
> >
> > I am a little surprised to see sha1_pack_index_name() converted
> > similarly here, as this patch promises only to touch the
> > 'odb_pack_name()' function.
> >
> >> diff --git a/packfile.h b/packfile.h
> >> index 0f78658229..507ac602b5 100644
> >> --- a/packfile.h
> >> +++ b/packfile.h
> >
> > Indeed, it looks like odb_pack_name(), sha1_pack_name(),
> > sha1_pack_index_name(), parse_pack_index(), and has_pack_index() are all
> > modified. Were these meant to go in separate patches?
> >
>
> Nope this is intentional, each commit tries to pick a base function and
> modifies all layers above it (I should have explicitly specified my
> approach in the cover).
>
> In this commit, we try to modify `odb_pack_name()` and therefore
> sha1_pack_name(), sha1_pack_index_name(), parse_pack_index(), and
> has_pack_index() too. Otherwise, we'd have a lot lot more commits.
>
> This simplies the review too, but yes, will add more instructions to the
> next version.

Makes sense, thanks for clarifying. I agree that this would be good
information to have in the patch message to avoid confusion.


Thanks,
Taylor
