From: =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
Subject: Re: gettext CTYPE for libc
Date: Mon, 25 Nov 2013 08:32:17 +0700
Message-ID: <5292A8A1.2040903@gmail.com>
References: <52900FD6.5020202@gmail.com> <874n72goem.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git-malling-list <git@vger.kernel.org>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Nov 25 02:32:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vkl2R-0001Yn-FL
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 02:32:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859Ab3KYBcb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 20:32:31 -0500
Received: from mail-pd0-f182.google.com ([209.85.192.182]:52506 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433Ab3KYBcb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 20:32:31 -0500
Received: by mail-pd0-f182.google.com with SMTP id v10so4407761pde.41
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 17:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=E1A22isfTj/qbGvC7JR5Y1JGyKmRsEBeESiqo1d5XvM=;
        b=mwfGFb0/L6jdHGYGmo/MQwJURmmdl4JSTrV3fK3rYOOFaThLJGVW5e7pFv22vuLQEs
         eE+xHiD/TptxcTIq+kYHGqQ9YnmuC2TLOdtmCfnoghQk0+gjP/7tzRUme7Q6ImA35p3J
         kmx1o3sTD+8rjv/j8jxzuDptiLQtEkCBlQ/7hHeIyboIKtXpq5x24DMoeGZGyw3Qgjg/
         t5yre2sVPYbi3WdXqvrBK4uTHWd5evOKd6hFti3LGmLZvlwvyDvWTYizL0od00jNpS7W
         pt0dfdV28gyarCb5k0Mf3S3NIT/EyHw6MWiTFGuYeDaWpDDeHuuQV6CY6cpquKSSBsj7
         ijVQ==
X-Received: by 10.66.218.198 with SMTP id pi6mr25047575pac.107.1385343150743;
        Sun, 24 Nov 2013 17:32:30 -0800 (PST)
Received: from vnwildman.myftp.org ([113.171.220.86])
        by mx.google.com with ESMTPSA id ka3sm69131229pbc.32.2013.11.24.17.32.28
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Nov 2013 17:32:29 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <874n72goem.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238271>

On 24/11/2013 16:05, Thomas Rast wrote:
> Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n <vnwildman@gmail.com> writes:
>
>> $ git status
>> fatal: Unable to read current working directory: Kh?ng c? t?p tin ho=
?c
>> th? m?c nh? v?y
>>
>> So, somthing wrong with our charset.
> [...]
> Do you know why this "suddenly" broke?
I think git set CTYPE=3D"C" for libc, so charset become  7-bit ASCII, b=
ut
it don't set LC_MESSAGES=3D"C" for libc and libc will get this one from
system variable.
> The long comment in
> init_gettext_charset() suggests that the *existing* code is there to
> handle exactly this problem, and apparently it doesn't.  Why?  Has li=
bc
> moved the perror() strings into a separate domain in some version?
See setlocale(3) [1]
I'm a newbie in GIT. I'm not sure about git work correctly [2] if set
git's charset to same with system.
I don't think libc moved perror() string in separate domain. It use its
own domain.

[1]  http://man7.org/linux/man-pages/man3/setlocale.3.html
[2]  incorrect if some function need work in ASCII mode

--=20
Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n.
