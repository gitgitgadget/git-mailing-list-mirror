From: Arnaud Bailly <abailly@oqube.com>
Subject: Re: Problem adding a symlinkg
Date: Sat, 20 Feb 2010 10:55:29 +0100
Organization: OQube
Message-ID: <854olcqlim.fsf@oqube.com>
References: <1265869060330-4553010.post@n2.nabble.com>
	<81b0412b1002110401mc77bd68w28034ca0e7fc537@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 11:02:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NimAL-0001Lw-2p
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 11:02:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543Ab0BTKCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 05:02:18 -0500
Received: from ks361723.kimsufi.com ([91.121.169.171]:51851 "EHLO
	public.oqube.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751917Ab0BTKCR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 05:02:17 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Feb 2010 05:02:17 EST
Received: by public.oqube.net (Postfix, from userid 1001)
	id CCFD91A44423; Sat, 20 Feb 2010 10:02:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on public.oqube.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	FH_DATE_PAST_20XX autolearn=no version=3.2.5
Received: from marie (unknown [80.125.173.55])
	by public.oqube.net (Postfix) with ESMTPSA id 074581A4441B;
	Sat, 20 Feb 2010 10:02:00 +0000 (UTC)
Received: from marie (localhost [127.0.0.1])
	by marie (Postfix) with ESMTP id B679F3861BD;
	Sat, 20 Feb 2010 10:55:30 +0100 (CET)
In-Reply-To: <81b0412b1002110401mc77bd68w28034ca0e7fc537@mail.gmail.com> (Alex
	Riesen's message of "Thu, 11 Feb 2010 13:01:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140523>


Hello,
My apologies for the very late reply. Here is the strace dump:

open("pb-util/protoc/Linux-x86-2.6.28/lib/", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|O_CLOEXEC) = 4
fstat64(4, {st_mode=S_IFDIR|0700, st_size=4096, ...}) = 0
fcntl64(4, F_GETFD)                     = 0x1 (flags FD_CLOEXEC)
getdents64(4, /* 24 entries */, 4096)   = 928
open(".gitignore", O_RDONLY|O_LARGEFILE) = 5
fstat64(5, {st_mode=S_IFREG|0700, st_size=237, ...}) = 0
read(5, "auto\r\n*.log\r\n*.class\r\n*~\r\n*.exe\r\n"..., 237) = 237
close(5)                                = 0
open(".gitignore", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("pb-util/.gitignore", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("pb-util/protoc/.gitignore", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("pb-util/protoc/Linux-x86-2.6.28/.gitignore", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("pb-util/protoc/Linux-x86-2.6.28/lib/.gitignore", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
lstat64("pb-util/protoc/Linux-x86-2.6.28/lib/libprotobuf-lite.so", {st_mode=S_IFLNK|0700, st_size=58, ...}) = 0
lstat64("pb-util/protoc/Linux-x86-2.6.28/lib/libprotobuf-lite.so.5", {st_mode=S_IFLNK|0700, st_size=58, ...}) = 0
lstat64("pb-util/protoc/Linux-x86-2.6.28/lib/libprotobuf-lite.so.6", {st_mode=S_IFLNK|0700, st_size=58, ...}) = 0
getdents64(4, /* 0 entries */, 4096)    = 0
close(4)                                = 0
open(".git/index", O_RDONLY|O_LARGEFILE) = 4
fstat64(4, {st_mode=S_IFREG|0700, st_size=283832, ...}) = 0
mmap2(NULL, 283832, PROT_READ|PROT_WRITE, MAP_PRIVATE, 4, 0) = 0xb7b3a000
close(4)                                = 0
mmap2(NULL, 286720, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7af4000
munmap(0xb7b3a000, 283832)              = 0
lstat64("pb-util/protoc/Linux-x86-2.6.28/lib/libprotobuf-lite.so", {st_mode=S_IFLNK|0700, st_size=58, ...}) = 0
readlink("pb-util/protoc/Linux-x86-2.6.28/lib/libprotobuf-lite.so", "libprotobuf-lite.so.5.0.0"..., 59) = 25
write(2, "error: readlink(\"pb-ut"..., 104error: readlink("pb-util/protoc/Linux-x86-2.6.28/lib/libprotobuf-lite.so"): Invalid argument
) = 104
write(2, "error: unable to index file pb-util"..., 95error: unable to index file pb-util/protoc/Linux-x86-2.6.28/lib/libprotobuf-lite.so
) = 95
write(2, "fatal: adding files failed\n"..., 27fatal: adding files failed
) = 27
close(3)                                = 0
unlink(".git/index.lock")               = 0
exit_group(128)                         = ?

Note that when I do

$> strace readlink pb-util/protoc/Linux-x86-2.6.28/lib/libprotobuf-lite.so

I got

readlink("pb-util/protoc/Linux-x86-2.6.28/lib/libprotobuf-lite.so", "libprotobuf-lite.so.5.0.0"..., 64) = 25
fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 1), ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7c6d000
write(1, "libprotobuf-lite.so.5.0.0\n"..., 26libprotobuf-lite.so.5.0.0
) = 26
close(1)                                = 0
munmap(0xb7c6d000, 4096)                = 0
close(2)                                = 0
exit_group(0)                           = ?

Any clue?

Thanks for your time,
-- 
Arnaud Bailly -- OQube
<software engineering>
http://www.oqube.com/
