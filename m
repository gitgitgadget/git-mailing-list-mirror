Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6996C433FE
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 22:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376602AbiDCWqd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 18:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376592AbiDCWqc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 18:46:32 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE56387BE
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 15:44:38 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C175A18687D;
        Sun,  3 Apr 2022 18:44:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=oelzyvVnua9v
        rR6jDZnANK8VUGXU7SQNihCEwqYTn5w=; b=w/qczLzDQZlqUPbFtzoMRN/m4dKu
        VWRqhFL3qL8GeOBaM68NJrmcnfsrovYWQCLZT0CS5oL2Wqskq5qRo4RS/p9dazlw
        Nluth54Ok3kytKzqhA5BvoqtNPHQ4L8bEWufG2XyR9q0SlUGOUfA927nquI62Y0/
        vpvbDtAiM0KKvPg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BABC718687C;
        Sun,  3 Apr 2022 18:44:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2239918687B;
        Sun,  3 Apr 2022 18:44:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Fernando Ramos <greenfoo@u92.eu>, git@vger.kernel.org,
        davvid@gmail.com, sunshine@sunshineco.com, seth@eseth.com,
        rogi@skylittlesystem.org, bagasdotme@gmail.com
Subject: Re: [PATCH v9 3/4] vimdiff: add tool documentation
References: <20220329224439.290948-1-greenfoo@u92.eu>
        <20220330191909.294610-1-greenfoo@u92.eu>
        <20220330191909.294610-4-greenfoo@u92.eu>
        <d01710e1-8a42-e4d1-5034-f6796372587e@gmail.com>
Date:   Sun, 03 Apr 2022 15:44:34 -0700
In-Reply-To: <d01710e1-8a42-e4d1-5034-f6796372587e@gmail.com> (Philippe
        Blain's message of "Sun, 3 Apr 2022 16:02:08 -0400")
Message-ID: <xmqq1qydu6r1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A2A59004-B39F-11EC-99E3-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Hi Fernando,
>
> Le 2022-03-30 =C3=A0 15:19, Fernando Ramos a =C3=A9crit=C2=A0:
>> Running 'git {merge,diff}tool --tool-help' now also prints usage
>> information about the vimdiff tool (and its variants) instead of just
>> its name.
>>=20
>> Two new functions ('diff_cmd_help()' and 'merge_cmd_help()') have been
>> added to the set of functions that each merge tool (ie. scripts found
>> inside "mergetools/") can overwrite to provided tool specific
>> information.
>>=20
>> Right now, only 'mergetools/vimdiff' implements these functions, but
>> other tools are encouraged to do so in the future, specially if they
>> take configuration options not explained anywhere else (as it is the
>> case with the 'vimdiff' tool and the new 'layout' option)
>>=20
>> Note that the function 'show_tool_names', used in the implmentation of
>
> typo here: implementation (by bad!)
>
> Maybe Junio will correct it before merging to next ?

Thanks.

$ git range-diff @{1}...
1:  7efd9fdf62 ! 1:  7b5cf8be18 vimdiff: add tool documentation
    @@ Commit message
         take configuration options not explained anywhere else (as it is=
 the
         case with the 'vimdiff' tool and the new 'layout' option)
    =20
    -    Note that the function 'show_tool_names', used in the implmentat=
ion of
    +    Note that the function 'show_tool_names', used in the implementa=
tion of
         'git mergetool --tool-help', is also used in Documentation/Makef=
ile to
         generate the list of allowed values for the configuration variab=
les
         '{diff,merge}.{gui,}tool'. Adjust the rule so its output is an A=
sciidoc
2:  3e7aa9c425 =3D 2:  980145f747 mergetools: add description to all diff=
/merge tools
