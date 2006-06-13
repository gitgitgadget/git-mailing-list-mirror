From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 1/4] Remove dependencies with absolute path
Date: Tue, 13 Jun 2006 00:32:24 -0400
Message-ID: <20060613043224.16681.98358.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Jun 13 06:32:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fq0Zz-0005Mg-Nc
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 06:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932869AbWFMEch (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 00:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932871AbWFMEcg
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 00:32:36 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:45966 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932869AbWFMEce
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jun 2006 00:32:34 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Fq0Zt-0003S6-LI
	for git@vger.kernel.org; Tue, 13 Jun 2006 00:32:33 -0400
Received: from [127.0.0.1] (helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.62)
	(envelope-from <proski@gnu.org>)
	id 1Fq0Zn-0004LA-57; Tue, 13 Jun 2006 00:32:27 -0400
To: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org,
	cvsps@dm.cobite.com
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21763>

From: Pavel Roskin <proski@gnu.org>

Not everybody has headers in the same locations and not everybody uses
gcc 3.3.6.  Only leave dependencies with relative path.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 Makefile |  213 ++++----------------------------------------------------------
 1 files changed, 14 insertions(+), 199 deletions(-)

diff --git a/Makefile b/Makefile
index 1257ae7..cc277e2 100644
--- a/Makefile
+++ b/Makefile
@@ -38,218 +38,33 @@ clean:
 .PHONY: install clean
 # DO NOT DELETE
 
-cache.o: /usr/include/stdio.h /usr/include/features.h
-cache.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
-cache.o: /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/include/stddef.h
-cache.o: /usr/include/bits/types.h /usr/include/bits/wordsize.h
-cache.o: /usr/include/bits/typesizes.h /usr/include/libio.h
-cache.o: /usr/include/_G_config.h /usr/include/wchar.h
-cache.o: /usr/include/bits/wchar.h /usr/include/gconv.h
-cache.o: /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/include/stdarg.h
-cache.o: /usr/include/bits/stdio_lim.h /usr/include/bits/sys_errlist.h
-cache.o: /usr/include/search.h /usr/include/string.h /usr/include/stdlib.h
-cache.o: /usr/include/limits.h
-cache.o: /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/include/limits.h
-cache.o: /usr/include/unistd.h /usr/include/bits/posix_opt.h
-cache.o: /usr/include/bits/confname.h /usr/include/ctype.h
-cache.o: /usr/include/endian.h /usr/include/bits/endian.h /usr/include/time.h
-cache.o: /usr/include/bits/time.h ./cbtcommon/hash.h ./cbtcommon/list.h
-cache.o: ./cbtcommon/inline.h ./cbtcommon/debug.h /usr/include/sys/types.h
+cache.o: ./cbtcommon/hash.h ./cbtcommon/list.h
+cache.o: ./cbtcommon/inline.h ./cbtcommon/debug.h
 cache.o: cache.h cvsps_types.h cvsps.h util.h
-cap.o: /usr/include/stdio.h /usr/include/features.h /usr/include/sys/cdefs.h
-cap.o: /usr/include/gnu/stubs.h
-cap.o: /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/include/stddef.h
-cap.o: /usr/include/bits/types.h /usr/include/bits/wordsize.h
-cap.o: /usr/include/bits/typesizes.h /usr/include/libio.h
-cap.o: /usr/include/_G_config.h /usr/include/wchar.h
-cap.o: /usr/include/bits/wchar.h /usr/include/gconv.h
-cap.o: /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/include/stdarg.h
-cap.o: /usr/include/bits/stdio_lim.h /usr/include/bits/sys_errlist.h
-cap.o: /usr/include/stdlib.h /usr/include/string.h ./cbtcommon/debug.h
-cap.o: /usr/include/sys/types.h /usr/include/time.h /usr/include/bits/time.h
+cap.o: ./cbtcommon/debug.h
 cap.o: ./cbtcommon/inline.h ./cbtcommon/text_util.h cap.h cvs_direct.h
-cvs_direct.o: /usr/include/string.h /usr/include/features.h
-cvs_direct.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
-cvs_direct.o: /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/include/stddef.h
-cvs_direct.o: /usr/include/unistd.h /usr/include/bits/posix_opt.h
-cvs_direct.o: /usr/include/bits/types.h /usr/include/bits/wordsize.h
-cvs_direct.o: /usr/include/bits/typesizes.h /usr/include/bits/confname.h
-cvs_direct.o: /usr/include/stdlib.h /usr/include/limits.h
-cvs_direct.o: /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/include/limits.h
-cvs_direct.o: /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/include/stdarg.h
-cvs_direct.o: /usr/include/zlib.h /usr/include/zconf.h
-cvs_direct.o: /usr/include/sys/types.h /usr/include/time.h
-cvs_direct.o: /usr/include/bits/time.h /usr/include/sys/socket.h
-cvs_direct.o: /usr/include/sys/uio.h /usr/include/bits/uio.h
-cvs_direct.o: /usr/include/bits/socket.h /usr/include/bits/sockaddr.h
-cvs_direct.o: /usr/include/asm/socket.h /usr/include/asm/sockios.h
-cvs_direct.o: ./cbtcommon/debug.h /usr/include/stdio.h /usr/include/libio.h
-cvs_direct.o: /usr/include/_G_config.h /usr/include/wchar.h
-cvs_direct.o: /usr/include/bits/wchar.h /usr/include/gconv.h
-cvs_direct.o: /usr/include/bits/stdio_lim.h /usr/include/bits/sys_errlist.h
+cvs_direct.o: ./cbtcommon/debug.h
 cvs_direct.o: ./cbtcommon/inline.h ./cbtcommon/text_util.h
 cvs_direct.o: ./cbtcommon/tcpsocket.h ./cbtcommon/sio.h cvs_direct.h util.h
-cvsps.o: /usr/include/stdio.h /usr/include/features.h
-cvsps.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
-cvsps.o: /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/include/stddef.h
-cvsps.o: /usr/include/bits/types.h /usr/include/bits/wordsize.h
-cvsps.o: /usr/include/bits/typesizes.h /usr/include/libio.h
-cvsps.o: /usr/include/_G_config.h /usr/include/wchar.h
-cvsps.o: /usr/include/bits/wchar.h /usr/include/gconv.h
-cvsps.o: /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/include/stdarg.h
-cvsps.o: /usr/include/bits/stdio_lim.h /usr/include/bits/sys_errlist.h
-cvsps.o: /usr/include/stdlib.h /usr/include/string.h /usr/include/limits.h
-cvsps.o: /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/include/limits.h
-cvsps.o: /usr/include/unistd.h /usr/include/bits/posix_opt.h
-cvsps.o: /usr/include/bits/confname.h /usr/include/search.h
-cvsps.o: /usr/include/time.h /usr/include/bits/time.h /usr/include/ctype.h
-cvsps.o: /usr/include/endian.h /usr/include/bits/endian.h
-cvsps.o: /usr/include/sys/stat.h /usr/include/bits/stat.h
-cvsps.o: /usr/include/sys/types.h /usr/include/fcntl.h
-cvsps.o: /usr/include/bits/fcntl.h /usr/include/regex.h
-cvsps.o: /usr/include/sys/wait.h /usr/include/signal.h
-cvsps.o: /usr/include/bits/sigset.h /usr/include/bits/signum.h
-cvsps.o: /usr/include/sys/resource.h /usr/include/bits/resource.h
-cvsps.o: /usr/include/bits/waitflags.h /usr/include/bits/waitstatus.h
 cvsps.o: ./cbtcommon/hash.h ./cbtcommon/list.h ./cbtcommon/inline.h
 cvsps.o: ./cbtcommon/list.h ./cbtcommon/text_util.h ./cbtcommon/debug.h
 cvsps.o: ./cbtcommon/rcsid.h cache.h cvsps_types.h cvsps.h util.h stats.h
 cvsps.o: cap.h cvs_direct.h list_sort.h
-list_sort.o: /usr/include/stdio.h /usr/include/features.h
-list_sort.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
-list_sort.o: /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/include/stddef.h
-list_sort.o: /usr/include/bits/types.h /usr/include/bits/wordsize.h
-list_sort.o: /usr/include/bits/typesizes.h /usr/include/libio.h
-list_sort.o: /usr/include/_G_config.h /usr/include/wchar.h
-list_sort.o: /usr/include/bits/wchar.h /usr/include/gconv.h
-list_sort.o: /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/include/stdarg.h
-list_sort.o: /usr/include/bits/stdio_lim.h /usr/include/bits/sys_errlist.h
-list_sort.o: /usr/include/stdlib.h list_sort.h ./cbtcommon/list.h
-stats.o: /usr/include/stdio.h /usr/include/features.h
-stats.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
-stats.o: /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/include/stddef.h
-stats.o: /usr/include/bits/types.h /usr/include/bits/wordsize.h
-stats.o: /usr/include/bits/typesizes.h /usr/include/libio.h
-stats.o: /usr/include/_G_config.h /usr/include/wchar.h
-stats.o: /usr/include/bits/wchar.h /usr/include/gconv.h
-stats.o: /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/include/stdarg.h
-stats.o: /usr/include/bits/stdio_lim.h /usr/include/bits/sys_errlist.h
-stats.o: /usr/include/string.h /usr/include/search.h ./cbtcommon/hash.h
+list_sort.o: list_sort.h ./cbtcommon/list.h
+stats.o: ./cbtcommon/hash.h
 stats.o: ./cbtcommon/list.h ./cbtcommon/inline.h cvsps_types.h
-stats.o: /usr/include/time.h /usr/include/bits/time.h cvsps.h
-util.o: /usr/include/stdio.h /usr/include/features.h /usr/include/sys/cdefs.h
-util.o: /usr/include/gnu/stubs.h
-util.o: /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/include/stddef.h
-util.o: /usr/include/bits/types.h /usr/include/bits/wordsize.h
-util.o: /usr/include/bits/typesizes.h /usr/include/libio.h
-util.o: /usr/include/_G_config.h /usr/include/wchar.h
-util.o: /usr/include/bits/wchar.h /usr/include/gconv.h
-util.o: /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/include/stdarg.h
-util.o: /usr/include/bits/stdio_lim.h /usr/include/bits/sys_errlist.h
-util.o: /usr/include/string.h /usr/include/stdlib.h /usr/include/unistd.h
-util.o: /usr/include/bits/posix_opt.h /usr/include/bits/confname.h
-util.o: /usr/include/limits.h
-util.o: /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/include/limits.h
-util.o: /usr/include/assert.h /usr/include/search.h /usr/include/time.h
-util.o: /usr/include/bits/time.h /usr/include/errno.h
-util.o: /usr/include/bits/errno.h /usr/include/linux/errno.h
-util.o: /usr/include/asm/errno.h /usr/include/asm-generic/errno.h
-util.o: /usr/include/asm-generic/errno-base.h /usr/include/signal.h
-util.o: /usr/include/bits/sigset.h /usr/include/bits/signum.h
-util.o: /usr/include/regex.h /usr/include/sys/types.h /usr/include/sys/stat.h
-util.o: /usr/include/bits/stat.h /usr/include/sys/time.h
-util.o: /usr/include/sys/select.h /usr/include/bits/select.h
-util.o: /usr/include/sys/wait.h /usr/include/sys/resource.h
-util.o: /usr/include/bits/resource.h /usr/include/bits/waitflags.h
-util.o: /usr/include/bits/waitstatus.h ./cbtcommon/debug.h
+stats.o: cvsps.h
+util.o: ./cbtcommon/debug.h
 util.o: ./cbtcommon/inline.h util.h
-cbtcommon/debug.o: /usr/include/stdio.h /usr/include/features.h
-cbtcommon/debug.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
-cbtcommon/debug.o: /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/include/stddef.h
-cbtcommon/debug.o: /usr/include/bits/types.h /usr/include/bits/wordsize.h
-cbtcommon/debug.o: /usr/include/bits/typesizes.h /usr/include/libio.h
-cbtcommon/debug.o: /usr/include/_G_config.h /usr/include/wchar.h
-cbtcommon/debug.o: /usr/include/bits/wchar.h /usr/include/gconv.h
-cbtcommon/debug.o: /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/include/stdarg.h
-cbtcommon/debug.o: /usr/include/bits/stdio_lim.h
-cbtcommon/debug.o: /usr/include/bits/sys_errlist.h /usr/include/errno.h
-cbtcommon/debug.o: /usr/include/bits/errno.h /usr/include/linux/errno.h
-cbtcommon/debug.o: /usr/include/asm/errno.h /usr/include/asm-generic/errno.h
-cbtcommon/debug.o: /usr/include/asm-generic/errno-base.h /usr/include/ctype.h
-cbtcommon/debug.o: /usr/include/endian.h /usr/include/bits/endian.h
-cbtcommon/debug.o: /usr/include/string.h cbtcommon/debug.h
-cbtcommon/debug.o: /usr/include/sys/types.h /usr/include/time.h
-cbtcommon/debug.o: /usr/include/bits/time.h ./cbtcommon/inline.h
+cbtcommon/debug.o: cbtcommon/debug.h
+cbtcommon/debug.o: ./cbtcommon/inline.h
 cbtcommon/debug.o: cbtcommon/rcsid.h
-cbtcommon/hash.o: /usr/include/stdio.h /usr/include/features.h
-cbtcommon/hash.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
-cbtcommon/hash.o: /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/include/stddef.h
-cbtcommon/hash.o: /usr/include/bits/types.h /usr/include/bits/wordsize.h
-cbtcommon/hash.o: /usr/include/bits/typesizes.h /usr/include/libio.h
-cbtcommon/hash.o: /usr/include/_G_config.h /usr/include/wchar.h
-cbtcommon/hash.o: /usr/include/bits/wchar.h /usr/include/gconv.h
-cbtcommon/hash.o: /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/include/stdarg.h
-cbtcommon/hash.o: /usr/include/bits/stdio_lim.h
-cbtcommon/hash.o: /usr/include/bits/sys_errlist.h /usr/include/stdlib.h
-cbtcommon/hash.o: /usr/include/string.h cbtcommon/debug.h
-cbtcommon/hash.o: /usr/include/sys/types.h /usr/include/time.h
-cbtcommon/hash.o: /usr/include/bits/time.h ./cbtcommon/inline.h
+cbtcommon/hash.o: cbtcommon/debug.h
+cbtcommon/hash.o: ./cbtcommon/inline.h
 cbtcommon/hash.o: cbtcommon/hash.h ./cbtcommon/list.h cbtcommon/rcsid.h
-cbtcommon/sio.o: /usr/include/stdio.h /usr/include/features.h
-cbtcommon/sio.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
-cbtcommon/sio.o: /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/include/stddef.h
-cbtcommon/sio.o: /usr/include/bits/types.h /usr/include/bits/wordsize.h
-cbtcommon/sio.o: /usr/include/bits/typesizes.h /usr/include/libio.h
-cbtcommon/sio.o: /usr/include/_G_config.h /usr/include/wchar.h
-cbtcommon/sio.o: /usr/include/bits/wchar.h /usr/include/gconv.h
-cbtcommon/sio.o: /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/include/stdarg.h
-cbtcommon/sio.o: /usr/include/bits/stdio_lim.h
-cbtcommon/sio.o: /usr/include/bits/sys_errlist.h /usr/include/unistd.h
-cbtcommon/sio.o: /usr/include/bits/posix_opt.h /usr/include/bits/confname.h
-cbtcommon/sio.o: /usr/include/errno.h /usr/include/bits/errno.h
-cbtcommon/sio.o: /usr/include/linux/errno.h /usr/include/asm/errno.h
-cbtcommon/sio.o: /usr/include/asm-generic/errno.h
-cbtcommon/sio.o: /usr/include/asm-generic/errno-base.h cbtcommon/sio.h
+cbtcommon/sio.o: cbtcommon/sio.h
 cbtcommon/sio.o: cbtcommon/rcsid.h
-cbtcommon/tcpsocket.o: /usr/include/string.h /usr/include/features.h
-cbtcommon/tcpsocket.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
-cbtcommon/tcpsocket.o: /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/include/stddef.h
-cbtcommon/tcpsocket.o: /usr/include/sys/types.h /usr/include/bits/types.h
-cbtcommon/tcpsocket.o: /usr/include/bits/wordsize.h
-cbtcommon/tcpsocket.o: /usr/include/bits/typesizes.h /usr/include/time.h
-cbtcommon/tcpsocket.o: /usr/include/bits/time.h /usr/include/sys/socket.h
-cbtcommon/tcpsocket.o: /usr/include/sys/uio.h /usr/include/bits/uio.h
-cbtcommon/tcpsocket.o: /usr/include/bits/socket.h /usr/include/limits.h
-cbtcommon/tcpsocket.o: /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/include/limits.h
-cbtcommon/tcpsocket.o: /usr/include/bits/sockaddr.h /usr/include/asm/socket.h
-cbtcommon/tcpsocket.o: /usr/include/asm/sockios.h /usr/include/netinet/in.h
-cbtcommon/tcpsocket.o: /usr/include/stdint.h /usr/include/bits/wchar.h
-cbtcommon/tcpsocket.o: /usr/include/bits/in.h /usr/include/endian.h
-cbtcommon/tcpsocket.o: /usr/include/bits/endian.h
-cbtcommon/tcpsocket.o: /usr/include/bits/byteswap.h /usr/include/arpa/inet.h
-cbtcommon/tcpsocket.o: /usr/include/netdb.h /usr/include/bits/netdb.h
-cbtcommon/tcpsocket.o: /usr/include/errno.h /usr/include/bits/errno.h
-cbtcommon/tcpsocket.o: /usr/include/linux/errno.h /usr/include/asm/errno.h
-cbtcommon/tcpsocket.o: /usr/include/asm-generic/errno.h
-cbtcommon/tcpsocket.o: /usr/include/asm-generic/errno-base.h
 cbtcommon/tcpsocket.o: cbtcommon/tcpsocket.h cbtcommon/debug.h
-cbtcommon/tcpsocket.o: /usr/include/stdio.h /usr/include/libio.h
-cbtcommon/tcpsocket.o: /usr/include/_G_config.h /usr/include/wchar.h
-cbtcommon/tcpsocket.o: /usr/include/gconv.h
-cbtcommon/tcpsocket.o: /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/include/stdarg.h
-cbtcommon/tcpsocket.o: /usr/include/bits/stdio_lim.h
-cbtcommon/tcpsocket.o: /usr/include/bits/sys_errlist.h ./cbtcommon/inline.h
+cbtcommon/tcpsocket.o: ./cbtcommon/inline.h
 cbtcommon/tcpsocket.o: cbtcommon/rcsid.h
-cbtcommon/text_util.o: /usr/include/ctype.h /usr/include/features.h
-cbtcommon/text_util.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
-cbtcommon/text_util.o: /usr/include/bits/types.h /usr/include/bits/wordsize.h
-cbtcommon/text_util.o: /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/include/stddef.h
-cbtcommon/text_util.o: /usr/include/bits/typesizes.h /usr/include/endian.h
-cbtcommon/text_util.o: /usr/include/bits/endian.h /usr/include/string.h
-cbtcommon/text_util.o: /usr/include/stdio.h /usr/include/libio.h
-cbtcommon/text_util.o: /usr/include/_G_config.h /usr/include/wchar.h
-cbtcommon/text_util.o: /usr/include/bits/wchar.h /usr/include/gconv.h
-cbtcommon/text_util.o: /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.6/include/stdarg.h
-cbtcommon/text_util.o: /usr/include/bits/stdio_lim.h
-cbtcommon/text_util.o: /usr/include/bits/sys_errlist.h /usr/include/stdlib.h
 cbtcommon/text_util.o: cbtcommon/text_util.h cbtcommon/rcsid.h
