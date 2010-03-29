From: SungHyun Nam <goweol@gmail.com>
Subject: git diff too slow for a file
Date: Mon, 29 Mar 2010 10:42:11 +0900
Message-ID: <4BB00573.6040005@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040300060603090207060701"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 29 03:47:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nw455-000248-1Q
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 03:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755559Ab0C2Brt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 21:47:49 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:36836 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755556Ab0C2Brs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 21:47:48 -0400
Received: by gwaa18 with SMTP id a18so3759341gwa.19
        for <git@vger.kernel.org>; Sun, 28 Mar 2010 18:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:x-stationery:content-type;
        bh=uU2uTUcFy8WkVLEolzL6Df9Gv9Vj0KfL27z3x/UiS9c=;
        b=M8Hlwag+g0eTRDkw5+W81wDAiiJuVpz6rjvC/670Op/aI8wdIEjMMh90fiMcQN/XTR
         KVTT2/Gb0e5a4I87Sr4V/o2/9umWd5Z0ey7k86GHM5PJuNbbkwHsXHfFVNnvmDEFRruk
         Ia931wvlQBluWZf2cqxx2+UmaqY65YiblPC5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-stationery:content-type;
        b=oVpPog4VcRe0xzILBEhpBQ4gqUMA3je4/sdLbBx/rJUbh44PBrvBo4FJUZI545rvj8
         WcYNKw+Fh+QfUcqdRIm3Akv2wpblmSbM/Weht6FjWb0fBHSCnmKxqNd5iRLp5Bwzit7V
         pDX4gGX7bJLzthxDqjkYykvXBCi+ETm7qgJwc=
Received: by 10.150.142.11 with SMTP id p11mr1273189ybd.209.1269826922363;
        Sun, 28 Mar 2010 18:42:02 -0700 (PDT)
Received: from [210.181.13.12] ([210.181.13.12])
        by mx.google.com with ESMTPS id 5sm953670ywd.29.2010.03.28.18.42.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Mar 2010 18:42:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ko; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
X-Stationery: 0.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143426>

This is a multi-part message in MIME format.
--------------040300060603090207060701
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

If I run a attached script for bunzipped attached files, I get:
(To reduce size, I removed many lines and bzipped.)

     $ ./mk.sh
     time diff -u x3 x4 >/dev/null 2>&1

     real	0m0.011s
     user	0m0.000s
     sys	0m0.010s

     time git diff >/dev/null 2>&1

     real	0m0.193s
     user	0m0.190s
     sys	0m0.000s

     $ git version
     git version 1.7.0.2.273.gc2413

     $ diff --version
     diff (GNU diffutils) 2.8.1
     ...

Well, though the files are ascii file, they includes a random
hexa-decimal datas, so that I don't interest the diff result at
all.  But the real problem is 'rebasing took so long if the file
was changed'.  Because the git tree includes several such a file,
if they changed, rebase took some miniutes for every branch.
Such a branch includes a few lines of changes for a C source file,
though.  Now I'm waiting an hour to finish rebasing all the
branches and yet a rebasing script is running... :-(

Please help!
Thanks,
namsh

The original file has more than 180000 lines and the result is:
     $ ./mk.sh
     time diff -u x3 x4 >/dev/null 2>&1

     real	0m0.759s
     user	0m0.740s
     sys	0m0.010s

     time git diff >/dev/null 2>&1

     real	0m44.460s
     user	0m44.390s
     sys	0m0.030s


--------------040300060603090207060701
Content-Type: application/octet-stream;
 name="x3.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="x3.bz2"

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

--------------040300060603090207060701
Content-Type: application/octet-stream;
 name="x4.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="x4.bz2"

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
--------------040300060603090207060701
Content-Type: text/plain;
 name="mk.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="mk.sh"

IyEvYmluL2Jhc2gKCnJ1bl9jb21tYW5kKCkKewogICAgZWNobyAiJEAiCiAgICBldmFsICIk
QCIKfQoKcnVuX2NvbW1hbmQgJ3RpbWUgZGlmZiAtdSB4MyB4NCA+L2Rldi9udWxsIDI+JjEn
Cgp7CiAgICBybSAtcmYgdQogICAgbWtkaXIgdQogICAgY2QgdQogICAgY3AgLi4veDMgeAog
ICAgZ2l0IGluaXQKICAgIGdpdCBhZGQgLgogICAgZ2l0IGNpIC1tIHgKICAgIGNwIC4uL3g0
IHgKfSA+L2Rldi9udWxsIDI+JjEKCmVjaG8gJycKcnVuX2NvbW1hbmQgJ3RpbWUgZ2l0IGRp
ZmYgPi9kZXYvbnVsbCAyPiYxJwoKZXhpdCAwCg==
--------------040300060603090207060701--
