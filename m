Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA72121841
	for <e@80x24.org>; Mon, 30 Apr 2018 09:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751527AbeD3JvE (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 05:51:04 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:55363 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbeD3JvB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 05:51:01 -0400
Received: by mail-wm0-f51.google.com with SMTP id a8so12094568wmg.5
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 02:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j/g6fdI7maeRXxYcG0btqnqo69d7fWcFYmurNpwVOVw=;
        b=l86QjlB8lRF/ZzFdq6hbmHgDalIl36NsMGQVwWYvOOM61n8s6f3zEfwnThd8MRIyYk
         +4JgdqVmzxPvCEEiK9CJNixBuh5HvjnUnay2dsaxUJ8p09ZsfJE8Tq4LSkHCl7yvkfIN
         9iHVBu+zGhSAbBq/rVK2M0ax40ZMLkEtrXIJ3tnCcAA23AjRK9yUoevq5tjRhqcBSItU
         kZ64HvQi8yO071BA4pMjOsk8SQThCtp6j8hAaWgX4d68Gj/DNlluG4ceroqm/N2n/p6T
         d5jV5r/ggwZ+wuDYNnWEsG/WNwf95HypndPIFd7d3pS3tM4QvEWIqbQ5JG5JWBgNwHvs
         Aq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j/g6fdI7maeRXxYcG0btqnqo69d7fWcFYmurNpwVOVw=;
        b=QSJIW+ajaDlrNhnYz3jrto/kabYoZHHOEq1sxa7tstYi6oFU1k8pHj7MrS+SHIR7nz
         q28Yta+A1XMudruOpMiNHHQ30fmX1od+8k0t+/9I0W8D3q2i1sXtF82e/PJE57h8nZCE
         yBxibdR/vTP58e+RC6pnBAE1QMPTObIM36fYKc0fTiK96eFFMRuIM/Zn+AZcCuAyQ21W
         aqizaXmqHzgsy/UEGoiMo3CJptjA8NMRcMQzr1zm5DeQrIYJK/yYEF4jIATtai/QTH4Y
         Rpw9yEg2309crlz+hCgO6FRJTqb8+LuPzg0TZHr20uaD6KIpsc7kTQfk6vyZx1vLGpxt
         cyGQ==
X-Gm-Message-State: ALQs6tBDYM5+152afO3II+mXoyVcYksHFHIzhFz2Ya1hbd7xETCaBH2S
        rQX6detSKVMCmgTHBPv+nMSEmbp3
X-Google-Smtp-Source: AB8JxZpTIGl+y0oI/mv4+Y/LAV2Cjbbfn9AqBC2rfrI5tBc3EZa0MxaAZy3nDbkiqnSBpm3l4bRZ5Q==
X-Received: by 10.28.51.6 with SMTP id z6mr6806029wmz.63.1525081859128;
        Mon, 30 Apr 2018 02:50:59 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 42-v6sm13178687wrx.24.2018.04.30.02.50.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Apr 2018 02:50:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Avery Pennarun <apenwarr@gmail.com>, Jeff King <peff@peff.net>,
        Stephen R Guglielmo <srguglielmo@gmail.com>,
        "A . Wilcox" <AWilcox@Wilcox-Tech.com>,
        David Aguilar <davvid@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/4] git-subtree: move from contrib/subtree/
Date:   Mon, 30 Apr 2018 09:50:41 +0000
Message-Id: <20180430095044.28492-2-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180430095044.28492-1-avarab@gmail.com>
References: <20180430095044.28492-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the git-subtree command from living in contrib to being a
"real" git command.

I think it's useful enough that it should be shipped by default, and
unlike git-submodule doesn't need any changes to git's object
format. It's just a helper to do things you can do manually already
with plumbing tools (but that would be much more tedious).

