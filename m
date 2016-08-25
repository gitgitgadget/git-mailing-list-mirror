Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E8AE1F859
	for <e@80x24.org>; Thu, 25 Aug 2016 20:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758000AbcHYUqa (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 16:46:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65260 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756199AbcHYUq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 16:46:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B3C8D39026;
        Thu, 25 Aug 2016 16:38:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5yAHO2n5Uany
        GlypDxLOfA1oz7Q=; b=On1Pv717gwzmJ9orryDPLl1iLnF1g0m49MeylYotyf62
        t1feCJnDPYHz4np+uD67V5+2pMhnYFxf6bg02/FC3WUQZLgFGYqy+ktoxSZ2ZW5j
        F3pxT5p0leJLlErk3yOoDTqDjNTYrY4oIoDQHlQYxRpkr65xcU6Vyd7GgMNRfkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Vpw2dt
        Caom9dWjML5sINb68Cg7EJ6CGR0d7UP2sR0Uj0sy4o1FmSJJ7Qgy4dQ3VNBAofaW
        15H5y24Jm9L/oAGe1Jh+CpKeGyCNfHV8yVFkk9aJ5dMlKP5C6g3svCN48cQI6KXC
        qJUknLYvowXVp7lU/OG8/8m95Z8+PQ4F/nlt4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AD40239025;
        Thu, 25 Aug 2016 16:38:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 301F339024;
        Thu, 25 Aug 2016 16:38:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v1 1/2] git ls-files: text=auto eol=lf is supported in Git 2.10
References: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
        <20160825155257.28968-1-tboegi@web.de>
Date:   Thu, 25 Aug 2016 13:38:14 -0700
In-Reply-To: <20160825155257.28968-1-tboegi@web.de> (tboegi@web.de's message
        of "Thu, 25 Aug 2016 17:52:57 +0200")
Message-ID: <xmqqtwe8lh3d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D9A7A410-6B03-11E6-8DBA-F7BB12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> The man page for `git ls-files --eol` mentions the combination
> of text attributes "text=3Dauto eol=3Dlf" or "text=3Dauto eol=3Dcrlf" a=
s not
> supported yet, but may be in the future.
> Now they are supported

Thanks. I'll finish the sentence with a full-stop here ;-).

>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  Documentation/git-ls-files.txt | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
> index 078b556..0d933ac 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -159,8 +159,7 @@ not accessible in the working tree.
>  +
>  <eolattr> is the attribute that is used when checking out or committin=
g,
>  it is either "", "-text", "text", "text=3Dauto", "text eol=3Dlf", "tex=
t eol=3Dcrlf".
> -Note: Currently Git does not support "text=3Dauto eol=3Dlf" or "text=3D=
auto eol=3Dcrlf",
> -that may change in the future.
> +Since Git 2.10 "text=3Dauto eol=3Dlf" and "text=3Dauto eol=3Dcrlf" are=
 supported.

It may be a good idea to have this for a while.  Having this
sentence would only help those who have been dissuaded by the
existing Note by telling them that the limitation is no longer
there, but that will quickly become unnecessary.

We'd eventually want to remove this sentence.  I wonder if it is a
better alternative to just remove the Note without adding new text,
though.

>  Both the <eolinfo> in the index ("i/<eolinfo>")
>  and in the working tree ("w/<eolinfo>") are shown for regular files,
