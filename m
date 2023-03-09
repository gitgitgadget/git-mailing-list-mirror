Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EB4C64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 23:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjCIXUj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 18:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjCIXU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 18:20:29 -0500
X-Greylist: delayed 464 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Mar 2023 15:20:25 PST
Received: from qs51p00im-qukt01071902.me.com (qs51p00im-qukt01071902.me.com [17.57.155.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74543F4DAD
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 15:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1678403559;
        bh=kK3Jg/Z659XSSAERes/mURotL9mEBl3luHySflEG5pY=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=0oHPcie27ZJPaFfx2bfp4MgtQAP5ouhpNtt5JgVb/rYd4RFPtMVJWMsykHFw3PynG
         8dW9xmIVhoCDVY3oTXug09yVLkoPUJMuWLtjOa6zQDsQMl5ctp/dM5Iz6pd4tmb75V
         EjReQkcqw65hS5E4rT8vGmWbj6+WR6PyPGUQpEdF44IAzisTWvwIWxAIYGOqdphkX9
         GfFwI43LP4gNTU7cTWkyFE5Qj11QB3X0LNZCooWXH1Ve8KPJDp1ErHgU+MwTOKxUQi
         VxcvHhHp9X/I1l/wsvn+ZWl7oCjSuO8WVx3MwesMIht7T65Gi+LQTMOZKyQksbf+9K
         yecv4AJz+FjMA==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01071902.me.com (Postfix) with ESMTPSA id 7E2D65EC0644;
        Thu,  9 Mar 2023 23:12:38 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: Feature Request - Better i18n support
From:   Emir SARI <emir_sari@icloud.com>
In-Reply-To: <xmqqfsad8tap.fsf@gitster.g>
Date:   Fri, 10 Mar 2023 02:12:25 +0300
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9F4F74FC-B424-4BF7-9F9D-8A821C89B442@icloud.com>
References: <ZAnXddDN7v0AOBdm@mbp.local> <xmqqfsad8tap.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Proofpoint-ORIG-GUID: 5gbmdvX8ZhO524qsdo1s_gbF-tCwdGLs
X-Proofpoint-GUID: 5gbmdvX8ZhO524qsdo1s_gbF-tCwdGLs
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-11=5F01:2022-01-11=5F01,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1011
 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2303090186
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Thank you very much for the prompt responses.

> Junio C Hamano <gitster@pobox.com> =C5=9Funlar=C4=B1 yazd=C4=B1 (10 =
Mar 2023 01:16):
>=20
> These are currently not even marked with _() to be translatable, and
> it should be just the matter of enclosing them in _().
>=20
> If these should be translated in the first place, that is.  I do not
> think these are originally meant to be machine parseable (it is
> shown as part of "git apply --summary"), but existing users may
> already be abusing them as such.

My general idea is, if the percentages appear with the translated
strings, they should use the localised format. Otherwise if they
only appear with some machine-output without any localised context
it is perfectly fine to leave them as-is.

> brian m. carlson <sandals@crustytoothpaste.net> =C5=9Funlar=C4=B1 =
yazd=C4=B1 (10 Mar 2023 01:27):
>=20
> More specifically, I think it could be fixed for progress output, but
> there are a few places in diff output where it couldn't because it =
might
> be parsed.  Would you be willing to try a patch for this?  I think the
> code you're probably thinking about is in progress.c (search for =
"%%"),
> but there might be other places you have in mind as well.

The progress output was my biggest motivation in reporting this. It was
rather disturbing to see translated strings with unlocalised values.

I=E2=80=99d love to assist in testing any possible patches. Just let me =
know of
any possible scenarios, and I=E2=80=99ll get back to you. Being in =
vacation, I
have plenty of time available.

> Can you clarify what places you're thinking about?  Is this printing
> decimal values, or is it parsing decimal values?  If we know what
> specifically is affected (for example, an affected command or =
message),
> it's a lot easier to fix this.

In general, I am not concerned with parsing, it=E2=80=99s more about =
printing
them. As with the percentage situation, having unlocalised content with
localised strings is not ideal. For instance, my ideal pull output would
look like this:

Nesneler say=C4=B1l=C4=B1yor: %100 (12/12), bitti.
Delta s=C4=B1k=C4=B1=C5=9Ft=C4=B1rmas=C4=B1 8 i=C5=9F par=C3=A7ac=C4=B1=C4=
=9F=C4=B1 kullan=C4=B1yor
Nesneler s=C4=B1k=C4=B1=C5=9Ft=C4=B1r=C4=B1l=C4=B1yor: %100 (7/7), =
bitti.
Nesneler yaz=C4=B1l=C4=B1yor: %100 (7/7), 3,79 KiB | 3,79 MiB/sn, bitti.

As I=E2=80=99ve indicated above, I am ready to test anything you might =
throw
at me. :)

Thank you again very much!

Best regards,
Emir (=F0=90=B0=BD=F0=90=B0=BA=F0=90=B0=8D)

** E-mail needs to stay simple
** Use plain text e-mail

