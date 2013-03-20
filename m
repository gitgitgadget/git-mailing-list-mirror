From: Kirill Likhodedov <kirill.likhodedov@gmail.com>
Subject: Bug? git show behaves incorrectly when called on a stash object
Date: Wed, 20 Mar 2013 19:08:58 +0400
Message-ID: <AF060B6D-27F7-45BE-9BC3-85FAF3487481@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 20 16:09:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIKdz-0001Cy-9P
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 16:09:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757368Ab3CTPJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 11:09:06 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:54410 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756206Ab3CTPJF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Mar 2013 11:09:05 -0400
Received: by mail-la0-f43.google.com with SMTP id ek20so3164833lab.16
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 08:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:content-type:content-transfer-encoding:subject:date
         :message-id:to:mime-version:x-mailer;
        bh=UYi6S4YfioXv8mCHrIW0BpJY+txcrz9YFo5NewQUZLM=;
        b=udwMj6w0kB3tZAjsLT1JLcc2msICZQbaJoLDl4ySxvWeau3qL/G4sW8tiwkcUucLBG
         nKNyKAHTbaRcgy5N0mP8BQbYbovG1MRXI8xWw5SXVZM5jB6kiMdOh5dnAMxCqKJjSDHc
         5C0n/HddGmCSU8TKSRA1ghwq8UEJ6InFjF+kAKREBv2n6PuA1zE2j1fKSKQwWwSKk+qI
         LIq0FRpuMqMCSwfgiQv4QmY6RYmtUOeOc6BR1fpXghSXhcORu3vzZkiphwijuH1lbZzQ
         oIyc4pidq4Eq3oG2TKAIBRCrIUY6zgkq/V/cGmsAqbwQGKNOjiyH9c6QjsRwgKTxPk6z
         qBPg==
X-Received: by 10.112.49.66 with SMTP id s2mr9646015lbn.16.1363792142007;
        Wed, 20 Mar 2013 08:09:02 -0700 (PDT)
Received: from loki.labs.intellij.net (gw.intellij.net. [195.5.138.42])
        by mx.google.com with ESMTPS id xw14sm1046894lab.6.2013.03.20.08.08.59
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 08:09:00 -0700 (PDT)
X-Mailer: Apple Mail (2.1283)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218612>

Hi,

I experience difference in behavior between `git stash show stash@{0}` and `git show stash@{0}`:

-----------------------------------------------------

# git stash show --name-status stash@{0}
A       a
M       conflict.js
# git show --name-status stash@{0}
commit 05aa170746dc4e060f10710a92aed4592276f2d4
Merge: 737f544 7c2160f
Author: Kirill Likhodedov <Kirill.Likhodedov@gmail.com>
Date:   Wed Mar 20 18:56:28 2013 +0400

   WIP on master: 737f544 master

MM      conflict.js

-----------------------------------------------------

The first gives the correct result, while the second doesn't show the addition.
Is it a bug, or I'm just missing something?

Thanks a lot!
Kirill.