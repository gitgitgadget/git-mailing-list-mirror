From: Martin Pirker <git.collector@gmail.com>
Subject: synchronizing 2 heterogenous branches by cherry-pick
Date: Tue, 21 Jul 2009 14:42:10 +0200
Message-ID: <8d53e6220907210542p4c989f3av2b57202fdd2db1f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 21 14:42:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTEfj-0003X2-TT
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 14:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848AbZGUMmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 08:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752802AbZGUMmM
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 08:42:12 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:15017 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbZGUMmL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 08:42:11 -0400
Received: by rv-out-0506.google.com with SMTP id f6so828595rvb.1
        for <git@vger.kernel.org>; Tue, 21 Jul 2009 05:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=y6dbzmaze/SkxJ1L1CSjfCHwHSgzG3cs2pZbjHOfnn8=;
        b=MwZWBbBka3Uokt7fmuVbrKisxhMpdzQg4VUEi6vf5gZyqgtitP+HReJRrfGtF4Hb8P
         1SlM8Rl8eMjiDhkRy4KPY6zJwQV1qPRQ0nfa6Nh4F/ZCcBuLQ9+Kc6euxvfWJdxml0d/
         Gp+aFUFd0ddqI1zHXsHBnT1UiTDfNw5eNnwAg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=qjVgO00hKnIkKq5HKHMNIksv/Tk9JN95d0BdwtlobzsO7usnYW/1j6sl/Zj6oSDZb/
         +jm9RhCsMwlKH0yzXCttK727RyxH6pV1NtihvdRlfcLK0HGvSPMvjJqOv2kuZE4E+1AJ
         pGW69WoJiXvngDxXnUyHHfBZ/qlA2G8ap4bVU=
Received: by 10.140.201.4 with SMTP id y4mr3397554rvf.205.1248180130808; Tue, 
	21 Jul 2009 05:42:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123657>

One of those weird real-world situations, advice appreciated:

Given...
one Git repository with
one branch "left" and one branch "right"
both branches have a different history (common ancestor is 0000000)
both branches have different content
_however_, at one specific commit in the "left" and "right"
branch it can be said that the content of specific
subdirectories is identical
these commits are marked with a tag "equal"

Thus, patches which only modify the identical
content can always be applied without conflicts on both branches.
I commit a new patch on "left", I can cherry-pick it to
"right" and both trees are identical again.

Issues:
Cheery-pick takes only one commit.
I have to find commits by hand.
Ideally, I want to specify equal..HEAD, if 10 commits are "left"
and "right" are 7, well, then cherry pick the last 3 from "left"
to "right".
Note that the patch content is always identical, the
commit text message (author/committer/timestamp/...) not
always
Note that ideally only one way synchronizing occurs. Bonus
points if I can add on both sides and then start magic sync...


Any good idea on how to automagically script these cherry-picking?

Martin
