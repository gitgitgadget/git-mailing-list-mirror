Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F267D1F463
	for <e@80x24.org>; Wed, 11 Sep 2019 08:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfIKILU (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 04:11:20 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:36329 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfIKILT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 04:11:19 -0400
Received: by mail-io1-f52.google.com with SMTP id b136so43863605iof.3
        for <git@vger.kernel.org>; Wed, 11 Sep 2019 01:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qotilabs-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=nxE2lhIj5zRIQSROOEQmOOILukX7U13+NJUX15PRscc=;
        b=qmDi9FCFwcRSNwHupC50LgAdwiLtdqrrcV5zxcgMuYt6vRpb1+leySwifUmIx1oA9p
         iSa96ZKHg1ugZ+TYzBxXlppc1MQswUSPmD64uh19uNdwybHeNyAXnw0OAQcyKfS4V2iI
         BTzYajh9zY8kWTCDi5rxHayPxZdj5rciT820d6StmVLZtBZuNFs2pJ1HpmmKzMSbZq3j
         OOapO5dMWLj2OcRgbcRuaIZ/poCbITLO4K8aYYjdJvS4Kb2y/NwPWdYeADhK0/HmjR7Q
         TGWK1lw0+KGAISTjeVs1qiIKt/HpgXOy83ZiCa/5LLcf4sxcFVZf3giIYbvmu8qUqHiA
         HnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=nxE2lhIj5zRIQSROOEQmOOILukX7U13+NJUX15PRscc=;
        b=F0vpFFxmAAoOxbkXC2sJj0m8wccAIfWm9Wj6wy+dyQcUaxgcR3+tVAiORVQMeblmyT
         evixcjI1YbLijCKy+4aoKS026hSRKaKkJim8THkBFjDjz29+uqsbMyhN81AzCmvrjyVu
         rfayTBnzGhiac+i+nVYi6eV54FOH4jvR0XwUe8WhJuZ5CZY9W/CVkOHKimHcw28eQPxp
         i58CmOrYXTFvAkbBDBnhfJeyZFbI0gZIX5NMsTIH9aHyL6PCCtz6LeQykDripNXVm7bK
         6ck3PufBpn1iASuVF7G9un8t1gWefpEMvS7fXM6CakFjmtrMDj/02Ea2s+JdbfeiJ0bY
         p3Yg==
X-Gm-Message-State: APjAAAW3a8cEzXe/MQRtwhAQfJ9dfyP7WrS9Ri2szVwIGwHy8bIMCDSq
        uUHcY/YyjFLHO3BEf5ZJKYn6qfKLPmsZbHcsHeUk17v95mA=
X-Google-Smtp-Source: APXvYqw/SZfOf+A8/TmMV1Gs9X5PqHFIfp5/BtiRvQegtzPMVKBnWmQbwTso4/p+cbZVMpA8SJS4y9APcF/MggyUbfc=
X-Received: by 2002:a02:93e5:: with SMTP id z92mr14560288jah.8.1568189478861;
 Wed, 11 Sep 2019 01:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <CA+oNJz+N_b6Gq-gVu0ZnGbL_ppdu0LDSfqPJjsV8QAghrS1Rkg@mail.gmail.com>
In-Reply-To: <CA+oNJz+N_b6Gq-gVu0ZnGbL_ppdu0LDSfqPJjsV8QAghrS1Rkg@mail.gmail.com>
From:   Bogdan Butnaru <bbutnaru@qotilabs.com>
Date:   Wed, 11 Sep 2019 10:11:03 +0200
Message-ID: <CA+oNJzKoQ-PmwY=p2W5HhCk1qn-BCwAKMZzZUn_7p2GVi-r9=w@mail.gmail.com>
Subject: =?UTF-8?B?RndkOiBQYXRoIGluc3RlYWQgb2YgcGF0aHNwZWMgZm9yIOKAnGdpdCBjaGVja291dCA8dA==?=
        =?UTF-8?B?cmVlLWlzaD4gWy0tXSA8cGF0aHNwZWM+4oCd?=
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!

Not sure if I=E2=80=99m doing something wrong here, but it seems that when
calling =E2=80=9Cgit checkout <tree-ish> [--] <pathspec>=E2=80=9D, the last=
 argument
is not interpreted correctly.

I have a repository that contains a multi-module Maven project, and as
such it contains several =E2=80=9Cpom.xml=E2=80=9D files, one in the root d=
irectory
and a few others in sub-directories. If I understand correctly the
documentation, calling =E2=80=9Cgit checkout 0123abcdef -- :/**pom.xml=E2=
=80=9D=E2=80=AFshould
checkout (to the working tree and the index) all files named =E2=80=9Cpom.x=
ml=E2=80=9D
from revision 0123abcdef. As of version 2.23.0.windows.1 it only
checks out the =E2=80=9Cpom.xml=E2=80=9D file from the root of the reposito=
ry.

However, if I run =E2=80=9Cgit checkout --patch 0123abcdef -- :/**pom.xml=
=E2=80=9D,
then during the interactive process I am asked about changes from all
=E2=80=9Cpom.xml=E2=80=9D files, everywhere in the directory hierarchy. (Th=
e short
form =E2=80=9C-p=E2=80=9D also works.) If I just type =E2=80=9Ca=E2=80=9D a=
t every prompt, I get what
I expected from the first command, i.e. all matching files in the
given revision.

(I just tested that version now because it=E2=80=99s the newest I can find.
But the issue happens since at least 2.20, probably earlier.)

Cheers,
=E2=80=94Bogdan Butnaru
