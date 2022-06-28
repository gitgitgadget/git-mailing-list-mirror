Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFF7C433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 00:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241880AbiF1AJi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 20:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238290AbiF1AJh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 20:09:37 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55F5DFB
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 17:09:36 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-101b4f9e825so15026804fac.5
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 17:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=Jht8lLPxTjtnZe95B0bvXuNYlTiqWqAsjBUH2EWPR00=;
        b=X7PF5RWiYPMU5iynV/xN9Tpa37mv7w3Qe1SaYoODn95o1TUJzOtaZ12/NDfHbAgyAt
         ZmH8ENfImltPLqYfSRtLLfhr2gR6ZghhZK7Uytih6CNBvTiE4ySdxtI1hyVdip7Yyx6N
         BrdZMDjYslihhVxUPSxExaY2w73YXfS85NTf0g4UYLaqhtnXv59iqoRM5DYiXYc9frdU
         krAkbvj8QxQMusqoRaSWjZXb5Zehy8JkbpfWU/l0ToIWUqhv5SRIqdMNq00YngaUGydP
         iAU3c6rd9D7irGyiccTXu8JvIqpRe5BHxgTFo1JreiOQpci4f6ToR++lA75RbjRHgkqT
         WJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=Jht8lLPxTjtnZe95B0bvXuNYlTiqWqAsjBUH2EWPR00=;
        b=nEQFvnIMFVo1FLNgLnih1ZQSmQssTDqTYc+G3rYEGqN9MQA2rIypRSFde0it8cPSmh
         Z25KQbx0b108Z1pXRALuNOcbZgiW5TNff7W/KW1l8fvaVZv0l+PK/V+mfzqMd3/uCRwq
         tZS9NqtTYyxMv3meesTPkbkd6ChpbQJHE0PTB8IT05V1ZKdc2gM+SAw+PUqQ4rrHsmgA
         S4kUbiqnmbcQhZeYesx4II2RHYEJyrLOElLLDNjOwnyHCOMdVyYUcOX/wnsbIo4heaVf
         NgyKkxtDw4dipvZZ7+NIGUr8VXXLLOP6M1Iy4rDA+bKXnTKZsq1IZAktXufFR12iHCL/
         v2ww==
X-Gm-Message-State: AJIora+6p4G1kZ55vRFBsQzYqoet1bEn/jfmJKET/KmDiNAs2E50ef7E
        6hwqVPt1vVeGvkeBp+t6Qyu6hqLNnG+gow==
X-Google-Smtp-Source: AGRyM1tM/6z6pk0pFvuzrCmDj556IqIq91MoH4tUJ5+4JN+VpKxulVSwOfCsTyneGwLOLQpo51acUg==
X-Received: by 2002:a05:6871:80c:b0:101:be11:a08a with SMTP id q12-20020a056871080c00b00101be11a08amr11766690oap.90.1656374975880;
        Mon, 27 Jun 2022 17:09:35 -0700 (PDT)
Received: from ?IPV6:2804:d51:495a:8100:45f7:7064:6998:d39? ([2804:d51:495a:8100:45f7:7064:6998:d39])
        by smtp.gmail.com with ESMTPSA id r1-20020a4aa8c1000000b00425a2c7f19asm2708489oom.5.2022.06.27.17.09.34
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 17:09:35 -0700 (PDT)
Message-ID: <97adcd90-b4d3-1114-205b-3445dd48b497@gmail.com>
Date:   Mon, 27 Jun 2022 21:09:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Content-Language: en-US
To:     git@vger.kernel.org
From:   Marcos Alano <marcoshalano@gmail.com>
Subject: Unable to use security key to commit signing using SSH keypair
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello fellows!

I'm able to sign commits using SSH keypair, but the keypair must be 
located in a file. If I try to use a SSH keypair in a security key (like 
an YubiKey) I get an error. I used this commands to do the test:
```
ssh-keygen -t ed25519-sk -f ~/.ssh/id_ed25519_sk
git config --global gpg.format ssh
git config --global user.signingkey "$(cat ~/.ssh/id_ed25519_sk.pub)"
git commit -S --allow-empty --message="Testing"
```

Bnd I get this error:
```
error: Couldn't load public key sk-ssh-ed25519@openssh.com <my key id>: 
No such file or directory?

fatal: failed to write commit object
```
I did the same thing with a plain ed25519 keypair and worked.

Am I doing anything wrong or security keys aren't supported yet?

Thank you for any help,
-- 
Marcos Alano
