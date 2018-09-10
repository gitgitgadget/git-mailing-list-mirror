Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2CD01F404
	for <e@80x24.org>; Mon, 10 Sep 2018 16:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeIJU6G (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 16:58:06 -0400
Received: from st14p37im-asmtp002.me.com ([17.41.209.31]:18120 "EHLO
        st14p37im-asmtp002.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbeIJU6G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 16:58:06 -0400
X-Greylist: delayed 3628 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Sep 2018 16:58:05 EDT
Received: from process-dkim-sign-daemon.st14p37im-asmtp002.me.com by
 st14p37im-asmtp002.me.com
 (Oracle Communications Messaging Server 8.0.2.2.20180531 64bit (built May 31
 2018)) id <0PEU00L00HSWYB00@st14p37im-asmtp002.me.com> for
 git@vger.kernel.org; Mon, 10 Sep 2018 15:03:06 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;     s=04042017;
 t=1536591786;  bh=3wbse0mK3xK462pdf1MTRrEnKvFfAiHmqV2AhgiJDNE=;
        h=From:Content-type:MIME-version:Subject:Message-id:Date:To;
        b=MPauTHc2BDC7j77I6K1XfyW5LJDxUln1mVBaN5aSaLHIzpFEYfOmXIiFSCg2fcY8M
 GZX2EF8sS/RLlXL7oEKkDB8xR5+FvX1SWmKp7qJYozq/d1pLCwjIZtUw19IUyucnPr
 00onw9whsNi8wjUqXNpCYw+6phM4TcgRhXMasxSnSrUSS3K0i2wbZeyd5AE//wJWOH
 2xGeySuad6AaqdQCBCIbA/fdLRuQ8klKbx9ZbCWiw17LpzhgZwocA2HTFyQ2bbtPxT
 yPy7CAD/SeunIh01oR9QsmM3GGy19GwYLZ6TfkxlvDp5LnUNe5gHIjvfmasZ1wuhqo
 x6Lt7RaIQJRew==
Received: from icloud.com ([127.0.0.1]) by st14p37im-asmtp002.me.com
 (Oracle Communications Messaging Server 8.0.2.2.20180531 64bit (built May 31
 2018)) with ESMTPSA id <0PEU00NG0HT08W10@st14p37im-asmtp002.me.com> for
 git@vger.kernel.org; Mon, 10 Sep 2018 15:03:02 +0000 (GMT)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1011 suspectscore=1 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1809100152
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2018-09-10_08:,, signatures=0
From:   Vasily Korytov <vasily.korytov@icloud.com>
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: quoted-printable
MIME-version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: zsh completion does not support branches with quotes/apostrophes
Message-id: <E2F53114-B4F9-4787-8017-60C976C8E03C@icloud.com>
Date:   Mon, 10 Sep 2018 18:02:59 +0300
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have the latest git and it includes a nice auto-completion for zsh: =
contrib/completion/git-completion.zsh

I=E2=80=99ve been using it happily for.. years I guess, until I ran into =
a problem yesterday.
I have a branch with apostrophe, named like: somebody's_business

When I want to switch to that branch, I type: git checkout some[tab] and =
the result is:
`git checkout somebody's_business` (and that does not work in zsh, of =
course).
For this to work it should escape the apostrophe and the completion =
should result it:
git checkout somebody\'s_business

When I try to use the quotes in the parameters, this does not work at =
all:
i.e. when I type `git checkout -b =E2=80=9Csome[tab]` nothing is =
completed.

So the only work-around for now seems to be manually fixing the =
completion results, escaping the quote.
However, it would be very nice if this could be fixed.

Thanks.

--=20
  Vasily Korytov
  https://chillum.github.io

