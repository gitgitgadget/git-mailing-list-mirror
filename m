Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A05F22611
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 23:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736378171; cv=none; b=Asn9ajigStLLa+Qq6vLAGRIB3O4G+Ks8gLdCVcVHhzFWC7uSsQstnV60R7BL0q/WDR9CfdEx1YCUX1XRSJI42wQX7Qu5BVt8Nq6Dd6RXJU6wEzSFxU09USU0nPKooZj/A37dV1cNsLkxgX4wJixXbVg3tjVg2aMtyIEagPYN6v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736378171; c=relaxed/simple;
	bh=WY4nhJAGJD+2WdM3uujiEN70vRLKY3UIlsMKYrwTJ08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZ/j1ZCxrb77RSrLSggzS8Q/AixjV8Lp3nkHG5SGKlj1BGA45BbH1k4F3MAtSxn9XvdsxpOs4t77J348Gc/GwpZqjrzxVBoeeAcF+Mb7yVFtBowG/0R3VTEWeZC3rnaJTQSZMMstZP1rFv1OaIh8k86cWu2ZrwiJSOJkZZlbpAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CN9X176+; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CN9X176+"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71e1e051e50so100318a34.0
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 15:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736378169; x=1736982969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4Hhr1YLFIr3NXkfiGvicno+TW5RslU3AwFZguhV9g8=;
        b=CN9X176+fu5irWTdfQMUINHDoEnny3AaKERVHi+FosDQutVgJiGt8xTtonuW4OhAfm
         mFJ1RH5Bz1LDTCbkMeVohcXkjvdkgZA22XNPlulOOCdKV3Jg045Ktkfga591dmnPmpiJ
         n30hH6sQxzfUxP1IcqsujDRI2DWHN33WQYKS5CIVU8rxpiJc5TB8QjafNNE7IiqeiPwO
         h4nY/5H36HRFZb27X0e/BNSxcwp4CQIdLOk7z9ORh0wEkmPa/iM9bKhJJxYnAJib6K/C
         t8OOGMg7AVWNDw5bzX9XamDBOcBxMO5GB78gqjOvcZhl0FC6B2bgCz5ZiN4W45Z7CilN
         qCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736378169; x=1736982969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4Hhr1YLFIr3NXkfiGvicno+TW5RslU3AwFZguhV9g8=;
        b=E5W+Th1umlrlVJtOYHAt8dSGjEDCkabF6hqrVI66epYb+QT87Ml76uN0ELBz0Cd1lJ
         BYChB3W4Q0Yuk3TbsWqf8Pcl9Zl7EQTc9PTCPMn6cA7S7sDNOaZ72Q0HYaJllegaWsdJ
         MYzgm7lhbY2RcnHhjiOY6TmfJMjSyqYrJwxP2Jd6nwSB/2yypKRoNVQMR4z6q+OCxvw4
         ZbKvNAOWDgmOySYqC/U68IS6RktgfA1eP3QmxKCUU/tgwJu2oTmjosnDucImcmNHyf/Y
         6dxGO7Xg6NlHqBExPTAQBXGy+VeKpw89q/xdWgmL3SoPf/q9umvLrkiTDQlAyIX6+QIq
         gHWw==
X-Gm-Message-State: AOJu0YwfH23n5OvUVwwFevpc+y1pEq/XU2X+gYPsyl9luHJSqUetkE/6
	KGtkbfvaREad/azNDbV9CASwXs6QIbh1kEl7Iachfkx6ropdBiHd
X-Gm-Gg: ASbGncskNQkgfHF8/6wgK6WRN1ut22ci+yH+fNRMbVKolLkNrBQPhSou4r/TOUwrade
	3BRsvWyzYD56TD7lW57+0f0JVX/XkQjE/Y3AcGvZLkalaFYgfr4VmmU5XgSAiTIjz5KrvMYw8Gp
	EgZ1oQrghALxJIT2OtMYPSzfx8z80b68YDcDTgTWFVoB5qFk9muK6NU7r4gmelSetdWPpWPXYKk
	a3PwpK+FYWOksQoH8E+jybGs8Au4oQnWLTULjfhtsJzNvWK/g==
X-Google-Smtp-Source: AGHT+IFnM2PU46kqCOrNHOVVfxsaIxBPkGw++8tGjrkLc3DtEKxgrqddkbRvZfqC+qRnNS3Lagju1w==
X-Received: by 2002:a05:6830:2643:b0:71d:4196:d92e with SMTP id 46e09a7af769-721e2e61f8dmr2391187a34.18.1736378169203;
        Wed, 08 Jan 2025 15:16:09 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72318575df9sm46341a34.43.2025.01.08.15.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 15:16:08 -0800 (PST)
Date: Wed, 8 Jan 2025 17:13:33 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [PATCH] rev-list: print missing object type with
 --missing=print-type
Message-ID: <23akc5fftnnkzrrxb3oojlskmcxgiwfwqpkxgncaubzbmaurm5@uj5tgy5q4bji>
References: <20250108034012.211043-1-jltobler@gmail.com>
 <xmqqjzb5pc6t.fsf@gitster.g>
 <onddu4fjgo2q7f6r7f6kgqctrbhshkll23z6ocsxiiqxbynap5@msq7qtj2un4w>
 <xmqq8qrllydy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qrllydy.fsf@gitster.g>

On 25/01/08 02:43PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> >> As I suspect that we would want to leave the door open for us to
> >> extend this later, I would perhaps suggest an output format format
> >> like:
> >> 
> >>     ?<object name> [<token>=<value>]...
> >
> > I think this is a great idea. To select which attributes get printed
> > with the missing object we could add an option. Something like:
> >
> >   $ git rev-list --objects --missing=print \
> >   --missing-attr=path --missing-attr=type
> 
> My knee-jerk reaction is that this is over-engineered; wouldn't it
> be possible for us to simply dump everything we know about the
> object, and let the receiving end pick and choose?

I think that should also be fine and much simpler. We may not want to
effect the existing output of `--missing=print` though, so we could have
a simple boolean option like `--missing-attr` or just add a new missing
action type like `--missing=print-attr`. When enabled it would just
print all the identified attributes.

If we don't care though, we could keep it very simple and just add all
the information whenever `--missing=print` is set. 

> > I like the idea of also adding a path attribute, but this raises a
> > couple of questions. The way `--missing=print` currently works is that
> > it prints the unique set of missing object IDs. A missing object could
> > possibly be referenced by multiple trees and thus have multiple valid
> > paths.
> 
> That is not an issue at all, I think.  "rev-list --objects" that
> shows objects that are not missing already has the same issue, and
> the solution is "show the path when the object gets shown for the
> first time".  Even when the same object is encountered during the
> history-and-then-tree walk later, that object is simply not listed.
> 
> The code path that collects "I thought this blob should exist
> because a tree wants to see it at this path, but the repository is
> corrupt and I cannot see it there" into the missing object table
> with attributes should do the same.  If the table does not yet have
> the object, record the attributes (like "expected type", "path at
> which the object was found") when inserting the object into the
> table for the first time.  If you have a missing object and the
> table already has it recorded there, don't do anything extra.

Good to know! That makes things a bit simpler. I'll follow this approach
and only add the missing object to the table if an object with the same
OID is not already recorded.

-Justin
