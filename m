Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47DDC432BE
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 09:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B30F061374
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 09:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbhHXJKO convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 24 Aug 2021 05:10:14 -0400
Received: from shark2.2a.pl ([213.77.90.2]:55921 "EHLO shark.2a.pl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235396AbhHXJKN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 05:10:13 -0400
X-Greylist: delayed 539 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Aug 2021 05:10:12 EDT
Received: from wrasse.2a.pl (wrasse.2a.pl [213.77.90.7])
        by shark.2a.pl (Postfix) with ESMTP id F25941750875
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 11:00:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 2a.pl
Received: from shark.2a.pl ([213.77.90.2])
        by wrasse.2a.pl (wrasse.2a.pl [213.77.90.7]) (amavisd-new, port 10024)
        with ESMTP id G66aUzYRLRus for <git@vger.kernel.org>;
        Tue, 24 Aug 2021 11:00:06 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.8.1.26])
        by shark.2a.pl (Postfix) with ESMTPSA id 04F051750808
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 11:00:06 +0200 (CEST)
From:   Krzysztof =?utf-8?B?xbtlbGVjaG93c2tp?= <giecrilj@stegny.2a.pl>
To:     git@vger.kernel.org
Subject: git log --encoding=HTML is not supported
Date:   Tue, 24 Aug 2021 11:00:03 +0200
Message-ID: <9896630.2IqcCWsCYL@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Co robiłeś/-aś zanim pojawił się błąd? (Kroki, aby odtworzyć problem)
{ git log --oneline --encoding=HTML stl_function.h; }

Co powinno się stać? (Oczekiwane zachowanie)
828176ba490 libstdc++: Improve doxygen comments in &lt;bits/stl_function.h>

Co stało się zamiast tego? (Rzeczywiste zachowanie)
828176ba490 libstdc++: Improve doxygen comments in <bits/stl_function.h>

Jaka jest różnica między tym, co powinno się stać, a tym, co się stało?
Znak początku nazwy pliku jest interpretowany jako znak otwierający znacznik.

Inne cenne uwagi:
Błąd u klienta:
<URL: https://bugs.kde.org/show_bug.cgi?id=441255 >

Implementacja wtyczki:
 "--pretty=format:
<tr> 
<td><a href=\"rev:%h\">%h</a></td> <td>%ad</td> <td>%s</td> <td>%an</td> 
</tr>"

Podobne zgłoszenie:
<URL: https://public-inbox.org/git/CACPiFCLzsiUjx-vm-dcd=0E8HezMWkErPyS==OQ7OhaXqR6CUA@mail.gmail.com/ >

Proponowane rozwiązanie:
W odróżnieniu od omawianych powyżej trudności używaniem formatu wynikowego 
JSON, moim zdaniem w tym przypadku wystarczyłoby zakodować znaki [<] i [&] 
w treści w sposób odpowiedni dla HTML.
(To rozwiązanie nie zakłada wykrywania i odrzucania znaków nieprawidłowych.)

[Informacje o systemie]
wersja gita:
git version 2.32.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.13.12-1-default #1 SMP Wed Aug 18 08:01:38 UTC 2021 (999e604) 
x86_64
informacje o kompilacji: gnuc: 11.1
informacje o bibliotece libc: glibc: 2.33
$SHELL (typically, interactive shell): /bin/bash


[Włączone skrypty Gita]



