Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546BBE92FC1
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 21:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjJEVL6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 17:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjJEVL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 17:11:57 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5C893
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 14:11:56 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 52D191ADD95;
        Thu,  5 Oct 2023 17:11:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tiZqj8U1X+L6
        /NFtVnaBs5v4cLI+SwQc/+4fftfapuI=; b=gw1Lbx6XDv02jcOBJP162clzM2Uo
        rFF5teOt+EGwVAO6tZWOv1a3ZiCRqbhCnluHHqkfsdiJSJi1UvKkBXJczIoJuc7Q
        hxWLWpeynEnBjpBt5e19Ekq3kbd2BRgBQST8rQaS8ArZXfkWCDDOxYihgh5HCRlz
        wInGwj8SECgHUCg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BA4B1ADD94;
        Thu,  5 Oct 2023 17:11:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B2F261ADD92;
        Thu,  5 Oct 2023 17:11:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] diff-merges: improve --diff-merges documentation
In-Reply-To: <CAPig+cT63L2+XmDRKw4Pc+iDmUL+UFcyummOcOtS+3wYaNbFvg@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 4 Oct 2023 18:02:26 -0400")
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20231004214558.210339-1-sorganov@gmail.com>
        <20231004214558.210339-2-sorganov@gmail.com>
        <CAPig+cT63L2+XmDRKw4Pc+iDmUL+UFcyummOcOtS+3wYaNbFvg@mail.gmail.com>
Date:   Thu, 05 Oct 2023 14:11:53 -0700
Message-ID: <xmqqcyxshizq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CF951D34-63C3-11EE-919C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> diff --git a/Documentation/diff-options.txt b/Documentation/diff-optio=
ns.txt
>> @@ -43,66 +43,74 @@ endif::git-diff[]
>> +-m::
>> +       Show diffs for merge commits in the default format. This is
>> +       similar to '--diff-merges=3Don' (which see) except `-m` will
>> +       produce no output unless `-p` is given as well.
>
> I'm having difficulty grasping the parenthetical "(which see)" comment.

I am, too.  I know what it means when written in the more common
Latin abbreviation (q.v.), but I suspect it may be rare to spell it
in English like this.  I found

https://writingcenter.unc.edu/tips-and-tools/latin-terms-and-abbreviation=
s/

that starts its explanation with this:

     The abbreviation q.v. stands for quod vide, which translates
     literally as =E2=80=9Cwhich see,=E2=80=9D although in practice it me=
a
     something more like =E2=80=9Cfor which see elsewhere.

and it goes on to say:

     The reader is expected to know how to locate this information
     without further assistance. Since there is always the
     possibility that the reader won=E2=80=99t be able to find the
     information cited by q.v., it=E2=80=99s better to use a simple Engli=
sh
     phrase such as =E2=80=9Cfor more on this topic, see pages 72-3=E2=80=
=9D or
     =E2=80=9Ca detailed definition appears on page 16.=E2=80=9D Such phr=
ases are
     immediately comprehensible to the reader (who may not even know
     what q.v. means) and remove any ambiguity about where
     additional information is located.

which only applies halfway to this example, as with the text before
it makes it very clear for readers that they need to learn about
"--diff-merges=3Don".  It is so clear to the point that the only
effect "(which see)" here has is to waste bytes and confuses
readers, I am afraid.

