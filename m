Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 544781F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 15:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733219AbfJOP7K (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 11:59:10 -0400
Received: from mail4.protonmail.ch ([185.70.40.27]:50613 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfJOP7J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 11:59:09 -0400
Date:   Tue, 15 Oct 2019 15:59:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1571155147;
        bh=Zz5XFjpe9DkU2sj5PztQnH81aeckzzNVVglg3xh/mrE=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=UPlerF0YK/mNoCoDX8MR9EnEoz0asD+a5VGS61w1oyKV1lhuSLAxZw4PmIEXbbs3J
         Sqpo1KPV7P9wwakufkdhksKDlE8hKne2wmP8LJlGaE3EicEtEaWbUxWW+5F4uHpmAj
         qagJWsMlHXTuDmS4BVmNZJaquXTLT3QbAOKpxZtw=
To:     git@vger.kernel.org
From:   Ralph Ewig <ralph.phd@protonmail.com>
Reply-To: Ralph Ewig <ralph.phd@protonmail.com>
Subject: git smart http + apache mod_auth_openidc
Message-ID: <4eb22ffc-77a1-4cd7-2277-bdc57d31186b@protonmail.com>
Feedback-ID: JbhSByWnCQwiafGbFv64IeMW95YrXE9PqRMglI51uN_uNsIp7h5EnYZeviw8UgH0DtxilqFslLTcJ61CqL2H5Q==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone, hoping you might have a solution for=20
this problem:

CONTEXT

 =C2=A0* I'm serving git repos using "smart https" via=20
apache and basic authentication; everything works=20
fine.
 =C2=A0* We're moving to SSO via Azure AD and apache=20
mod_auth_openidc; this works fine for gitweb (on=20
the same server as git).

PROBLEM

When trying to clone a repo with the OIDC setup,=20
git breaks on the redirect for user authentication=20
with the following error message (replaced server=20
ids etc with xxx):

 =C2=A0=C2=A0=C2=A0 C:\Users\void>git clone --progress -v=20
"https://git.xxx.xxx/WebApps.git"
 =C2=A0=C2=A0=C2=A0 Cloning into 'WebApps'...
 =C2=A0=C2=A0=C2=A0 fatal: unable to update url base from=20
redirection:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asked for:=20
https://git.xxx.xxx/WebApps.git/info/refs?service=3Dgit-upload-pack
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 redirect:=20
https://login.microsoftonline.com/xxx/oauth2/authorize?response_type=3Dcode=
&scope=3Dopenid&client_id=3Dxxx&state=3Dxxx&redirect_uri=3Dhttps%3A%2F%2Fgi=
t.xxx.xxx%2Fredirect&nonce=3Dxxx


Can the git client just not handle a web based=20
redirect for login, or is this a configuration=20
issue? Any ideas would be greatly appreciated. Thanks!

Ralph


