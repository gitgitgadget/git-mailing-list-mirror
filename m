Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6077F207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 15:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934109AbcILPkt (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 11:40:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51848 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934062AbcILPkq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 11:40:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E16623D384;
        Mon, 12 Sep 2016 11:40:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=VQarWiIovG2Pen+RmzFnPWMQi
        XM=; b=gqUKnL7/gOsT98Z1FvolmD84Tn96y/frQP7It1p4VA5SmKNsQCukm4yAo
        KsB1YBUASI8jbMNZNJIejpsoeagS0GdK/gzpZxPmkQPqaZpCnihGvHlnMichxXfo
        DLky7CkuvESu6lq5U4y4oxA3Hqui07venugtW1QA4cZRse4INg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=jIl7Fh8jazbSwhAKE0P
        1yrF1x4nr0ZNw+uPupKSIKPu4TrzB5jIef7A66geBFwPl03R4m2dJSYIZrkxVeEe
        i+uNF5tptv/JzD3Pr1gFhelBc6Wn8rFf+Ga2FovqEx6xHHJOBD5vGQ98U5mZ2qCv
        7PdCJxY7ZCc3EcquE1sohRxQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DA54D3D382;
        Mon, 12 Sep 2016 11:40:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6031E3D380;
        Mon, 12 Sep 2016 11:40:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>, git@vger.kernel.org,
        Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 04/13] i18n: blame: mark error messages for translation
References: <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt>
        <1473259758-11836-4-git-send-email-vascomalmeida@sapo.pt>
        <2532042.KMOOJ8STkh@cayenne>
Date:   Mon, 12 Sep 2016 08:40:42 -0700
Message-ID: <xmqq37l55dol.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 44962CB6-78FF-11E6-8370-51057B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

>> @@ -2820,7 +2820,7 @@ int cmd_blame(int argc, const char **argv, const=
 char
>> *prefix) &bottom, &top, sb.path))
>>  			usage(blame_usage);
>>  		if (lno < top || ((lno || bottom) && lno < bottom))
>> -			die("file %s has only %lu lines", path, lno);
>> +			die(_("file %s has only %lu lines"), path, lno);
>
> Here a plural version is needed.

Good eyes, like this?

 builtin/blame.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 3fee197..cb12085 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2820,7 +2820,9 @@ int cmd_blame(int argc, const char **argv, const ch=
ar *prefix)
 				    &bottom, &top, sb.path))
 			usage(blame_usage);
 		if (lno < top || ((lno || bottom) && lno < bottom))
-			die(_("file %s has only %lu lines"), path, lno);
+			die(Q_("file %s has only %lu line",
+			       "file %s has only %lu lines", lno),
+			    path, lno);
 		if (bottom < 1)
 			bottom =3D 1;
 		if (top < 1)
