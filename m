From: "Geoffrey Ferrari" <geoffrey.ferrari@googlemail.com>
Subject: Post-update hook problems
Date: Fri, 5 Oct 2007 12:27:22 +0100
Message-ID: <930d91430710050427o79395023nffe3bd842a87cddb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 13:27:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdlLF-0008Ct-3p
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 13:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbXJEL1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 07:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752027AbXJEL1Z
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 07:27:25 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:14566 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbXJEL1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 07:27:24 -0400
Received: by nf-out-0910.google.com with SMTP id g13so621053nfb
        for <git@vger.kernel.org>; Fri, 05 Oct 2007 04:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=epwSLeCLN7Yw9EE5Dop6QUxP1y9uMPPOl29PGFwznHE=;
        b=H8YjKRGGNhZILD1NRBJq1K6GTkLSZDaRwV1WJcyXeIeqUlV+nzPq1I1x/LWeDB5p1AGuKT74jTuA1Q3H8tOQ4bhUKRQR6+c24n6NPnizBmevJhaZp+t7ePScCEe8uMFtjqf2S8CUi8++1PCckynI4aHy4l4nr6PIak8UyFO08PI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=igTYz8M2SkgkeubTrr1d7X3op6acwrG7/gzb+pieLvP7bCvD9FjNCiGJKSK5Nno742W7pD8g19MAKZexTIbMXy6UXGtPM50g67cBeO4KkrXi4LqsQLNXXsoSIRUE7tgvnZWj1Rr0bx2p5Cv0lWC27co75KGSR4IbJ/aE4s6Wvfg=
Received: by 10.78.159.7 with SMTP id h7mr5598306hue.1191583642461;
        Fri, 05 Oct 2007 04:27:22 -0700 (PDT)
Received: by 10.78.131.5 with HTTP; Fri, 5 Oct 2007 04:27:22 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60069>

I have a public and a private git repository on the same machine, in
the same user's home directory. I want to ensure that when the public
repos is updated, the private repos automatically receives those
updates. Let's just assume that this is a good idea.

So, I've created a post-update hook script and made it executable. The
script is very simple. It 'cd's to the private repos and then does a
git pull. It looks, in essence, like this:

--
#!/bin/sh

cd /user/home/private/repos
git pull

exit 0
--

When I run this script directly, it works fine. (It also works fine
when I run it directly over ssh). However, when I do a git push to the
public repos, (either locally or remotely over ssh) the script is
called but reports back the following error:

--
fatal: Not a git repository: '.'
Failed to find a valid git directory.
--

Can anyone explain why this happens? And how can I make the script
work properly?

With sincere thanks for your help,

Geoffrey Ferrari
