Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886DD3C2798
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772729836; cv=none; b=NiMHqGaltYK2UUiqqm9S/p9LHnL2CA0918ON84QtJq46fNSmgpcwKpLdlc9m2Nzql4JiUHWisELreItqogsDNoTQjxIePxxEhLMKrM/uSFZ6kAqFvwGF9MgLabOS3UXOYqAJFvw3Fj5kN8VW4EeqYwPCoyWj4953VVxBHYx61Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772729836; c=relaxed/simple;
	bh=uNWFLP2xZomwA6Qb+1i/C63ghRN3tTxvRN/XZRPoQeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTUCIuIKG16P6MMDl1Mi3clVeE5opbYat7Cf/4LTmsexNw5nnJ5tV0212bfNU25tQrp5ZrJCHNrtQZ/808f+CcdJIGD/W9fFIgilsXS1LRf9JjgwLYL7hKrqZ5/J+MR74Mam4+B89fBcgjYUHSfbHSoKQOmpTxcDWCb5AxTIggo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCTQEKpR; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCTQEKpR"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-662f91bba0fso6975753eaf.0
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 08:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772729834; x=1773334634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4PPi4aq2IdtZI5funBAkKh7G+crd0wjfF+/7xfE7EVI=;
        b=OCTQEKpRGTrFRz807sNNTcV/is1zYdn5oXUtrwuIQ9WgMRhcC+vsT6J51Hdl8jzmi6
         E0aIFQP7697wfSEa3J0LYUW7N90GkqP7s++3YSWVq6HGWA6GVxB8ldUOiRNK8UE39gHD
         iLTKDvHjGcrZ0jIKK7RFZdkGXPkacQfAZuc1V6A8Hagm+xOr7RzNru4MUBsACttdNShs
         djQlYmqZjWeWrnvJ5l2sy1wfBPX0EddlxFqhISsRq/WG3h49DluMGzuXxGQ9WE2TYMzW
         mrNNb4XMKcxc922PJ76bm7AnX3u2KwdZPsZ/EbrtX59smr4gffga/nxzzy4+gRJprF3J
         M+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772729834; x=1773334634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PPi4aq2IdtZI5funBAkKh7G+crd0wjfF+/7xfE7EVI=;
        b=AfNS8DmG9LvoMpbSBfgizTG9Hu7xAlt87tEj2z+fc3zxcRGBs4GRW7dcPYbsO8XmmI
         381nmbnssc9oSroZ6KEhYVDfaKnRCMJWcwlfssNgzqOr9J9BPmV9AeqNu3BPHbDX0HL9
         +KqjCUoyoDAiElrurPBuHTxLUJGp1NVLMxjRxLiBL3pRDgtPMmhofOQLAde1uu0WKVIO
         y+lRBb2tYSZiQmWlkydLRVP6hfViLqzyL9qX4/IsrqNQos25sPCpcXUyeF2TgBbJgVv6
         XZuvn5Woy8LXCh0Dg7vxGQBoB81pwLR9r+KSsXR+nGQ092rZRbat6mIb+ONzvDdYB5/E
         sidg==
X-Gm-Message-State: AOJu0Yxz7TaeS1jnRL8iX7mpT4V4sm+sE+NpGUyj6d5IUNj7YNus1Rps
	3lUw4o7b69e86zRwZo1JVFpDhVOOYkKDuXu3Hh163V39L707PYTtqzTunQf7MA==
X-Gm-Gg: ATEYQzzGViuHJNZRsiUTi2lqW/PacXMdfxaUTG/NsNHtTa/Mzrj52ykID6iITgbYzQJ
	UWAoR1umTkPFJSilkhGXVGcfydX6VQM13iCKfRzcn5Ffuf9rund0N9RTUk6jzYjrIxHgk93jA55
	Bso5R+5MLTuHTztqRGMe1oGiopkPir7H9mTODAPPateq315SiurK/YPmI6kk+d0hnuJ82QDPAJ4
	D1yIbFZAt5YWmxjlWU6+GyYKQLZ3UqNzWe7AQBBqUqYUgITpVgOcYLqmJ2x/XVNjq+h/LPWbGPd
	iNAlV+WrjWj4XweFhhdg7l9D/qncVK6kGC0tTMRme0o0kYhZtx38CmoUrNOIVOezXmeuXd72feK
	awbjRA3jmtEcrrcCwsLIsQX4DwpctPj4GLLio5pyTsBDjbzJhUjLOQ47VZbkJtsPcxMSx6laF0u
	s1FNILpQu0GBLvPsl3
X-Received: by 2002:a05:6820:4b07:b0:676:ad01:3c2a with SMTP id 006d021491bc7-67b9450c00bmr1439536eaf.21.1772729834350;
        Thu, 05 Mar 2026 08:57:14 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2bfee3csm15778083eaf.7.2026.03.05.08.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 08:57:13 -0800 (PST)
Date: Thu, 5 Mar 2026 10:57:11 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/17] odb: split `struct odb_source` into separate header
Message-ID: <aam1Tu5wFA58swfi@denethor>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
 <20260223-b4-pks-odb-source-pluggable-v1-1-253bac1db598@pks.im>
 <aahToju3J2qj6lR3@denethor>
 <aamDv3M02MKthCPF@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aamDv3M02MKthCPF@pks.im>

On 26/03/05 02:23PM, Patrick Steinhardt wrote:
> On Wed, Mar 04, 2026 at 09:55:11AM -0600, Justin Tobler wrote:
> > > diff --git a/odb.h b/odb.h
> > > index 68b8ec2289..e13b5b7c44 100644
> > > --- a/odb.h
> > > +++ b/odb.h
> > > @@ -3,6 +3,7 @@
> > >  
> > >  #include "hashmap.h"
> > >  #include "object.h"
> > > +#include "odb/source.h"
> > 
> > Out of curiousity, since we include the header here, it is transitively
> > included wherever we are using `struct odb_source`. Ideally should we be
> > explicit or would it be best to just rely on this transitively?
> 
> Hum, dunno. I think it's fine to just be pragmatic here and only include
> "odb.h"?

Ya sounds completely fair. I was mostly curious if we intended "odb.h"
to server as the entry point here and expected "odb/source.h" to be
"internal". This is certainly fine though.

-Justin