It'll also help to avoid the confusion noted in
https://public-inbox.org/git/alpine.LFD.2.21.1802070547040.5530@android-a172fe96dd584b41/
where users know git-subtree exists, but can't find its
documentation (or it isn't installed).

This change removes config/subtree's copy of COPYING because it's
redundant to the one in the root of the tree. The contrib/subtree/todo
file is being removed because we don't usually store TODOs
in-tree (and this'll be available in the history), the rest like the
.gitignore, Makefile etc. are all redundant to things we have in-tree.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .gitignore                                    |   1 +
 Documentation/git-submodule.txt               |   2 +-
 .../subtree => Documentation}/git-subtree.txt |   3 +
 Makefile                                      |   1 +
 contrib/subtree/.gitignore                    |   7 -
 contrib/subtree/COPYING                       | 339 ------------------
 contrib/subtree/INSTALL                       |  28 --
 contrib/subtree/Makefile                      |  97 -----
 contrib/subtree/README                        |   8 -
 contrib/subtree/t/Makefile                    |  86 -----
 contrib/subtree/todo                          |  48 ---
 .../subtree/git-subtree.sh => git-subtree.sh  |   0
 {contrib/subtree/t => t}/t7900-subtree.sh     |   5 +-
 13 files changed, 7 insertions(+), 618 deletions(-)
 rename {contrib/subtree => Documentation}/git-subtree.txt (99%)
 delete mode 100644 contrib/subtree/.gitignore
 delete mode 100644 contrib/subtree/COPYING
 delete mode 100644 contrib/subtree/INSTALL
 delete mode 100644 contrib/subtree/Makefile
 delete mode 100644 contrib/subtree/README
 delete mode 100644 contrib/subtree/t/Makefile
 delete mode 100644 contrib/subtree/todo
 rename contrib/subtree/git-subtree.sh => git-subtree.sh (100%)
 rename {contrib/subtree/t => t}/t7900-subtree.sh (99%)

diff --git a/.gitignore b/.gitignore
index 833ef3b0b7..b78a5b6e0a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -155,6 +155,7 @@
 /git-status
 /git-stripspace
 /git-submodule
+/git-subtree
 /git-submodule--helper
 /git-svn
 /git-symbolic-ref
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 71c5618e82..ba718d2c9b 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -402,7 +402,7 @@ for details.
 
 SEE ALSO
 --------
-linkgit:gitsubmodules[7], linkgit:gitmodules[5].
+linkgit:gitsubmodules[7], linkgit:gitmodules[5], linkgit:git-subtree[1].
 
 GIT
 ---
diff --git a/contrib/subtree/git-subtree.txt b/Documentation/git-subtree.txt
similarity index 99%
rename from contrib/subtree/git-subtree.txt
rename to Documentation/git-subtree.txt
index 352deda69d..f206a32c8f 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/Documentation/git-subtree.txt
@@ -345,6 +345,9 @@ AUTHOR
 ------
 Written by Avery Pennarun <apenwarr@gmail.com>
 
+SEE ALSO
+--------
+linkgit:git-submodule[1].
 
 GIT
 ---
diff --git a/Makefile b/Makefile
index 50da82b016..82cdac3aa2 100644
--- a/Makefile
+++ b/Makefile
@@ -576,6 +576,7 @@ SCRIPT_SH += git-remote-testgit.sh
 SCRIPT_SH += git-request-pull.sh
 SCRIPT_SH += git-stash.sh
 SCRIPT_SH += git-submodule.sh
+SCRIPT_SH += git-subtree.sh
 SCRIPT_SH += git-web--browse.sh
 
 SCRIPT_LIB += git-mergetool--lib
diff --git a/contrib/subtree/.gitignore b/contrib/subtree/.gitignore
deleted file mode 100644
index 0b9381abca..0000000000
--- a/contrib/subtree/.gitignore
+++ /dev/null
@@ -1,7 +0,0 @@
-*~
-git-subtree
-git-subtree.1
-git-subtree.html
-git-subtree.xml
-mainline
-subproj
diff --git a/contrib/subtree/COPYING b/contrib/subtree/COPYING
deleted file mode 100644
index d511905c16..0000000000
--- a/contrib/subtree/COPYING
+++ /dev/null
@@ -1,339 +0,0 @@
-		    GNU GENERAL PUBLIC LICENSE
-		       Version 2, June 1991
-
- Copyright (C) 1989, 1991 Free Software Foundation, Inc.,
- 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- Everyone is permitted to copy and distribute verbatim copies
- of this license document, but changing it is not allowed.
-
-			    Preamble
-
-  The licenses for most software are designed to take away your
-freedom to share and change it.  By contrast, the GNU General Public
-License is intended to guarantee your freedom to share and change free
-software--to make sure the software is free for all its users.  This
-General Public License applies to most of the Free Software
-Foundation's software and to any other program whose authors commit to
-using it.  (Some other Free Software Foundation software is covered by
-the GNU Lesser General Public License instead.)  You can apply it to
-your programs, too.
-
-  When we speak of free software, we are referring to freedom, not
-price.  Our General Public Licenses are designed to make sure that you
-have the freedom to distribute copies of free software (and charge for
-this service if you wish), that you receive source code or can get it
-if you want it, that you can change the software or use pieces of it
-in new free programs; and that you know you can do these things.
-
-  To protect your rights, we need to make restrictions that forbid
-anyone to deny you these rights or to ask you to surrender the rights.
-These restrictions translate to certain responsibilities for you if you
-distribute copies of the software, or if you modify it.
-
-  For example, if you distribute copies of such a program, whether
-gratis or for a fee, you must give the recipients all the rights that
-you have.  You must make sure that they, too, receive or can get the
-source code.  And you must show them these terms so they know their
-rights.
-
-  We protect your rights with two steps: (1) copyright the software, and
-(2) offer you this license which gives you legal permission to copy,
-distribute and/or modify the software.
-
-  Also, for each author's protection and ours, we want to make certain
-that everyone understands that there is no warranty for this free
-software.  If the software is modified by someone else and passed on, we
-want its recipients to know that what they have is not the original, so
-that any problems introduced by others will not reflect on the original
-authors' reputations.
-
-  Finally, any free program is threatened constantly by software
-patents.  We wish to avoid the danger that redistributors of a free
-program will individually obtain patent licenses, in effect making the
-program proprietary.  To prevent this, we have made it clear that any
-patent must be licensed for everyone's free use or not licensed at all.
-
-  The precise terms and conditions for copying, distribution and
-modification follow.
-
-		    GNU GENERAL PUBLIC LICENSE
-   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
-
-  0. This License applies to any program or other work which contains
-a notice placed by the copyright holder saying it may be distributed
-under the terms of this General Public License.  The "Program", below,
-refers to any such program or work, and a "work based on the Program"
-means either the Program or any derivative work under copyright law:
-that is to say, a work containing the Program or a portion of it,
-either verbatim or with modifications and/or translated into another
-language.  (Hereinafter, translation is included without limitation in
-the term "modification".)  Each licensee is addressed as "you".
-
-Activities other than copying, distribution and modification are not
-covered by this License; they are outside its scope.  The act of
-running the Program is not restricted, and the output from the Program
-is covered only if its contents constitute a work based on the
-Program (independent of having been made by running the Program).
-Whether that is true depends on what the Program does.
-
-  1. You may copy and distribute verbatim copies of the Program's
-source code as you receive it, in any medium, provided that you
-conspicuously and appropriately publish on each copy an appropriate
-copyright notice and disclaimer of warranty; keep intact all the
-notices that refer to this License and to the absence of any warranty;
-and give any other recipients of the Program a copy of this License
-along with the Program.
-
-You may charge a fee for the physical act of transferring a copy, and
-you may at your option offer warranty protection in exchange for a fee.
-
-  2. You may modify your copy or copies of the Program or any portion
-of it, thus forming a work based on the Program, and copy and
-distribute such modifications or work under the terms of Section 1
-above, provided that you also meet all of these conditions:
-
-    a) You must cause the modified files to carry prominent notices
-    stating that you changed the files and the date of any change.
-
-    b) You must cause any work that you distribute or publish, that in
-    whole or in part contains or is derived from the Program or any
-    part thereof, to be licensed as a whole at no charge to all third
-    parties under the terms of this License.
-
-    c) If the modified program normally reads commands interactively
-    when run, you must cause it, when started running for such
-    interactive use in the most ordinary way, to print or display an
-    announcement including an appropriate copyright notice and a
-    notice that there is no warranty (or else, saying that you provide
-    a warranty) and that users may redistribute the program under
-    these conditions, and telling the user how to view a copy of this
-    License.  (Exception: if the Program itself is interactive but
-    does not normally print such an announcement, your work based on
-    the Program is not required to print an announcement.)
-
-These requirements apply to the modified work as a whole.  If
-identifiable sections of that work are not derived from the Program,
-and can be reasonably considered independent and separate works in
-themselves, then this License, and its terms, do not apply to those
-sections when you distribute them as separate works.  But when you
-distribute the same sections as part of a whole which is a work based
-on the Program, the distribution of the whole must be on the terms of
-this License, whose permissions for other licensees extend to the
-entire whole, and thus to each and every part regardless of who wrote it.
-
-Thus, it is not the intent of this section to claim rights or contest
-your rights to work written entirely by you; rather, the intent is to
-exercise the right to control the distribution of derivative or
-collective works based on the Program.
-
-In addition, mere aggregation of another work not based on the Program
-with the Program (or with a work based on the Program) on a volume of
-a storage or distribution medium does not bring the other work under
-the scope of this License.
-
-  3. You may copy and distribute the Program (or a work based on it,
-under Section 2) in object code or executable form under the terms of
-Sections 1 and 2 above provided that you also do one of the following:
-
-    a) Accompany it with the complete corresponding machine-readable
-    source code, which must be distributed under the terms of Sections
-    1 and 2 above on a medium customarily used for software interchange; or,
-
-    b) Accompany it with a written offer, valid for at least three
-    years, to give any third party, for a charge no more than your
-    cost of physically performing source distribution, a complete
-    machine-readable copy of the corresponding source code, to be
-    distributed under the terms of Sections 1 and 2 above on a medium
-    customarily used for software interchange; or,
-
-    c) Accompany it with the information you received as to the offer
-    to distribute corresponding source code.  (This alternative is
-    allowed only for noncommercial distribution and only if you
-    received the program in object code or executable form with such
-    an offer, in accord with Subsection b above.)
-
-The source code for a work means the preferred form of the work for
-making modifications to it.  For an executable work, complete source
-code means all the source code for all modules it contains, plus any
-associated interface definition files, plus the scripts used to
-control compilation and installation of the executable.  However, as a
-special exception, the source code distributed need not include
-anything that is normally distributed (in either source or binary
-form) with the major components (compiler, kernel, and so on) of the
-operating system on which the executable runs, unless that component
-itself accompanies the executable.
-
-If distribution of executable or object code is made by offering
-access to copy from a designated place, then offering equivalent
-access to copy the source code from the same place counts as
-distribution of the source code, even though third parties are not
-compelled to copy the source along with the object code.
-
-  4. You may not copy, modify, sublicense, or distribute the Program
-except as expressly provided under this License.  Any attempt
-otherwise to copy, modify, sublicense or distribute the Program is
-void, and will automatically terminate your rights under this License.
-However, parties who have received copies, or rights, from you under
-this License will not have their licenses terminated so long as such
-parties remain in full compliance.
-
-  5. You are not required to accept this License, since you have not
-signed it.  However, nothing else grants you permission to modify or
-distribute the Program or its derivative works.  These actions are
-prohibited by law if you do not accept this License.  Therefore, by
-modifying or distributing the Program (or any work based on the
-Program), you indicate your acceptance of this License to do so, and
-all its terms and conditions for copying, distributing or modifying
-the Program or works based on it.
-
-  6. Each time you redistribute the Program (or any work based on the
-Program), the recipient automatically receives a license from the
-original licensor to copy, distribute or modify the Program subject to
-these terms and conditions.  You may not impose any further
-restrictions on the recipients' exercise of the rights granted herein.
-You are not responsible for enforcing compliance by third parties to
-this License.
-
-  7. If, as a consequence of a court judgment or allegation of patent
-infringement or for any other reason (not limited to patent issues),
-conditions are imposed on you (whether by court order, agreement or
-otherwise) that contradict the conditions of this License, they do not
-excuse you from the conditions of this License.  If you cannot
-distribute so as to satisfy simultaneously your obligations under this
-License and any other pertinent obligations, then as a consequence you
-may not distribute the Program at all.  For example, if a patent
-license would not permit royalty-free redistribution of the Program by
-all those who receive copies directly or indirectly through you, then
-the only way you could satisfy both it and this License would be to
-refrain entirely from distribution of the Program.
-
-If any portion of this section is held invalid or unenforceable under
-any particular circumstance, the balance of the section is intended to
-apply and the section as a whole is intended to apply in other
-circumstances.
-
-It is not the purpose of this section to induce you to infringe any
-patents or other property right claims or to contest validity of any
-such claims; this section has the sole purpose of protecting the
-integrity of the free software distribution system, which is
-implemented by public license practices.  Many people have made
-generous contributions to the wide range of software distributed
-through that system in reliance on consistent application of that
-system; it is up to the author/donor to decide if he or she is willing
-to distribute software through any other system and a licensee cannot
-impose that choice.
-
-This section is intended to make thoroughly clear what is believed to
-be a consequence of the rest of this License.
-
-  8. If the distribution and/or use of the Program is restricted in
-certain countries either by patents or by copyrighted interfaces, the
-original copyright holder who places the Program under this License
-may add an explicit geographical distribution limitation excluding
-those countries, so that distribution is permitted only in or among
-countries not thus excluded.  In such case, this License incorporates
-the limitation as if written in the body of this License.
-
-  9. The Free Software Foundation may publish revised and/or new versions
-of the General Public License from time to time.  Such new versions will
-be similar in spirit to the present version, but may differ in detail to
-address new problems or concerns.
-
-Each version is given a distinguishing version number.  If the Program
-specifies a version number of this License which applies to it and "any
-later version", you have the option of following the terms and conditions
-either of that version or of any later version published by the Free
-Software Foundation.  If the Program does not specify a version number of
-this License, you may choose any version ever published by the Free Software
-Foundation.
-
-  10. If you wish to incorporate parts of the Program into other free
-programs whose distribution conditions are different, write to the author
-to ask for permission.  For software which is copyrighted by the Free
-Software Foundation, write to the Free Software Foundation; we sometimes
-make exceptions for this.  Our decision will be guided by the two goals
-of preserving the free status of all derivatives of our free software and
-of promoting the sharing and reuse of software generally.
-
-			    NO WARRANTY
-
-  11. BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
-FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN
-OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
-PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED
-OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
-MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE ENTIRE RISK AS
-TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU.  SHOULD THE
-PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,
-REPAIR OR CORRECTION.
-
-  12. IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
-WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
-REDISTRIBUTE THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES,
-INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING
-OUT OF THE USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED
-TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY
-YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER
-PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
-POSSIBILITY OF SUCH DAMAGES.
-
-		     END OF TERMS AND CONDITIONS
-
-	    How to Apply These Terms to Your New Programs
-
-  If you develop a new program, and you want it to be of the greatest
-possible use to the public, the best way to achieve this is to make it
-free software which everyone can redistribute and change under these terms.
-
-  To do so, attach the following notices to the program.  It is safest
-to attach them to the start of each source file to most effectively
-convey the exclusion of warranty; and each file should have at least
-the "copyright" line and a pointer to where the full notice is found.
-
-    <one line to give the program's name and a brief idea of what it does.>
-    Copyright (C) <year>  <name of author>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License along
-    with this program; if not, write to the Free Software Foundation, Inc.,
-    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-
-Also add information on how to contact you by electronic and paper mail.
-
-If the program is interactive, make it output a short notice like this
-when it starts in an interactive mode:
-
-    Gnomovision version 69, Copyright (C) year name of author
-    Gnomovision comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
-    This is free software, and you are welcome to redistribute it
-    under certain conditions; type `show c' for details.
-
-The hypothetical commands `show w' and `show c' should show the appropriate
-parts of the General Public License.  Of course, the commands you use may
-be called something other than `show w' and `show c'; they could even be
-mouse-clicks or menu items--whatever suits your program.
-
-You should also get your employer (if you work as a programmer) or your
-school, if any, to sign a "copyright disclaimer" for the program, if
-necessary.  Here is a sample; alter the names:
-
-  Yoyodyne, Inc., hereby disclaims all copyright interest in the program
-  `Gnomovision' (which makes passes at compilers) written by James Hacker.
-
-  <signature of Ty Coon>, 1 April 1989
-  Ty Coon, President of Vice
-
-This General Public License does not permit incorporating your program into
-proprietary programs.  If your program is a subroutine library, you may
-consider it more useful to permit linking proprietary applications with the
-library.  If this is what you want to do, use the GNU Lesser General
-Public License instead of this License.
diff --git a/contrib/subtree/INSTALL b/contrib/subtree/INSTALL
deleted file mode 100644
index 7ab0cf4509..0000000000
--- a/contrib/subtree/INSTALL
+++ /dev/null
@@ -1,28 +0,0 @@
-HOW TO INSTALL git-subtree
-==========================
-
-First, build from the top source directory.
-
-Then, in contrib/subtree, run:
-
-  make
-  make install
-  make install-doc
-
-If you used configure to do the main build the git-subtree build will
-pick up those settings.  If not, you will likely have to provide a
-value for prefix:
-
-  make prefix=<some dir>
-  make prefix=<some dir> install
-  make prefix=<some dir> install-doc
-
-To run tests first copy git-subtree to the main build area so the
-newly-built git can find it:
-
-  cp git-subtree ../..
-
-Then:
-
-  make test
-
diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
deleted file mode 100644
index 5c6cc4ab2c..0000000000
--- a/contrib/subtree/Makefile
+++ /dev/null
@@ -1,97 +0,0 @@
-# The default target of this Makefile is...
-all::
-
--include ../../config.mak.autogen
--include ../../config.mak
-
-prefix ?= /usr/local
-gitexecdir ?= $(prefix)/libexec/git-core
-mandir ?= $(prefix)/share/man
-man1dir ?= $(mandir)/man1
-htmldir ?= $(prefix)/share/doc/git-doc
-
-../../GIT-VERSION-FILE: FORCE
-	$(MAKE) -C ../../ GIT-VERSION-FILE
-
--include ../../GIT-VERSION-FILE
-
-# this should be set to a 'standard' bsd-type install program
-INSTALL  ?= install
-RM       ?= rm -f
-
-ASCIIDOC         = asciidoc
-ASCIIDOC_CONF    = -f ../../Documentation/asciidoc.conf
-ASCIIDOC_HTML    = xhtml11
-ASCIIDOC_DOCBOOK = docbook
-ASCIIDOC_EXTRA   =
-XMLTO            = xmlto
-
-ifdef USE_ASCIIDOCTOR
-ASCIIDOC         = asciidoctor
-ASCIIDOC_CONF    =
-ASCIIDOC_HTML    = xhtml5
-ASCIIDOC_DOCBOOK = docbook45
-ASCIIDOC_EXTRA  += -I../../Documentation -rasciidoctor-extensions
-ASCIIDOC_EXTRA  += -alitdd='&\#x2d;&\#x2d;'
-endif
-
-ifndef SHELL_PATH
-	SHELL_PATH = /bin/sh
-endif
-SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
-
-MANPAGE_XSL   = ../../Documentation/manpage-normal.xsl
-
-GIT_SUBTREE_SH := git-subtree.sh
-GIT_SUBTREE    := git-subtree
-
-GIT_SUBTREE_DOC := git-subtree.1
-GIT_SUBTREE_XML := git-subtree.xml
-GIT_SUBTREE_TXT := git-subtree.txt
-GIT_SUBTREE_HTML := git-subtree.html
-GIT_SUBTREE_TEST := ../../git-subtree
-
-all:: $(GIT_SUBTREE)
-
-$(GIT_SUBTREE): $(GIT_SUBTREE_SH)
-	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' $< >$@
-	chmod +x $@
-
-doc: $(GIT_SUBTREE_DOC) $(GIT_SUBTREE_HTML)
-
-install: $(GIT_SUBTREE)
-	$(INSTALL) -d -m 755 $(DESTDIR)$(gitexecdir)
-	$(INSTALL) -m 755 $(GIT_SUBTREE) $(DESTDIR)$(gitexecdir)
-
-install-doc: install-man install-html
-
-install-man: $(GIT_SUBTREE_DOC)
-	$(INSTALL) -d -m 755 $(DESTDIR)$(man1dir)
-	$(INSTALL) -m 644 $^ $(DESTDIR)$(man1dir)
-
-install-html: $(GIT_SUBTREE_HTML)
-	$(INSTALL) -d -m 755 $(DESTDIR)$(htmldir)
-	$(INSTALL) -m 644 $^ $(DESTDIR)$(htmldir)
-
-$(GIT_SUBTREE_DOC): $(GIT_SUBTREE_XML)
-	$(XMLTO) -m $(MANPAGE_XSL) man $^
-
-$(GIT_SUBTREE_XML): $(GIT_SUBTREE_TXT)
-	$(ASCIIDOC) -b $(ASCIIDOC_DOCBOOK) -d manpage $(ASCIIDOC_CONF) \
-		-agit_version=$(GIT_VERSION) $(ASCIIDOC_EXTRA) $^
-
-$(GIT_SUBTREE_HTML): $(GIT_SUBTREE_TXT)
-	$(ASCIIDOC) -b $(ASCIIDOC_HTML) -d manpage $(ASCIIDOC_CONF) \
-		-agit_version=$(GIT_VERSION) $(ASCIIDOC_EXTRA) $^
-
-$(GIT_SUBTREE_TEST): $(GIT_SUBTREE)
-	cp $< $@
-
-test: $(GIT_SUBTREE_TEST)
-	$(MAKE) -C t/ test
-
-clean:
-	$(RM) $(GIT_SUBTREE)
-	$(RM) *.xml *.html *.1
-
-.PHONY: FORCE
diff --git a/contrib/subtree/README b/contrib/subtree/README
deleted file mode 100644
index c686b4a69b..0000000000
--- a/contrib/subtree/README
+++ /dev/null
@@ -1,8 +0,0 @@
-
-Please read git-subtree.txt for documentation.
-
-Please don't contact me using github mail; it's slow, ugly, and worst of
-all, redundant. Email me instead at apenwarr@gmail.com and I'll be happy to
-help.
-
-Avery
diff --git a/contrib/subtree/t/Makefile b/contrib/subtree/t/Makefile
deleted file mode 100644
index 276898eb6b..0000000000
--- a/contrib/subtree/t/Makefile
+++ /dev/null
@@ -1,86 +0,0 @@
-# Run tests
-#
-# Copyright (c) 2005 Junio C Hamano
-#
-
--include ../../../config.mak.autogen
--include ../../../config.mak
-
-#GIT_TEST_OPTS=--verbose --debug
-SHELL_PATH ?= $(SHELL)
-PERL_PATH ?= /usr/bin/perl
-TAR ?= $(TAR)
-RM ?= rm -f
-PROVE ?= prove
-DEFAULT_TEST_TARGET ?= test
-TEST_LINT ?= test-lint
-
-ifdef TEST_OUTPUT_DIRECTORY
-TEST_RESULTS_DIRECTORY = $(TEST_OUTPUT_DIRECTORY)/test-results
-else
-TEST_RESULTS_DIRECTORY = ../../../t/test-results
-endif
-
-# Shell quote;
-SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
-PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
-TEST_RESULTS_DIRECTORY_SQ = $(subst ','\'',$(TEST_RESULTS_DIRECTORY))
-
-T = $(sort $(wildcard t[0-9][0-9][0-9][0-9]-*.sh))
-TSVN = $(sort $(wildcard t91[0-9][0-9]-*.sh))
-TGITWEB = $(sort $(wildcard t95[0-9][0-9]-*.sh))
-THELPERS = $(sort $(filter-out $(T),$(wildcard *.sh)))
-
-all: $(DEFAULT_TEST_TARGET)
-
-test: pre-clean $(TEST_LINT)
-	$(MAKE) aggregate-results-and-cleanup
-
-prove: pre-clean $(TEST_LINT)
-	@echo "*** prove ***"; GIT_CONFIG=.git/config $(PROVE) --exec '$(SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
-	$(MAKE) clean-except-prove-cache
-
-$(T):
-	@echo "*** $@ ***"; GIT_CONFIG=.git/config '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
-
-pre-clean:
-	$(RM) -r '$(TEST_RESULTS_DIRECTORY_SQ)'
-
-clean-except-prove-cache:
-	$(RM) -r 'trash directory'.* '$(TEST_RESULTS_DIRECTORY_SQ)'
-	$(RM) -r valgrind/bin
-
-clean: clean-except-prove-cache
-	$(RM) .prove
-
-test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax
-
-test-lint-duplicates:
-	@dups=`echo $(T) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` && \
-		test -z "$$dups" || { \
-		echo >&2 "duplicate test numbers:" $$dups; exit 1; }
-
-test-lint-executable:
-	@bad=`for i in $(T); do test -x "$$i" || echo $$i; done` && \
-		test -z "$$bad" || { \
-		echo >&2 "non-executable tests:" $$bad; exit 1; }
-
-test-lint-shell-syntax:
-	@'$(PERL_PATH_SQ)' ../../../t/check-non-portable-shell.pl $(T) $(THELPERS)
-
-aggregate-results-and-cleanup: $(T)
-	$(MAKE) aggregate-results
-	$(MAKE) clean
-
-aggregate-results:
-	for f in '$(TEST_RESULTS_DIRECTORY_SQ)'/t*-*.counts; do \
-		echo "$$f"; \
-	done | '$(SHELL_PATH_SQ)' ../../../t/aggregate-results.sh
-
-valgrind:
-	$(MAKE) GIT_TEST_OPTS="$(GIT_TEST_OPTS) --valgrind"
-
-test-results:
-	mkdir -p test-results
-
-.PHONY: pre-clean $(T) aggregate-results clean valgrind
diff --git a/contrib/subtree/todo b/contrib/subtree/todo
deleted file mode 100644
index 0d0e777651..0000000000
--- a/contrib/subtree/todo
+++ /dev/null
@@ -1,48 +0,0 @@
-
-	delete tempdir
-
-	'git subtree rejoin' option to do the same as --rejoin, eg. after a
-	  rebase
-
-	--prefix doesn't force the subtree correctly in merge/pull:
-	"-s subtree" should be given an explicit subtree option?
-		There doesn't seem to be a way to do this.  We'd have to
-		patch git-merge-subtree.  Ugh.
-		(but we could avoid this problem by generating squashes with
-		exactly the right subtree structure, rather than using
-		subtree merge...)
-
-	add a 'log' subcommand to see what's new in a subtree?
-
-	add to-submodule and from-submodule commands
-
-	automated tests for --squash stuff
-
-	"add" command non-obviously requires a commitid; would be easier if
-		it had a "pull" sort of mode instead
-
-	"pull" and "merge" commands should fail if you've never merged
-		that --prefix before
-		
-	docs should provide an example of "add"
-	
-	note that the initial split doesn't *have* to have a commitid
-		specified... that's just an optimization
-
-	if you try to add (or maybe merge?) with an invalid commitid, you
-		get a misleading "prefix must end with /" message from
-		one of the other git tools that git-subtree calls.  Should
-		detect this situation and print the *real* problem.
-	
-	"pull --squash" should do fetch-synthesize-merge, but instead just
-		does "pull" directly, which doesn't work at all.
-
-	make a 'force-update' that does what 'add' does even if the subtree
-		already exists.  That way we can help people who imported
-		subtrees "incorrectly" (eg. by just copying in the files) in
-		the past.
-
-	guess --prefix automatically if possible based on pwd
-
-	make a 'git subtree grafts' that automatically expands --squash'd
-		commits so you can see the full history if you want it.
diff --git a/contrib/subtree/git-subtree.sh b/git-subtree.sh
similarity index 100%
rename from contrib/subtree/git-subtree.sh
rename to git-subtree.sh
diff --git a/contrib/subtree/t/t7900-subtree.sh b/t/t7900-subtree.sh
similarity index 99%
rename from contrib/subtree/t/t7900-subtree.sh
rename to t/t7900-subtree.sh
index d05c613c97..eb223ff049 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/t/t7900-subtree.sh
@@ -9,10 +9,7 @@ This test verifies the basic operation of the add, pull, merge
 and split subcommands of git subtree.
 '
 
-TEST_DIRECTORY=$(pwd)/../../../t
-export TEST_DIRECTORY
-
-. ../../../t/test-lib.sh
+. ./test-lib.sh
 
 subtree_test_create_repo()
 {
-- 
2.17.0.290.gded63e768a

