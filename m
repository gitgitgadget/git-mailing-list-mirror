Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00DEC433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 21:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiJTV7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 17:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJTV7L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 17:59:11 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88028A52C1
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 14:59:10 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id d13so888486qko.5
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 14:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBRhGn5vAWFeVZzSNvrf+dd6/bNWzxU1WFoa/Ta8foI=;
        b=JQ9RRrKbwrGmXOtWVppS4r52IEChPcjZ8Y4qdjxslRLQJMNqTAEJPlXG4dnsxam0vb
         Y/thHjwi+ugXedURLY8GpsyQH30dSfZoMM1m4sFi96UdruGD/8aqy10UPi+XfVXPjmgY
         3QgMVZ34UuGgju0rQrURixVhqJN+Dgpc/HcLZ+BA7AU/Pyes1BfuS8Gt+rMkF3yF5on9
         jVcixqqfEBVIU5E0Ujua/B/DQRLr6pSj6cCK1+yuaHWzU9Eqwms68o/A23dsoWjMM0z+
         6N1/uigtSeZM+6pP0v/YplO8q5OjGAERxLVP40PfhLQeEoYTMzxI8aOgmRcyGDUivmwT
         9+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBRhGn5vAWFeVZzSNvrf+dd6/bNWzxU1WFoa/Ta8foI=;
        b=2QAMbIvpaUVFV7CzM2QNNt/VQW1XGUkDpg5Bt+1PgWEnfKRt48DFSOJW0FmYCII0n4
         HA6zSe8YCRop6naUtxH2ojv6GVKAjkBEOwtEyu2waapnRtrEjbGYiyQasmPDOnY4S+bg
         O4P7iklsHtIxXHReBbVoISm9MQUihwbFo34xx+adMUUkqAmVQWlk3eViVpY7rd/7wC5r
         skcHEPvpy8wwjTEchscMaHWrUvmbyULnpBXNju9rLLoFSY40qGWsThRNVU+1uw9cSyIt
         sc99aOGDtncQ8f3XhCXjzLe+QtukEjPrlBWBW1wfLms1c7otoNTu3UrqCRXuVsGdpSS6
         Vi9w==
X-Gm-Message-State: ACrzQf14R/K2li54CA8Tgm4cT/AQAZa1zlCd7xiUp9KXcfMr/atmHCfa
        IxA05OJN86Xbw9WAqhDFgbwa14OKYeY=
X-Google-Smtp-Source: AMsMyM7BahoefIuPJ/+SvRfc8Xx8ZSHvhRKzc4jlmUogtqdw08frDTwNA+kpM87ygBYZTDavPUZhlw==
X-Received: by 2002:a05:620a:2293:b0:6ee:94a6:5cd4 with SMTP id o19-20020a05620a229300b006ee94a65cd4mr10497995qkh.537.1666303138705;
        Thu, 20 Oct 2022 14:58:58 -0700 (PDT)
Received: from smtpclient.apple (99-46-141-114.lightspeed.sntcca.sbcglobal.net. [99.46.141.114])
        by smtp.gmail.com with ESMTPSA id u30-20020a37ab1e000000b006ef0350db8asm2378792qke.128.2022.10.20.14.58.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Oct 2022 14:58:58 -0700 (PDT)
From:   "W. Ekkehard Blanz" <ekkehard.blanz@gmail.com>
X-Google-Original-From: "W. Ekkehard Blanz" <Ekkehard.Blanz@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: Cloning remotely under git for Windows not working
In-Reply-To: <CA+JQ7M92x03FPWM6qWjG=FYPxCYs8xcC_HRWLnkwj4iqA9KK=w@mail.gmail.com>
Date:   Thu, 20 Oct 2022 14:58:56 -0700
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <46A1CB40-BBEE-43FC-9626-588718518B4A@gmail.com>
References: <5E2E10BE-6EEB-4C78-A489-5899400DA937@gmail.com>
 <CA+JQ7M-NA9UYafMurb9MAo5bp6djdzRP7ChAbdmzU+nmrkXTNw@mail.gmail.com>
 <DB5611E0-6B1C-4711-BB9F-72F6E8F39506@gmail.com>
 <CA+JQ7M92x03FPWM6qWjG=FYPxCYs8xcC_HRWLnkwj4iqA9KK=w@mail.gmail.com>
To:     Erik Cervin Edin <erik@cervined.in>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Erik,

yes, I have tried forward slashes too - all with the same result.

Oh - and I forgot to mention that even from the same (Windows 11) =
machine, where I can clone the repository locally via=20
    git clone D:\gitDepot\test.git
it fails with the same error if I do it over the LAN (which I think =
should be expected).

Regarding your suggestion re. Powershell, I can start the cloning =
command in a power shell window on a different (or the same) Windows =
box, no problem, but this gives me the same result.

How do I convince git to use Powershell as its shell of choice when it =
arrives over ssh at my target Windows box?  Unfortunately,=20
    git help clone
Does not give me any indication how to do that.

Ekkehard

> On Oct 20, 2022, at 13:31, Erik Cervin Edin <erik@cervined.in> wrote:
>=20
> On Thu, Oct 20, 2022, 8:16 PM W. Ekkehard Blanz
> <ekkehard.blanz@gmail.com> wrote:
>> Here is the output from running it with GIT_TRACE=3D1 (which I had to =
do under Cygwin, since this won't work in a DOS shell, but I am still =
using native git from Windows - did not install it in Cygwin to keep =
things consistent):
>>=20
>>    $ GIT_TRACE=3D1 git clone 10.0.7.181:D:\\gitDepot\\test.git
>>    19:04:23.917439 exec-cmd.c:237          trace: resolved executable =
dir: D:/Applications/Git/mingw64/bin
>>    19:04:23.917439 git.c:460               trace: built-in: git clone =
'10.0.7.181:D:\gitDepot\test.git'
>>    Cloning into 'test'...
>>    19:04:23.948681 run-command.c:655       trace: run_command: unset =
GIT_DIR; GIT_PROTOCOL=3Dversion=3D2 ssh -o SendEnv=3DGIT_PROTOCOL =
10.0.7.181 'git-upload-pack '\''D:\gitDepot\test.git'\'''
>>    username@10.0.7.181's password:
>>    fatal: ''D:\gitDepot\test.git'' does not appear to be a git =
repository
>>    fatal: Could not read from remote repository.
>>=20
>>    Please make sure you have the correct access rights
>>    and the repository exists.
>>=20
>> What I got from this is to use double backslashes to get the path =
right (I had tried this before though), but unfortunately, the result is =
still the same.
>=20
> Maybe try forward slash, it's valid in both unix and windows and
> sometimes plays nicer
>=20
>> I will try the power shell workaround once I am back from my doctor's =
appointment.  Is that on the local or the remote machine or both?
>=20
> on the remote

