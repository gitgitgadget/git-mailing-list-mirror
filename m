Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30476EB64DD
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 13:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbjGMNZG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 09:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbjGMNYw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 09:24:52 -0400
X-Greylist: delayed 1141 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Jul 2023 06:23:48 PDT
Received: from scc-mailout-kit-01.scc.kit.edu (scc-mailout-kit-01.scc.kit.edu [IPv6:2a00:1398:9:f712::810d:e751])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ABB3C3A
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 06:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=student.kit.edu; s=20220408; h=Content-Transfer-Encoding:Content-Type:
        Subject:To:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tBzKohqLgw0JSI83EtLP8ijOL9k61vbrjdGLUlTVLUo=; b=NxIddzBCYOGWERslsURKY0w5+u
        0XLTmkeBWinKEBhzZEFIe6As0W6uo7edIQ1EacVxisew5Vg1muW+hrql2VtrOAdqmIvwctGCE6jft
        eJpzzuDWCitDO/GuH6bSrNVo+O5RNikljs6MFhSWfIuuqZ58BBxUv7bjyn5iAD1UYZHins0t5UNjd
        3i8582REJ47hbg19nqbXka0koMJbi7hE3bNwaBrY7k1K/2mbW3Xp+uTl07pNorW3rU3/TBOiVgBUv
        ohC6fzOy2zt+0qj1fCQ9qxSc47YUbTxwa/9iGbhfev+m+2lbwqSIXpBoEPogesexCf7PunuoSkxi5
        tZBvIUxg==;
Received: from kit-msx-44.kit.edu ([2a00:1398:9:f612::144])
        by scc-mailout-kit-01.scc.kit.edu with esmtps (TLS1.2:ECDHE_SECP384R1__RSA_SHA256__AES_256_GCM:256)
        (envelope-from <uxecw@student.kit.edu>)
        id 1qJvzq-00Ck3X-Aw
        for git@vger.kernel.org; Thu, 13 Jul 2023 15:04:38 +0200
