Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60B791F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 00:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbfJ1AL5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 20:11:57 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:38513 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfJ1AL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Oct 2019 20:11:57 -0400
Received: by mail-pl1-f182.google.com with SMTP id w8so4612225plq.5
        for <git@vger.kernel.org>; Sun, 27 Oct 2019 17:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=A6meYb6b8lnOKSaOcM2Ag7LccGU4fzqN5870Ey8PDDg=;
        b=ZcLQY09gg5ZFb6yoIMafT+BpX4WmL+YQ9gPAqd2x0RGm6thQLUjIWUjGfUxwdQoWPm
         Q6H/KunYXvXrj+J4d22dgefojagzibAi+o72Wz0j4MkH406z8oxXeWDi8DqmsxHPrWSH
         sroiLHCG4A7hggi1fxVT1WRa28sUl3nGOswH4DDvA39lzNiSmeNdU2q5S3EY2n/jc/Uz
         Eujn4nBEug0AIz2nfCg7CzeKRpNoDzkOBbt4EggXw3cv6CD/itW3981YA3fiPdQicdH1
         aOL3O5ZIQPf4MJFTdSyrWX9PX3AqVH6L4LSqumZfjVSwvIInPeJ6rowc6DqqTB6T0o7z
         kHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=A6meYb6b8lnOKSaOcM2Ag7LccGU4fzqN5870Ey8PDDg=;
        b=T1ksJXrLCRZc6/OH4sV0Y8RaRAKhI3vNQadtvpfimPppRsLbqkJUTQIoYvTDRIBlV4
         184yPEhp3ycqVhnsE6u+QMnEeOTPNinF6mivqbBPTraKnpxLOlMx3+9xesHjD5YyQR7e
         MeAwKQqFTON5XUaoKM7gnmsEZ3TcWAcwR0CdgZXkaNgwpeTGcEmt5+qB7SYptP7lritO
         jxh9UM0+5OP7bGAS8ddu1GUSAlz6pO9Vz/N0H7SZvCp+BOIPE0YCO+ByhEoy3LxR7wic
         jXVIEszZcMYIOq/sMgav+hq1v4M7uZrB3ZLEDnrz0Wbq5z6X0i0YDGe0MkgANyVCz7at
         QsEQ==
X-Gm-Message-State: APjAAAW2vY2UG7mqWbb5fq6e3J8tT4Mab4UB0+4+mOOEsAbpv8bFRGEb
        GI6iAJvM1Sgr9vGs6jaFLSheTypy
X-Google-Smtp-Source: APXvYqy3pbE0Mf60jf/aDExXz/t9MAjGD8thglhqRIU/gk1/Qh1CA1dUbfqaP4h5WillOymHuuvNXw==
X-Received: by 2002:a17:902:36a:: with SMTP id 97mr16456883pld.83.1572221516219;
        Sun, 27 Oct 2019 17:11:56 -0700 (PDT)
Received: from LJZDELLPC ([184.103.122.48])
        by smtp.gmail.com with ESMTPSA id s202sm11029368pfs.24.2019.10.27.17.11.55
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2019 17:11:55 -0700 (PDT)
From:   <lyle.ziegelmiller@gmail.com>
To:     "'git bug report'" <git@vger.kernel.org>
Subject: unpacking error
Date:   Sun, 27 Oct 2019 17:11:52 -0700
Message-ID: <004101d58d24$4daab5b0$e9002110$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdWNJDiIfjDgERHAQoKm8S5KM08uyA==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi

I almost always get this error when pushing from my PC to the bare
repository on my laptop. I'm running Cygwin on Windows 10. I've tried
everything! chmod -R 777, chown -R <my user id>, etc.

A few more details: I have a Git repository on my PC, and from that, I've
cloned a bare repository on my laptop, which I then used to clone a regular
repository on my laptop. The error occurs when I attempt to push changes on
my PC into the bare repository on my laptop.

If I delete the old bare repository on my laptop, I'm able to create a new
bare repository on my laptop from my pc, but then as soon as I try to push
to it, I get this error again. I've tried disabling the anti-virus, etc.
I've spent hours Googling solutions. Nothing works! Many others have had
this same issue. I never had this type of problem with SVN.

It would be nice if Git would say what's failing when this happens, and it
would be nice to get this bug fixed. It happens with all my git
repositories. I don't think it's a network issue or I wouldn't be able to
create a new repository on my laptop from my PC, as that would encounter the
same permissions issues.

The two machines are connected with an ethernet cable. I've done everything
I can to make sure all the Windows permissions are set correctly, etc.

$ git push
Counting objects: 3, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 331 bytes | 331.00 KiB/s, done.
Total 3 (delta 2), reused 0 (delta 0)
remote: fatal: not a git repository: '.'
error: remote unpack failed: unpack-objects abnormal exit To
//lylez-laptop/Users/Administrator/bare-repositories/Tradelab-bare-repositor
y.git/
 ! [remote rejected] timestamp_testing -> timestamp_testing (unpacker error)
error: failed to push some refs to
'//lylez-laptop/Users/Administrator/bare-repositories/Tradelab-bare-reposito
ry.git/'


$ git --version
git version 2.17.0

------------------
System Information
------------------
      Time of this report: 10/27/2019, 16:53:09
             Machine name: LJZ-DELLPC
               Machine Id: {39BC0826-743F-4ECA-AFBE-66A14FBE533C}
         Operating System: Windows 10 Pro 64-bit (10.0, Build 17134)
(17134.rs4_release.180410-1804)
                 Language: English (Regional Setting: English)
      System Manufacturer: Dell Inc.
             System Model: Inspiron 3650
                     BIOS: BIOS Date: 06/17/16 21:14:07 Ver: 05.0000B (type:
BIOS)
                Processor: Intel(R) Core(TM) i5-6400 CPU @ 2.70GHz (4 CPUs),
~2.7GHz
                   Memory: 8192MB RAM
      Available OS Memory: 8096MB RAM
                Page File: 8076MB used, 7243MB available
              Windows Dir: C:\WINDOWS
          DirectX Version: DirectX 12
      DX Setup Parameters: Not found
         User DPI Setting: 96 DPI (100 percent)
       System DPI Setting: 96 DPI (100 percent)
          DWM DPI Scaling: Disabled
                 Miracast: Available, with HDCP Microsoft Graphics Hybrid:
Not Supported
           DxDiag Version: 10.00.17134.0001 64bit Unicode


Regards,

Lyle Ziegelmiller




