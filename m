Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60EFC3F68F
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 00:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9676F2075D
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 00:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfL3AOO convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 29 Dec 2019 19:14:14 -0500
Received: from gateway34.websitewelcome.com ([192.185.148.194]:44973 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726119AbfL3AON (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 29 Dec 2019 19:14:13 -0500
X-Greylist: delayed 1203 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Dec 2019 19:14:12 EST
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 99249A566C2
        for <git@vger.kernel.org>; Sun, 29 Dec 2019 17:54:08 -0600 (CST)
Received: from gator4087.hostgator.com ([192.185.4.99])
        by cmsmtp with SMTP
        id liNsicCuyW4frliNsitvLa; Sun, 29 Dec 2019 17:54:08 -0600
X-Authority-Reason: nr=8
Received: from mail-qk1-f181.google.com ([209.85.222.181]:40157)
        by gator4087.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <xda@abalgo.com>)
        id 1iliNs-002lti-D5
        for git@vger.kernel.org; Sun, 29 Dec 2019 17:54:08 -0600
Received: by mail-qk1-f181.google.com with SMTP id c17so25264561qkg.7
        for <git@vger.kernel.org>; Sun, 29 Dec 2019 15:54:08 -0800 (PST)
X-Gm-Message-State: APjAAAUJj0JloyxJHPtzEuhfL50LjT1Yf8mVtyH7JN3DGtGW7iuuEdWZ
        AN7U8xxmAIjv4A+20a4gNjx5vVCeiE9ddJm8UDw=
X-Google-Smtp-Source: APXvYqzv7/hs5CAqDbSTSGnI3OSfUR979rbY5jGTnpdPSEnYTbzpyzrIxR2sTNcakqnkKs/wJrSMwi6cLlhLSJd4y6U=
X-Received: by 2002:a05:620a:1001:: with SMTP id z1mr38181300qkj.99.1577663647889;
 Sun, 29 Dec 2019 15:54:07 -0800 (PST)
MIME-Version: 1.0
References: <CAEW0o+jV+r1UMZReRXa3g_fyqCYxHTVYVf6pWvjB7_isofbBaw@mail.gmail.com>
 <xmqqd0c6iuw0.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0c6iuw0.fsf@gitster-ct.c.googlers.com>
From:   Arnaud Bertrand <xda@abalgo.com>
Date:   Mon, 30 Dec 2019 00:53:56 +0100
X-Gmail-Original-Message-ID: <CAEW0o+g7vXj841h+4nNK8iSoO758Uh9fLKMCN87RE2w2Nd=CRg@mail.gmail.com>
Message-ID: <CAEW0o+g7vXj841h+4nNK8iSoO758Uh9fLKMCN87RE2w2Nd=CRg@mail.gmail.com>
Subject: Re: Feature request: add a metadata in the commit: the "commited in
 branch" information
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Arnaud Bertrand <xda@abalgo.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4087.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - abalgo.com
X-BWhitelist: no
X-Source-IP: 209.85.222.181
X-Source-L: No
X-Exim-ID: 1iliNs-002lti-D5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: mail-qk1-f181.google.com [209.85.222.181]:40157
X-Source-Auth: abalgo
X-Email-Count: 16
X-Source-Cap: YWJhbGdvO2FiYWxnbztnYXRvcjQwODcuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

It really depends how git is used. With big collaborative project
(like git or linux kernel), you are totally right.
for development limited to a company that has developments with team
of 10-20 developers and that uses
a correct SCM plan, the name of the branch is regulated and is
meaningful, mostly  linked to a bug tracking system
system. For audits and  traceability, the branch name is really
important... certainly more than the email of the developer ;-)
So the "contamination" is negligible compare to the bentefit in this context.
It will also helps the graphical tools to have a comprehensive
representation which can do git even better.

If you think it is a bad idea to have it by default, what about an
option to activate this functionality ? Today with the patch I've
done, it is not a problem if there is no branchname in the commit. The
only thing is the "%Xb" placeholder.

I would like to have your advice about the name because I have added
the "branch" metadata but, even it is really the name of the branch, I
think it too "hard". I preferred "BranchOfCommit" or something similar
that is more explicit... I think this one is too heavy. Do you have
other suggestions ?

Thanks for your feedback
.


Le lun. 30 déc. 2019 à 00:20, Junio C Hamano <gitster@pobox.com> a écrit :
>
> Arnaud Bertrand <xda@abalgo.com> writes:
>
> > I understood that in git philosophy, once it is merged, a branch can
> > disappear. But for a lot of companies, a SCM is also a guardian of the
> > history.
>
> A lot more important point than "once it is merged" is that the
> branch identity is strictly local to your repository.  Contaminating
> the object header, which is cast in stone and cannot be modified
> after the fact, with such a piece of information will not mix well
> with the rest of Git, so ...
>
>
