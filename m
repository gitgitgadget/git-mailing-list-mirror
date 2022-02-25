Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B04DC433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 16:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241724AbiBYQDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 11:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242436AbiBYQDu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 11:03:50 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E511A3604
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 08:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645804990;
        bh=q5Q02FVqT1yjbN2Zlt/os82l8LsjdyPRnBljCTrNxBw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PRDo2TuCohnnDrRHbs47JnZ7C+S+aOi10frYhRikkVn7WI/ETT0am+dwuyxmnIkRX
         No+MykbfZ2Jcy2aHDQ6rn5/6ylp+ZrEmUM5yKtjyiQnILQ0E9DVxw/MlHUmbLfaiqR
         8oV+AuQkJfDNO0ZT/GoMWGWLQcYwjfO93uLSVcZE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCbEf-1nXDhN1i1z-009ckq; Fri, 25
 Feb 2022 17:03:10 +0100
Date:   Fri, 25 Feb 2022 17:03:08 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 00/14] Finish converting git bisect into a built-in
In-Reply-To: <xmqqo82xs1ue.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2202251700110.11118@tvgsbejvaqbjf.bet>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com> <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com> <xmqqo82xs1ue.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:amaBdH1l4/jk5e352ydgLH+7vtmAv/LVDvRG5oJGyjClETAlRnB
 nYjhahQ1E5DVtickdNbHPHdWDgxw7zvIk9YDNmXZ5c8ypmyWYxQH5Bgxh7tLZjc6tyWquiI
 7XhtKaP1Th6RkaYQa7iiAP66i9DGkoMbu8HemMyh55Q+JJ3EPMHf7AKHRo/1ZC5LIaukelL
 021kxvwWvBfshGRWZpvRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:21yd/HRgR54=:+H8LX7ieruU4XztFaYDqJA
 TCTibvc1tXHELNYElMIn6bQQ8hGBTg9v65CSHE9gPLsjsTTz3bIzL6uXPhggmcytrZZuLRPaR
 tTokk8/sFMJe0kOFWrPUro07bJXJRRPWjemsHBOx+KSvPWTXC0ryAn38X3Ie+e4UDJ1uWLIiT
 J2IyZQdSI3ExMfQymR0xJP9D+pbt9WeUd9ftzGoIks6qSA8/XvYK3H7FbjSGWxOZRzkvsOjeW
 C2P9H+PFo0PRDn6I7Yq3wIpwt9RVFuyS1+WYgc/yY9abaz7d7kBrxs1l03nbk+Y9/JFm537QZ
 LpaAZtCB/296HwgSYbCQGOMSXtj9lzsXb4CaTdAm6+ojzCyk2Cw9MlDevjD4USMRk8VncFzDt
 bnPBwER5SGMWw3GfUYmw2y7Nr35gcnAJhmcv1n7nCkAj00HNL1hs7MFQbmME5FxreJCg51iv3
 S8657BnxdmHjYg6fv4C2DjlemGs9tOA1bMHclYpBymD5H/H0eHjNuh3bOaETaJ253GuGD+6z8
 aOLkWTQL61tt3s32eZ7uQQEsT9Py9bLdqTIuGh60DgcwSlkyNhU6o4HjC9JrbmsZ9YVnS6fCL
 aVJyTCh0lFaUtFsmnutgTpFNAPybBJvoqPIOksyqcYi6bLpHV89JPg+/LToLRfokf5UnqrpWW
 ldbdu/GSBk/5UhpbNd/Bnnvb4dW3mQILfHVeYlKXBBj6eayN69OASqSNsJP68BshwqvE5x0fH
 T8Qc6q4H1VfQutgcHP4/qqQUeNiOCvOykDTXrVfOLXPqexw04305al8hhqVMMWWekNzh5kYyB
 zxewY2qxpC66ycGZOLcXXgk2CWq0PCUOCmP2AfHo4QRjM1+HtImCLugL6bVzye0IGEWUAOgIm
 oBgXajzCCpB/A8sGF5jCy8HkX6SREx/vUPTecYGeasDVFRK4o0zG2tJyoXvR6weU9jbIVdzfI
 czpkpwzfM0vhKbTk9pQ/pHU6f0jXvax4xhMe7GcVGyiDyJb0ZK0UheOILaMTXJIqxprstoy05
 HNpfROdIE7UGUOCMWfvTBpyVX+ufWAncZabN2z4Ej5ppN73iB4K2VOl5Ki71VF6JmfwBBUvt9
 N5zW6CmQdb0xsk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 23 Feb 2022, Junio C Hamano wrote:

> [...] the parse-options bit I am not sure about (read: I do not have a
> strong objection, but I do have to wonder if there is a better way to
> achieve the goal) [...]

After spending a lot of time to try to make it work, I realized that it's
in the name of `parse_options()` that it's not a `handle_subcommand()`
API.

So yes, I agree there is probably a better way (and e.g. `git bundle`
and `scalar` would benefit from it, too): designing a proper API for
handling subcommands.

That's safely outside the scope of the patch series, of course.

> Will queue.

Thanks,
Dscho
