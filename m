From: =?UTF-8?B?6YOR5ZCR5piV?= <pandazxx@gmail.com>
Subject: Re: [Bug report] too many open files while cvsimport
Date: Mon, 24 Feb 2014 10:12:35 +0800
Message-ID: <CABAQQMni8BY5AWZm_reH3e3nf8zkTCJYqzewrjcHg-jW82FaYA@mail.gmail.com>
References: <CABAQQMkSe6k9nNk3m6HSYmguuOvzp7n06dWNBRbaCxqGO=WEAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 24 03:13:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHl2T-0003aJ-6s
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 03:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbaBXCM5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Feb 2014 21:12:57 -0500
Received: from mail-wg0-f65.google.com ([74.125.82.65]:42827 "EHLO
	mail-wg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbaBXCM4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Feb 2014 21:12:56 -0500
Received: by mail-wg0-f65.google.com with SMTP id l18so1559218wgh.8
        for <git@vger.kernel.org>; Sun, 23 Feb 2014 18:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=8m9VSOo3A/QanI4xvIxoZGKg/GJ6DT2ycRtxlvLM6Mk=;
        b=enLvoyzZyVf6uSx+9zfDJQlIGKQfZ1HZZwUl8h4JL5PlCR88l6i+8hUrUPJaM8qzBG
         k7WwYIcD4czWOWx+N/RptyOEUAhWPDmQxffYgDpey/YVTo5no0/R0wCpGPioAycq7U9d
         OFKoVM+8263tOC2kcBbS3CWQiY4TEt/uS2SD3mnSiQZnRc9D5DxNPyWFVWXVpKmmdGRG
         j/FH/zp3z1w0Jar+cCAcunNlWH3gL5K5vdWeO6NZ3Za2B5B8Yr18InJpUjC5xoNM9qNr
         rYtp8nqq3+/IPoa7zN3wvyC4R4XxD+qmRCng4M+VTpoybZY2R/JrxRaKrTudYlagWS8h
         dMFw==
X-Received: by 10.180.87.9 with SMTP id t9mr11719159wiz.36.1393207975254; Sun,
 23 Feb 2014 18:12:55 -0800 (PST)
Received: by 10.180.5.10 with HTTP; Sun, 23 Feb 2014 18:12:35 -0800 (PST)
In-Reply-To: <CABAQQMkSe6k9nNk3m6HSYmguuOvzp7n06dWNBRbaCxqGO=WEAQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242555>

Hi

git reports "Unknown: error  Too many open files" when importing cvs
repository using cvsimport. The repository is kind of middle size one,
around 5000 files, thousands commits.

Command line is:
# git cvsimport -k -L 2

current ulimit:

# ulimit -a
-t: cpu time (seconds)              unlimited
-f: file size (blocks)              unlimited
-d: data seg size (kbytes)          unlimited
-s: stack size (kbytes)             10240
-c: core file size (blocks)         0
-m: resident set size (kbytes)      unlimited
-u: processes                       32767
-n: file descriptors                10000
-l: locked-in-memory size (kbytes)  32
-v: address space (kbytes)          unlimited
-x: file locks                      unlimited
-i: pending signals                 32767
-q: bytes in POSIX msg queues       819200
-e: max nice                        0
-r: max rt priority                 0

System: RHEL i386

# git --version
git version 1.9.0

I build git from source.

Best Regards,
Xiangxin Zheng
Best Regards,
Xiangxin Zheng


2014-02-21 13:48 GMT+08:00 =E9=83=91=E5=90=91=E6=98=95 <pandazxx@gmail.=
com>:
> Hi
>
> git reports "Unknown: error  Too many open files" when importing cvs
> repository using cvsimport. The repository is kind of middle size one=
,
> around 5000 files, thousands commits.
>
> Command line is:
> # git cvsimport -k -L 2
>
> current ulimit:
>
> # ulimit -a
> -t: cpu time (seconds)              unlimited
> -f: file size (blocks)              unlimited
> -d: data seg size (kbytes)          unlimited
> -s: stack size (kbytes)             10240
> -c: core file size (blocks)         0
> -m: resident set size (kbytes)      unlimited
> -u: processes                       32767
> -n: file descriptors                10000
> -l: locked-in-memory size (kbytes)  32
> -v: address space (kbytes)          unlimited
> -x: file locks                      unlimited
> -i: pending signals                 32767
> -q: bytes in POSIX msg queues       819200
> -e: max nice                        0
> -r: max rt priority                 0
>
> System: RHEL i386
>
> # git --version
> git version 1.9.0
>
> I build git from source.
>
> Best Regards,
> Xiangxin Zheng
