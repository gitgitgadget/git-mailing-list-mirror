X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Some advanced index playing
Date: Sun, 3 Dec 2006 17:01:15 +0000
Message-ID: <200612031701.15594.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 3 Dec 2006 17:01:49 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33117>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gquij-0000NC-5q for gcvg-git@gmane.org; Sun, 03 Dec
 2006 18:01:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757574AbWLCRBh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 12:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757426AbWLCRBh
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 12:01:37 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk
 ([82.44.22.127]:42983 "EHLO home.chandlerfamily.org.uk") by vger.kernel.org
 with ESMTP id S1757574AbWLCRBg (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3
 Dec 2006 12:01:36 -0500
Received: from kanger.home ([192.168.0.21]) by home.chandlerfamily.org.uk
 with esmtp (Exim 4.63) (envelope-from <alan@chandlerfamily.org.uk>) id
 1GquiY-00005N-De for git@vger.kernel.org; Sun, 03 Dec 2006 17:01:30 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

With all the discussion about the index file in the last few days I would have 
thought that this issue would have come up.  But I don't think it has.

I have been editing a set of files to make a commit, and after editing each 
one had done a git update-index.

At this point I am just about to commit when I realise that one of the files 
has changes in it that really ought to be a separate commit. 

So effectively, I want to do one of three things

a) git-commit <that-file>

Except I can't because there is a safety valve that prevents this and there is 
no force option.

b) Revert the index entry for that file back to the previous HEAD commit 
point, whilst leaving the edits in the working tree, so that I can then 
commit without that one file.

I can't find a command to do that.  The nearest seems to be 
git-update-index --remove, but the manual says that it will not do anything 
if the file still exists.

c) Revert the entire index back to the state it was at the last commit so I 
can selectively add back in the files that I have editted.

The command to do that seems to be

git-read-tree HEAD 

I tried this, and it did indeed seem to exactly this - not quite what I 
wanted, but actually a reasonable compromise.

However, it took me a long time scanning possible commands before I found it 
so I thought I might add some text to one of the tutorials

Any ideas of where?

What happened to the text written here

http://marc.theaimsgroup.com/?l=git&m=116406699903565&w=2

I thought this might be a place to put something like this, but having just 
updated my version of git from source, it doesn't seem to have been put in to 
git anywhere yet.



-- 
Alan Chandler
