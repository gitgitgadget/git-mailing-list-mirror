From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: t3902-quoted.sh broken on cygwin
Date: Mon, 2 Jul 2007 10:46:55 +0200
Message-ID: <81b0412b0707020146x74f1a707na27cc3e5e16f75ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 02 10:47:02 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5HYj-00027B-Bd
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 10:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646AbXGBIq6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 04:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753606AbXGBIq6
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 04:46:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:50901 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861AbXGBIq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 04:46:57 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1214658ugf
        for <git@vger.kernel.org>; Mon, 02 Jul 2007 01:46:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UuShlWjeijJF0QfISHXVpFHdNCa/iUyoJp5Mfq2BOBEnQ3C7VH0R8Kyq2bC1FFSL634KEsrWihfQls2PwMcTfh2vF9NREuIBQPwDVoqCQ9MabASEZYlZZpIIKsqYgrxBrsG7DVU68XzYOafiBYtQKLHqQwKRUMe6LA7tGl3kLF0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=umS4aKb5tAKTRKHCdYvbsFeZgXqbIQOcsyWZqo+27jE7rO/xtjAOdoai4tobAI+JCiSYnhmM/6rxZG6HIRfYNF0zZknOm8Wr8ub36pZirBd1ZtitE4tV8keMZQ6eZL47E3Pt5T3C6QIqEpr8vvcgRKlyKpgPoYiSs3ovPkBTldk=
Received: by 10.78.97.7 with SMTP id u7mr2768046hub.1183366015954;
        Mon, 02 Jul 2007 01:46:55 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Mon, 2 Jul 2007 01:46:55 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51347>

... and I suspect it is broken on MacOSX as well.
I suggest we disable the test completely on Cygwin/MinGW,
and after a test of course, on MacOSX.

The problem is the filesystems deficiencies again (HT and LF
can't be used in the filenames on Windows, and the unicode
characters may get broken on MacOSX).
