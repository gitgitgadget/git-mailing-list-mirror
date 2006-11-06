X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Liu Yubao <yubao.liu@gmail.com>
Subject: how to show log for only one branch
Date: Mon, 06 Nov 2006 11:41:15 +0800
Message-ID: <454EAEDB.8020909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 6 Nov 2006 03:42:36 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=mfEvGhvxUaLgxe8ARVvKDa5k2QQNI74hqScydVzhXe2M0HJAAs4rm+xK+fkb3QZg3ZXK9apNtotxm0teyon7pbJZlPf4yv5ccaAMkdADI/Afc91Nvy0edaZGy5Hop7HPgtSHAMM/2ucpTd8cq4ngBY+8dK4JgEdGXtET8RU60L0=
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.7) Gecko/20060909 Thunderbird/1.5.0.7 Mnenhy/0.7.4.666
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30990>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgvNW-0006tg-F9 for gcvg-git@gmane.org; Mon, 06 Nov
 2006 04:42:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423408AbWKFDmQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 22:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423415AbWKFDmQ
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 22:42:16 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:28910 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S1423408AbWKFDmQ
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 22:42:16 -0500
Received: by py-out-1112.google.com with SMTP id a73so922523pye for
 <git@vger.kernel.org>; Sun, 05 Nov 2006 19:42:15 -0800 (PST)
Received: by 10.35.40.10 with SMTP id s10mr9569323pyj.1162784535068; Sun, 05
 Nov 2006 19:42:15 -0800 (PST)
Received: from ?192.168.88.85? ( [221.122.47.70]) by mx.google.com with ESMTP
 id n27sm4395127pyh.2006.11.05.19.42.13; Sun, 05 Nov 2006 19:42:14 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I'm some confused by `git log', here is a revision graph:

a-----> b ---> c ----------------> f ---> g --- master
         \                        /
          `------> d ----------> e ---- test

I hope `git log ...` shows g, f, c, b, a.

`git log master` shows g, f, e, d, c, b, a;
`git log master ^test` shows g, f, c.
`git log --no-merges master` shows g, e, d, c, b, a.

That's to say, I want to view master, master~1, master~2, master~3, ...
until the beginning, no commits in other branches involved.

I have heard git treats all parents equally in a merge operation, so I
am curious how git decides which parent is HEAD^1.

I feel the HEAD^1 branch is more special than HEAD^2 branch, because HEAD^1
is usually the working branch and the target branch of merging operation.
it's a little more convenient to see only commits that really happen in
current branch, especially for people who come from CVS and Subversion (yes,
I think git is more interesting than CVS and Subversion:-).
