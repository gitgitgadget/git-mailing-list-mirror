Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367A2C433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 19:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B745B207DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 19:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="suyRpjh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgHCTjR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:39:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52694 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbgHCTjR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 15:39:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BDE3D78B70;
        Mon,  3 Aug 2020 15:39:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y5dGtwFWZuP/rBbMwRx3nc6hW5k=; b=suyRpj
        h/x3OwkfAZkTfsN7BLES3dmfaGEbvgqBsgzgPDCPLsmE+x6W/Beh/9dIpOEfJK4P
        zTObK3Yww2hmTdMvIKRVv9BniopJBi8y31ljMOrOunn9n32HRZm/1bFSsIHSCWK2
        QMMyKqI7OYNTaz00Da1Qpjj0cX00Xu3p9pHCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YUF9UNyW3zS34bZR0YiblivUonUTCALD
        /++8ArzzxIDh9qCQKi7ej8HsRng3aVeclClXGH4wpyNSktYpD/5fpzFXlbB9ZmAa
        rjVYRAOhdCZo96tL/cO91HbWha/DGFEb7woXyL3vK3lK8F5cBho5nuan4u4iw3uU
        jExVw2A6T2o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B65C878B6E;
        Mon,  3 Aug 2020 15:39:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 424E978B6D;
        Mon,  3 Aug 2020 15:39:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Noam Yorav-Raphael via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Noam Yorav-Raphael <noamraph@gmail.com>
Subject: Re: [PATCH v3] docs: improve the example that illustrates git-notes path names
References: <pull.692.v2.git.1596471677167.gitgitgadget@gmail.com>
        <pull.692.v3.git.1596481815803.gitgitgadget@gmail.com>
        <20200803191139.GA68002@syl.lan>
Date:   Mon, 03 Aug 2020 12:39:12 -0700
In-Reply-To: <20200803191139.GA68002@syl.lan> (Taylor Blau's message of "Mon,
        3 Aug 2020 15:11:39 -0400")
Message-ID: <xmqqpn87v7rz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02573C00-D5C1-11EA-86F9-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Aug 03, 2020 at 07:10:15PM +0000, Noam Yorav-Raphael via GitGitGadget wrote:
>> From: Noam Yorav-Raphael <noamraph@gmail.com>
>>
>> Make it clear that the filename has only the rest of the object ID,
>> not the entirety of it.
>>
>> Signed-off-by: Noam Yorav-Raphael <noamraph@gmail.com>
>> ---
>>     Improve the example that illustrates git-notes path names
>>
>>     docs: improve the example that illustrates git-notes path names
>>
>>     Make it clear that the filename has only the rest of the object ID, not
>>     the entirety of it.
>>
>>     Changes since v1:
>>
>>      * Improved the commit message, according to comments by Taylor Blau.
>>      * Changed the parts to random hex, so the '...' won't be confusing,
>>        according to suggestion by Junio C Hamano.
>>
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-692%2Fnoamraph%2Fclearer-notes-path-doc-v3
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-692/noamraph/clearer-notes-path-doc-v3
>> Pull-Request: https://github.com/gitgitgadget/git/pull/692
>>
>> Range-diff vs v2:
>>
>>  1:  8b3defb657 ! 1:  e973e321d8 docs: improve the example that illustrates git-notes path names
>>      @@ Documentation/git-notes.txt: are taken from notes refs.  A notes ref is usually
>>        they describe, with some directory separators included for performance
>>        reasons footnote:[Permitted pathnames have the form
>>       -'ab'`/`'cd'`/`'ef'`/`'...'`/`'abcdef...': a sequence of directory
>>      -+'12'`/`'34'`/`'56'`/`'...'`/`'789abc...': a sequence of directory
>>      ++'bf'`/`'fe'`/`'30'`/`'...'`/`'680d5a...': a sequence of directory
>>        names of two hexadecimal digits each followed by a filename with the
>>        rest of the object ID.].
>>
>>
>>
>>  Documentation/git-notes.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
>> index ced2e8280e..0a4200674c 100644
>> --- a/Documentation/git-notes.txt
>> +++ b/Documentation/git-notes.txt
>> @@ -223,7 +223,7 @@ are taken from notes refs.  A notes ref is usually a branch which
>>  contains "files" whose paths are the object names for the objects
>>  they describe, with some directory separators included for performance
>>  reasons footnote:[Permitted pathnames have the form
>> -'ab'`/`'cd'`/`'ef'`/`'...'`/`'abcdef...': a sequence of directory
>> +'bf'`/`'fe'`/`'30'`/`'...'`/`'680d5a...': a sequence of directory
>>  names of two hexadecimal digits each followed by a filename with the
>>  rest of the object ID.].
>>
>>
>> base-commit: 85b4e0a6dc8407de6f69808d9ee6debdf167ced3
>> --
>> gitgitgadget
>
> Looks good to me, but Junio should chime in, too.
>
>   Acked-by: Taylor Blau <me@ttaylorr.com>

Yeah, thanks, both.
