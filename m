Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C8CC1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 12:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbeHCN53 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 09:57:29 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:44171 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbeHCN53 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 09:57:29 -0400
Received: by mail-lf1-f41.google.com with SMTP id g6-v6so3849225lfb.11
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 05:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=e4ii5LkqFXylCBfTv0a4Fjs2yWGFqc/ZLXk0FuN/PUM=;
        b=UjZCx/j3/kDFClkBlafi6240MY5QePO2DWJeVIFiO0OV5ecbWNaINheg8/mBThahp6
         oR+xo7QzY3uJPH1V2WHSWWKO9irYON/L12W3j2EoPB+uR7Nqn+RnbJAHEAJHUKdJPG7I
         WVq+fksaHACj0stKX2TVa8NF7GJOdVNAjtP1KW0wTYoIVgn/a2kLJdlnOY5elPvK7F4Y
         KMxFaPX6rbNh+UKlQvbpcff4KCO/wW2ZH0/ULZrry+0qCPQUx7G+telr5miR+fM5ASe/
         l0tRKwaYbtCPK2wR795UJqfhf/qV2d+sytmGVB+XewDJJ823/5SiMh6/tmbOYtg5gAbc
         GJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=e4ii5LkqFXylCBfTv0a4Fjs2yWGFqc/ZLXk0FuN/PUM=;
        b=EdAV9O+qABU/TjKHSOXkTr/raaE5Gvw9nEeTMdtkcokKiHy3LUc4E0JBAhylcnRsZs
         Ux/yIVFOxOfDRsD//fWMAnicuKv/Hc3evwb7bWk3Nq6hHOatd68Y3pCOZ1blFcm+HOMS
         R9hfuoaJNwKzO/jZg9d5YsIzrzHnTpK39wz6jRfy1RMVfATo8CIFZh4A6kAPlKIorebU
         9tRAb/CHZJGfR6YCyeTFJGM4OjWAMLVxXdGCI1XbUIEjF1AkvU9OK7K68cuP69BVJgpg
         hlXoPAsKxlifHiAc5fxbHAbAf5qz8zJAzF2y4Be775uglO8LtFVn+me0izcl/fQ1Lx1d
         eYlA==
X-Gm-Message-State: AOUpUlF6eZLdVkJcYuiC8gmR3hmrxzP+UEvsSms3PuOF65e3W8pl6QSE
        Rip4hwlqGPXYdtkMx2dLps8Nv0WyYa49vyDVZHXcnt5RiTc=
X-Google-Smtp-Source: AAOMgpcgSV7tnKO6OVySEgbXSxvgfB7PKORNiit8TVY/ZUxWYCxc7mUThxJceNU2epZB3mjkETZav4r6voJvEKZfKeU=
X-Received: by 2002:a19:ea5c:: with SMTP id i89-v6mr4443920lfh.19.1533297686520;
 Fri, 03 Aug 2018 05:01:26 -0700 (PDT)
MIME-Version: 1.0
From:   Vadim Belov <vadim.belov@gmail.com>
Date:   Fri, 3 Aug 2018 15:01:15 +0300
Message-ID: <CALr1GiFBm9zJ1v-UWuVLWJJ+zFh-iTKOv=T4KETLN8qkW_0pAg@mail.gmail.com>
Subject: Squash & Merge Implementation
To:     git@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000f0aba2057286afd3"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000f0aba2057286afd3
Content-Type: text/plain; charset="UTF-8"

Hello,
I'm trying to manually implement Github's *Squash&Merge *functionality.
After looking many forums like stackoverflow.com I'm still struggling with
the issue.

*The scenario is as follows*:
- master is a protected branch (configured on github)
- a service user *svc *is permitted to push to master (configured on github)
- other users don't have such permissions
- github PR status check is set to SUCCESS before execution of any set of
git commands below

1. This merges successfully without squash:
git checkout origin/master
git merge ${PR-Branch}
git push origin HEAD:master
git push origin --delete ${PR-Branch}

2. This closes the PR, but there is no update seen on master:
git checkout origin/master
git merge --squash --commit ${PR-Branch}
git push origin HEAD:master
git push origin --delete ${PR-Branch}

3. This fails to push to master with the error "GH006: Protected branch
update failed"  (despite that the PR is set to SUCCESS):
git checkout origin/master
git merge --squash ${PR-Branch}
git commit -am"comment"
git push origin HEAD:${m_mainBranch}
git push origin --delete ${m_prBranch}


Will appreciate your help on this.

Thanks,
Vadim

--000000000000f0aba2057286afd3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,=C2=A0<br>I&#39;m trying to manually implement Githu=
b&#39;s=C2=A0<u>Squash&amp;Merge </u>functionality.<div>After looking many =
forums like <a href=3D"http://stackoverflow.com">stackoverflow.com</a> I&#3=
9;m still struggling with the issue.</div><div><br></div><div><u>The scenar=
io is as follows</u>:<br>- master is a protected branch (configured on gith=
ub)</div><div>- a service user <i>svc </i>is permitted to push to master (c=
onfigured on=C2=A0github)</div><div>- other users don&#39;t have such permi=
ssions</div><div>- github PR status check is set to SUCCESS before executio=
n of any set of git commands below</div><div><br></div><div>1. This merges =
successfully without squash:</div><div><font face=3D"monospace, monospace">=
git checkout origin/master</font></div><div><div><font face=3D"monospace, m=
onospace">git merge ${PR-Branch}</font></div><div><font face=3D"monospace, =
monospace">git push origin HEAD:master</font></div></div><div><font face=3D=
"monospace, monospace">git push origin --delete ${</font><span style=3D"fon=
t-family:monospace,monospace">PR-Branch</span><span style=3D"font-family:mo=
nospace,monospace">}</span>=C2=A0</div><div>=C2=A0<br></div><div>2. This cl=
oses the PR, but there is no update seen on master:<br><div><span style=3D"=
font-family:monospace,monospace">gi</span><font face=3D"monospace, monospac=
e">t checkout origin/master</font></div><div><font face=3D"monospace, monos=
pace">git merge --squash --commit ${</font><span style=3D"font-family:monos=
pace,monospace">PR-Branch}</span></div><div><font face=3D"monospace, monosp=
ace">git push origin HEAD:master</font></div><div><font face=3D"monospace, =
monospace">git push origin --delete ${</font><span style=3D"font-family:mon=
ospace,monospace">PR-Branch</span><span style=3D"font-family:monospace,mono=
space">}</span></div></div><div><br></div><div>3. This fails to push to mas=
ter with the error &quot;<span style=3D"color:rgb(51,51,51);font-size:15px;=
white-space:pre-wrap">GH006: Protected branch update failed</span>&quot;=C2=
=A0 (despite that the PR is set to SUCCESS):</div><div><div><span style=3D"=
font-family:monospace,monospace">gi</span><font face=3D"monospace, monospac=
e">t checkout origin/master</font>=C2=A0=C2=A0<font face=3D"monospace, mono=
space"><br>git merge --squash ${PR-Branch}</font></div><div><font face=3D"m=
onospace, monospace">git commit -am&quot;comment&quot;</font></div><div><fo=
nt face=3D"monospace, monospace">git push origin HEAD:${m_mainBranch}</font=
></div><div><font face=3D"monospace, monospace">git push origin --delete ${=
m_prBranch}</font></div></div><div><br></div><div><br></div><div>Will appre=
ciate your help on this.</div><div><br></div><div>Thanks,</div><div>Vadim=
=C2=A0<br></div><div><br></div><div>=C2=A0</div></div>

--000000000000f0aba2057286afd3--
