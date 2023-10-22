Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753626FCC
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="xjhoSPTy"
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3A6A7
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 08:50:27 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ca72f8ff3aso14849845ad.0
        for <git@vger.kernel.org>; Sun, 22 Oct 2023 08:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1697989827; x=1698594627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UjaUUGzBnKkAnmVtLwmlBU2xjzO3KnwekjHPnMyTHPg=;
        b=xjhoSPTyeLNV9ugJUhsYBeFecMKSKMYsxmns3g2VpBx7oXSxJoBek7mywfUhKIKQ2k
         LbE+0Y/bFr05BuDFURIxGHkw87Z5BQhnxV41NitJZp4nQrQhGyJZSfcGNUyouR47KqXe
         fF8FyDXUld65h5Jb6VDBh+eGOW+FiCRPdCxVaIkfetOvYl0vjCaB+DMefvN+9JijB7/3
         BvlOwnEJwLOvN9l5gAabXOKFzaeUjuGlczCXEk+3mSeiTchYIrPtSa3JU4MK4b7Gsjyy
         5xJ0zoFA0RKX/T7oTFUmVnS7d6tFqugmW95OnXCdUc4QQRPoQkkjj0usuiqG5n/YZ1Qf
         OOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697989827; x=1698594627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjaUUGzBnKkAnmVtLwmlBU2xjzO3KnwekjHPnMyTHPg=;
        b=IGr4PFYlFUrYpdQBQ3ihDQ6WFbxHnJYFUmBKFFkCC6upXL4PShMq9tz7m1Uvtcwkvv
         CXo4eLmvT2UhCrbQaVUNNX4VOsFNKE5EWUNXPjcmhBIMs+qGTjf60qxa2Ui2/yFG3yql
         d4zK5ag+yzo+73dQypeDWJmIBVxOxKy3dPvcmB0xFZRKvr7iVQgDRsmQNFeybOasZg4y
         PbPy5ZMJTuL50p274aII4KyW0QArNX1ZVNFPSZlRaMiKp7DNV8HGqTvrOdjnVnytlJ24
         8sb14zsyaM7Gk+Garx3dELhsA9q5Cc3ZRMqRttBwcV83iQIq8CSsE7I4uQDQSN3C3UBm
         ui6Q==
X-Gm-Message-State: AOJu0YxrKASTljoHJmNn5khKPL33jnn4icSYlPZ0ofzxz14w9nvXTcBS
	Owuz+j86ZBFJlDcEAgOOz8zQSZDR3SPJ2xQQJ2SVNN+c
X-Google-Smtp-Source: AGHT+IGK0ssbRhEgMIWLlRbK9U8goOKQJCwH7JUikUDKGOizeCF+eX+u5JJ7QpRm6ZMFWzpNlruB4g==
X-Received: by 2002:a17:903:60d:b0:1c9:e6a0:edb6 with SMTP id kg13-20020a170903060d00b001c9e6a0edb6mr4367522plb.2.1697989827108;
        Sun, 22 Oct 2023 08:50:27 -0700 (PDT)
Received: from initialcommit.io (mobile-166-170-46-145.mycingular.net. [166.170.46.145])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902714700b001bbb7af4963sm4695236plm.68.2023.10.22.08.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 08:50:26 -0700 (PDT)
Date: Sun, 22 Oct 2023 08:50:23 -0700
From: Jacob Stopak <jacob@initialcommit.io>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Dragan Simic <dsimic@manjaro.org>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
Message-ID: <ZTVEv3SMhhjeA6z5.jacob@initialcommit.io>
References: <20231020183947.463882-1-jacob@initialcommit.io>
 <fd26df85661d554ced9d8e0445f75952@manjaro.org>
 <ZTL1wJIIK/5YWQK5.jacob@initialcommit.io>
 <d3bbe53c3b910f891c80465ea0c3f53f@manjaro.org>
 <ZTS4jfsU6oS6LW0u.jacob@initialcommit.io>
 <5fac8607a3c270e06fd610551d7403c7@manjaro.org>
 <ZTT5uI5Hm1+n0Agx@ugly>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTT5uI5Hm1+n0Agx@ugly>

On Sun, Oct 22, 2023 at 12:30:16PM +0200, Oswald Buddenhagen wrote:
> On Sun, Oct 22, 2023 at 08:38:19AM +0200, Dragan Simic wrote:
> > True, but I still think that having git put its thoughts into tables is
> > actually not helpful.
> > 
> i'm not convinced that the proposed feature specifically would have helped
> me, either (i found the index a rather obvious concept once i knew that it's
> there), but i'm making a general argument here. so:
> 

Thank you for the input! One point I'd like to add is that although the
current proposal patch series only implements the table option for the
status and add commands, it could be applied to many others as dry runs,
as mentioned in my cover letter, some of which touch on concepts besides
the index. Examples would be git stash and git clean. It can take a while
before all these commands feel natural, which was my hope for having this
optional helper when the user simply could use a bit more clarity.

> > To be precise, it actually might be helpful, but only to the first
> > category of users, who will never reach it.  I mean, never say never,
> > but in this case I'm pretty sure it's safe to say it.
> > 
> well, and i think that you're wrong about that.
> your categorization is simply wrong, because it assumes an incorrect static
> model.
> 
> while for the last decade i've been as much of a git expert as one can
> reasonably be without being literally obsessed with it or having written
> much of it, i absolutely *did* start out in your first category (as in, it
> was forced upon me, while i couldn't have cared less about the specifics -
> p4 was working well enough (or so i thought)). and i hated this stupid git
> (it was 2009, and it was much more of a pita for noobs than it is now). i
> certainly could have used more sensible visualizations at every step - on
> the command line, because that's where i mostly "live".
> 

:D. I feel similar and as mentioned in a reply above, the main benefit
to getting direct feedback on in the cli is that it can provide guidance
based on the exact context the user is in, instead of an external
resource which can in most cases only suggest a more general or
tangential guidance / solution.
