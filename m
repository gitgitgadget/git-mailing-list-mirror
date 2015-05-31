From: Bruce Korb <bruce.korb@gmail.com>
Subject: Re: seg fault in "git format-patch"
Date: Sun, 31 May 2015 13:41:29 -0700
Message-ID: <CAKRnqNKVfzt_qMqoxsjMpunUYDNYd8C0jACM69HxGhJHEeVY-Q@mail.gmail.com>
References: <556B5D4C.4030406@gmail.com> <CAP8UFD0Pi3_hF0+S3AXktD5NkBL_Q1mU_oN4fULyZemDEUr8Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Development <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 22:41:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzA3R-0008LI-3T
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 22:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758526AbbEaUlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 16:41:53 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:33975 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758494AbbEaUlv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 16:41:51 -0400
Received: by wgv5 with SMTP id 5so99518008wgv.1
        for <git@vger.kernel.org>; Sun, 31 May 2015 13:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=f5m5IWuFVCMTz045yv50W+PSAPs6kNXzm68/aU41APE=;
        b=Pq4eWKilbhNQvGPS80RPZ21AzeZ2btgMHfKu9kOnkqLHFs8e6g4cuaJlN2HwI/Ylxs
         omd8wjVbFH9/St+Yu47zJdvFbLKscM+dAbsgpgeEGfls6SQjgOtndW4l3U/dN8ajud44
         yLvwlJPtO/l3CI8Zxc7ORmEmUydIfr/VP62Fj7lvMK4gle0B6T8SFLOFi4+kVoI3eNdW
         cwWI5O7InW8J0Z42uXAcjdtcwtlW9Ae/xlN2EgGES3gfegFOdBBPFuRPyne46k5pJ4Do
         Qa9NYc7Ca9S12MzHl5JiZ1FyF/6r13KgW/js/QWbzuXk+DCn1kXlvKAvxSLum+W5Iq1/
         5JeQ==
X-Received: by 10.180.107.70 with SMTP id ha6mr14486974wib.20.1433104910462;
 Sun, 31 May 2015 13:41:50 -0700 (PDT)
Received: by 10.194.208.234 with HTTP; Sun, 31 May 2015 13:41:29 -0700 (PDT)
In-Reply-To: <CAP8UFD0Pi3_hF0+S3AXktD5NkBL_Q1mU_oN4fULyZemDEUr8Jg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270351>

bt won't help much:

Program received signal SIGSEGV, Segmentation fault.
0x000000000047e62f in ?? ()
(gdb) bt
#0  0x000000000047e62f in ?? ()
#1  0x000000000047e6ba in ?? ()
#2  0x000000000043cb9a in ?? ()
#3  0x000000000043e9cc in ?? ()
#4  0x000000000040647d in ?? ()
#5  0x0000000000405863 in ?? ()
#6  0x00007ffff6fc3be5 in __libc_start_main () from /lib64/libc.so.6
#7  0x0000000000405cd5 in ?? ()

$ git --version
git version 1.8.4.5
$ rpm -q -a|grep  '^git'
git-email-1.8.4.5-3.8.4.x86_64
gitg-0.2.7-3.1.4.x86_64
git-cvs-1.8.4.5-3.8.4.x86_64
git-svn-1.8.4.5-3.8.4.x86_64
git-web-1.8.4.5-3.8.4.x86_64
git-gui-1.8.4.5-3.8.4.x86_64
gitg-lang-0.2.7-3.1.4.noarch
git-1.8.4.5-3.8.4.x86_64
git-core-1.8.4.5-3.8.4.x86_64
gitk-1.8.4.5-3.8.4.x86_64

$ head -n 300 /etc/*eleas*
==> /etc/SuSE-release <==
openSUSE 13.1 (x86_64)
VERSION = 13.1
CODENAME = Bottle
# /etc/SuSE-release is deprecated and will be removed in the future,
use /etc/os-release instead

==> /etc/lsb-release <==
LSB_VERSION="core-2.0-noarch:core-3.2-noarch:core-4.0-noarch:core-2.0-x86_64:core-3.2-x86_64:core-4.0-x86_64"

==> /etc/lsb-release.d <==
head: error reading '/etc/lsb-release.d': Is a directory

==> /etc/os-release <==
NAME=openSUSE
VERSION="13.1 (Bottle)"
VERSION_ID="13.1"
PRETTY_NAME="openSUSE 13.1 (Bottle) (x86_64)"
ID=opensuse
ANSI_COLOR="0;32"
CPE_NAME="cpe:/o:opensuse:opensuse:13.1"
BUG_REPORT_URL="https://bugs.opensuse.org"
HOME_URL="https://opensuse.org/"
ID_LIKE="suse"


On Sun, May 31, 2015 at 1:26 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Sun, May 31, 2015 at 9:13 PM, Bruce Korb <bruce.korb@gmail.com> wrote:
>> $ git format-patch -o patches --ignore-if-in-upstream
>> 14949fa8f39d29e44b43f4332ffaf35f11546502..2de9eef391259dfc8748dbaf76a5d55427f37b0d
>> Segmentation fault
>> /u/gnu/proj/gnu-pw-mgr
>> $ git format-patch -o patches
>> 14949fa8f39d29e44b43f4332ffaf35f11546502..2de9eef391259dfc8748dbaf76a5d55427f37b0d
>> patches/0001-remove-dead-code.patch
>> patches/0002-dead-code-removal.patch
>> patches/0003-add-sort-pw-cfg-program.patch
>> patches/0004-add-doc-for-sort-pw-cfg.patch
>> patches/0005-clean-up-doc-makefile.patch
>> patches/0006-clean-up-doc-makefile.patch
>> patches/0007-happy-2015-and-add-delete-option.patch
>> patches/0008-fix-doc-Makefile.am.patch
>> patches/0009-re-fix-copyright.patch
>> patches/0010-finish-debugging-remove_pwid.patch
>> patches/0011-only-update-file-if-something-was-removed.patch
>> patches/0012-update-NEWS.patch
>> patches/0013-bootstrap-cleanup.patch
>
> Could you tell us which git version you are using? You can use "git --version".
> The operating system you are using could also be useful.
> And maybe you could also run git under gdb and give us the output of
> the "bt" (backtrace) gdb command when it crashes?
>
> Thanks,
> Christian.
