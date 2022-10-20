Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67A3C433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 20:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiJTUud (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 16:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiJTUu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 16:50:28 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7521578BA
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 13:50:18 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id c23so419032qtw.8
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 13:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:references:cc:in-reply-to:date:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ZDz2NRGrlMDpcB5JOwsd6Zhd00InS8wFHinmNT7kL8=;
        b=GROB46B7+rZHdkIex7pr1HykZNUG3IceicqxpAfm+LwDyX7ZYMdXANuii1rRhzRcNG
         YMHtebxUwEoWK7Yi84ngh1N5ny+cJZ+vWgrHhIACrZeMkggTNtwUy/nHlQOBeMrNEEE3
         ei6AGCUi5VwQKkf0hhtblndvKKttoozcl6enlLQXjD3JT9MNKaC2ryoDMfe+zKwgjExM
         1z9V2M8SCigHmsj+uNinHLLQ2IVrvFlujn9HFw1cyV7hbeGDrOXHdRAuYoIWqG1odX03
         7rRHDhsCKPLViD8EkLVFrAB9DhNhBsIXv68ZL3Y87ayBYbWtuG+gLNiXeE4F6MyIM32T
         mCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:references:cc:in-reply-to:date:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ZDz2NRGrlMDpcB5JOwsd6Zhd00InS8wFHinmNT7kL8=;
        b=CY7vDZ0LDv+L7divGpKfVJxZtV63MBzMKW4PSwieTBVE/xsQrSMHhsnnNHRYRj6OZI
         0zLcGgYDTd6hF1fqG/nYJpIFolwJmLPxvyqI6HkXuK0K+zLAflgIfcfdEvkMAjWQEW8T
         18Eyz2C+gvgtjhcyOWem84r4Fts/66hLgeC/zmD/lzub9F2fDtSbQIU8hkl+Bf0ckicK
         eZotib+B6qPWon9ifvzZK9gTWaEFn0BjRIRkzJjjRn4wenh0NIrlyKu9sABtaHqpG+TJ
         FocGR7ZsnyaCMbTS0rk3QaTLPeGn22YbtpQ4hkJvaVF9kYeU5nsmSYH+KOYJ3PpJS5Z1
         KFRA==
X-Gm-Message-State: ACrzQf2k/6STSXSppHEIAgJSero4+C4gEoYLDusBeHNqne41SWp350pT
        b+Db5+GBCrB2WrpUnVcyXMX9V4KLcrU=
X-Google-Smtp-Source: AMsMyM5U21v5henkBpOEqmJ3gXeny19Ltk0FW1PysFN2qA2Q9YtSiCLRcuNp67Ph+ZoMnsnC7lAvog==
X-Received: by 2002:ac8:7c52:0:b0:39c:faf7:74d3 with SMTP id o18-20020ac87c52000000b0039cfaf774d3mr10222938qtv.79.1666299011852;
        Thu, 20 Oct 2022 13:50:11 -0700 (PDT)
Received: from smtpclient.apple (99-46-141-114.lightspeed.sntcca.sbcglobal.net. [99.46.141.114])
        by smtp.gmail.com with ESMTPSA id i3-20020a05622a08c300b0039cc665d60fsm6692012qte.64.2022.10.20.13.50.10
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Oct 2022 13:50:11 -0700 (PDT)
From:   "W. Ekkehard Blanz" <ekkehard.blanz@gmail.com>
X-Google-Original-From: "W. Ekkehard Blanz" <Ekkehard.Blanz@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: Cloning remotely under git for Windows not working
Date:   Thu, 20 Oct 2022 13:50:09 -0700
In-Reply-To: <5F48868F-1788-4BB6-8E24-1652B919B60E@gmail.com>
Cc:     git@vger.kernel.org
References: <5E2E10BE-6EEB-4C78-A489-5899400DA937@gmail.com>
 <20221020172405.oet6twwiehpjemkd@tb-raspi4>
 <5F48868F-1788-4BB6-8E24-1652B919B60E@gmail.com>
Message-Id: <6FF08D2C-F45E-48D2-99B4-9B194D2AF5A3@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Oct 20, 2022, at 10:44, W. Ekkehard Blanz =
<Ekkehard.Blanz@gmail.com> wrote:
>=20
> Yup Torsten,
>=20
> I tried that, plus all the conceivable combination with double =
backslashes, escaping the second colon with a backslash, and all this =
other stuff that Microsoft was kind enough to introduce into the world =
during good old DOS days.  Nothing seemed to help
>=20
> But just for the record:
>=20
>    $ git clone 10.0.7.181:d:/gitDepot/test.git
>    Cloning into 'test'...
>    username@10.0.7.181's password:
>    fatal: ''d:/gitDepot/test.git'' does not appear to be a git =
repository
>    fatal: Could not read from remote repository.
>=20
>    Please make sure you have the correct access rights
>    and the repository exists.
>=20
>=20
>=20
>> On Oct 20, 2022, at 10:24, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
>>=20
>> On Thu, Oct 20, 2022 at 08:58:54AM -0700, W. Ekkehard Blanz wrote:
>>> I am almost certain this is not a bug but a deficiency in my =
understanding.  But I can't be certain.  Here it goes...
>>>=20
>>> I copied an existing and valid bare git repository to a brand new =
Windows 11 machine (10.0.7.181) into D:\gitDepot\test.git
>>>=20
>>> The problem is that from any other machine on the LAN (Kubuntu =
20.04, Raspberry Pi running buster, an M1 MacBook Pro running macOS =
Monterey 12.6,  and a Windows 10 box), I cannot clone it remotely.  I =
made sure ssh works correctly on all machines.  If I clone locally on =
the Windows 11 box where the repository resides, it works just fine.  =
Version of git on the Mac is 2.30.1, on RBPi 2.20.1, the one on Linux is =
2.25.1, and Windows 10 and Windows 11 are running the git version =
2.38.1-6  I downloaded the day before yesterday. Since both Windows =
boxes are running the latest version of git (for Windows), I'll focus on =
these.  Here is the output from trying from the Windows 10 machine via =
the LAN (but Linux, RBPi, and Mac are equivalent, modulo the dreaded =
backslash quirks on all non-Windows machines):
>>>=20
>>>  $ git clone 10.0.7.181:D:\gitDepot\test.git
>>>  Cloning into 'test'...
>>>  username@10.0.7.181's password:
>>>  fatal: ''D:\gitDepot\test.git'' does not appear to be a git =
repository
>>>  fatal: Could not read from remote repository.
>>=20
>> This is somewhat out of the blue,
>> did you try
>>=20
>> git clone 10.0.7.181:D:/gitDepot/test.git
>>=20
>> What result do you get ?
>=20

