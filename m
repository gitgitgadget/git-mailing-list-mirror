Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B70E1F946
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 19:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718393832; cv=none; b=TKuFZJdmJUXZkJI3xd4uEvy666gueyKCuvsLvh9V69llXsRjVUfihC+MntcRi5eDbJSZpQeShrSpj6fPnejeDGqqblK6kNwjsULjmE8+W/nQdRW66k9OzTOU57iPvqo+HLdyo6zPAdtnQhtgqAU4Duj6xiqk8XEsx+JEYeN9jg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718393832; c=relaxed/simple;
	bh=LN0u6IMihpchU7rC2IgZ3ZzgRgCNB3zxWwaRNkI+vQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k11FYRqyxGngppngJiw/U0PhmGiyRXdBNK9xTOcZ44E3rYTyBRlBgfVmfXsM+3QVF7UBlt2MElxyXc0Rg6a4F7GWFa50458lO32fCGZTVnSpFWRdbmVS03QG6j5ay7LNPpoVVvopJQZnDIZ7K3Z4NSM9q3Xt23R4Ka3OpJ7h1fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-627e3368394so27722637b3.2
        for <git@vger.kernel.org>; Fri, 14 Jun 2024 12:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718393829; x=1718998629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNMSdLzVxojBxBpFHw//ACzAiwaral4ISUoaCgN4O/s=;
        b=iueOQzpKLhrrgC8+JQkEYttR1tu+cx3jq+9qPUY3l+66GlynU8Tbx0m2b+niRdkoN9
         uxv4dfOjBskRKA+h4wuJCbTp0Tc9D7HvdlN/kck8UjXnr8afWsW5aq/2/c+JVqYAcQcG
         iUv5oqRxbdDOa0oq2SBx3wAe+i6NdPgv29i3D1zd7b442dWaXnoFbZsvT1fy8xW1YP3Z
         +yCqea+HeAAkpFe3DnvjyzsKxrHdB0gJpaNJI4nkEzQsVrF7xS1rf7bcgMrtLPQbhqNy
         h9WysEQj9I8ypGyvMc1euH9Gjv6x+P23hs7XGq0BCZ6MIqu7EEMV+9YE3f3k2BB344MW
         LQIA==
X-Gm-Message-State: AOJu0YyF/9lgu6dKzSf4uiOF8+YrA0OWn4zwv8wmFJfat+UumoWt4etG
	bAhu5p0LjiCXn5H/dLNUoisLwP29EP5LeS4a9pb89oUi5A43y73/LZw0DoNEefEnup477NJPQKW
	8u+65oN+GBIVq6YvitKr78GPWhbE=
X-Google-Smtp-Source: AGHT+IEksv5ggJPPdM7yNkL99PLn7Tw2jESES+4g7NH5f/a5lGTUo9fBBPfOJJct//uIwwQ1ByvqKkmPj7j8m6AgDOU=
X-Received: by 2002:a05:690c:95c:b0:62f:4791:4e90 with SMTP id
 00721157ae682-63222b50602mr32800337b3.19.1718393829618; Fri, 14 Jun 2024
 12:37:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALyzih__9sZD31SVMECcxk55+MAMjkfgpLzecoHo0xUoauerqA@mail.gmail.com>
In-Reply-To: <CALyzih__9sZD31SVMECcxk55+MAMjkfgpLzecoHo0xUoauerqA@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 14 Jun 2024 15:36:58 -0400
Message-ID: <CAPig+cRGnAcfpr4JWp9WWC0b4yvjKx-_0up_S2iaXCBxgcSLjQ@mail.gmail.com>
Subject: Re: git grep bug replacing - with :
To: Rickard Andersson <rickard.a1992@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 3:22=E2=80=AFPM Rickard Andersson
<rickard.a1992@gmail.com> wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
>    Added 2 files to my repo with words in them
>    text-file.txt
>    text-file-file.txt
>    ```
>    git grep -l ExtremelyInterestingWord
>    ```
>
> What happened instead? (Actual behavior)
>    I get
>    ```
>    text:file.txt
>    text:file-file.txt
>    ```

I am unable to reproduce this problem:

    $ git version
    git version 2.45.2
    $ git init foo
    Initialized empty Git repository in .../foo/.git/
    $ cd foo
    $ echo ExtremelyInterestingWord >text-file.txt
    $ echo ExtremelyInterestingWord >text-file-file.txt
    $ git add text-file.txt text-file-file.txt
    $ git commit -m msg
    [main (root-commit) 765269f] msg
     2 files changed, 2 insertions(+)
     create mode 100644 text-file-file.txt
     create mode 100644 text-file.txt
    $ git grep -l ExtremelyInterestingWord
    text-file-file.txt
    text-file.txt
