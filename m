Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B0BC433EF
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 15:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbiFWPWZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 11:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiFWPWX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 11:22:23 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AC13EF15
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 08:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1655997708;
        bh=jt8CHfpap4PS3IXO2NGqm/pa6ZAx7CXoyw0/yFmU4to=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=iYbVFfz2kUG/fJ5BS+EmN4UVJmK8/l6yZsrGEW9wnJPMC3JoF932hiskNphFf/Sbq
         Z3SmRsOGd6O+mfdtCg7+fe2JatLlxS3zPTpeC4CJrNdCPdZ7MaQtXUoFwigDHRriCW
         fhymxcD/c9/pmT+Pj6khfFAwDTwz/8mZxdgGQg8k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.19.130]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1JF8-1o79ny2VVS-002yMV; Thu, 23
 Jun 2022 17:21:48 +0200
Message-ID: <664fcc55-1cd3-eb01-9be6-80bc4492e849@web.de>
Date:   Thu, 23 Jun 2022 17:21:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: v2.37.0-rc2 - Additional Breakages on NonStop x86 (was RE:
 [ANNOUNCE] Git v2.37.0-rc2)
Content-Language: en-US
To:     rsbecker@nexbridge.com, 'Junio C Hamano' <gitster@pobox.com>,
        git@vger.kernel.org
Cc:     git-packagers@googlegroups.com
References: <002401d88700$7908f6d0$6b1ae470$@nexbridge.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <002401d88700$7908f6d0$6b1ae470$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x/umffbWGss0wbw9bAsl/Fa17K0wO+hAeiSpsp4e9L5kW8ycUzA
 7AB1dvNrQ7jRgOI5aXStOyJHC0LgcLe8mrSUFK+DrY1WSPmtv0pQl22E9oD7pN+p9t4vhph
 7tHBPCqWYFzY7lwIO9EdUMPdHShD0CX803z0CYrPOHMVynZABOnZHgwrKbYoi1e+mQBzJ0i
 tr2TlskdpmyKLei9Z+0hA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qyZEcizJbv4=:B6YbawZ31ct9CcuY08Onzw
 WFHv6q8mIYr6YOHOtLMbAjSDq0a2tOwtJLt/n7L51l8gonYVb3URChhdGo1tmYTqw5E5t9JoS
 e5WVmA8qxWBQYpEjQ0Mcl/eiVVVFuyyUARyShtLjKgEHXWCby7iNTGucZqt2utAs8JAEHyhXc
 yBpUG2PgbBQ4cVOgm31Uhyx4syab4LCDgoLO/lMkVv+7VEi0KWFyVc05CCIU5ddXrUu6b//xE
 IV00/KziyPLdJR37eGNJaXRwJqqaRhGE0OPWT0p9CsGeuhz4jzmOx24MGqZtx9C6eDlfL5AO/
 sOfrI1NXn7WDLwg92VLkZlZKr2mQsRVRwCJJYKe1xSrrG1uyWEUlZOzVFtS22Y9cr6/UsJtMI
 00+t09Mf3tDw4VyFVne2wkh/6hza9NRNwbzMyrxQ3WIkqbMY4ZlTggR4M5lsIQtrDDzOrj9zR
 xDqZ6bkwv9fFFBtj4nsURRDsSS7zZdcplK3xQ5Rzb/mhS0QUMm+uQVJC+pZGwvpxGUWSV6uQk
 6wXf1pG4S0jWT+9NP2S+VnJn7ncFcRyAv5fnAwvelIEFTIQJd/dpiP2BV41WlKKC4kcmyMdRr
 3JwRGpoyLGYJ6E09NCGov8SJC9PxH3Za3L6TwSwdeSdYeBnWXXeap7ljRcpBxgPBCgzxnuho3
 DqZSLfSqyourVTRVsXCRXkoeQ7MvqdM2GJnz6nUbBy7dAw/8wlT2eRtKtOVHxBbii6zIUTtgZ
 E4/+Oc6Debe8pdrGZGQsAp5tl4ChiNVUmfKHGXR3CwwCnPO9u3jN0UZqDnUESdDuIdEExhmDz
 FteuDjA60UeH2UM1alDbOvm1LB4Cq7KVOJDlQ9gL3BjE75zC1FcyNqQxoqHPswY38XqTIUoy3
 /4KzAliVaUb8shNzsdRqrSbPZkCCaTTxw0tPNuEEZFapH6xurQe93oA+tc3EJaucTx0Aa1M/V
 kGkL20WgY1LYPsbxUJnXynKujil4rP45MGwCYfTrbfFdnaPwFs4TFB4UQ496DXNLJLbS2rQtg
 x0ZQ19GuYTVtnZjGNwV1k0H09JXaIFdn2qMaojSt9hB884UANBzLCUNq4J7nFemSxqVZq3tzW
 rk9jkgfzj+tC0p1mvEo+J8gMTNFQMhj+syt
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.06.22 um 14:55 schrieb rsbecker@nexbridge.com:
> On June 22, 2022 3:32 PM, Junio C Hamano wrote:
>> A release candidate Git v2.37.0-rc2 is now available for testing at the=
 usual places.
>> It is comprised of 378 non-merge commits since v2.36.0, contributed by =
64 people,
>> 19 of which are new faces [*].
>
> RC2 had numerous new test failures on NonStop that were not present in R=
C1, RC0, or prior git releases, ignoring the @2 problem previously reporte=
d. Failures are:
>
> t5516.113
> t5601.8
> t7031.3, 11
> t7421 (all subtests)
> t7500.46-50
> t7528.4,5,8,15,16,20

That's curious.  Here are the test names:

   t5516-fetch-push.sh
      113 - fetch warns or fails when using username:password
   t5601-clone.sh
      8 - clone warns or fails when using username:password
   t7031-verify-tag-signed-ssh.sh
      3 - verify and show ssh signatures
      11 - verify multiple tags ssh
   t7421-submodule-summary-add.sh
      1 - summary test environment setup
      2 - submodule summary output for initialized submodule
      3 - submodule summary output for deinitialized submodule
      4 - submodule summary output for submodules with changed paths
   t7500-commit-template-squash-signoff.sh
      46 - commit --squash works with -c
      47 - commit --squash works with -C for same commit
      48 - commit --squash works with -c for same commit
      49 - commit --squash works with editor
      50 - invalid message options when using --fixup
   t7528-signed-commit-ssh.sh
      4 - verify and show signatures
      5 - verify-commit exits failure on untrusted signature
      8 - verify-commit succeeds with commit date and key validity matchin=
g
      15 - show signed commit with signature
      16 - detect fudged signature
      20 - show bad signature with custom format

rc2 changed the following files:

   $ git diff --stat v2.37.0-rc1 v2.37.0-rc2
    Documentation/git-gc.txt         |  3 +--
    GIT-VERSION-GEN                  |  2 +-
    builtin/name-rev.c               |  2 +-
    contrib/completion/git-prompt.sh | 32 +++++++++++++++++---------------
    t/t9903-bash-prompt.sh           |  2 +-
    5 files changed, 21 insertions(+), 20 deletions(-)

The name-rev change only modifies a help message.  At first glance there
doesn't seem to be a way that these changes may influence the outcome of
those tests.

Ren=C3=A9
