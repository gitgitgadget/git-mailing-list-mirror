Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10867CD37B0
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 20:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjIRU65 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 16:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjIRU6q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 16:58:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C03187
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 13:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695070710; x=1695675510; i=johannes.schindelin@gmx.de;
 bh=gjBVkPefS2zbr6mga6UZ5C8RQejYG8txvx8G1UcEOfM=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=BTt9kwDElp7gIEZ1PkaqcKTlSyjmrZuSUosqY4894hPi0LoEAyv8RkLhTED/cx51Xfx9dRUrPaf
 APlT8ydm9JV/Ir5+mOjUDExLiNOGx8FHcu5KSajvNonUnsDP6kAxG+GK/qND7JCbPoy5SU87tluch
 BfAdJXfkuyg0v/BFBc0Mb4tMKZTlc3T7p7aoTqQ1MZfOmt+cIhqExe33lt/jyJyZMdaVrDaqsiJon
 Zz4R+RWWAINZMs1DAkbe+TgfOz/B2ZXXy5x30CaauRSTB/wWl30BGr/LjFkUyXM+SFqD72KVAhJpc
 vSF8QNR4GNqUNuJQxPOaWKfHEjtUW68JS/hw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.206]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQe5k-1r636W2G0c-00Neht; Mon, 18
 Sep 2023 22:58:30 +0200
Date:   Mon, 18 Sep 2023 22:58:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     phillip.wood@dunelm.org.uk
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/4] cmake: also build unit tests
In-Reply-To: <d7d1505c-8d65-4b64-8814-3e3b1e46f8ac@gmail.com>
Message-ID: <4e13e2ce-9cca-eee4-788a-bf47fc29bc07@gmx.de>
References: <pull.1579.git.1693462532.gitgitgadget@gmail.com> <2cc1c03d85153356edd55fc0747a957db3c94ab0.1693462532.git.gitgitgadget@gmail.com> <d7d1505c-8d65-4b64-8814-3e3b1e46f8ac@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7PDLpA31Yx79iuTEXRRAxLxfCqyFxS/JQ7Y20+ElAMYSwakV54n
 G1pdo4bCzIhSGxI7BVui+GAP9pe5rjVyui+X+WcHK5R9fuhisnqza0SKIyQicNwWAPGeyJT
 nl+oD2fJhIePKCxPmduKSo37lhle3/xboq9HsMAElz1frKk5TAWreHDGJ0UGlBWQ56Je4/g
 m/lRbTpJkfzoTVIlo/dOA==
UI-OutboundReport: notjunk:1;M01:P0:BQgJNQXwNcg=;UERDke6XAk1T+SzoyDgth4+3/Gs
 qBxxBju2MlIHM0lgCnD8syrUaOZtF1cVMXDACNBC5fJDPxdvuMdnCbGBPDRwY23aJbByjswGM
 T8V+jK5kIdg1k4qmu3nWBQHguSZgyAap5Pnv049ow5UpVy1lS7EdL16lJuiLvhTpmURFsrjf3
 t9G4Xs8gevdejsPl+r6KsCORTeP61kcgONHSjO+W5INTSXOWVKINpJm+1bOb84ulSTtCNQlYq
 G+hb09TfdV6nPc07x8LKw/ctemhZE/wRLCOarDdLEUg//die8rfKYsAlQwW6OF474o3LwI707
 nxNci/wN8uSQxrf1as5QKl4qPHutbMTfWsIwLwmSP7nPkRDZ0BSf8BXmNdsf620Lvqf23JXt9
 3u5KvJn6QP3hERu33DC0wKx5mlp0T4WgqgxoBODnI23ssZaWptcO2HB6HL+codSNKdhpBPI2a
 5PHewf/TK9Elh2P84553JkINKVX1PnlvMKeGiRUGTW13ExtNJZCenR1ZDPcwfWQfJyrnF+4y5
 ggseiDkR6VtIGwBgaa3lC70mk+d4S0M/GLSw90DhKLSnvYCMl7tSiz3dUr54zwyUgZJy3KZV4
 ZXhr4xhu0OnRPEZZiF776cIUiggoVKVaUdceNVgah/dBD9f/xxGtAjCuIaEC58rhteXwNyqhn
 J/AwQsjA3/iJwaJTe9rHDJVYmm+uS8LFlwnJc72g+JcdG9gbFMo9Q8K5J9b/jm/nmsFPZe5Fv
 UE5hxKmWXaRpK0qtKgTasrIX08W2z5RJSkJ0Wdf0K90zgmxlYF+mQ7NQ1oPJs1o6lmmLBJlfa
 zaZC/GOiX5rE+167bSflA3GGU4Q9k+kMWmKX3X9HWG6HraJ7d2YhTH95DDIrcFlYuiASGFUe8
 FK39bUFnY42DQdVbujVnVpWgFLl37MTACOSuwhEIP+2BZ3fP/IfIOCVlR57CSlLSCg6eVyUyG
 zoPcjQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 11 Sep 2023, Phillip Wood wrote:

> On 31/08/2023 07:15, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > A new, better way to run unit tests was just added to Git. This adds
> > support for building those unit tests via CMake.
>
> This patch builds the unit tests but does not add them to the list of te=
sts
> run by CTest - how are the tests typically run on the CMake build?

You're right, I missed that the unit tests are run as part not of t0080,
but as a separate target in `t/Makefile`.

I've added a couple of patches to clean up the CTest part and then run the
unit test (t-strbuf, and whatever is added to the `UNIT_TEST_PROGRAMS`
variable in `Makefile`).

Thank you,
Johannes
