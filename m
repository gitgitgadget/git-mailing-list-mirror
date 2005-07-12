From: "Dan Kohn" <dan@dankohn.com>
Subject: Compilation troubles
Date: Tue, 12 Jul 2005 11:33:36 -0700
Message-ID: <B1091462CF5479489B1D8FE818330D2C01371D9F@exchange2003.ad.skymv.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-From: git-owner@vger.kernel.org Tue Jul 12 20:35:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsPay-0001op-14
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 20:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVGLSef (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 14:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVGLSec
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 14:34:32 -0400
Received: from mail.skymv.com ([66.120.210.140]:14281 "EHLO
	exchange2003.ad.skymv.com") by vger.kernel.org with ESMTP
	id S261934AbVGLSdi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2005 14:33:38 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Compilation troubles
Thread-Index: AcWHEDcGAWw+xoR4SmSK9oF5pT6cpA==
To: <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I apologize for what are probably obvious compilation questions, but I
suspect other newbies are encountering them as well.  I'm having trouble
installing cogito 0.12.1 on both a vanilla Ubuntu box and on my account
on a FreeBSD machine.  I'm used to autoconf-built programs, so there's
probably just some simple library path I'm not setting up right.  But
I'd appreciate your suggestions, and perhaps we can add the answer to
the INSTALL file.

UBUNTU 5.04

I used synaptics to install openssl, zlib, and curl, but cogito can't
seem to see them.

root@ubuntu-dan-kohn:/usr/local/src/cogito-0.12.1 # make
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o read-cache.o
read-cache.c
In file included from read-cache.c:6:
cache.h:21:21: openssl/sha.h: No such file or directory
cache.h:22:18: zlib.h: No such file or directory
In file included from read-cache.c:6:
cache.h:169: error: syntax error before '*' token
read-cache.c: In function `verify_hdr':
read-cache.c:339: error: `SHA_CTX' undeclared (first use in this
function)
read-cache.c:339: error: (Each undeclared identifier is reported only
once
read-cache.c:339: error: for each function it appears in.)
read-cache.c:339: error: syntax error before "c"
read-cache.c:346: warning: implicit declaration of function `SHA1_Init'
read-cache.c:346: error: `c' undeclared (first use in this function)
read-cache.c:347: warning: implicit declaration of function
`SHA1_Update'
read-cache.c:348: warning: implicit declaration of function `SHA1_Final'
read-cache.c: At top level:
read-cache.c:408: error: syntax error before '*' token
read-cache.c: In function `ce_write':
read-cache.c:410: error: `len' undeclared (first use in this function)
read-cache.c:415: error: `data' undeclared (first use in this function)
read-cache.c:418: error: `context' undeclared (first use in this
function)
read-cache.c:419: error: `fd' undeclared (first use in this function)
read-cache.c: At top level:
read-cache.c:430: error: syntax error before '*' token
read-cache.c: In function `ce_flush':
read-cache.c:436: error: `context' undeclared (first use in this
function)
read-cache.c:442: error: `fd' undeclared (first use in this function)
read-cache.c: In function `write_cache':
read-cache.c:449: error: `SHA_CTX' undeclared (first use in this
function)
read-cache.c:449: error: syntax error before "c"
read-cache.c:461: error: `c' undeclared (first use in this function)
make: *** [read-cache.o] Error 1
root@ubuntu-dan-kohn:/usr/local/src/cogito-0.12.1 # locate openssl
/etc/ssl/openssl.cnf
[long list of python and docs elided]
/usr/share/man/man1/openssl.1ssl.gz
/usr/bin/openssl
/usr/bin/openssl_fips_fingerprint
/usr/lib/libgnutls-openssl.so.11.1.16
/usr/lib/libgnutls-openssl.so.11
/usr/lib/ssl/openssl.cnf
/usr/local/ssl/man/man1/openssl.1
/usr/local/ssl/bin/openssl
/usr/local/ssl/lib/pkgconfig/openssl.pc
/usr/local/ssl/include/openssl
/usr/local/ssl/include/openssl/e_os2.h
/usr/local/ssl/include/openssl/crypto.h
/usr/local/ssl/include/openssl/tmdiff.h
/usr/local/ssl/include/openssl/opensslv.h
/usr/local/ssl/include/openssl/opensslconf.h
/usr/local/ssl/include/openssl/ebcdic.h
/usr/local/ssl/include/openssl/symhacks.h
/usr/local/ssl/include/openssl/ossl_typ.h
/usr/local/ssl/include/openssl/objects.h
/usr/local/ssl/include/openssl/obj_mac.h
/usr/local/ssl/include/openssl/md2.h
/usr/local/ssl/include/openssl/md4.h
/usr/local/ssl/include/openssl/md5.h
/usr/local/ssl/include/openssl/sha.h
/usr/local/ssl/include/openssl/hmac.h
/usr/local/ssl/include/openssl/ripemd.h
/usr/local/ssl/include/openssl/des.h
/usr/local/ssl/include/openssl/des_old.h
/usr/local/ssl/include/openssl/aes.h
/usr/local/ssl/include/openssl/rc2.h
/usr/local/ssl/include/openssl/rc4.h
/usr/local/ssl/include/openssl/idea.h
/usr/local/ssl/include/openssl/blowfish.h
/usr/local/ssl/include/openssl/cast.h
/usr/local/ssl/include/openssl/bn.h
/usr/local/ssl/include/openssl/ec.h
/usr/local/ssl/include/openssl/rsa.h
/usr/local/ssl/include/openssl/dsa.h
/usr/local/ssl/include/openssl/ecdsa.h
/usr/local/ssl/include/openssl/dh.h
/usr/local/ssl/include/openssl/ecdh.h
/usr/local/ssl/include/openssl/dso.h
/usr/local/ssl/include/openssl/engine.h
/usr/local/ssl/include/openssl/buffer.h
/usr/local/ssl/include/openssl/bio.h
/usr/local/ssl/include/openssl/stack.h
/usr/local/ssl/include/openssl/safestack.h
/usr/local/ssl/include/openssl/lhash.h
/usr/local/ssl/include/openssl/rand.h
/usr/local/ssl/include/openssl/err.h
/usr/local/ssl/include/openssl/evp.h
/usr/local/ssl/include/openssl/asn1.h
/usr/local/ssl/include/openssl/asn1_mac.h
/usr/local/ssl/include/openssl/asn1t.h
/usr/local/ssl/include/openssl/pem.h
/usr/local/ssl/include/openssl/pem2.h
/usr/local/ssl/include/openssl/x509.h
/usr/local/ssl/include/openssl/x509_vfy.h
/usr/local/ssl/include/openssl/x509v3.h
/usr/local/ssl/include/openssl/conf.h
/usr/local/ssl/include/openssl/conf_api.h
/usr/local/ssl/include/openssl/txt_db.h
/usr/local/ssl/include/openssl/pkcs7.h
/usr/local/ssl/include/openssl/pkcs12.h
/usr/local/ssl/include/openssl/comp.h
/usr/local/ssl/include/openssl/ocsp.h
/usr/local/ssl/include/openssl/ui.h
/usr/local/ssl/include/openssl/ui_compat.h
/usr/local/ssl/include/openssl/krb5_asn.h
/usr/local/ssl/include/openssl/store.h
/usr/local/ssl/include/openssl/pqueue.h
/usr/local/ssl/include/openssl/pq_compat.h
/usr/local/ssl/include/openssl/ssl.h
/usr/local/ssl/include/openssl/ssl2.h
/usr/local/ssl/include/openssl/ssl3.h
/usr/local/ssl/include/openssl/ssl23.h
/usr/local/ssl/include/openssl/tls1.h
/usr/local/ssl/include/openssl/dtls1.h
/usr/local/ssl/include/openssl/kssl.h
/usr/local/ssl/openssl.cnf
root@ubuntu-dan-kohn:/usr/local/src/cogito-0.12.1 # locate zlib
1.9.79/program/python-core-2.3.4/lib/encodings/zlib_codec.py
1.9.79/program/python-core-2.3.4/lib/test/test_zlib.py
/media/windows/Program Files/Trillian/zlib1.dll
/var/lib/dpkg/info/zlib1g.postinst
/var/lib/dpkg/info/zlib1g.list
/var/lib/dpkg/info/zlib1g.preinst
/var/lib/dpkg/info/zlib1g.shlibs
/var/lib/dpkg/info/zlib1g.md5sums
/var/cache/apt/archives/zlib1g_1%3a1.2.2-4ubuntu1.1_i386.deb
/usr/share/doc/zlib1g
/usr/share/doc/zlib1g/changelog.gz
/usr/share/doc/zlib1g/README.gz
/usr/share/doc/zlib1g/README.Debian
/usr/share/doc/zlib1g/copyright
/usr/share/doc/zlib1g/changelog.Debian.gz
/usr/share/doc/python2.4/examples/Demo/zlib
/usr/share/doc/python2.4/examples/Demo/zlib/minigzip.py
/usr/share/doc/python2.4/examples/Demo/zlib/zlibdemo.py
/usr/include/linux/zlib.h
/usr/lib/python2.4/lib-dynload/zlib.so
/usr/lib/python2.4/encodings/zlib_codec.py
/usr/lib/python2.4/encodings/zlib_codec.pyc
/usr/lib/python2.4/encodings/zlib_codec.pyo
/usr/lib/win32/avizlib.dll
/lib/modules/2.6.10-5-386/kernel/lib/zlib_deflate
/lib/modules/2.6.10-5-386/kernel/lib/zlib_deflate/zlib_deflate.ko
root@ubuntu-dan-kohn:/usr/local/src/cogito-0.12.1 #




FREEBSD

I believe I need to modify the Makefile to find my libcurl, but I don't
know how.  Also, it's probably worth mentioning in INSTALL that gmake is
necessary, for those machines that have both.

[emlis:~/src/cogito-0.12.1]$ make
"Makefile", line 109: Need an operator
"Makefile", line 112: Need an operator
"Makefile", line 115: Need an operator
"Makefile", line 116: Need an operator
"Makefile", line 119: Need an operator
"Makefile", line 120: Need an operator
"Makefile", line 123: Need an operator
"Makefile", line 126: Need an operator
"Makefile", line 127: Need an operator
"Makefile", line 162: Missing dependency operator
"Makefile", line 165: Need an operator
make: fatal errors encountered -- cannot continue
[emlis:~/src/cogito-0.12.1]$ gmake
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o read-cache.o
read-cache.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o sha1_file.o
sha1_file.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o usage.o usage.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o object.o
object.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o commit.o
commit.c
commit.c: In function `add_user_info':
commit.c:244: warning: field width is not type int (arg 4)
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o tree.o tree.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o blob.o blob.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o tag.o tag.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o date.o date.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o index.o index.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o diff-delta.o
diff-delta.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o patch-delta.o
patch-delta.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o entry.o entry.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o path.o path.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o epoch.o epoch.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o refs.o refs.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o csum-file.o
csum-file.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o pack-check.o
pack-check.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o pkt-line.o
pkt-line.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o connect.o
connect.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o strbuf.o
strbuf.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o quote.o quote.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o diff.o diff.c
diff.c: In function `parse_num':
diff.c:702: warning: value computed is not used
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o
diffcore-rename.o diffcore-rename.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o
diffcore-pickaxe.o diffcore-pickaxe.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o
diffcore-pathspec.o diffcore-pathspec.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o
diffcore-break.o diffcore-break.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o
diffcore-order.o diffcore-order.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o count-delta.o
count-delta.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o gitenv.o
gitenv.c
ar rcs libgit.a read-cache.o sha1_file.o usage.o object.o commit.o
tree.o blob.o tag.o date.o index.o diff-delta.o patch-delta.o entry.o
path.o epoch.o refs.o csum-file.o pack-check.o pkt-line.o connect.o
strbuf.o quote.o  diff.o diffcore-rename.o diffcore-pickaxe.o
diffcore-pathspec.o diffcore-break.o diffcore-order.o count-delta.o
gitenv.o epoch.o
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o update-cache.o
update-cache.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>' -o git-update-cache
update-cache.o libgit.a -lz -lcrypto
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o diff-files.o
diff-files.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>' -o git-diff-files
diff-files.o libgit.a -lz -lcrypto
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o init-db.o
init-db.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>' -o git-init-db
init-db.o libgit.a -lz -lcrypto
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o write-tree.o
write-tree.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>' -o git-write-tree
write-tree.o libgit.a -lz -lcrypto
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o read-tree.o
read-tree.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>' -o git-read-tree
read-tree.o libgit.a -lz -lcrypto
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o commit-tree.o
commit-tree.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>' -o git-commit-tree
commit-tree.o libgit.a -lz -lcrypto
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o cat-file.o
cat-file.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>' -o git-cat-file
cat-file.o libgit.a -lz -lcrypto
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o fsck-cache.o
fsck-cache.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>' -o git-fsck-cache
fsck-cache.o libgit.a -lz -lcrypto
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o
checkout-cache.o checkout-cache.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>' -o git-checkout-cache
checkout-cache.o libgit.a -lz -lcrypto
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o diff-tree.o
diff-tree.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>' -o git-diff-tree
diff-tree.o libgit.a -lz -lcrypto
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o rev-tree.o
rev-tree.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>' -o git-rev-tree
rev-tree.o libgit.a -lz -lcrypto
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o ls-files.o
ls-files.c
ls-files.c: In function `show_files':
ls-files.c:270: warning: unsigned int format, u_long arg (arg 3)
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>' -o git-ls-files
ls-files.o libgit.a -lz -lcrypto
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o check-files.o
check-files.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>' -o git-check-files
check-files.o libgit.a -lz -lcrypto
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o ls-tree.o
ls-tree.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>' -o git-ls-tree
ls-tree.o libgit.a -lz -lcrypto
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o merge-base.o
merge-base.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>' -o git-merge-base
merge-base.o libgit.a -lz -lcrypto
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o merge-cache.o
merge-cache.c
merge-cache.c: In function `merge_entry':
merge-cache.c:62: warning: unsigned int format, long unsigned int arg
(arg 3)
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>' -o git-merge-cache
merge-cache.o libgit.a -lz -lcrypto
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o unpack-file.o
unpack-file.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>' -o git-unpack-file
unpack-file.o libgit.a -lz -lcrypto
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o export.o
export.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>' -o git-export export.o
libgit.a -lz -lcrypto
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o diff-cache.o
diff-cache.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>' -o git-diff-cache
diff-cache.o libgit.a -lz -lcrypto
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o convert-cache.o
convert-cache.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>' -o git-convert-cache
convert-cache.o libgit.a -lz -lcrypto
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o pull.o pull.c
cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o http-pull.o
http-pull.c
http-pull.c:6: curl/curl.h: No such file or directory
http-pull.c:7: curl/easy.h: No such file or directory
gmake: *** [http-pull.o] Error 1
rm cat-file.o diff-files.o rev-tree.o fsck-cache.o convert-cache.o
unpack-file.o diff-cache.o checkout-cache.o update-cache.o diff-tree.o
export.o read-tree.o write-tree.o merge-base.o ls-tree.o check-files.o
commit-tree.o merge-cache.o ls-files.o init-db.o
[emlis:~/src/cogito-0.12.1]$ which curl
/usr/local/bin/curl
[emlis:~/src/cogito-0.12.1]$ locate libcurl
/usr/local/lib/comprex/scheme/libcurlscm.a
/usr/local/lib/comprex/scheme/libcurlscm.la
/usr/local/lib/comprex/scheme/libcurlscm.so
/usr/local/lib/libcurl.a
/usr/local/lib/libcurl.la
/usr/local/lib/libcurl.so
/usr/local/lib/libcurl.so.2
/usr/local/man/man3/libcurl-errors.3
/usr/local/man/man3/libcurl-multi.3
/usr/local/man/man3/libcurl.3
/usr/local/share/doc/curl/libcurl
/usr/local/share/doc/curl/libcurl/Makefile
/usr/local/share/doc/curl/libcurl/Makefile.am
/usr/local/share/doc/curl/libcurl/Makefile.in
/usr/local/share/doc/curl/libcurl/curl_easy_cleanup.3
/usr/local/share/doc/curl/libcurl/curl_easy_cleanup.html
/usr/local/share/doc/curl/libcurl/curl_easy_cleanup.pdf
/usr/local/share/doc/curl/libcurl/curl_easy_duphandle.3
/usr/local/share/doc/curl/libcurl/curl_easy_duphandle.html
/usr/local/share/doc/curl/libcurl/curl_easy_duphandle.pdf
/usr/local/share/doc/curl/libcurl/curl_easy_getinfo.3
/usr/local/share/doc/curl/libcurl/curl_easy_getinfo.html
/usr/local/share/doc/curl/libcurl/curl_easy_getinfo.pdf
/usr/local/share/doc/curl/libcurl/curl_easy_init.3
/usr/local/share/doc/curl/libcurl/curl_easy_init.html
/usr/local/share/doc/curl/libcurl/curl_easy_init.pdf
/usr/local/share/doc/curl/libcurl/curl_easy_perform.3
/usr/local/share/doc/curl/libcurl/curl_easy_perform.html
/usr/local/share/doc/curl/libcurl/curl_easy_perform.pdf
/usr/local/share/doc/curl/libcurl/curl_easy_setopt.3
/usr/local/share/doc/curl/libcurl/curl_easy_setopt.html
/usr/local/share/doc/curl/libcurl/curl_easy_setopt.pdf
/usr/local/share/doc/curl/libcurl/curl_escape.3
/usr/local/share/doc/curl/libcurl/curl_escape.html
/usr/local/share/doc/curl/libcurl/curl_escape.pdf
/usr/local/share/doc/curl/libcurl/curl_formadd.3
/usr/local/share/doc/curl/libcurl/curl_formadd.html
/usr/local/share/doc/curl/libcurl/curl_formadd.pdf
/usr/local/share/doc/curl/libcurl/curl_formfree.3
/usr/local/share/doc/curl/libcurl/curl_formfree.html
/usr/local/share/doc/curl/libcurl/curl_formfree.pdf
/usr/local/share/doc/curl/libcurl/curl_formparse.3
/usr/local/share/doc/curl/libcurl/curl_formparse.html
/usr/local/share/doc/curl/libcurl/curl_formparse.pdf
/usr/local/share/doc/curl/libcurl/curl_free.3
/usr/local/share/doc/curl/libcurl/curl_free.html
/usr/local/share/doc/curl/libcurl/curl_free.pdf
/usr/local/share/doc/curl/libcurl/curl_getdate.3
/usr/local/share/doc/curl/libcurl/curl_getdate.html
/usr/local/share/doc/curl/libcurl/curl_getdate.pdf
/usr/local/share/doc/curl/libcurl/curl_getenv.3
/usr/local/share/doc/curl/libcurl/curl_getenv.html
/usr/local/share/doc/curl/libcurl/curl_getenv.pdf
/usr/local/share/doc/curl/libcurl/curl_global_cleanup.3
/usr/local/share/doc/curl/libcurl/curl_global_cleanup.html
/usr/local/share/doc/curl/libcurl/curl_global_cleanup.pdf
/usr/local/share/doc/curl/libcurl/curl_global_init.3
/usr/local/share/doc/curl/libcurl/curl_global_init.html
/usr/local/share/doc/curl/libcurl/curl_global_init.pdf
/usr/local/share/doc/curl/libcurl/curl_mprintf.3
/usr/local/share/doc/curl/libcurl/curl_mprintf.html
/usr/local/share/doc/curl/libcurl/curl_mprintf.pdf
/usr/local/share/doc/curl/libcurl/curl_multi_add_handle.3
/usr/local/share/doc/curl/libcurl/curl_multi_add_handle.html
/usr/local/share/doc/curl/libcurl/curl_multi_add_handle.pdf
/usr/local/share/doc/curl/libcurl/curl_multi_cleanup.3
/usr/local/share/doc/curl/libcurl/curl_multi_cleanup.html
/usr/local/share/doc/curl/libcurl/curl_multi_cleanup.pdf
/usr/local/share/doc/curl/libcurl/curl_multi_fdset.3
/usr/local/share/doc/curl/libcurl/curl_multi_fdset.html
/usr/local/share/doc/curl/libcurl/curl_multi_fdset.pdf
/usr/local/share/doc/curl/libcurl/curl_multi_info_read.3
/usr/local/share/doc/curl/libcurl/curl_multi_info_read.html
/usr/local/share/doc/curl/libcurl/curl_multi_info_read.pdf
/usr/local/share/doc/curl/libcurl/curl_multi_init.3
/usr/local/share/doc/curl/libcurl/curl_multi_init.html
/usr/local/share/doc/curl/libcurl/curl_multi_init.pdf
/usr/local/share/doc/curl/libcurl/curl_multi_perform.3
/usr/local/share/doc/curl/libcurl/curl_multi_perform.html
/usr/local/share/doc/curl/libcurl/curl_multi_perform.pdf
/usr/local/share/doc/curl/libcurl/curl_multi_remove_handle.3
/usr/local/share/doc/curl/libcurl/curl_multi_remove_handle.html
/usr/local/share/doc/curl/libcurl/curl_multi_remove_handle.pdf
/usr/local/share/doc/curl/libcurl/curl_slist_append.3
/usr/local/share/doc/curl/libcurl/curl_slist_append.html
/usr/local/share/doc/curl/libcurl/curl_slist_append.pdf
/usr/local/share/doc/curl/libcurl/curl_slist_free_all.3
/usr/local/share/doc/curl/libcurl/curl_slist_free_all.html
/usr/local/share/doc/curl/libcurl/curl_slist_free_all.pdf
/usr/local/share/doc/curl/libcurl/curl_strequal.3
/usr/local/share/doc/curl/libcurl/curl_strequal.html
/usr/local/share/doc/curl/libcurl/curl_strequal.pdf
/usr/local/share/doc/curl/libcurl/curl_strnequal.3
/usr/local/share/doc/curl/libcurl/curl_strnequal.html
/usr/local/share/doc/curl/libcurl/curl_strnequal.pdf
/usr/local/share/doc/curl/libcurl/curl_unescape.3
/usr/local/share/doc/curl/libcurl/curl_unescape.html
/usr/local/share/doc/curl/libcurl/curl_unescape.pdf
/usr/local/share/doc/curl/libcurl/curl_version.3
/usr/local/share/doc/curl/libcurl/curl_version.html
/usr/local/share/doc/curl/libcurl/curl_version.pdf
/usr/local/share/doc/curl/libcurl/curl_version_info.3
/usr/local/share/doc/curl/libcurl/curl_version_info.html
/usr/local/share/doc/curl/libcurl/curl_version_info.pdf
/usr/local/share/doc/curl/libcurl/index.html
/usr/local/share/doc/curl/libcurl/libcurl-errors.3
/usr/local/share/doc/curl/libcurl/libcurl-errors.html
/usr/local/share/doc/curl/libcurl/libcurl-errors.pdf
/usr/local/share/doc/curl/libcurl/libcurl-multi.3
/usr/local/share/doc/curl/libcurl/libcurl-multi.html
/usr/local/share/doc/curl/libcurl/libcurl-multi.pdf
/usr/local/share/doc/curl/libcurl/libcurl.3
/usr/local/share/doc/curl/libcurl/libcurl.html
/usr/local/share/doc/curl/libcurl/libcurl.pdf
/usr/local/share/doc/curl/libcurl-the-guide
[emlis:~/src/cogito-0.12.1]$ curl-config --version
libcurl 7.10.5

          - dan
--
Dan Kohn <mailto:dan@dankohn.com>
<http://www.dankohn.com/>  <tel:+1-650-327-2600>
