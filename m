Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8CE4189B9
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791191201; cv=pass; b=duhICSNdUzQlYqtpULednHu/EliD36SmyTIpn7TplPZnvWkZQo2L3sbWwR31txJMERxf9UCNRfjwh4B/F4zHc8vPtVTGqVhLN8de0blQa/L5UC1csaQ5/lOjEFpoqPXv/pxR9JzJPQ5eYpJdWwyaFRNNN5DNWt/5dJwG4wmoQkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791191201; c=relaxed/simple;
	bh=0BFS27LSRNReU7oovMRiCsfPL4um5W3HAW0ktxBCdwc=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZ85ZAqq9Hbcl6uEA/ENfmR/YUKXJAgj/yeJjxuSVv9nPaf3mzdClaP3SDOWSPkwIcNbSS4vA2epTvqmVVp0b7dW1WtFUv6djP78po/3K0R8yR4HZDJ4tWsnGgLeMI8Hn8w1W2D6Hw4w72f5hb9aTxokJabpSSRvn1yws2yrSv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rr5+KG/+; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rr5+KG/+"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-895eaf31683so9015007b3.0
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 02:06:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791191199; cv=none;
        d=google.com; s=arc-20260327;
        b=XkqNKJ5ZTWh8cBC8Y0bmjLM8FlZZm6v/SHD5secOGNS4LtIBfeOmAsUH3AE5TxnxXM
         YrDccY7CwJBfmgWtxZp5RVE7u1yOHUhE2P5Z99H8cihBd6Akjj3jkLU/aQ2o0ygx82WB
         knh8lxUMurDCp8tII9RjZGvUuQYtYVnbEOif7UkFCH4KfFa4cib/sVgnOuzhoyC9m9JY
         gzXpgmNrZ55MNAUgGQnyk6eudQeVFr7xM4PLxNJA163Gv6VmouzIDR+ns2EjmHGYASv+
         hLN9IOpqxE4GmGyNbsN9wF0dSip+16grqr3fKEhjTBJAamAyUADq3OUV2vP7KPJJUJZy
         VZXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=xFtbUjwCHO5iB/qo7E/yO8n2dKaOKD8W+tC3+kDjisY=;
        fh=jGxuR2e7AO/J0sq2RAuqTiKiid/8c9HmDdwsrJEihSQ=;
        b=iCDmyBDMde+ZFckh9smbM06woDGOWQqU9tLKpl15RjXbs4rcZjJmCWh0VWhAfctqbM
         MtudlSKBJ7Awh/U88HLARG8GdsKzX8F8ShCvmTKZxJzuygNVPA9R9Ily4H5h9y7kVI58
         IBcKK5HNYFC5psSGpw55nbhbYH+ZcSc+Ht2TcQE9BXiVvM6qKfBi0Hm5Nct3V9z03per
         c5KuYm7QVnAu2euqD5KTAZWg/JfRVCc4s5FwdLA88wd5oQ0bedUHn2ehIIqDZfkAt50u
         mlKMy3J3ia0lyHbXjmrjDRt1AsCAVD/YWu7D1E2htYf202yx19l4AcuBoOu4slv1qspC
         ZaHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791191199; x=1791795999; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xFtbUjwCHO5iB/qo7E/yO8n2dKaOKD8W+tC3+kDjisY=;
        b=rr5+KG/+E5uiLqtTiBklwgULJ2N9hcfj87SANw3nx4fn2IxoTvLxl4+3jXcSmVPcjZ
         RYZc/FfEqi5kA6Dkyz6oI+6XzFUc/zx8BL/BbE662mK3wZB98JTU7PVfjeR6DVQM/Bks
         Jb6cFxukwD1vdOvWQz0XpKhLmN8eRvrmAOmEF7aX6in4oQt+n3sIRxdUCbrdG4BxgXlk
         F1aryW5xxJR6MJydVFXxE0TEx9iPkvUJRoXyv5OE+I+53f3Q1MRkXTCBXhsE13ZbudLn
         FzLqjjMrq+dcQTMNQxTNaBJpk4AWKdjwaj6TGAtU0oaMH2I1yVhuXGy0gHci72tKWnc2
         hayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791191199; x=1791795999;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xFtbUjwCHO5iB/qo7E/yO8n2dKaOKD8W+tC3+kDjisY=;
        b=mwBXh4XX20tjzDIbfNobgAqp6MeCiHdFwJsZaO4cker/rJO2kYrY+QnODRork8sJTI
         Tyt92tFvHdShFMMf8CpwNmea8wtQt98SfWPKBpBCv0+tJ1sYus7lMNz4iCem+Rw1g7Tr
         0hktlyqP3l8jEP179jPfopPhm1btdB8NfbhgLKYYVhCZ9cipQJjUnR2SGMWk1ueQ2J/2
         7UFQzkPJYNTEufSLIq4c4DsVQugvlICA4bGQ8jDvVamBZ9xU4GVPFTPN3mcBIIlmJ/Fo
         mjRPLcBizFa51Q1fhmWrzBU9MMcKphazWY6MgfFyh/NWdykq4MaQiUyq7B5uHkCc70YD
         pBVg==
