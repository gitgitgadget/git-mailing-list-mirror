Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C305C43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 09:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbiFBJ5C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 05:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiFBJ5A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 05:57:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9F6CE1
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 02:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654163799;
        bh=ueeRawPwSKQRcMUCr7RWXV2T7y4x22p94UxuMxk14U4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NHEB7qKXUnPL94XPbQJauifk50vXBPsJQc8EDXqxpSK8HrFe8Oyl3e4Yee7aybphi
         XY8Cey1GyfeSQdBq6GA1xtXA8aZE1gV+zzdX/+R1QZt7EtD6yfcw6rwtArOdhWOPov
         mC6wulk3XXi1kKL49v5qPVlQ3F2JGt8Ua/DpxEOU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.206.165] ([89.1.212.145]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4s0j-1nydF331XT-0021RK; Thu, 02
 Jun 2022 11:56:38 +0200
Date:   Thu, 2 Jun 2022 11:56:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Torsten B??gershausen <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v9 00/30] Builtin FSMonitor Part 3
In-Reply-To: <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2206021155070.349@tvgsbejvaqbjf.bet>
References: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com> <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WTRB2XQP2srG44JwIlzPbB6oF9hVwJGU/1WU5Nd5lZr3cWlqYUF
 8Q03ZGkYpgyDUEHZTr+4X0H7CUcGUD27LF5RbHOdnaeo3MN36MxQxx6Oq/5Zz0BVfnAVmKK
 edfqEVGrVJr/2aChe0EhvSM76BjRjJcduXrODiGHcb3GWrCb8ygED9E+5K8Lca1Ayg++mKq
 xGlBrINgHr/Fx7JNVx3nA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NgKyer5NjmE=:aul3YCvNCnEHKITdlMlJAG
 sgU4uGi2yDsHmSYoHyzdaHvSD29J8D2fohE+HC5smitf5hRfS+HeDvRVlQpy5hHdYpBMHIKy4
 bUPpSCB0WLQ0nq1C2bcREtZ8UxMa/huTAXRMhZkVw82x6AO6MjTXap5ditPwXeQGN3/U+GnDo
 UR5uh4SDZSMMSl7CbqXeysEdb9hZfdzohiH90aMXr3959hA5f55qr9MfmuL4aX2LlyVplGiqt
 PrgFM59vChOrF5Mfjt7FBsXcBq7ndascEVCxS6gTBwsqRoTWucWiY/vfO/tqDLQEIGGL+BG0a
 /bNR05m5UWpwCgPN4Wm2YCc6PjhMnXzn994oQ/l4GPc1rEep8CLAMww0k7bz6p9N1zkorjcgt
 pijQmmCpQnV/FLXaqFY3yDB2aqT7/F5q4KhFtvf9HHuoH/UNF5x0yjxTLszinkw7GP9VwV6yx
 XoDGVNrwPP3EUsVM+VPT95Ho94Gb/FbipcQ7Ftt4rpCBp6SH9xkoBzDlsc4ywO1w34+RMtjYv
 lTrYRgsRbv0asiCVkviZNO5wLWJZJETa35rI4lg/5SpO4d1jKrJIQc5eeL9y0AgC1FEnZ4Rs2
 R9Wldc/LXQkWMqR04GvgDhHK5wLrOFhqtVC899NCU+L2FrgMWza3xwMXI+j4hZq9mQcCMb9Dx
 oD/6uy5Fj4zSeGTc9cwPuk4I9aZA3a/BWGcHUbMNYSjWMKXdA+AYZrPWMsvsUkvrZDlBOyw+Z
 IZjxVVY8WdIonCc25lyhBAbRpxNOw1yYjc021a7yq+Xx8ZzHgXB1zgYe0TB/ruUHTxtCppmNo
 Ujg1QT1VnUJMNaB5Yxpm6oaI2qs35Y+E58o/ypgkcsDQoWiOGgPPD1GfSERlRPkRgA9c7Ma3Q
 PWf5gyt8OCua7jDxzEKjmTnh8Usps9Nm13lIMY8Kg8GTjpVbBICf3YSBywpbaap6+jbtmPAbN
 +aWkUg9S9B0XwyOQsnsqqLmdONixJKKpYOAMFnAVPJyW0h1Kf+pEqZYD/nr8xzVPaIPvpam89
 yaD396E2O7QRDxfaSz5qlPUdJVc9Ej/U4ejPXIlc/2rmu256a00KyzJzzu74QwYviJ9YCbsSf
 iFXYVH9JXnPt/KnvvBr38MvQhuEUWaOJBUEBS+EXoIKq6CF8CDfjVe7Hg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Thu, 26 May 2022, Jeff Hostetler via GitGitGadget wrote:

> Here is version 9 of part 3 of FSMonitor.
>
> This version addresses the test failure on t7527.[56] when deleting/rena=
ming
> the .git directory using the "GIT~1" spelling. Between v6 and v7, I chan=
ged
> the way check_for_shortnames() constructed the wchar_t path to .git from=
 a
> pair of wcscpy() calls to a swprintf() call. However, I used a "%s" by
> mistake rather than a "%ls".
>
> This caused a non-portable behavior. The tests passed with MSVC and with=
 GCC
> 10.1.0 on my laptop, but failed under GCC on one of the CI build machine=
s.
>
> This was partially hidden by CI machines that have GCC 12 and that fail =
to
> compile Git without the fixes for GCC 12.x.

I was already happy with the range-diff you showed in v7, and I am even
happier with the `hexdump` changes you introduced in v8 and with the
`swprintf()` format fix in v9.

=46rom my side, this patch series is ready for `next`.

Thank you,
Dscho
