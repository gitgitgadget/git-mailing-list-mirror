From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Stgit and refresh-temp
Date: Tue, 4 Nov 2008 08:37:24 -0500
Message-ID: <9e4733910811040537p4e88c09an94370154eca12778@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	"Catalin Marinas" <catalin.marinas@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 04 14:38:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxM7F-0001Mo-QA
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 14:38:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017AbYKDNh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 08:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbYKDNh0
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 08:37:26 -0500
Received: from rv-out-0506.google.com ([209.85.198.238]:56349 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987AbYKDNhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 08:37:25 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3278299rvb.1
        for <git@vger.kernel.org>; Tue, 04 Nov 2008 05:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=HKjRyBhP4yVKodpZiOivjiZAIk0AhRTq2a82MCr+1h4=;
        b=XVXBCfjXFdEp3s32WkldAOazSLJcj2eGyyUt2+n4XX3Py1Nwc4gYsk4ZGvFn7aRFfo
         hAb/YpNLX0L9RnLMV5GTxIyI36b7IFI/TMucGZ/rFHoX3IuhHzYV6pYLmF2YrlRcX0FB
         rKAOHcpUIClhnI7WifGOtRehbjfXMPtcAWKXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=bshgtJhcLuw4ARg8B47oYhhcsD9UTnV8dAHyO0NxLpQ1Eyh+3a2nWIsstItWZpn3/n
         HY3c96VcDZa9fomOd5e+eeoS9Ay6ZNjMoNQ8IlQRGTCiQYhJF/MAOQGOuokcKaBzaqAG
         JQq7RjcRPae5SNxASQdUu+0hCmypdP9l06HPE=
Received: by 10.140.125.1 with SMTP id x1mr845092rvc.287.1225805844900;
        Tue, 04 Nov 2008 05:37:24 -0800 (PST)
Received: by 10.140.208.10 with HTTP; Tue, 4 Nov 2008 05:37:24 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100077>

I hit a case when refreshing a buried patch that needed a merge
conflict sorted out.
I'm unable to recover out of the state.

jonsmirl@terra:~/fs$ stg status
A drivers/input/ir/ir-configfs.c
A drivers/input/ir/ir-core.c
A drivers/input/ir/ir.h
C drivers/input/ir/Makefile
D drivers/input/ir-configfs.c
D drivers/input/ir-core.c
D drivers/input/ir.h
M drivers/input/Makefile
M drivers/input/input.c
jonsmirl@terra:~/fs$ gedit drivers/input/Makefile drivers/input/input.c
jonsmirl@terra:~/fs$ gedit drivers/input/ir/Makefile
jonsmirl@terra:~/fs$ stg resolve drivers/input/ir/Makefile
jonsmirl@terra:~/fs$ stg help
usage: stg <command> [options]

Generic commands:
  help        print the detailed command usage
  version     display version information
  copyright   display copyright information

Repository commands:
  clone     Make a local clone of a remote repository
  id        Print the git hash value of a StGit reference

Stack (branch) commands:
  branch    Branch operations: switch, list, create, rename, delete, ...
  clean     Delete the empty patches in the series
  coalesce  Coalesce two or more patches into one
  commit    Permanently store the applied patches into the stack base
  float     Push patches to the top, even if applied
  goto      Push or pop patches to the given one
  hide      Hide a patch in the series
  init      Initialise the current branch for use with StGIT
  log       Display the patch changelog
  patches   Show the applied patches modifying a file
  pop       Pop one or more patches from the stack
  pull      Pull changes from a remote repository
  push      Push one or more patches onto the stack
  rebase    Move the stack base to another point in history
  redo      Undo the last undo operation
  repair    Fix StGit metadata if branch was modified with git commands
  reset     Reset the patch stack to an earlier state
  series    Print the patch series
  sink      Send patches deeper down the stack
  top       Print the name of the top patch
  uncommit  Turn regular git commits into StGit patches
  undo      Undo the last operation
  unhide    Unhide a hidden patch

Patch commands:
  delete    Delete patches
  edit      edit a patch description or diff
  export    Export patches to a directory
  files     Show the files modified by a patch (or the current patch)
  fold      Integrate a GNU diff patch into the current patch
  import    Import a GNU diff file as a new patch
  mail      Send a patch or series of patches by e-mail
  new       Create a new, empty patch
  pick      Import a patch from a different branch or a commit object
  refresh   Generate a new commit for the current patch
  rename    Rename a patch
  show      Show the commit corresponding to a patch
  sync      Synchronise patches with a branch or a series

Index/worktree commands:
  diff      Show the tree diff
  resolved  Mark a file conflict as solved
  status    Show the tree status
jonsmirl@terra:~/fs$ stg help coalesce
jonsmirl@terra:~/fs$ stg series
+ Makefile
+ anton_1
+ anton_3
+ add-of_find_i2c_device_by_node
+ jds_platform
+ max9485
+ jds-soc-machine
+ jds-psc-c
+ soc-u32-cleanup
+ jds-audio
+ g_spi_4
+ m_1
+ spi-mmc
+ mpc5200-rtc
+ lirc
+ jds-lirc
> refresh-temp
- jds-lirc-gpt
- jds-lirc-device-tree
- jds-lirc-mce2
jonsmirl@terra:~/fs$ ls
arch     Documentation  init    MAINTAINERS     net
samples     usr             vmlinux.strip.gz
block    drivers        ipc     Makefile        patches-master  scripts     virt
COPYING  firmware       Kbuild  mm              patches-save
security    vmlinux
CREDITS  fs             kernel  modules.order   README          sound
     vmlinux.bin.gz
crypto   include        lib     Module.symvers  REPORTING-BUGS
System.map  vmlinux.o
jonsmirl@terra:~/fs$ mv patches-master patches-foo
jonsmirl@terra:~/fs$ stg export
Checking for changes in the working directory ... done
Warning: Local changes in the tree; you might want to commit them first
jonsmirl@terra:~/fs$ stg status
A drivers/input/ir/ir-configfs.c
A drivers/input/ir/ir-core.c
A drivers/input/ir/ir.h
D drivers/input/ir-configfs.c
D drivers/input/ir-core.c
D drivers/input/ir.h
M drivers/input/Makefile
M drivers/input/input.c
M drivers/input/ir/Makefile
jonsmirl@terra:~/fs$ ls patches-master
add-of_find_i2c_device_by_node  g_spi_4    jds_platform     lirc
max9485       series
anton_1                         jds-audio  jds-psc-c        m_1
mpc5200-rtc   soc-u32-cleanup
anton_3                         jds-lirc   jds-soc-machine  Makefile
refresh-temp  spi-mmc
jonsmirl@terra:~/fs$ vi patches-master/refresh-temp
jonsmirl@terra:~/fs$ stg series
+ Makefile
+ anton_1
+ anton_3
+ add-of_find_i2c_device_by_node
+ jds_platform
+ max9485
+ jds-soc-machine
+ jds-psc-c
+ soc-u32-cleanup
+ jds-audio
+ g_spi_4
+ m_1
+ spi-mmc
+ mpc5200-rtc
+ lirc
+ jds-lirc
> refresh-temp
- jds-lirc-gpt
- jds-lirc-device-tree
- jds-lirc-mce2
jonsmirl@terra:~/fs$ stg refresh -p jds-lirc
Error: HEAD and top are not the same.
       This can happen if you modify a branch with git.
       "stg repair --help" explains more about what to do next.
stg refresh: Command aborted (all changes rolled back)
jonsmirl@terra:~/fs$ stg refresh
Error: HEAD and top are not the same.
       This can happen if you modify a branch with git.
       "stg repair --help" explains more about what to do next.
stg refresh: Command aborted (all changes rolled back)
jonsmirl@terra:~/fs$ stg new foo
Invoking the editor: "vi .stgit-new.txt" ... done
Error: HEAD and top are not the same.
       This can happen if you modify a branch with git.
       "stg repair --help" explains more about what to do next.
stg new: Command aborted (all changes rolled back)
jonsmirl@terra:~/fs$ stg new foo
Invoking the editor: "vi .stgit-new.txt" ... done
Error: HEAD and top are not the same.
       This can happen if you modify a branch with git.
       "stg repair --help" explains more about what to do next.
stg new: Command aborted (all changes rolled back)
jonsmirl@terra:~/fs$ stg repair --help
Usage: stg repair

Fix StGit metadata if branch was modified with git commands

Options:
  -h, --help  show this help message and exit
jonsmirl@terra:~/fs$




-- 
Jon Smirl
jonsmirl@gmail.com
