From: Garbageyard <varuag.chhabra@gmail.com>
Subject: Git tag: pre-receive hook issue
Date: Fri, 17 Jul 2015 11:58:53 -0700 (MST)
Message-ID: <1437159533304-7635764.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 17 21:07:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGAyz-0007pH-T7
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 21:07:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbbGQTHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 15:07:37 -0400
Received: from mwork.nabble.com ([162.253.133.43]:49178 "EHLO mwork.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751343AbbGQTHg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 15:07:36 -0400
X-Greylist: delayed 525 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Jul 2015 15:07:36 EDT
Received: from mjim.nabble.com (unknown [162.253.133.84])
	by mwork.nabble.com (Postfix) with ESMTP id 8065F23C93CF
	for <git@vger.kernel.org>; Fri, 17 Jul 2015 11:58:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274095>

We have a pre-receive hook that checks for JIRA ID whenever someone pushes
code to Git server. I'm trying to avoid this check when someone is applying
a tag. Here's the link for the script: http://pastebin.com/VnMQp5ar

This is the link for output: http://pastebin.com/tBGmYaZF

Problem is that if i run the following command, the output that i get on
command line is 0

git describe --exact-match ac28ca721e67adc04078786164939989a5112d98 2>&1 |
grep -o fatal | wc -w

So i'm wondering why it's not entering the IF block (as confirmed in the
output link)

I agree this is a bad implementation (and i will change it soon) for
checking tags and can be easily done by just checking whether $refname
starts with refs/tags/ but i'll really appreciate if someone could tell me
the mistake i'm committing. I've spent few hours banging my head on this.



--
View this message in context: http://git.661346.n2.nabble.com/Git-tag-pre-receive-hook-issue-tp7635764.html
Sent from the git mailing list archive at Nabble.com.
