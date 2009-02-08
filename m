From: Caleb Cushing <xenoterracide@gmail.com>
Subject: checking sha1's of files
Date: Sun, 8 Feb 2009 04:39:19 -0500
Message-ID: <81bfc67a0902080139j1331d967g34bfc18f4068e443@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 10:40:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW69h-0002q4-GD
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 10:40:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728AbZBHJjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 04:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752707AbZBHJjW
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 04:39:22 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:4194 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703AbZBHJjV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 04:39:21 -0500
Received: by qw-out-2122.google.com with SMTP id 3so861091qwe.37
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 01:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=olVELeSxKVMEU1CNY6ip7ppzsu/4f84sEk7qGmcEG8s=;
        b=nwwTfKrvs8RbtLZETzLW2GuZ7g2QbJhY/uC0+Cf//SEQQDb4FIoQwvC1chOty2mgA2
         dVjuh/P7+ViLsUnmBg2ncblIob4GLhFDIW0E4A48uvq9oJck+GjKzyOewVppSlObc6P9
         CXtb4Hh9ZWsTAuyu6f/hU8h3NQLOv6OeflApM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=a8KCeK6gNeErmBdQerZ921uyfOWuAm68LS/prSz2wgm4eIlao7vdlqkuHgaFGTaAGv
         7AthRaV0xv9R+8N8GlVpEdYcwEYbCjMHxlfGCjBBqLl38c7M3CFZhEc8h69vXlc4Ic6W
         u8jCLS/gkXn0UlQ9+RSHYWCT+gsmutoXhq0Ik=
Received: by 10.229.74.8 with SMTP id s8mr993752qcj.40.1234085959404; Sun, 08 
	Feb 2009 01:39:19 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108934>

I need to check the hashes of specific files in the repo in an
automated fashion, in another tool.

to be less vague currently gentoo's portage tree has manifests for
each file in the tree, on funtoo and regen2 (forks) we've imported the
tree into git. Git has all the manifesting that's needed (most of it,
still doesn't help with files outside the tree) in it. I'd like to be
able to remove manifests from the tree, however I still want to check
that the ebuilds (package format) are consistent at run time. Checking
the entire tree is not sane.

I figure the best way to do this is to first check stat against the
index, then, if that passes check the sha1, if that passes continue to
the next step.

I don't want to do anything like determine the output of a git command
in my code, I'd rather check to see if the check passed or failed
using return codes or some such. If it is capable of checking these
but would require me to parse output I'd still like to know, as it may
let me get the fix in faster, and I can do better later.

I know git may not be currently capable of this behavior, which means
I should extend it, or even write a new program to deal with it. If
this is the case, is there any documentation on how git does this?
aside from the source? could someone point me in the general direction
of source files I should be looking at? maybe even specific functions?

any help with this endeavor of any kind would be appreciated as the
manifests 'cause the repo to balloon, not to mention are just a pain
to manage as they can't actually be merged.
-- 
Caleb Cushing

http://xenoterracide.blogspot.com
