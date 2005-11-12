From: Roberto Nibali <ratz@drugphish.ch>
Subject: git-core-0.99.9g: mailinfo.c:448: undefined reference to `libiconv_open'
Date: Sat, 12 Nov 2005 11:27:10 +0100
Message-ID: <4375C37E.6030509@drugphish.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Nov 12 11:28:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Easbi-0005D1-N2
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 11:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbVKLK1R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 05:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbVKLK1R
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 05:27:17 -0500
Received: from drugphish.ch ([69.55.226.176]:26508 "EHLO www.drugphish.ch")
	by vger.kernel.org with ESMTP id S932281AbVKLK1R (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2005 05:27:17 -0500
Received: from [172.23.2.3] (unknown [83.173.211.133])
	by www.drugphish.ch (Postfix) with ESMTP id CAAE9406C005
	for <git@vger.kernel.org>; Sat, 12 Nov 2005 11:27:13 +0100 (CET)
User-Agent: Thunderbird 1.4.1 (X11/20051006)
To: git@vger.kernel.org
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11668>

Hello,

I've tried to compile git-core-0.99.9g on an old SuSE 9.1 box with a
self-compiled libiconv. Anyone can shed a light on the following?

gcc -o mailinfo.o -c -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>' mailinfo.c
gcc -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>' -o git-mailinfo
mailinfo.o libgit.a
mailinfo.o(.text+0x799): In function `convert_to_utf8':
/data/down/git-core-0.99.9g/mailinfo.c:448: undefined reference to
`libiconv_open'
mailinfo.o(.text+0x7f6):/data/down/git-core-0.99.9g/mailinfo.c:460:
undefined reference to `libiconv'
mailinfo.o(.text+0x801):/data/down/git-core-0.99.9g/mailinfo.c:461:
undefined reference to `libiconv_close'
collect2: ld returned 1 exit status
make: *** [git-mailinfo] Error 1

# nm /usr/local/lib/libiconv.so | grep -E "libiconv_open|libiconv_close"
0000f550 T libiconv_close
0000f580 T libiconv_open

I might be missing something really obvious. It's not very important;
just if you happen to know something regarding this issue I'd be interested.

Regards,
Roberto Nibali, ratz
-- 
echo
'[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq' | dc
