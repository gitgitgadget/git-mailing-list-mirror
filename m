Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAxVLc0y"
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605C719B
	for <git@vger.kernel.org>; Wed, 13 Dec 2023 06:01:46 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5e297a5799aso8652757b3.0
        for <git@vger.kernel.org>; Wed, 13 Dec 2023 06:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702476105; x=1703080905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FSTVtuUNGssj7bHqSlPpebQLI4Ka+uymU7y1nahHOA=;
        b=IAxVLc0yWMo/PNnPy2sckTE91LwsCtiIvzMKxSpZ8HXvHnkDHFEb2OWqbeIU75PI4g
         UcyEAcFDMV9hHhVn0pdROQ/+Ly2YRORgSx5YtHD89mk8Ycff/SI+V6MwAT7zg17XErA0
         /KGhGsqxYFIKz9Zccu05dP6Cn4PLGhq8PEUgkjQcBbUB6Y1ThJIqWn9QP0cl9CNm1ByO
         m7jzzckkXQYARXyogRu1NUsZ6+JxzZZ7DPmzzLD6H8n+cwniuQhTefqmLXMFgSdRNUtX
         zUr5pyXGz8P6kzGJcckUmSjRaFtzEiT8RUkT7k8oCjRc2ojwoKK4jfKgC6LEgQV3oyNX
         FnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702476105; x=1703080905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FSTVtuUNGssj7bHqSlPpebQLI4Ka+uymU7y1nahHOA=;
        b=tJFRaZJ1SJVgWDwFbtgGaja8+1sbgfKj6C0PuiLqIG09UH22U+YWB44yA82v24HezV
         4PBg4WqUDrI4zrAyC9z0MbNdARQnn0QlGkXDoECrGS2YmMHR2zgjR2sXto41VtNHJTrE
         ltI1BOlCtBHnYBB3DSFCSPHd1EkCwHSK1ed3afEP/Fgq3d/xV2/+VdM7Gf8C9m+7P7Jc
         iclYz1aCafuIUpZV8/Gxf05F81HjGwIuehfYIi1U1hqLR3N8MVfEPRw3I6G+KythajkJ
         6mEM4egVUlxSg/kKcImp9nQE7x5nAzx3MHgSB4Es6h4Hv58V8kO8WNmR8DugzTgMpem0
         +V7Q==
X-Gm-Message-State: AOJu0YxB7ZUSuXOoN9dzyJf5AhOCHZuktGcTJkDkq61ReODFgTe3nCRC
	zfSExZ+Snomf4uhphPjM/PRiqvUFfk1r1mUgg1U=
X-Google-Smtp-Source: AGHT+IF+Mc8GpdkzcmA1+gSiMn7gsd4p+zd4E93NP/h1j0rQgkBTfK78NToIfv4YQITNXfdZvZG6/DwSsYXkOGdXK3o=
X-Received: by 2002:a81:8786:0:b0:5d7:1941:ab1 with SMTP id
 x128-20020a818786000000b005d719410ab1mr6089770ywf.76.1702476104962; Wed, 13
 Dec 2023 06:01:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMP44s3qa_CoM_4--UmwYQTgO-5dHh6=jogH-rxF7OXEWr53Lw@mail.gmail.com>
 <802ca62b9d9672e9553ab064452d46e0d72dfc76.1702116416.git.zhiyou.jx@alibaba-inc.com>
 <xmqqcyvfmccr.fsf@gitster.g>
In-Reply-To: <xmqqcyvfmccr.fsf@gitster.g>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Wed, 13 Dec 2023 22:01:33 +0800
Message-ID: <CANYiYbGUo6TsOBHLGNF7onRgM1fsE3CU3=8=vwJsiuXnsnuLog@mail.gmail.com>
Subject: Re: New attempt to export test-lib from Git, maybe Sharness2?
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jiang Xin <zhiyou.jx@alibaba-inc.com>, 
	Mathias Lafeldt <mathias.lafeldt@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 10, 2023 at 2:59=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
> Is it a viable option to stick to the name "test-lib" (or possibly,
> "git-test-lib" to make it more prominent to say where it came from)?

Will rename the project to "git-test-lib".

> If you do not plan to coordinate with those who work on (the remnant
> of) the original sharness based on an ancient version of our test
> framework, and do not plan to actively transition its users to your
> version, it is less confusing if you named yours differently, as it
> avoids hinting that your version is a successor of theirs.
>
> I am not sure if reusing the history of our project verbatim using
> filter-repo is really a good way to help those who are interested in
> the test framework, by the way.

If all historical commits were squashed, it would be difficult to
track future changes of test-lib in the Git project. Futhermore, who
will be the author of the squashed commit?

> and unedited filter-repo result will describe such a commit
> primarily to explain why the changes in the commit was made on Git
> side.  Most of the changes described in the resulting commit message
> are discarded by filter-repo and the resulting history becomes hard
> to follow.

One solution is to add notes in the README file and users can refer to
the commit history of the git project.
