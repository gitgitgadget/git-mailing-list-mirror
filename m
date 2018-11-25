Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5C4A1F97E
	for <e@80x24.org>; Sun, 25 Nov 2018 01:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbeKYMIz (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Nov 2018 07:08:55 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58761 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeKYMIz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Nov 2018 07:08:55 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 50E6A2A8C3;
        Sat, 24 Nov 2018 20:19:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cjLtg5uhUI/w
        QfU1hZDBN4JReHc=; b=cGZxe/X8dlJLLruKSkkxxi25vLQUNOAAJRDgkPYY7HN8
        cPCS4wAebzLKEkisRlKONXYTWUol/rnuvN1livUamOR5STfYGD2nD/XZsNDUD1xJ
        x+raF2egj6F2X3oStBZjYVxkXydALQpK4GPdFE9/aFfQjBO88qWwYIrh4dF30cU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=h6znFn
        pswJ6aq5bZklOfmGIne0oMrdBunvFST9xIGfhxtFhBTRQPXUNfquxz5MQWzFw56u
        jFteiMi1uGVwa4aEJyyC4lVKCe4y81zpaLkxeHYwaOGEiNA3kuicrv2Csx22fmw7
        BbUHC9tM0AARcGRbHxb35/23dN/ptnn4nZzWw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4814F2A8C2;
        Sat, 24 Nov 2018 20:19:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5945D2A8C1;
        Sat, 24 Nov 2018 20:19:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v3 3/8] refs: new ref types to make per-worktree refs visible to all worktrees
References: <20180929191029.13994-1-pclouds@gmail.com>
        <20181021080859.3203-1-pclouds@gmail.com>
        <20181021080859.3203-4-pclouds@gmail.com>
        <87a7ly1djb.fsf@evledraar.gmail.com>
Date:   Sun, 25 Nov 2018 10:19:00 +0900
In-Reply-To: <87a7ly1djb.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sat, 24 Nov 2018 20:27:52 +0100")
Message-ID: <xmqqtvk60xa3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 17E602AC-F050-11E8-93E4-CC883AD79A78-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sun, Oct 21 2018, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
> This change has a regression in 2.20:
>
>> [...]
>>  static void files_reflog_path(struct files_ref_store *refs,
>>  			      struct strbuf *sb,
>>  			      const char *refname)
>> @@ -158,6 +178,9 @@ static void files_reflog_path(struct files_ref_sto=
re *refs,
>>  	case REF_TYPE_PSEUDOREF:
>>  		strbuf_addf(sb, "%s/logs/%s", refs->gitdir, refname);
>>  		break;
>> +	case REF_TYPE_OTHER_PSEUDOREF:
>> +	case REF_TYPE_MAIN_PSEUDOREF:
>> +		return files_reflog_path_other_worktrees(refs, sb, refname);
>>  	case REF_TYPE_NORMAL:
>>  		strbuf_addf(sb, "%s/logs/%s", refs->gitcommondir, refname);
>>  		break;
>
> SunCC on Solaris hard errors on this:
>
>     "refs/files-backend.c", line 183: void function cannot return value
>
> Needs to be files...(); break; instead.

True.

The caller itself returns "void", so it would be nice if this were a
mere warning() from practical usabliity's point of view, though ;-)
