Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3BEE1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 18:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732168AbeGSTdG (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 15:33:06 -0400
Received: from st42p59im-ztdg12240501.me.com ([17.36.65.26]:42251 "EHLO
        st42p59im-ztdg12240501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727401AbeGSTdG (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Jul 2018 15:33:06 -0400
X-Greylist: delayed 2581 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Jul 2018 15:33:05 EDT
Received: from process-dkim-sign-daemon.st42p59im-ztdg12240501.me.com by
 st42p59im-ztdg12240501.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) id <0PC400500KOSSQ00@st42p59im-ztdg12240501.me.com> for
 git@vger.kernel.org; Thu, 19 Jul 2018 18:05:46 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=04042017;
        t=1532023546; bh=13koflLRWlaknOBZpxJ5MRyS0tIj2d3eR7gC0szGi/0=;
        h=From:Content-type:MIME-version:Subject:Message-id:Date:To;
        b=kyXlbVEF2T8AnX1Si5li0jsQsam7F+DjXdFDVmgy9s2x24kNgoIpf8zxAAgGcdqAf
 6YqiF7Zt6wMApxAzjd+bNvzGq8uR5uCWuwCh6Q2YP/DkR+PuxrjHuo/PLxaHIepMqK
 qPByVUZCy98p9gu0Uk5jCt02WTUeodjmDGw5vRhktvW3BF+WcjU/uEYUW1k7+zji5E
 LtpmK3kxb1WotCiAxmj7/e1BjDZQNTJRTriCgYGewSWFr4u0DLP7NKjNSJMFF6xu71
 5UtkyH7rnXCLN2vSpgATYmJXRy8Cf4fKamnMR3ihAKwBPoWQ7B0oWHziQooRjOq/45
 FksjgCrcPHnvw==
Received: from icloud.com ([127.0.0.1]) by st42p59im-ztdg12240501.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) with ESMTPSA id <0PC400JCBKXJJK10@st42p59im-ztdg12240501.me.com> for
 git@vger.kernel.org; Thu, 19 Jul 2018 18:05:46 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2018-07-19_06:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1011 suspectscore=1 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1807190189
From:   Evgeny Cherpak <cherpake@me.com>
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: quoted-printable
MIME-version: 1.0 (Mac OS X Mail 12.0 \(3445.100.17\))
Subject: Gitk doesn't work on macOS Mojave
Message-id: <D295145E-7596-4409-9681-D8ADBB9EBB0C@me.com>
Date:   Thu, 19 Jul 2018 21:05:43 +0300
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.100.17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

You have probably heard this by now already, but gitk doesn=E2=80=99t =
work on macOS 10.14 - because it uses Apple Events,
And apps on 10.14 require user to give them permissions to control other =
apps with Apple Events.

Here is what I get when I try running it on my machine with beta 4 =
installed:

Error in startup script: 58:102: execution error: Not authorized to send =
Apple events to System Events. (-1743)
    while executing
"exec osascript -e [format {
        tell application "System Events"
            set frontmost of processes whose unix id is %d to true
        end te..."
    invoked from within
"if {[tk windowingsystem] eq "aqua"} {
    exec osascript -e [format {
        tell application "System Events"
            set frontmost of processes ..."
    (file "/usr/local/bin/gitk" line 12212)

And Apple doesn=E2=80=99t allow to add apps to =E2=80=9CAutomation=E2=80=9D=
 :(=20

Best regards.
And thanks for git :)=20=