X-Gm-Message-State: AFq9FYLwwLsMQ0YmpjT05eaEEdyLcZGXcq0GkBGySPwFqER9yrlHzkpp
	wRKOl27/58IYPlOHOy8JwXdN0DSC1ViWIUkzspwUKF9nAuDqOVwB7iiwss+W+RCq2OW612fnLR7
	fHFb+yDIsdUzNuuCcR7Gwpx8a/iuHYQNx63ZO
X-Gm-Gg: AYBFou0X3sK392UPM3CLt//CxzyyzkPPct5h+iT1ucPGpJlu5l13cIFLDWPuTOktIRm
	e52LQScGyXj2oKwrHFWJROG2+QvITyg3W9QihAal/kCtg1Mrn9IFbUGkEh9HtujAEqN4Us4SQZp
	JefT7xb7VGlC3Wt36JIHR39GzUGr35IiynU0DCdOat5Yek/yHY5hSswAiLSwxJTt+BLWgGcXXcG
	FN9fTdyXmxX5CB8XDJsx02pRxuMoet0MqLTRbZJM7J/X3jaZ1G21LqEEMw+C2ultWTRBKQr/LsL
	94DJsldMXnCmkejQwLgxZ2KQzw1XXDncLxXQ7oWPWV8LpqiZsL8L0auYw7v9N2Dl7Q==
X-Received: by 2002:a05:690e:e84:b0:677:de05:34df with SMTP id
 956f58d0204a3-677de053ba9mr492600d50.87.1791191198774; Mon, 05 Oct 2026
 02:06:38 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 5 Oct 2026 02:06:36 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 5 Oct 2026 02:06:36 -0700
In-Reply-To: <7012706b-516b-4cd9-abf3-0144093e0779@kdbg.org>
References: <arw5XxJPNlUxU8TS@fruit.crustytoothpaste.net> <20261005055337.7579-1-hananarshad619@gmail.com>
 <e1635b9c-bc03-4835-805f-5fa52f09364d@kdbg.org> <CAKPibBx6364BcB2nqyQ7jhTaQMaUuR2TNKzZ-9H8VopcRjXbZw@mail.gmail.com>
 <7012706b-516b-4cd9-abf3-0144093e0779@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hanan Arshad <hananarshad619@gmail.com>
Date: Mon, 5 Oct 2026 02:06:36 -0700
X-Gm-Features: AclHuK_eupxovsfRn5gZ3UwGd5GNeAD2qhjCWXz6u0RLDZFP3bLD7fnlqOORB2k
Message-ID: <CAKPibBwjRSb5cXd2iWo8bbYby1odcXNazEg-D9hcqbehrR6g3w@mail.gmail.com>
Subject: Re: [RFC] git stash: add porcelain for sharing stashes through remotes
To: j6t@kdbg.org
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"

Hi Hannes,

Thanks, I agree with your point after looking more closely at the
existing behavior.

I had overstated what a git stash publish command would add. For a
single stash, Git already handles the essential operation directly:

    git push origin stash@{0}:refs/stashes/hanan/fix-login

So I agree that adding git stash publish would mostly duplicate
functionality that already exists in one command, and I do not plan to
pursue it.

The narrower proposal I am considering now is only around the parts of
the temporary handoff workflow that are less convenient today:

- discovering available remote stash refs,
- fetching one and storing it as a normal local stash entry,
- removing the remote ref when it is no longer needed.

Publishing would remain ordinary git push.

For example, conceptually:

    git stash list --remote <remote> <ref-pattern>
    git stash get <remote> <remote-ref>
    git stash remove <remote> <remote-ref>

These would only be porcelain around existing ls-remote, fetch/stash
store, and remote ref deletion. There would still be no new stash
representation, server-side mechanism, tracking relationship, or
mandatory namespace.

I think this is a more accurate scope for the original shelf-like
workflow I had in mind.

Thanks,
Hanan

On Mon, 5 Oct 2026 10:21:03 +0200, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 05.10.26 um 10:03 schrieb Hanan Arshad:
> > The use case I have in mind is narrower: temporarily handing off an
> > unfinished working state to another clone or developer, without first
> > turning that state into a normal branch workflow.
>
> Understood. But you don't do this ten times a day, so...
>
> > The question I am trying to answer is therefore not really "should
> > stashes become collaborative objects?", but rather:
> >
> > Is there value in providing a small convenience command around an
> > already-supported stash transport workflow, so users do not have to
> > understand and manually compose the lower-level ref/export/import
> > steps?
>
> ... why do you need convenience? A simple export plus a push or even
> just a single push command are all that is required today.
>
> So, IMHO, there is zero reason to upgrade stashes so that they can
> achieve the exact same thing that we can already do with branches.
>
> (Hence, if indeed you do share your half-finsihed work ten times a day,
> then, please, by all means, use the right tool for the task: put your
> work on a branch, not in a stash.)
>
> -- Hannes
