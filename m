From: cpettitt <cpettitt@gmail.com>
Subject: git-fast-import segfaults
Date: Thu, 25 Oct 2007 17:29:01 -0700
Message-ID: <de47e4420710251729j5858481cg69146385a2ed798d@mail.gmail.com>
References: <de47e4420710251726nb45a19fk15b3105b735a74f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 26 02:29:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlD4j-0006Nb-BX
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 02:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587AbXJZA3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 20:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753099AbXJZA3G
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 20:29:06 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:33136 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbXJZA3D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 20:29:03 -0400
Received: by fk-out-0910.google.com with SMTP id z23so627166fkz
        for <git@vger.kernel.org>; Thu, 25 Oct 2007 17:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ERonDLSq3sodpoRbHCp8Q0ggmxI/6E4FrLJcJjhAsrg=;
        b=PP9o1TeWPFSprWWAj5PHSdr5S2uDQ9uwLoSXdSjzP9pKrWanNff0Ag5Fp17jLGsWossf0zo1rDUCcLZ/i4mQ4Dr8rgI4tE+LwRe5kcHcS3/fbUB98td39YzvLbZH7MMGfUzG9VIOip4LGV3RMZwxF8nWloY8b/6b3s52KQyjAzc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a3HbbkkxMgX4TQQ0w7YC1dwOaQb/CWjmKPmenFhChUQC8J6Gqi5OAWsFeL3prPk4/WjgLjtkux2/lFW08oFdpEVKPA0kQEkeK66bruO/UsvpQTbqBwMT7uM3W1Cso94AThUF/FG8chtEHgRw+hOCGt6ee5V86iVyeYIgODx5qCE=
Received: by 10.82.177.3 with SMTP id z3mr5003228bue.1193358541092;
        Thu, 25 Oct 2007 17:29:01 -0700 (PDT)
Received: by 10.82.171.3 with HTTP; Thu, 25 Oct 2007 17:29:01 -0700 (PDT)
In-Reply-To: <de47e4420710251726nb45a19fk15b3105b735a74f8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62388>

I'm seeing the following errors when I run git-fast-import (on Intel
OSX) with some data from a git-p4 import:

[cpettitt@gish scratch2]$ rm -rf .git; git init; git-fast-import < ~/writer.out
Initialized empty Git repository in .git/
git-fast-import(23021) malloc: *** error for object 0x500e50: double free
git-fast-import(23021) malloc: *** set a breakpoint in szone_error to debug
git-fast-import(23021) malloc: ***  Deallocation of a pointer not
malloced: 0x501a80; This could be a double free(), or free() called
with the middle of an allocated block; Try setting environment
variable MallocHelp to see tools to help debug
git-fast-import(23021) malloc: *** error for object 0x5020a0: double free
git-fast-import(23021) malloc: *** set a breakpoint in szone_error to debug
git-fast-import(23021) malloc: ***  Deallocation of a pointer not
malloced: 0x5007e0; This could be a double free(), or free() called
with the middle of an allocated block; Try setting environment
variable MallocHelp to see tools to help debug
git-fast-import(23021) malloc: ***  Deallocation of a pointer not
malloced: 0x5006e0; This could be a double free(), or free() called
with the middle of an allocated block; Try setting environment
variable MallocHelp to see tools to help debug
git-fast-import(23021) malloc: ***  Deallocation of a pointer not
malloced: 0x501e10; This could be a double free(), or free() called
with the middle of an allocated block; Try setting environment
variable MallocHelp to see tools to help debug
git-fast-import(23021) malloc: ***  Deallocation of a pointer not
malloced: 0x502190; This could be a double free(), or free() called
with the middle of an allocated block; Try setting environment
variable MallocHelp to see tools to help debug
git-fast-import(23021) malloc: *** error for object 0x500280: double free
git-fast-import(23021) malloc: *** set a breakpoint in szone_error to debug
git-fast-import(23021) malloc: ***  Deallocation of a pointer not
malloced: 0x5009c0; This could be a double free(), or free() called
with the middle of an allocated block; Try setting environment
variable MallocHelp to see tools to help debug
git-fast-import(23021) malloc: *** error for object 0x500b00:
incorrect checksum for freed object - object was probably modified
after being freed, break at szone_error to debug
git-fast-import(23021) malloc: *** set a breakpoint in szone_error to debug
Segmentation fault

I start getting free errors at fast-import.c:1577:

                        rc = rc_free;
                        if (rc)
                                rc_free = rc->next;
                         else {
                                rc = cmd_hist.next;
                                cmd_hist.next = rc->next;
                                cmd_hist.next->prev = &cmd_hist;
                                free(rc->buf); // <-- error is emitted
in free here
                        }


I believe these errors started showing up in commit
b449f4cfc972929b638b90d375b8960c37790618. I did a bisect on
fast-import.c and this was the first commit for that file that
exhibits this bug with the input.

I thought I would check with the list to see if this is a known issue
before I spend time trying to dig into it.
