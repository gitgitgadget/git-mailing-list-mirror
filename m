From: Peter Wu <peter@lekensteyn.nl>
Subject: git archive and glob pathspecs
Date: Wed, 03 Sep 2014 00:17:38 +0200
Message-ID: <7752133.8a4hJ4krff@al>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 03 00:50:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOwuQ-0003lY-TB
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 00:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755308AbaIBWug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 18:50:36 -0400
Received: from lekensteyn.nl ([178.21.112.251]:44168 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752046AbaIBWug (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 18:50:36 -0400
X-Greylist: delayed 1972 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Sep 2014 18:50:35 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2014-q1;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From; bh=msfxzrfRnG+/cbtNYpkRqEexOmQQoBnefKYqfqvPnto=;
	b=TpkVVSXhNOZgSZwPcwzyjw3de7VyrM22JI0axt8Day/H/tQ2LKQQOGBXbRCEBb0fxiJKkAatMzQJt2uX4QxsC04pd/EBbA+tdr2p+g6AI1ndVAt2Bnm04qijbwJGASHEpf+PEqG2TvvzJSHSHMnt7Yvjmx57Q0i3bV3C5aa6YTT5GTB3Ng9ewPNuKmK72Re/T9OylaWY35qy38+KlMFhOJ1y9Ubp84SB98kx4i4FFc+zWNG/3Sm4a/vZUzjGh6Kqb+VhbZtO/pY8wr1yul53YtSX8Z9er4MCBTi7x1F4ACSqD163wWnAKg9s1zkLrmPY36xEYeEtvm+Y8GdtFhI6Tg==;
Received: by lekensteyn.nl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <peter@lekensteyn.nl>)
	id 1XOwOR-0004o3-N9
	for git@vger.kernel.org; Wed, 03 Sep 2014 00:17:39 +0200
User-Agent: KMail/4.13.3 (Linux/3.15.0-rc8-custom-00058-gd2cfd31; KDE/4.14.0; x86_64; ; )
X-Spam-Score: 0.0 (/)
X-Spam-Status: No, hits=0.0 required=5.0 tests=NO_RELAYS=-0.001,URIBL_BLOCKED=0.001 autolearn=disabled
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256373>

Hi,

The `git archive` seems to accept a pathspec judging from the error message (git
version 2.1.0):

    git archive HEAD -- :x
    fatal: pathspec 'x' did not match any files

When I try to use deeper glob specs however, it throws an error (this also
happens if I use `:(glob)**/Makefile`, tested in the git source tree):

    $ git archive HEAD -- ':(glob)*/Makefile'
    fatal: pathspec '*/Makefile' did not match any files

Strange enough, command `git log -- ':(glob)*/Makefile'` works. Any idea what is
wrong?

Kind regards,
Peter
https://lekensteyn.nl
