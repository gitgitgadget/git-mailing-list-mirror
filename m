From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: [PATCH revised] git_mkstemps: add test suite test
Date: Tue, 6 Aug 2013 15:02:32 -0400
Message-ID: <201308061902.r76J2W33027399@freeze.ariadne.com>
References: <201308061805.r76I51If026086@freeze.ariadne.com> <7vsiymfzuh.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 06 21:02:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6mWl-00073P-OT
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 21:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756018Ab3HFTCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 15:02:35 -0400
Received: from qmta15.westchester.pa.mail.comcast.net ([76.96.59.228]:39637
	"EHLO qmta15.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755776Ab3HFTCf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Aug 2013 15:02:35 -0400
Received: from omta01.westchester.pa.mail.comcast.net ([76.96.62.11])
	by qmta15.westchester.pa.mail.comcast.net with comcast
	id 9Nyw1m0050EZKEL5FX2aPf; Tue, 06 Aug 2013 19:02:34 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta01.westchester.pa.mail.comcast.net with comcast
	id 9X2Z1m01R1KKtkw3MX2axj; Tue, 06 Aug 2013 19:02:34 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r76J2XGg027400;
	Tue, 6 Aug 2013 15:02:33 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r76J2W33027399;
	Tue, 6 Aug 2013 15:02:32 -0400
In-reply-to: <7vsiymfzuh.fsf@alter.siamese.dyndns.org> (gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1375815754;
	bh=/S6JMZNUdo5D1E+sqSnq/HCEHxRrWTCjeDjuDO42X+Q=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=fFwNtG8Vj0J0cminqJHs/CHCPuAtaU0q1OWirIUZ86niH9HsKUFTVXVz87nAHWvRw
	 tfndQEDVQF9A+HQAbewi9QW0TrKu2EPHIUkzB8nZx7pYxoIq/RC8K0LScFPn3u17M7
	 ZiB9WsRgJhwzM+VBGT7DLqdK2eV3B6nOvrUu0hooXC1+g34g3lHpWBltjKZH7ys4n8
	 eo2ExIz055L7N7oiJD/Fz+aSdf9P3HxrqeeCqLpsVB2NwCug1BF7fvb7caVjrElLs9
	 bMKJpiZJ0iLiQUqTD+2p9+jDI8Yvn/7Fj57S3581rNTFpGb3Fx0NubMPuBSLnb5Q3D
	 ft/kWZXD0dleg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231777>

>     git commit --allow-empty -m message <&-

Though as of [fb56570] "Sync with maint to grab trivial doc fixes",
that test doesn't fail for me if I revert to

		fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
		if (fd > 0)
			return fd;

I haven't been watching the code changes carefully; has there been a
fix that is expected to cause that?

Dale
