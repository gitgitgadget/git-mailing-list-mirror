Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 396B22035F
	for <e@80x24.org>; Thu, 10 Nov 2016 11:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755017AbcKJLKD (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 06:10:03 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:34944 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754760AbcKJLKD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 06:10:03 -0500
Received: by mail-it0-f51.google.com with SMTP id e187so260859482itc.0
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 03:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OJCpuSmfJN0URh8nzKEW3Ml7tW63iBWKS3+g5gqIzS0=;
        b=DyEYNLwc72QcoNt2VL62Re6YbVI+dech5q9DpPf2Tue2YTKN6ERWw3ojAg2fFWtE1h
         VuIyeVzXu1p+Fcb66pqFw1xs8DcYRiwybxuN5TeRI9nh5eewJcZe75Krd+45OZRvDVpy
         3PxqKB4N/h4Znp0JZ6I0IlrCAmHVSHi8H7Na5DnmtWf5triX5ONpNN6Ld0JCXFeZUtpe
         MEtkpBOmRWPAO5RiTgoRQ7tPubCT8KNeD+/YX7gFwzWAgHMRjA5RRdLmTeu6c4Jdp/uV
         4t09XitCUDmOQjKXzuv+Jgqs2GQWm8a7MDpEqgMLIcqALgwvSAQs8Y5PEqZcUULy39DF
         DwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OJCpuSmfJN0URh8nzKEW3Ml7tW63iBWKS3+g5gqIzS0=;
        b=IZ4cUDiQ0XQLbL0pC9J0eLUoZ7v8h6RFVxnszGwl0UL2s5hqtfWPt7vYdFBWd7xmJD
         cMGSyx1bHmFstdtMAnp982mQHAz7RXTe5XvGJBcYaKe5V0xGiD8O9klxajMgOax2LJgj
         RxQ14r2L8fN2KYFcrOPhlxNuzkAjgtRT8Cku0uBeHfXWrG1xAQN9VlFmSdmeSXdCjp02
         0aPmROVMYsAcYbakjuRnTJqXRoLgzk7DdprCd0dow9/aJENIZDLbGfZwFCLw4+1Wo/bK
         WIpEl5cBe/wQ3TmL6c5CmN3wr76XcnvXr5jvIjpCi9e7ESoVSnYTH7OXhnVQArCPB7fM
         +EJA==
X-Gm-Message-State: ABUngve3i+30L79hNcvdBIkmmKle1SZuVaSM15BO+r//aQHXJHJaa4M53jDi+FiMvXnxwJCoLjEtM8o2dWuxuQ==
X-Received: by 10.36.103.201 with SMTP id u192mr3255801itc.3.1478776200551;
 Thu, 10 Nov 2016 03:10:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Thu, 10 Nov 2016 03:09:30 -0800 (PST)
In-Reply-To: <xmqqh97g9zut.fsf@gitster.mtv.corp.google.com>
References: <20161026094658.20704-1-pclouds@gmail.com> <20161109091131.17933-1-pclouds@gmail.com>
 <xmqqh97g9zut.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 10 Nov 2016 18:09:30 +0700
Message-ID: <CACsJy8D9SHjwb2Ug_DYKmSO+dDxkkqwBFViQrW4eDqbJFjHESw@mail.gmail.com>
Subject: Re: [PATCH v2] rebase: add --forget to cleanup rebase, leave
 everything else untouched
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2016 at 3:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> ---
>>  v2 changes just the subject line
>
> That's not sufficient, is it?  What you did in the documentation
> would raise the same "Hmph, is this only about HEAD?" and unlike the
> commit subject, it will carve it in stone for end-users.

Oops. I forgot about git-rebase.txt. How about this?

--forget::
        Abort the rebase operation but leave HEAD, the index and
working tree untouched.

And think that's all the things rebase touches.
--=20
Duy