Received: from [IPV6:2a02:8071:67f0:fc0:3c65:561e:c5ff:fb6a]
 (2a02:8071:67f0:fc0:3c65:561e:c5ff:fb6a) by smtp.kit.edu
 (2a00:1398:9:f612::106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.16; Thu, 13 Jul
 2023 15:04:37 +0200
Message-ID: <fcdf19b3-269b-aa9f-38c2-d0f775524a89@student.kit.edu>
Date:   Thu, 13 Jul 2023 15:04:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US, de-DE
From:   uxecw <uxecw@student.kit.edu>
Autocrypt: addr=uxecw@student.kit.edu; keydata=
 xsFNBGKgiDkBEADfh1lLw7ou90rjVMQbl+8KuYhcvQgaLGeeFEibnQkxkAHAl3rh7gf73S15
 TQLEjLRL0TpMFxPUxZ2quH18F8PTRlcSV2oqW2CWby0yzk6ksnGGc9REOfmlkd4tqtqxNsTQ
 7XKNpMgvYRJvjCWIusc/aTiIWBx0VhpZAcDc+EMn/UH7r2zXBlQzojmFalyALJJRMkepitxr
 jU+J0kUDsg4XxpKvOLoVnkWjwvkZ1gh5SIzoxZIJafNR7O3czrsj/5L9BQRAnK/rnR9BQ/3G
 2YGPry+NxJs6GzE3DUyA6IltnA73qaRj68YjhFbwwCI93Yy4RK6m1ijWXOb/6gM3ixzmxVln
 4xYJgSSdYjd0wtQg5z7imSjEnoyolFK6/oF7vVymla2JYCVsfa3eFyUMMytPnmNKh8GuQRDH
 /fnIszO0CKEGgPTz3U/TuLvnVWqXN5oNqkOOd/CdsjMQjf/PIHUN8CjXhBvgH3g82ALIafXV
 I4Z9dRFxfLbpt0DA4p4dwe0xrqN0LCDUsztJfdbsZhTN6j+aXPC5ECsUrKOBPMm7u+mUqUK5
 XU+3GXDpUXAkmgHAgSO8q705BZXRPH99fUbW+kVtPK294HzMxH10tN7cyIcdj+JjXZ1dxjsC
 ix4wzR9UtTT+WfMeL/CzIlXXrAWe45Ki98Y5pOyHjZCdtMKUTQARAQABzR11eGVjdyA8dXhl
 Y3dAc3R1ZGVudC5raXQuZWR1PsLBjQQTAQgANxYhBHPVUMYzkNyoXTbVP+NJQ34w9R3DBQJi
 oIg6BQkFo5qAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQ40lDfjD1HcN4pw/9Ecfyn/bUdjpX
 btOdlFKWjZ5ZhyZM70u1tjdqjeMLTtr5sITVMZxbeTi08MoPN56JsbrFc5DYKJv9U9gS8Xgx
 bo4Jxn5ej4bMjGpePixAiKaMufdkUvoUui+bv4NOAirHQg49MB5QTDTS/7ON4nTk0ljV4QrF
 faAMNUmDvTwhXZWHhfhgdn41GqcqU5wVKFjTkED2A9Jfukshh4cdg7hwEkSYv5vxTdcXC4Qy
 1CXMqRNd/K04o+Gs0Jtt68QCnGylFqAXT5oALzobfqU7Cu0dHaE7ONRde50DRgOsZ1tTiGWp
 FFWWTxakq+83WV0Q4V1Kl2Ub6/NDqca5Ab7T2i7FEOzYM4aJ96dqV8u3cjdyzWstKBgrjdI/
 4gyoEWKstJxXQs5Ecg6X+Z+f1DvcG2S8aS2xBQRn3v+Vnxro4Qfff5uTmX3o6Lj/qQkSM79T
 J93qKonO+OggB+chdVFbXTYDwd1bJbokOKwipL/yAXn5ie3S02q4s1eI6grWcFgbthR7szin
 rDXC13XRHTpTNkr+ohd+JbU3eauIa5To1ICr9+1v/O5Vopvu39CTG0eFsvZKFyfGKQYEC9D9
 Hehd1EGE6iVUDbMXiPLbgTJ0/FyB1MvcohMQ7vJJ3dk8OiAM6v7QrVzl7/KqwQRjbMp1sfOq
 Guy++BwqBCjU+GC2d/agYh/OwU0EYqCIOgEQANgwg0WwBeWpjJS6qgLU/dMO6EI7mDlKVh/b
 eBrn/T1ttXaKWNT5k9wqtc+VXW5HOmP1g/nbf7GFflXVDfhcDMdpxQJLQsp/pZlHge1V910A
 GuGStGF9FFxhLci/SuqHnCQyyBJHJEpWY4rhFNCoq5OsyG5YnNWND4+w3/E7p8q01Ir9Xm3a
 JaSVuWL0GMNn/Dt4gp0WNrAHkGJei1JFZuV6yrfW3vSSiDQKkOrct6/xkp1Tx0B9bzsH5dak
 TMmHtpzBuBLi+D5IDRyrozx/r7pG+e/yBaeSmMtlEh5RBK7djOt/jeqJEBKB3EjF43MPG5Ez
 7zUyCL+CbQ5jlQEcIZl7ayZ6FB4/Cx094OjEOS9SPu4nZoPGS3GKe4LwuEm+XoSGZgA3eF6O
 HM0Cy5TeUbCdlzYOCp4ZM6PPrg4zwSKdIIz7Xzk11bYxPmCy2Goyx7v/TLbat+m4DTjQmwhw
 ogsSI/DzCuGYjXl+dC6m3h3FYwfo/nSKQtyARdX9FNaud7ESwanBmzyxx+YihEcJW5Qbxufx
 S7CR5kSsC+pOZ30mPjQI/gcTGqgHCIiqlLF5+yV4OT8zKHRCHZqyacM4yPLiX3L/0IoUUN/o
 9rGxMJ6rthCNPT9dKNtXFsssr5m3DqVTVmc1Hm3j/Cac9mOtXMTmVe9DD/VOV2V0LS3AruB/
 ABEBAAHCwXwEGAEIACYWIQRz1VDGM5DcqF021T/jSUN+MPUdwwUCYqCIOwUJBaOagAIbDAAK
 CRDjSUN+MPUdw3JkD/9D3/F/yY6l4o2P/rMPDf9YdwEM1dY9mcZNVfElJmPz5xpZSuh4tms/
 VBrpDzYqoyWBCzr2I/I3qc0uSCmI2VlrlhReDw7O7pt/FxtlXd96oCflBIG71D9DHWpAGnlh
 QUNkSIA78E5lRLt4XXwfvYvfbVSs9BOEkVYPeZ4K2sopJmJa5Jv8KE0h8rciPGeszWqPCAnk
 kmA4WHhi7elmusaSEIZwqHaPC2cm7K3a/mcsDFUgeBj20fRdgO86fA4Y0sGLm6lFNTdKarts
 lV+f5yFDUr91blyCkpS7Ss/EZC5W99WiVJoDnnkdE8TTm6ikohhjDoO/yFIbvfVgEe0IdFL9
 CnLN98bzYcWKI32n2KcYu9N1h/0oG69NklvHvL7E9QzZ1I6iqZjqpvtUZQt6SmRReru5R7JG
 NYIQYhRfjA2zd+EdEa/AVtJLyde+R4gFshn3lffmE9gmBqwlR9CSI7057R5D/4iD5OQjFvQv
 s+CiCIupCISGnKizmEKWb0hoOLCrW0VNcB1YTQGvOyMRHAmyLp62iIsk3V/iZg+0/Eor+1di
 oWvFXZpHPGoqA6d9zP/WqEa3WRNmPcnPmaUdnwyL1I1xhS/AjnWozsGkwgelyneIkUx03kNt
 4RdrNOM9DKLgCCmKBl3iAz3PbcCIwhR6/00kuXhWLd0vms8YOhKs2w==
To:     <git@vger.kernel.org>
Subject: Bug Report - Git does not require a space between shorthand flags and
 the commit-message
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2a02:8071:67f0:fc0:3c65:561e:c5ff:fb6a]
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
Rebasing.
I entered `git commit —amend` (one hypen istead of two) accidently and 
it passed as defacto `git commit —all —message "end"`.
I think because of the missing space git should have rejected the given 
input.

What did you expect to happen? (Expected behavior)
Input should have been rejected

What happened instead? (Actual behavior)
`git commit —all —message "end"`

What's different between what you expected and what actually happened?

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.34.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.19.0-46-generic #47~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC 
Wed Jun 21 15:35:31 UTC 2 x86_64
compiler info: gnuc: 11.3
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show

