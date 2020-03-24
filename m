Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E88FC10DCE
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 22:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 116F52080C
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 22:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="j2O25WOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgCXWbP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 18:31:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:46633 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728227AbgCXWbP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 18:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585089071;
        bh=AigWq7iUsbi8t+P0MA/Cbx7Sb7iywO0n95dnq69cboE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=j2O25WOKliLxVd3LLWotVrJcxR30tW15OwCmylx7cs4Id9qsx71oZMUXjIBqOz5p7
         92SVKwvVmC4QiY2qsOCE/jqQ3MGa/G+E8CixYEdziSv8Cp/3dzEAko/hBzjU17FjXh
         3KQipRzm+53AJXC+BBZT8eTRa61FKjnlN0Z1Icps=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.213.32]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MWigq-1ijz8x19tA-00X8AC; Tue, 24 Mar 2020 23:31:11 +0100
Date:   Tue, 24 Mar 2020 23:31:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 6/8] t7063: drop non-POSIX argument "-ls" from
 find(1)
In-Reply-To: <xmqqy2rr5amm.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2003242330540.46@tvgsbejvaqbjf.bet>
References: <cover.1584838148.git.congdanhqx@gmail.com> <59e3f73784b2a3bd9ccec87412e6178411c3708e.1584838148.git.congdanhqx@gmail.com> <nycvar.QRO.7.76.6.2003231509150.46@tvgsbejvaqbjf.bet> <xmqqy2rr5amm.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RdmgthfjzTT7BF0V/S92TlolGV7jZE5te85tNwHJdg0mkFRWJRw
 uyFsv9c7N8ToC6nIdOS2UwixqKKaW9wr5RCOpPjoiN/N8iuZdiVMeRNEsHJHD0veGSuRFgi
 XLStyWf3SkIcK+ZWTCWg2Rfe+i6WzNQ8FvYCUzCg59X1pcef68yVQimoKNr6HIDL266Nuc8
 +E+DEojR7oRMwGXTP4jlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FvppS1SbnQw=:y+QFiM/gO/zvBzhmNngvht
 z8f6NP4qrGQRWFjTLp3wa6W3vDwl1xFwHr7yXROiSpFbYlMO+hE3jT8/nJmVRMTjiVmSRsRiL
 d+cb6vP/sLZS7SC7l2qSEtSl8e3SAXuU8n+YJ7jFMcbpiAtrBOaiyggObVGPzXUiZ8XzGJVX6
 Y9AI1fMEd7nq0XPY2Al3qcxjGJjGyhwSCCI9DB3zkCvWcxPrpdohZNcuLFGHh7BolU6SrFOmX
 nOaZDl42lghEv0iXT7ISi+GVeG4y5XwznH15+BLtc0PYTJc4RBp5PdsD6USPA5ZOEKvh9XAGa
 Ffuz+ry8RWQNtpsoJt5NekMml73SdIc8V5GBt60aLjONrvk+N2hAYGEw6Wy9f/o3+/ardCcNX
 +xFa4My6iQo40qu3cZwSH+LvjlzDy2hYJLjdhG82BBFk/JoKKdMPJLiFAfNksiI1nOVy+/wKW
 F9eP5M6HnEe8DnRt27kl+CL37Von9l+mbeHi4ppfkNMh1cQAkbHMXhUhWB5/1P7UwwftQpvfo
 8CxjfyLg2tmyz7rewoXLs09PGrGv4EOxq0kp9Iqw9YEPVmZ+r0jBOxMUWOi6scdGOMhPczJey
 fHKe2TimAP3qWB/in+pHumJaUtSqjlpQhzNBk8Uzo6RnRzr0iqoXU8UBR3wTOdsquaeTp6sAi
 U2IB+KeOODD21eLn+jRLwcgl/ZnmsXWyWCKc3HY2NvVwR5d7uYZ/ijKBb8P2nYdso+fEaq7Fm
 US4UAJJTr4vfO6NIA7rOTAmENdXpC8Sbdd919lMa7VN1ErmzRm81dCl4oJJ+Y0GcH6pOsMUg/
 7iGJFHFqEMOP169tCRCjRcaGLcWpOW+umo0GhU2f0k/O62mezH5s8H0mwPcc/S2DSF8yNC7Ol
 0S04R8L0Rj3mG72iRXQpv7Ww3/TAL2j5yENUZ6vzAugTkv4ozy5/auC/I6wp8cbwoV74egLh7
 cn6e28xIoPFSY4YL9z3HHCaOQB+dEyNEDZ4Ue//K3gGngMVU6oqopkA0FERUG8POOc8J1SCy/
 lE0f8v0Z8IiDjdzjNcQpz+0u2sCBGfv8aONXwdZwArZPvXCA37UZ9wWeLaWOmDEtzV1ZyGlMq
 8hnJVj3OipAC5rUkLcVPIK717Xh5DBrkacl3Rr07YyS82bf3nAgDwBJzLcgP69/tesEimELj/
 R59qPssOT9R/XsSaVhKUpH+oTgQvw6TPl1vXqE+nE1chdpW1uUnTUzt+n0lEFdbAHqtAqmDjz
 F2cNhE+BuBfy0bQ+2
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 23 Mar 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > diff --git a/t/t7063-status-untracked-cache.sh
> > b/t/t7063-status-untracked-cache.sh
> > index 190ae149cf3c..ab7e8b5fea01 100755
> > --- a/t/t7063-status-untracked-cache.sh
> > +++ b/t/t7063-status-untracked-cache.sh
> > @@ -18,7 +18,12 @@ GIT_FORCE_UNTRACKED_CACHE=3Dtrue
> >  export GIT_FORCE_UNTRACKED_CACHE
> >
> >  sync_mtime () {
> > -       find . -type d -ls >/dev/null
> > +       if test_have_prereq BUSYBOX
> > +       then
> > +               find . -type d -print0 | xargs -0r ls -ld >/dev/null
> > +       else
> > +               find . -type d -ls >/dev/null
> > +       fi
>
> Given that this is only to work around the lazy mtime sync found on
> BSDs, if we were to have any if/then/else, shouldn't we be rather
> doing
>
> 	if test_have_prereq NEEDS_SYNC_MTIME_BECAUSE_WE_ARE_ON_BSD
> 	then
> 		find . -type d -ls >/dev/null
> 	fi
>
> to make it a no-op for most everybody (including Windows)?

I like that approach.

Thank you,
Dscho
