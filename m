From: Chris Pettitt <cpettitt@gmail.com>
Subject: git-p4: detect changes to executable bit and push to p4
Date: Thu,  1 Nov 2007 20:41:36 -0700
Message-ID: <1193974896-19173-1-git-send-email-cpettitt@gmail.com>
To: Simon Hausmann <simon@lst.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 04:41:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InnPy-0008Pk-3K
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 04:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbXKBDlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 23:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbXKBDlo
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 23:41:44 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:56935 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbXKBDln (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 23:41:43 -0400
Received: by wa-out-1112.google.com with SMTP id v27so804709wah
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 20:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:message-id:x-mailer;
        bh=QqENrYcxPRerxPMXkzShZ8ruKxxA1y1l/mMvAZePU+k=;
        b=m/TZ1DVv4jTUe3DWJIv+PgxZdHczdXDw2oxC9N0AziR4kgeHf/aNTqfBHxURxLP1vwhipMtzsxpxS54vmwf2IsOGKw5LUXp7hlvhrzftTc42AnsVRWYfH6/TXQb6gDG7hMFYba2r9zVgg98jYcisKsvVf4tIAMQ0z9PUYnm3pjM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:message-id:x-mailer;
        b=H2gj3rZi6ljCFN2/Gn8LmYeDq4Kx9A+xmq7bYTGNYnzdwG/z5yIxhj/bWMokzCKyfdYFFtfugZs7Qfhev5r+7Jq8IsmXvZ0A5RF5dWsVedm3nuvLWkpk0M5nNN5NF7hUmC/UumVptAp+ejk+ihVHqMNYDYxlA4y8IenZH6FtHfw=
Received: by 10.115.89.1 with SMTP id r1mr1407994wal.1193974902744;
        Thu, 01 Nov 2007 20:41:42 -0700 (PDT)
Received: from localhost ( [76.236.71.63])
        by mx.google.com with ESMTPS id m25sm3419318waf.2007.11.01.20.41.39
        (version=SSLv3 cipher=OTHER);
        Thu, 01 Nov 2007 20:41:40 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4.498.g9c514
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63053>


The following two patches add support to git-p4 for detecting changes to the
executable bit in git and including these changes in the p4 changeset during
git-p4 submit.
