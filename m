Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C58C2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 18:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 432A8208B6
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 18:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bHHgKh0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgIWSu7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 14:50:59 -0400
Received: from mout.gmx.net ([212.227.15.18]:40883 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbgIWSu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 14:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600887057;
        bh=lPjFfrc4i6zW2omvwdsgDVwJ1TFuFJO83IpV8xPWoy8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bHHgKh0sOkijcDALgldaHHpaGvYiPs++MuncLggoQifmKZmc8PYnzVyZcHVZ2Nih2
         RZ2TqPlrc6nJOlGVz3k+ahAVGR6PfgDPFETnWHEyxwaawOp8q+TlP/5sYe/MB4TnrA
         DPcq2IgSDxGPCiJujFMvv+89mhpGLgq6cxLQWzbA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.89.169] ([89.1.212.22]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9o1v-1kQMui0BOP-005uG2; Wed, 23
 Sep 2020 20:50:57 +0200
Date:   Wed, 23 Sep 2020 16:48:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "Miriam R." <mirucam@gmail.com>
cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH v7 00/13] Finish converting git bisect to C part 2
In-Reply-To: <CAN7CjDDVp_i7dhpbAq5zrGW69nE6+SfivJQ-dembmu+WyqKiQQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009231647370.5061@tvgsbejvaqbjf.bet>
References: <20200831105043.97665-1-mirucam@gmail.com> <nycvar.QRO.7.76.6.2009031403510.56@tvgsbejvaqbjf.bet> <CAN7CjDDVp_i7dhpbAq5zrGW69nE6+SfivJQ-dembmu+WyqKiQQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jCcbfU6iG/L5qsGsQuFSXWS350GaJ63UGhyw5D45XJbma0CgJFA
 sjTQzz9AeWIzJBcpvAqt3B/26SReNml9qw/mrNyKn7n08kaBrsWEz/wmfgmj/ks1KRx4FLF
 xwBz/Q9bPGMMB641LV0xIaQKooLBfqtaptuseO8Em/17VlSMz04hVhxMIkMWt+6BY2lspfM
 8HCICaZ0+DnIX7IUKF9Lg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P+YXB//tHOA=:9rHGYcmPCh+pr69rhapjy7
 JT4HAOC1wRDH126VWFvdCVFt9bC81wKqUjqHF+rJRpqmj+bQwso22sPJjBi3b7XJCMwOFtLfh
 D50ZYW2v+wzMjVYzz1cBU9XE2DVl62Uh1fZlepje43BC/TavlHNzwvBXC3nFKXkHsSCjD4Ax7
 7eXABdbPOUhJ3hy0rYk2KdgdcSd90V+T2CfgJSdbtESf2xEwIK56z/CYlC34VBlW8rOwDBOyb
 6nvjFosoWBZOQTqxQ8W24VQ2swFDEdOnGgIJZ+n+br/tOePtsBnsTeggpiE3N4PkXqR2eGr2j
 uwOT2DHvjLGOXSU2OiJ9rvgLPMUgT4eFMbQocOQtWEn5qPJIrlVN9XC/vB9jfcfjTj3TRHk6b
 eku6fFwCbJmimlYB0/yJQDhIlYYbhlw7ZfXqoLfDt8CWjfRIz1aWLGSEIX24ROk4DgdH5FaJr
 TwWnKWPRhg6T1ibv3HeqvV2pYZzUGXS1vE2mYBZ9BTxdt6h2vH4vOBO5MalP9I6iLhZVbRXnV
 HHLlDazjJeVLV4yMv4Z4A4gJYGH1UbQ9R26Jb7K6D2wJHH9f+9nz5d07u7tuaeaZQSnDATvQH
 Sujtu5taUDs84ZAqp3IoC6NxeiESU1h41RukWJFRPB/8iJxYFzBAA1B/qQctyR7VTbZXoIDNm
 qoxHG5P4ZvikR74p2kyFr7oDXL3vvRRRX04n/2GkMrkITMfSLiKRotmMmcqQvG/1vxZAg7QKy
 7e2swC+qLbQrpT7jXMJhIBPaaYHfYCnK+6U4Vhv4VZMkVQQUwQMIyvlDFScDcl4q5/3uir9Fy
 DMe4q06THjxDmFr3pt/8OxeL6x122pIlpx877wM0pXRS3LbI3Gxijx+5/nYOTlI9x9vtJ5NKi
 /+hjzq+A9yNydBE01zArbUbUuyycYLrcnxl9qXhLAwDj4byRqT4mirbLE47f6kO3k9ZFH734Z
 VP2ZgR1ba811okmQR8sEJoO/dMubgHaReAmWNYd6nZsbmap737dylDf0mANCD8brpFN8zNo38
 uvjhD+dsMSb2CuQK4RsK5Yqv+UhfsZ0VyhaiMXSJS/k7z+bOsCZa13aXYYdVmlcyt3TjpBVEA
 sMCtlLoiK9mUnKZ4czVOc6WE9RAMt04HPNYpNlpETtfv91ege6y1XkAkeUE786jQ7IgkgkOj0
 agsyGPk1BG1xxVMIXQdi6HLIiYhOvi+pD51Q0ji0gG5omN9zRuB6XzrV46AnBTK3OxHun82L3
 O6O0dzVgV7/Yv+XmI0GRM4vL6Bkb+Z0E7M+RzTQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Wed, 23 Sep 2020, Miriam R. wrote:

> Applying some of your suggestions related to removing some 'eval' in
> git-bisect shell script, a bug has appeared. It seems it is related to
> a previous code merged before my internship.

Now you got me curious: what bug did you see?

> Christian Couder will take over this fix, but in the meantime I will
> send a subset of this part2, with the first six patches of this patch
> series (and that are not affected by the problem) in order to move
> them forward and be accepted, hopefully .

Okay, good. Let me know if I can help!

Thanks,
Dscho
