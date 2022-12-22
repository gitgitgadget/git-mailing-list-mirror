Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56461C4332F
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 17:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiLVR5u (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 12:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiLVR5r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 12:57:47 -0500
X-Greylist: delayed 588 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Dec 2022 09:57:46 PST
Received: from qs51p00im-qukt01080101.me.com (qs51p00im-qukt01080101.me.com [17.57.155.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47A528E31
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 09:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1671731277;
        bh=puwp1wMkehmx7Vw7TLGazMhZOKg4LUGJ9lbHvB+vkw8=;
        h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
        b=Fh5Zg6KVn/VZcVCx2OudRB9025zhio4XFPX8OlVqaMKjfB4jvK9hJchrM1AL03VhY
         g03KDPv6ZdRJO7cgHBVnF6/sGEO5gqMJfmwxUfp+KXUXydWNxQioqzgSs2ybnZyCvz
         PROb7MVQenAGE/hGXk4F/ToYuO1KOBEQAIojgrjo1SY6KOFDgf+S/Lahzb4Bj7qL7c
         NmJdCuuM240CefgBBQxQqB520s4butSgQheTgbXpOq3QUqxS3q7506xEUoa5s8k/bO
         TTysQxLhOA8XjYgUewDZG0pOUA9jQWYoBkcmJ09CZXDRSasi3BGNZRI2yY08hDuakz
         C0e4/TgKOigKg==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01080101.me.com (Postfix) with ESMTPSA id E589C6180400
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 17:47:56 +0000 (UTC)
From:   James Lowden <james.k.lowden@icloud.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Reply-To: "James K. Lowden" <jklowden@acm.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.200.110.1.12\))
Subject: report default colors
Message-Id: <FC7C600C-5D51-4BE0-82BD-9E28C88A1BB8@icloud.com>
Date:   Thu, 22 Dec 2022 12:47:44 -0500
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3731.200.110.1.12)
X-Proofpoint-GUID: t3cAQc2ohQ7a5NXB8LOSajJv6_Pq9Fv0
X-Proofpoint-ORIG-GUID: t3cAQc2ohQ7a5NXB8LOSajJv6_Pq9Fv0
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-11=5F01:2022-01-11=5F01,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 clxscore=1011 adultscore=0 phishscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2212220151
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,=20

My good friends, I would like a way to report all colors, default and =
configured, used by git. =20

I can report configured colors,=20

$ git config --get-regexp color
color.diff.meta black bold
color.diff.frag magenta bold
color.diff.old red bold
color.diff.new blue bold

which is not terribly useful, because those values came from a file I =
control. =20

I can get a list of all keys from "git help", which is something.  But =
I'm left guessing at which keys control the text on the screen for a =
given command, and what color they are. =20

In the instant case, "git push" was rejected, and the reason is =
impossible to read because it's in yellow on a light blue background.  =
(Don't get me started on the pointlessly difficult antiquated arcane =
color control of ANSI terminals.)  My workaround is to guess what it =
probably says (probably it says I need to pull).  When that doesn't =
work, I copy and paste the text into emacs. =20

What I would like to do is identify every color git is using for every =
purpose.  That would let me change, say, all yellow to yellow-on-black.  =
But I have no way to discover what shows up in yellow, other than =
intuition. =20

Thank you for your kind consideration of my suggestion. =20

--jkl

