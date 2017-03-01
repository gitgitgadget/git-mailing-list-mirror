Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1C682023D
	for <e@80x24.org>; Wed,  1 Mar 2017 17:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753205AbdCARw0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 12:52:26 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50228 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753202AbdCARwW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 12:52:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A4DF5757EC;
        Wed,  1 Mar 2017 12:52:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Op4/lFAzgDJp
        WfA+/WBbYFh2JUo=; b=XApFnLmSFtc+NkgzkobCgtSb5wU+20KYt1xJ61bu5PhO
        BTbXdJzujQFLujpeiiulz1SuGF7tL9pmaJMzoI/+ntIAGCNb45kv6kA7s9SifUU9
        +X5dnrFlNnuCgpw4TqxKxI5C5GvOh1q/PK9y6q2yGbVVMpvE/7qfwJb5pE9OVqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=DystnW
        7uJT0VuR5MOyDReXkMvouwQrmamyd6aPj1J5WCaDvEbTk1+iXmnumi2E1vQXTOow
        6cOWugi3V+OhIuF0xHbdgnne2dbVoMOAbQR+fpZh4FHStcVluj77A5XS+1zbwYlk
        7N1tst5NWidFYJ5FgP3VWfP9//QlQJaoh0O9E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CED2757EB;
        Wed,  1 Mar 2017 12:52:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F3CC6757EA;
        Wed,  1 Mar 2017 12:52:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        sschuberth@gmail.com, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Philip Oakley <philipoakley@iee.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v7 0/3] Conditional config include
References: <20170224131425.32409-1-pclouds@gmail.com>
        <20170301112631.16497-1-pclouds@gmail.com>
Date:   Wed, 01 Mar 2017 09:52:12 -0800
In-Reply-To: <20170301112631.16497-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 1 Mar 2017 18:26:28 +0700")
Message-ID: <xmqqk288hokz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CD6B5998-FEA7-11E6-BD86-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
>   config.txt: clarify multiple key values in include.path
>   config.txt: reflow the second include.path paragraph
>   config: add conditional include

Thanks.  The primary change looked good (it looked good already in
the previous round).

Here is a list of minor suggestions on top.

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2a41e84bab..5faabc7934 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -82,7 +82,7 @@ Includes
 You can include a config file from another by setting the special
 `include.path` variable to the name of the file to be included. The
 variable takes a pathname as its value, and is subject to tilde
-expansion. `include.path` supports multiple key values.
+expansion. `include.path` can be given multiple times.
=20
 The included file is expanded immediately, as if its contents had been
 found at the location of the include directive. If the value of the
@@ -96,8 +96,7 @@ Conditional includes
 You can include a config file from another conditionally by setting a
 `includeIf.<condition>.path` variable to the name of the file to be
 included. The variable's value is treated the same way as
-`include.path`. `includeIf.<condition>path` supports multiple key
-values.
+`include.path`. `includeIf.<condition>.path` can be given multiple times=
.
=20
 The condition starts with a keyword followed by a colon and some data
 whose format and meaning depends on the keyword. Supported keywords
