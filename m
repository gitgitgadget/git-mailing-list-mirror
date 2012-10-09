From: Arthur Etchells <adetchells@gmail.com>
Subject: Inconsistency in specifying commit & path for git diff
Date: Tue, 09 Oct 2012 15:43:04 -0400
Message-ID: <50747E48.3060203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Arthur Etchells <adetchells@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 21:43:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLfi4-0008RA-LX
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 21:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754501Ab2JITnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 15:43:09 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:35729 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389Ab2JITnI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 15:43:08 -0400
Received: by mail-yh0-f46.google.com with SMTP id m54so1401126yhm.19
        for <git@vger.kernel.org>; Tue, 09 Oct 2012 12:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=EIyz+zX7Pow70d2+cngxQG+iU+bNbY+4rZ3F/6qu2WY=;
        b=VpBsiolKVD//0+J1fZ7tdbLCEtije/oTxLzZuGWBQiClFp9ydzSDJxB2TK0xM/U0l/
         tLLQ+49UmoSxLU99MeVeploV0IPx727zW9VGizxJfKCj5kvjvvFr4angIxiopj/Plepo
         fciyt9zDPAu3CsJxWPGP4s1cNBPokyK716KQzG5AbTTw99jOfdJCPGudSA79NMrZrJ6r
         iOyl5jfN+cQl1kOY6p6FHKKZQ3Pja7kFb81Cbh94+TR5m4jbJL4o/p1yOa4csyreR1vm
         aLGe4ZqMDJVD+SYrnywELce9XVV5CqhEd3YudSnAsVBNTDkAEynQYGh/50jhw3CJAw+O
         YDqg==
Received: by 10.236.143.131 with SMTP id l3mr20247987yhj.108.1349811787522;
        Tue, 09 Oct 2012 12:43:07 -0700 (PDT)
Received: from arthur-etchellss-macbook-pro.local (99-39-102-49.lightspeed.tukrga.sbcglobal.net. [99.39.102.49])
        by mx.google.com with ESMTPS id o66sm28874932yhi.19.2012.10.09.12.43.04
        (version=SSLv3 cipher=OTHER);
        Tue, 09 Oct 2012 12:43:05 -0700 (PDT)
User-Agent: Postbox 2.5.3 (Macintosh/20110907)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207339>

git diff <commit>..<commit>
and
git diff <commit> <commit>
both succeed

however
git diff <commit>:<path>..<commit>:<path>
fails while
git diff <commit>:<path> <commit>:<path>
succeeds

OS X 10.7.5
git version 1.7.9.1

Reproduced by another user:
http://stackoverflow.com/questions/12805004/git-cherry-pick-creates-blobs-not-commits#comment17319876_12805004

It seems logical to support the '..' syntax in both for consistency.
