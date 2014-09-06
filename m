From: dev <dev@cor0.com>
Subject: "trace.c", line 219: error: identifier redeclared: trace_strbuf
Date: Sat, 6 Sep 2014 15:26:54 -0400 (EDT)
Message-ID: <893371408.24076.1410031614959.JavaMail.vpopmail@webmail2.networksolutionsemail.com>
Reply-To: dev <dev@cor0.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 06 21:27:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQLdX-0004E7-6s
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 21:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbaIFT07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 15:26:59 -0400
Received: from atl4mhob13.myregisteredsite.com ([209.17.115.51]:39310 "EHLO
	atl4mhob13.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751371AbaIFT06 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 15:26:58 -0400
Received: from atl4oxapp02pod2.mgt.hosting.qts.netsol.com ([10.30.77.38])
	by atl4mhob13.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s86JQsaQ008194
	for <git@vger.kernel.org>; Sat, 6 Sep 2014 15:26:54 -0400
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v6.20.7-Rev18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256601>




Build on Solaris 10 of latest git tarball fails thus :

    CC tag.o
    CC trace.o
"trace.c", line 219: error: identifier redeclared: trace_strbuf
        current : function(pointer to const char, pointer to const
struct strbuf {unsigned long alloc, unsigned long len, pointer to char
buf}) returning void
        previous: function(pointer to struct trace_key {const pointer to
const char key, int fd, unsigned int initialized :1, unsigned int
need_close :1}, pointer to const struct strbuf {unsigned long alloc,
unsigned long len, pointer to char buf}) returning void : "trace.h",
line 33
"trace.c", line 221: warning: argument 0000003 is incompatible with
prototype:
        prototype: pointer to struct trace_key {const pointer to const
char key, int fd, unsigned int initialized :1, unsigned int need_close
:1} : "trace.c", line 160
        argument : pointer to const char
"trace.c", line 390: error: reference to static identifier "offset" in
extern inline function
"trace.c", line 392: error: reference to static identifier "offset" in
extern inline function
"trace.c", line 393: error: reference to static identifier "offset" in
extern inline function
"trace.c", line 401: error: reference to static identifier "offset" in
extern inline function
"trace.c", line 403: error: reference to static identifier "offset" in
extern inline function
cc: acomp failed for trace.c
gmake: *** [trace.o] Error 2




extracted the tarball and did the following :

$ gmake CFLAGS="$CFLAGS" LDFLAGS="$LD_OPTIONS" NEEDS_LIBICONV=Yes \
> SHELL_PATH=/usr/local/bin/bash \
> SANE_TOOL_PATH=/usr/local/bin \
> USE_LIBPCRE=1 LIBPCREDIR=/usr/local CURLDIR=/usr/local \
> EXPATDIR=/usr/local NEEDS_LIBINTL_BEFORE_LIBICONV=1 \
> NEEDS_SOCKET=1 NEEDS_RESOLV=1 USE_NSEC=1 \
> PERL_PATH=/usr/local/bin/perl \
> TAR=/usr/bin/tar \
> NO_PYTHON=1 DEFAULT_PAGER=/usr/xpg4/bin/more \
> DEFAULT_EDITOR=/usr/local/bin/vim DEFAULT_HELP_FORMAT=man \
> prefix=/usr/local
GIT_VERSION = 2.1.0
    * new build flags
    CC credential-store.o
    * new link flags
    CC abspath.o
    CC advice.o
    CC alias.o
    CC alloc.o
    CC archive.o
    CC archive-tar.o
    CC archive-zip.o
    CC argv-array.o
    * new prefix flags
    CC attr.o
    CC base85.o
    CC bisect.o
    CC blob.o
    CC branch.o
    CC bulk-checkin.o
    CC bundle.o
    CC cache-tree.o
    CC color.o
    CC column.o
    CC combine-diff.o
    CC commit.o
    CC compat/obstack.o
    CC compat/terminal.o
    CC config.o
    CC connect.o
    CC connected.o
    CC convert.o
    CC copy.o
    CC credential.o
    CC csum-file.o
    CC ctype.o
"ctype.c", line 50: warning: initializer does not fit or is out of
range: 128
"ctype.c", line 50: warning: initializer does not fit or is out of
range: 129
"ctype.c", line 50: warning: initializer does not fit or is out of
range: 130
"ctype.c", line 50: warning: initializer does not fit or is out of
range: 131
"ctype.c", line 50: warning: initializer does not fit or is out of
range: 132
"ctype.c", line 50: warning: initializer does not fit or is out of
range: 133
"ctype.c", line 50: warning: initializer does not fit or is out of
range: 134
"ctype.c", line 50: warning: initializer does not fit or is out of
range: 135
"ctype.c", line 51: warning: initializer does not fit or is out of
range: 136
"ctype.c", line 51: warning: initializer does not fit or is out of
range: 137
"ctype.c", line 51: warning: initializer does not fit or is out of
range: 138
"ctype.c", line 51: warning: initializer does not fit or is out of
range: 139
"ctype.c", line 51: warning: initializer does not fit or is out of
range: 140
"ctype.c", line 51: warning: initializer does not fit or is out of
range: 141
"ctype.c", line 51: warning: initializer does not fit or is out of
range: 142
"ctype.c", line 51: warning: initializer does not fit or is out of
range: 143
"ctype.c", line 52: warning: initializer does not fit or is out of
range: 144
"ctype.c", line 52: warning: initializer does not fit or is out of
range: 145
"ctype.c", line 52: warning: initializer does not fit or is out of
range: 146
"ctype.c", line 52: warning: initializer does not fit or is out of
range: 147
"ctype.c", line 52: warning: initializer does not fit or is out of
range: 148
"ctype.c", line 52: warning: initializer does not fit or is out of
range: 149
"ctype.c", line 52: warning: initializer does not fit or is out of
range: 150
"ctype.c", line 52: warning: initializer does not fit or is out of
range: 151
"ctype.c", line 53: warning: initializer does not fit or is out of
range: 152
"ctype.c", line 53: warning: initializer does not fit or is out of
range: 153
"ctype.c", line 53: warning: initializer does not fit or is out of
range: 154
"ctype.c", line 53: warning: initializer does not fit or is out of
range: 155
"ctype.c", line 53: warning: initializer does not fit or is out of
range: 156
"ctype.c", line 53: warning: initializer does not fit or is out of
range: 157
"ctype.c", line 53: warning: initializer does not fit or is out of
range: 158
"ctype.c", line 53: warning: initializer does not fit or is out of
range: 159
"ctype.c", line 54: warning: initializer does not fit or is out of
range: 160
"ctype.c", line 54: warning: initializer does not fit or is out of
range: 161
"ctype.c", line 54: warning: initializer does not fit or is out of
range: 162
"ctype.c", line 54: warning: initializer does not fit or is out of
range: 163
"ctype.c", line 54: warning: initializer does not fit or is out of
range: 164
"ctype.c", line 54: warning: initializer does not fit or is out of
range: 165
"ctype.c", line 54: warning: initializer does not fit or is out of
range: 166
"ctype.c", line 54: warning: initializer does not fit or is out of
range: 167
"ctype.c", line 55: warning: initializer does not fit or is out of
range: 168
"ctype.c", line 55: warning: initializer does not fit or is out of
range: 169
"ctype.c", line 55: warning: initializer does not fit or is out of
range: 170
"ctype.c", line 55: warning: initializer does not fit or is out of
range: 171
"ctype.c", line 55: warning: initializer does not fit or is out of
range: 172
"ctype.c", line 55: warning: initializer does not fit or is out of
range: 173
"ctype.c", line 55: warning: initializer does not fit or is out of
range: 174
"ctype.c", line 55: warning: initializer does not fit or is out of
range: 175
"ctype.c", line 56: warning: initializer does not fit or is out of
range: 176
"ctype.c", line 56: warning: initializer does not fit or is out of
range: 177
"ctype.c", line 56: warning: initializer does not fit or is out of
range: 178
"ctype.c", line 56: warning: initializer does not fit or is out of
range: 179
"ctype.c", line 56: warning: initializer does not fit or is out of
range: 180
"ctype.c", line 56: warning: initializer does not fit or is out of
range: 181
"ctype.c", line 56: warning: initializer does not fit or is out of
range: 182
"ctype.c", line 56: warning: initializer does not fit or is out of
range: 183
"ctype.c", line 57: warning: initializer does not fit or is out of
range: 184
"ctype.c", line 57: warning: initializer does not fit or is out of
range: 185
"ctype.c", line 57: warning: initializer does not fit or is out of
range: 186
"ctype.c", line 57: warning: initializer does not fit or is out of
range: 187
"ctype.c", line 57: warning: initializer does not fit or is out of
range: 188
"ctype.c", line 57: warning: initializer does not fit or is out of
range: 189
"ctype.c", line 57: warning: initializer does not fit or is out of
range: 190
"ctype.c", line 57: warning: initializer does not fit or is out of
range: 191
"ctype.c", line 58: warning: initializer does not fit or is out of
range: 192
"ctype.c", line 58: warning: initializer does not fit or is out of
range: 193
"ctype.c", line 58: warning: initializer does not fit or is out of
range: 194
"ctype.c", line 58: warning: initializer does not fit or is out of
range: 195
"ctype.c", line 58: warning: initializer does not fit or is out of
range: 196
"ctype.c", line 58: warning: initializer does not fit or is out of
range: 197
"ctype.c", line 58: warning: initializer does not fit or is out of
range: 198
"ctype.c", line 58: warning: initializer does not fit or is out of
range: 199
"ctype.c", line 59: warning: initializer does not fit or is out of
range: 200
"ctype.c", line 59: warning: initializer does not fit or is out of
range: 201
"ctype.c", line 59: warning: initializer does not fit or is out of
range: 202
"ctype.c", line 59: warning: initializer does not fit or is out of
range: 203
"ctype.c", line 59: warning: initializer does not fit or is out of
range: 204
"ctype.c", line 59: warning: initializer does not fit or is out of
range: 205
"ctype.c", line 59: warning: initializer does not fit or is out of
range: 206
"ctype.c", line 59: warning: initializer does not fit or is out of
range: 207
"ctype.c", line 60: warning: initializer does not fit or is out of
range: 208
"ctype.c", line 60: warning: initializer does not fit or is out of
range: 209
"ctype.c", line 60: warning: initializer does not fit or is out of
range: 210
"ctype.c", line 60: warning: initializer does not fit or is out of
range: 211
"ctype.c", line 60: warning: initializer does not fit or is out of
range: 212
"ctype.c", line 60: warning: initializer does not fit or is out of
range: 213
"ctype.c", line 60: warning: initializer does not fit or is out of
range: 214
"ctype.c", line 60: warning: initializer does not fit or is out of
range: 215
"ctype.c", line 61: warning: initializer does not fit or is out of
range: 216
"ctype.c", line 61: warning: initializer does not fit or is out of
range: 217
"ctype.c", line 61: warning: initializer does not fit or is out of
range: 218
"ctype.c", line 61: warning: initializer does not fit or is out of
range: 219
"ctype.c", line 61: warning: initializer does not fit or is out of
range: 220
"ctype.c", line 61: warning: initializer does not fit or is out of
range: 221
"ctype.c", line 61: warning: initializer does not fit or is out of
range: 222
"ctype.c", line 61: warning: initializer does not fit or is out of
range: 223
"ctype.c", line 62: warning: initializer does not fit or is out of
range: 224
"ctype.c", line 62: warning: initializer does not fit or is out of
range: 225
"ctype.c", line 62: warning: initializer does not fit or is out of
range: 226
"ctype.c", line 62: warning: initializer does not fit or is out of
range: 227
"ctype.c", line 62: warning: initializer does not fit or is out of
range: 228
"ctype.c", line 62: warning: initializer does not fit or is out of
range: 229
"ctype.c", line 62: warning: initializer does not fit or is out of
range: 230
"ctype.c", line 62: warning: initializer does not fit or is out of
range: 231
"ctype.c", line 63: warning: initializer does not fit or is out of
range: 232
"ctype.c", line 63: warning: initializer does not fit or is out of
range: 233
"ctype.c", line 63: warning: initializer does not fit or is out of
range: 234
"ctype.c", line 63: warning: initializer does not fit or is out of
range: 235
"ctype.c", line 63: warning: initializer does not fit or is out of
range: 236
"ctype.c", line 63: warning: initializer does not fit or is out of
range: 237
"ctype.c", line 63: warning: initializer does not fit or is out of
range: 238
"ctype.c", line 63: warning: initializer does not fit or is out of
range: 239
"ctype.c", line 64: warning: initializer does not fit or is out of
range: 240
"ctype.c", line 64: warning: initializer does not fit or is out of
range: 241
"ctype.c", line 64: warning: initializer does not fit or is out of
range: 242
"ctype.c", line 64: warning: initializer does not fit or is out of
range: 243
"ctype.c", line 64: warning: initializer does not fit or is out of
range: 244
"ctype.c", line 64: warning: initializer does not fit or is out of
range: 245
"ctype.c", line 64: warning: initializer does not fit or is out of
range: 246
"ctype.c", line 64: warning: initializer does not fit or is out of
range: 247
"ctype.c", line 65: warning: initializer does not fit or is out of
range: 248
"ctype.c", line 65: warning: initializer does not fit or is out of
range: 249
"ctype.c", line 65: warning: initializer does not fit or is out of
range: 250
"ctype.c", line 65: warning: initializer does not fit or is out of
range: 251
"ctype.c", line 65: warning: initializer does not fit or is out of
range: 252
"ctype.c", line 65: warning: initializer does not fit or is out of
range: 253
"ctype.c", line 65: warning: initializer does not fit or is out of
range: 254
"ctype.c", line 65: warning: initializer does not fit or is out of
range: 255
    CC date.o
    CC decorate.o
    CC diffcore-break.o
    CC diffcore-delta.o
    CC diffcore-order.o
    CC diffcore-pickaxe.o
    CC diffcore-rename.o
    CC diff-delta.o
    CC diff-lib.o
    CC diff-no-index.o
    CC diff.o
    CC dir.o
    CC editor.o
    CC entry.o
    CC environment.o
    CC ewah/bitmap.o
    CC ewah/ewah_bitmap.o
    CC ewah/ewah_io.o
    CC ewah/ewah_rlw.o
    CC exec_cmd.o
    CC fetch-pack.o
    CC fsck.o
    CC gettext.o
    CC gpg-interface.o
    CC graph.o
    CC grep.o
    CC hashmap.o
    GEN common-cmds.h
    CC help.o
    CC hex.o
    CC ident.o
    CC kwset.o
    CC levenshtein.o
    CC line-log.o
    CC line-range.o
    CC list-objects.o
    CC ll-merge.o
    CC lockfile.o
    CC log-tree.o
    CC mailmap.o
    CC match-trees.o
    CC merge.o
    CC merge-blobs.o
    CC merge-recursive.o
    CC mergesort.o
    CC name-hash.o
    CC notes.o
    CC notes-cache.o
    CC notes-merge.o
    CC notes-utils.o
    CC object.o
    CC pack-bitmap.o
    CC pack-bitmap-write.o
    CC pack-check.o
    CC pack-objects.o
    CC pack-revindex.o
    CC pack-write.o
    CC pager.o
    CC parse-options.o
    CC parse-options-cb.o
    CC patch-delta.o
    CC patch-ids.o
    CC path.o
    CC pathspec.o
    CC pkt-line.o
    CC preload-index.o
    CC pretty.o
    CC prio-queue.o
    CC progress.o
    CC prompt.o
    CC quote.o
    CC reachable.o
    CC read-cache.o
"read-cache.c", line 799: warning: statement not reached
    CC reflog-walk.o
    CC refs.o
    CC remote.o
    CC replace_object.o
    CC rerere.o
    CC resolve-undo.o
    CC revision.o
    CC run-command.o
    CC send-pack.o
    CC sequencer.o
    CC server-info.o
    CC setup.o
    CC sha1-array.o
    CC sha1-lookup.o
    CC sha1_file.o
    CC sha1_name.o
    CC shallow.o
    CC sideband.o
    CC sigchain.o
    CC split-index.o
    CC strbuf.o
    CC streaming.o
    CC string-list.o
    CC submodule.o
    CC symlinks.o
    CC tag.o
    CC trace.o
"trace.c", line 219: error: identifier redeclared: trace_strbuf
        current : function(pointer to const char, pointer to const
struct strbuf {unsigned long alloc, unsigned long len, pointer to char
buf}) returning void
        previous: function(pointer to struct trace_key {const pointer to
const char key, int fd, unsigned int initialized :1, unsigned int
need_close :1}, pointer to const struct strbuf {unsigned long alloc,
unsigned long len, pointer to char buf}) returning void : "trace.h",
line 33
"trace.c", line 221: warning: argument 0000003 is incompatible with
prototype:
        prototype: pointer to struct trace_key {const pointer to const
char key, int fd, unsigned int initialized :1, unsigned int need_close
:1} : "trace.c", line 160
        argument : pointer to const char
"trace.c", line 390: error: reference to static identifier "offset" in
extern inline function
"trace.c", line 392: error: reference to static identifier "offset" in
extern inline function
"trace.c", line 393: error: reference to static identifier "offset" in
extern inline function
"trace.c", line 401: error: reference to static identifier "offset" in
extern inline function
"trace.c", line 403: error: reference to static identifier "offset" in
extern inline function
cc: acomp failed for trace.c
gmake: *** [trace.o] Error 2




Solaris 10 with Oracle Studio 12.3 compiler tools. A lengthy maillist
discussion last week sorted out the previous release of git just
fine however this release fails to build.
