Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A38C5519F
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 11:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32C8520789
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 11:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="N+PeeKcH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgKVLCP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Nov 2020 06:02:15 -0500
Received: from mout.web.de ([212.227.17.12]:42161 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727360AbgKVLCP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Nov 2020 06:02:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1606042928;
        bh=C/5wnirZ8DSwFWgZ7+CAtOuY1pW89Ssc+YKRvyxYgQY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=N+PeeKcH+WHfsv+uBGTTe0vBh4j9a9wnrJ3blwubhatShLft/IfCK8g4InxjY28C2
         q3cmpFy2XV9wMT3IwzJ0UrsB13ZyTdzFB92d+GD1y8nleW6OMlEtb7DSKuq7KuTLpf
         rY0fUl9nNCopuA13G+66Oemibk0UnNsdcR4yvdiU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Martm-1kvaCA1gF8-00KTCN; Sun, 22
 Nov 2020 12:02:08 +0100
Subject: Re: What's cooking in git.git (Nov 2020, #04; Thu, 19)
To:     Junio C Hamano <gitster@pobox.com>
References: <xmqqwnyeqpw9.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org
Message-ID: <3b2afb7a-57aa-025c-806f-ae3faa0ed077@web.de>
Date:   Sun, 22 Nov 2020 12:02:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqwnyeqpw9.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VnmCaTYzbNE+vy0qIGQF8wg+DCOcWoNBLFO87zI2VDb1/czxEPV
 DhGbDvV74FK0lm06TsRMbv9ezi3V4NOhNSJvoJ4eBg/PJ7pSHOUG+Ig/f1MtZe0Jlofdeti
 gaN1yhKOLCMXdSF/ctT5iWxt0f2sAmY1HlOIsGB+dlBMRam3h6/3abjHeuuEbDRDpp5yQji
 IoWrN/3L4w9xhDinhE6Dg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vVHyTOwnWyE=:jYWQiNIFOdIfJ8tuow6OSQ
 IWIUaNmaL+c2oI/6Dkx9MskTfUR8JWQxXmrPJ7ig55JZ5YyfDmYZ2/Q3qhZj/G2z2FjTNWr/6
 c1MSWxlT2EQHT4A4sngfCyxG/7lOBl+0M3Ie+iWUWpGKnIJVNG1dXEdxcALzgbt3L0fYh6aSq
 qRw0iM7IlCRRFN+qew599fUAFTfW4drPgwjhpDJNKKY113sUgfWsG6TOnaSHY80jC//B/1eiJ
 /SKXEvUYces0ufK5YDvB0WhtTwWqXQwVnAhHJY8NmuHlddCjOBxpBjuoogYMQBLTihLSHHCJt
 8NJ3Aw/JR8osLM6DE32+neFkxGeUtKeWgHIIXP4V+zXHTkuyRHBPyLaIfZc8sUU1n5aWLGWHj
 Zz1HbXmsRr+vfs5HYHKP0gNHl5fTUMmJXvJwONgOTC/czymcPQBlJSMNj1tqrDuxMTDS7PL8E
 6lkoyCMNT+aQ3+G7HxyHb+NC98OKkGzak7gN5TB1wRs4XCptGpcTfpwzo3yqSLnArlo2Dvac8
 OuPZ/I3JORUHnnktlzEngg1DzDdv51mUDDBvJVr/07wl5ie97Nnra0SYxojLZ1Y0617At7Lpo
 3kogigQ2CyJ5Hv3VJUfhs6mlH740DpSeXTNmKq5W5vMibLyi4sxz/DWJ7vmoH90BsyqYPsNP1
 M0o0qvnlGjTZL7+Y7JG/dohDozpG6wYFemsgPn5d7VQ9F4o7sMi7WqvBOfrdO4NTGVp2uwCkl
 Rh2foi0LVgx50ABtIGb23uJ+wVJ02+GbZ0GFodR0R2kcJ/SEYaZSJ5TD+Vbrzh62I+nfgT1bs
 rCH/YLoDFsTpCHxD5/38/jg6kESGMgeOrPYziIjF0UkI+fXSHo2hyi0jLF4cNVNrZ8xTNzSOr
 HovJTFo8dhuS7Ut2kwiQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.11.20 um 23:57 schrieb Junio C Hamano:
> * rs/chdir-notify-unleak (2020-11-16) 1 commit
>  - chdir-notify: UNLEAK registrated callback entries
>
>  Mark some stuff on list_head chain with UNLEAK() macro to squelch
>  leak checker.
>
>  Will merge to 'next'.

Please drop this one, it's too weak.  We can get the same effect by
reordering the struct members, but a better solution would be to
actually free the allocations on exit.

Ren=C3=A9
