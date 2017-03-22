Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 212FF20323
	for <e@80x24.org>; Wed, 22 Mar 2017 16:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934791AbdCVQZ7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 12:25:59 -0400
Received: from mout.gmx.net ([212.227.17.20]:58825 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934784AbdCVQZx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 12:25:53 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M8IuM-1buvjQ0kCo-00vydl; Wed, 22
 Mar 2017 17:25:42 +0100
Date:   Wed, 22 Mar 2017 17:25:40 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: difftool-builtin fixes, was Re: What's cooking in git.git (Mar 2017,
 #08; Mon, 20)
In-Reply-To: <xmqqefxrtvqa.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1703221724500.3767@virtualbox>
References: <xmqqefxrtvqa.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:mKGi9g/ZuDz5w08U+rJkY0bs04edyDEEc7P8LyYAWJKl0OuiiG6
 B8eNVefY2x4KjdDZJxYNsXA4Psr9k4dRDSel2+7GGZ2VOktHGzi6FOn5BwlG/8gtKJSPGso
 x9a3Nkc7cQoFpKhtJNl619LTwISXeZHH/LpblnLpZ7FX6Y1toitnhBR8PyacNeozo7h9SEl
 k70p65ujct6+Q2UJsQrNA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IIZXlTF/gwY=:2qgCpJ88Xww7fKOJO4Mrg+
 hXplQf5ZUo9kxHSBXERT6pybGFPM6Gsabt4Duo4WIqOKge+jGdp05JLkfmeWHI+kL4MR/H5zW
 9gNQOAbTiYkMP6dD2qV6q7bWZYryk+fsHDUYAu3OyeiCCzovA816GyhvYRq50+u0j3WefrH14
 vpR/nj0BUWsVl+/ONZAdt9XPIPRFDcE99G1oWQAyxT9Oj/6M37OUPDZosthFZVIQF/H24xwGn
 8EuPtjvhDMCOyUYp6rIoVNVHXetdZw+df/z5tXvpyQQtW46YCbjPEz7rvkCKqbI8ngSiM4ZQt
 YaGE3c7URR7MUVn/JYtB+5gne+44h5g4FStCXxqcmnqrRpOEuZXcW7Vt+PBuQ3I+qvcuzbC+A
 ge17raV5Uu7zKuzAVYhSVxjTVG4K2OrbDDa7M8sNppaet1tCzvZ5fPzh/OqlaWrZ2nSVXTd8w
 JchlBdd/f8A9MV+9UXmm5e6LU0xOlTWDq5onNjT9KZEo10alx82WgLobb9zCsPegveoMt2ZPA
 tT1rHDJMbII8pu/MxM3wcvbjl/L3H8XTLqSOcwMxrChyvTet5PD8Piobd3DN14H4T2zMna5Pc
 8hr0hhDPzcn22VafoqB0B+u8mBVhsbOjXIRL/qtSVRVd+3PvRNB26Ynx7W22TMoISyygWZFTd
 rqgcEVUODVzpf3S7gj37dlhtCI81n2QA6QJ3RpI/K7FoCqzdSMcsZDVIWJ6XiqWiny8HKOJk8
 xMqp44721ayzJLh2K3c/6vyraFMcpRXX201A187pYm5CoGnd4SyYHEzNGKRti726GTjHl/BHM
 kV6lB/egECIDvxp46UZC63RCWKVeg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 20 Mar 2017, Junio C Hamano wrote:

> * js/difftool-builtin (2017-03-15) 3 commits
>   (merged to 'next' on 2017-03-16 at 3fccb60a07)
>  + difftool: handle modified symlinks in dir-diff mode
>  + t7800: cleanup cruft left behind by tests
>  + t7800: remove whitespace before redirect
> 
>  "git difftool --dir-diff" used to die a controlled death giving a
>  "fatal" message when encountering a locally modified symbolic link,
>  but it started segfaulting since v2.12.  This has been fixed.

David fixed much more than the segfault. He fixed the underlying problem,
i.e. *also* the "fatal" message.

Ciao,
Johannes
