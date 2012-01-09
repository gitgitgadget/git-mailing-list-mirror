From: Bertrand BENOIT <projettwk@users.sourceforge.net>
Subject: git grep doesn't follow symbolic link
Date: Mon, 9 Jan 2012 17:54:14 +0100
Message-ID: <CAPRVejc7xND_8Y=Pb5rYGEcaKYUaX7_WkSro-_EL8tTGxkfY3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 09 17:54:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkIUH-0002rM-Am
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 17:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443Ab2AIQyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 11:54:16 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:62970 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932234Ab2AIQyP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jan 2012 11:54:15 -0500
Received: by obcwo16 with SMTP id wo16so4323031obc.19
        for <git@vger.kernel.org>; Mon, 09 Jan 2012 08:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=38/q4rNuSQrqfvwNFZkjh4bCwn2b8rZKoFCP4rsN5uU=;
        b=Fg7E5C8CDjRCskTzcDiYmeihJKv4BVwnIUqPZ3S3znkKQhWMyT0GRc2HlXedzqm5qj
         5gvdu5XWis+mgOgvojuFP0idQ2cirIEyqKn0kaHAIq2QK3QhBc22+0v0IDIc9w+oECk9
         /kae8bqe4fIoA/jCpNGbQNVLzmgTalvBjZI/0=
Received: by 10.182.49.106 with SMTP id t10mr15371330obn.49.1326128054914;
 Mon, 09 Jan 2012 08:54:14 -0800 (PST)
Received: by 10.182.81.69 with HTTP; Mon, 9 Jan 2012 08:54:14 -0800 (PST)
X-Google-Sender-Auth: 7R4OenzYBiHSe4z8G1OwF35MK04
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188181>

Hi,

I've not found information about that in documentation, so I do a report.

When using git grep, symbolic links are not followed.
Is it a wanted behavior ?

I've tested with a symbolic link:
 - 'ignored'
 - NOT staged for commit
 - to be commited
 - commited
Anytime -> no result when asking on symbolic link

Example:
# git grep foo mySrc
-> OK answer [...]

# ln -s mySrc test
# git grep foo test
-> KO: No answer

# git add test
# git grep foo test
-> KO: No answer

# git commit -m "DO NOT PUSH" test
# git grep foo test
-> KO: No answer

Best Regards,
Bertrand
