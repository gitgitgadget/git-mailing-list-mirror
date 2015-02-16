From: Julien Cretel <j.cretel@umail.ucc.ie>
Subject: Should "git log --decorate" indicate whether the HEAD is detached?
Date: Mon, 16 Feb 2015 22:42:27 +0000
Message-ID: <CACdBeKmNazMtzK4hdd7WXMPDr7HdPe+EFpyd3M-TPBAUEY+HpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 23:42:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNUN6-0008Hj-Mf
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 23:42:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbbBPWm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 17:42:29 -0500
Received: from mail-yk0-f176.google.com ([209.85.160.176]:34811 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598AbbBPWm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 17:42:28 -0500
Received: by mail-yk0-f176.google.com with SMTP id 142so14382318ykq.7
        for <git@vger.kernel.org>; Mon, 16 Feb 2015 14:42:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=iQPLxou+101nap4dv2P+FQDR2Sq8Qpz0OObGxRpnRs0=;
        b=EQ817Ar4MWoeOQkUQ7KDGwqL3RnXUHrTQyf1PHoz3rNUZVDFIvxsBASJwReh7iA3Fw
         hp2e7O7yACLOnA3dUWp1cdQOn22orkKseWWlUlFPmvGf/jH6WpbZfyBHx4cK3Zta60W+
         /K33ftit2mxzdvV0q2Ghlp1uSu3BxOTDDWdClIwcuWEHKB0vy/W2KRtkuFONfUj2WggV
         wxTqF3uWI8PqkcvfK9PXU/EJd5KSnBqunsUOx6FU9SKZTzEI4Lq6johI2bpC0OcGQ25M
         934GrmqrF6Lh2Hlz42+Cg//q2RywgBA4+PMXcyKJ5pqcnVl2hHZxYuSsDgSLSlGGEFn/
         IqnA==
X-Gm-Message-State: ALoCoQmhWI9Z+hbUW7ksRnhOqsgNpeSUFwUPd6a7RnhktLfMMqgn8ZHTW9FensDijZptu7GpFLYD
X-Received: by 10.170.87.8 with SMTP id e8mr19580664yka.81.1424126547994; Mon,
 16 Feb 2015 14:42:27 -0800 (PST)
Received: by 10.170.36.197 with HTTP; Mon, 16 Feb 2015 14:42:27 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263922>

As of Git 2.3.0, the output of "git log --decorate" is ambiguous as to
whether the HEAD is detached or not.
More specifically, consider the following output of "git log --decorate":

    4d860e9 (HEAD, master, dev) Remove trailing whitespace

Whether the HEAD is attached to master or detached, the output is the same.
Could/should "git log --decorate" be modified to provide this information?
Perhaps something along the lines of

    4d860e9 (HEAD -> master, dev) Remove trailing whitespace

or

    4d860e9 (HEAD = master, dev) Remove trailing whitespace

in case HEAD is attached to master, and the current output if it is
detached? Any thoughts?
(For information, I asked a related question on Stack Overflow a few
months ago: http://stackoverflow.com/q/25392580/2541573.)

Also, if such a feature is desirable, would its implementation be a
suitable "microproject" for a prospective GSoC-2015 applicant?

Jubobs
