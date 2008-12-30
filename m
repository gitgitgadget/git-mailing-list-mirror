From: skillzero@gmail.com
Subject: Why can't git pull --rebase work if there are modified files?
Date: Tue, 30 Dec 2008 13:40:22 -0800
Message-ID: <2729632a0812301340y735c3946weee55c9856d4e6a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 30 22:41:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHmLY-00011k-0j
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 22:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbYL3Vk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 16:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752430AbYL3VkZ
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 16:40:25 -0500
Received: from yx-out-1718.google.com ([74.125.44.158]:38455 "EHLO
	yx-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425AbYL3VkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 16:40:25 -0500
Received: by yx-out-1718.google.com with SMTP id 3so1908385yxi.72
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 13:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=IpA5zBdRA+6sX6H7Y7m5obIGrMSg0CPoaJFmBIAiYFA=;
        b=Os60zuSjHRzjm/0L75z46bSsBthSJjZy7pINBRkvQAIcEsYMF4QuzY1lyowtZAPWUc
         +lVwJ6BEX7el5TCkhMHm6rNqlH7ICO5NxakBO0bdwZ+/BMh3CFfM32XC6MxemK8X0VAB
         aZGSwybZb6TVYhgJOjCj7PEOh7caju5DxTGLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=gVsItf9NoFs2GPefaO9pxwts7kTz5HCuWME/HGh9PMvfq94FyXNXfeSzr8Qp4a0CUc
         q7tucEjRIZRZVIeMy/f45taKe7g2mfmGvZLbfW13EhNTNxOytoJ4wbe8tAQY8dw/NInx
         bLlurcTcr4xzMQ/jFfCQJYaI/h0LRCnAGkOCE=
Received: by 10.64.251.17 with SMTP id y17mr11719061qbh.9.1230673222750;
        Tue, 30 Dec 2008 13:40:22 -0800 (PST)
Received: by 10.65.192.6 with HTTP; Tue, 30 Dec 2008 13:40:22 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104210>

If I have locally modified files and I try to 'git pull --rebase', it
fails because of the locally modified files. If I don't use the
--rebase option, it works (but generates a merge commit if I have
local commits). Why does rebasing require an unmodified checkout? It
seems like it should only stop if I something in the newly fetched
changes conflict with my local changes.

I almost always have modified files in my checkout for things I'm
working on. I also often have a commit or two that haven't been pushed
because I'm waiting until I get to a good point before pushing. If I
do 'git pull', I end up with a merge commit each time. That's why I
want to use --rebase, but for it to work, I have to git stash, then
rebase then git stash pop.
