Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F82B20FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 21:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbcF2VhU (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 17:37:20 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:36982 "EHLO
	mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbcF2VhT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 17:37:19 -0400
Received: by mail-it0-f51.google.com with SMTP id f6so54215877ith.0
        for <git@vger.kernel.org>; Wed, 29 Jun 2016 14:37:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=75ROPCMzq6y92RJALdq/ZA0JzP2HJxHYAd4CX70HRZI=;
        b=Qck6QoUATonw7AeVnPdHUamImBTU5w3R4JmFd3hHYeJOing9Aec1yW4dAwX5wKRRVV
         rklghNp6YG14VfNdLOTWq0QlDqzlZie8Okr/YE6kt1fDZcRhKc12zUHtW/pyVtk6vOkd
         ypviawQJShLI0lgVhurkEpBEjRH95NZFC6tVnVd58R8rAtZaVn5LdvdRq1e7SaNiYfD0
         C9R9YWQV7gPIyNCIx2nW9FfcaRgxlcC/sx6np0CsUB8UGNyFOyMAy9LqwJgxCZrDIVgi
         fGuEJWPZWBoj31ae91/HUhFHb1T/77d19G3rgPsLiD13D/IVmnQT8+ZDTuRutmYkiiw+
         /JCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=75ROPCMzq6y92RJALdq/ZA0JzP2HJxHYAd4CX70HRZI=;
        b=G4Y45U4VJIN9EFdMDvXdnyk7akPdp9Xr0r7yEAcYeRVyuhGYcfB4QLDZ7DrC/Z0hCT
         fHkIUK4fikBRciDPtmijYKzH1pYcHbmEC51r9bHmM2DOkCSkX2NlZvzSjnbEP6gthY6f
         sRO7a2i/XLiD846MsTJrAGWM7O/Tf+BykX2kH3qxGH+QgOcTAZvcFOQhBr7lSuueeYuL
         Fn+vnyVSgWELKe0/dRi9xfreJ/ITjoxNb3tKXsVij1gXZhw4pstURU/jJiNZI3Bg8ZOw
         t31yOxJiPfVXIavZraT9rHi1cVvckXk/Wr4/GrGnHfwRqQmhzGyALkjrv1f7eahcMHnZ
         3b7Q==
X-Gm-Message-State: ALyK8tIDUnYkYeCBX/eafrQyw80Z21p+Qc7qvcAOFI0W362IAHOd4lCVS7XgX9e9ZAz8B0KRh9t2cwIUAz0GGl0z
X-Received: by 10.107.144.86 with SMTP id s83mr10923852iod.165.1467236238230;
 Wed, 29 Jun 2016 14:37:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Wed, 29 Jun 2016 14:37:17 -0700 (PDT)
In-Reply-To: <CAGZ79kZNnbrKFaKGchZ0r5wKCs7pz4RcyYq=0rnD5qSd8XDKXw@mail.gmail.com>
References: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com>
 <CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com>
 <CAGZ79kY6Ry+DfO90wza_RrVbCRAgNB4N=0W6svuJgvGNxeFh5Q@mail.gmail.com>
 <xmqqk2h73f2i.fsf@gitster.mtv.corp.google.com> <CAGZ79kZNnbrKFaKGchZ0r5wKCs7pz4RcyYq=0rnD5qSd8XDKXw@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 29 Jun 2016 14:37:17 -0700
Message-ID: <CAGZ79kbjntaTQPNdw9u07AJX3pTWdyKB1fiPqJZ=DZRzNvnKzg@mail.gmail.com>
Subject: Re: topological index field for commit objects
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marc Strapetz <marc.strapetz@syntevo.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 29, 2016 at 1:54 PM, Stefan Beller <sbeller@google.com> wrote:
> Chances are that the 10 years of history may be correct time wise as long
> as people don't introduce a bad date malevolently.
>

To answer my own speculation:
Even git.git violates the timing property, so there is no hope to find
many projects
to have "parents committer date < committer date"

$ git log --format="%H %ct %P" HEAD | {
> while read sha sha_date parents ; do
> for p in $parents ; do
> # echo "$id, $parents, $p"
> pd=$(git show -s --format="%ct" $p)
> if test $pd -gt $sha_date ; then
> echo $sha
> fi
> done
> done
> }
619a644d6daef56d70aeca85514e2d281eb483a5
776398709dee4050fc194fec45c5818ba9b01afe
ed19f367220a50e4e2a5c1a00b03c14eafcaba89

(out of curiosity these are:)
(2009-10-18 12:34:56, "checkout A...B" switches to the merge base
between A and B)
(2007-09-01 23:53:47, Keep last used delta base in the delta window)
(2006-03-03 23:29:56, Add a Documentation/git-tools.txt)
