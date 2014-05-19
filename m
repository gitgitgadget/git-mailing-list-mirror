From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Mon, 19 May 2014 16:17:03 -0700
Message-ID: <xmqqvbt1uzo0.fsf@gitster.dls.corp.google.com>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
	<20140516084126.GB21468@sigill.intra.peff.net>
	<xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
	<20140516225228.GA3988@sigill.intra.peff.net>
	<5376f2ca5c90d_65b915db2f877@nysa.notmuch>
	<20140517062413.GA13003@sigill.intra.peff.net>
	<xmqq1tvq4r43.fsf@gitster.dls.corp.google.com>
	<53795ef8e4023_10da88d30825@nysa.notmuch>
	<xmqqppja2t8a.fsf@gitster.dls.corp.google.com>
	<537a75e0a53b7_afee5d300f3@nysa.notmuch>
	<xmqqzjidv1y4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 01:17:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmWo3-0002M1-BF
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 01:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbaESXRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 19:17:15 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51498 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750852AbaESXRO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 19:17:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B0F0F197DC;
	Mon, 19 May 2014 19:17:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yP1D3kismwTVeK8Cer6aVw23a6E=; b=UWqJZI
	ojInq5xGrtDCZtApxxjfHW0K/V/OvKmbxVhriIWugRGzq9l0tCla4nTd+uQszLag
	6+T50xp12VsqMY0N/6yWU4uEmBMJnHgAlV5lrLOxvGxo7414Dll5qrWu2NONFrhK
	Ipkg9yUeLg740vOslyj+Tv/subrOW7/8hI5+g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rPE6btSiX3GBL8HYG0dXFgUHNyuFC1q9
	5CrbWHHDADNuFZ6MzoSLS1GftVJUrFeoc1PJLoBM+5EU3SztlqXVdFzk20NjPf5s
	GB0M7xTEu0e9Mibg+GcK750DcN4/hGUij7COl09Zpb9aWRnAMB/40DdSJEznVS8P
	PK8IvS9F2bA=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A54BA197DB;
	Mon, 19 May 2014 19:17:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A48DC197D9;
	Mon, 19 May 2014 19:17:04 -0400 (EDT)
In-Reply-To: <xmqqzjidv1y4.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 19 May 2014 15:27:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B09E7872-DFAB-11E3-BFEC-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249636>

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> We could. Personally I don't see the point of making the warning any
>> more annoying....

If we were giving the users a choice of "no thanks, I'll keep using
the obsolete one", then trying to be a low key and giving them a way
to squelch with an advice.* config might make sense, but if we plan
to remove/stub at as early as v2.1, I think annoyance is very much
what we want, actually, because it clearly is the case that we do
prefer users switching instead of waiting for v2.1.

How does this sound?

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Mon, 19 May 2014 16:05:34 -0700
Subject: [PATCH] remote-helpers: give short instructions to download the
 latest

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/remote-helpers/git-remote-bzr | 6 ++++++
 contrib/remote-helpers/git-remote-hg  | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index be4b9a3..c0cb652 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -46,6 +46,12 @@ import atexit, shutil, hashlib, urlparse, subprocess
 sys.stderr.write('WARNING: git-remote-bzr is now maintained independently.\n')
 sys.stderr.write('WARNING: For more information visit https://github.com/felipec/git-remote-bzr\n')
 
+sys.stderr.write('''WARNING: You can pick a directory on your $PATH and download it, e.g.:
+WARNING:   $ wget -O $HOME/bin/git-remote-bzr \\
+WARNING:     https://raw.github.com/felipec/git-remote-bzr/master/git-remote-bzr
+WARNING:   $ chmod +x $HOME/bin/git-remote-bzr
+''')
+
 NAME_RE = re.compile('^([^<>]+)')
 AUTHOR_RE = re.compile('^([^<>]+?)? ?[<>]([^<>]*)(?:$|>)')
 EMAIL_RE = re.compile(r'([^ \t<>]+@[^ \t<>]+)')
diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 989df66..c07d1a5 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -28,6 +28,12 @@ import time as ptime
 sys.stderr.write('WARNING: git-remote-hg is now maintained independently.\n')
 sys.stderr.write('WARNING: For more information visit https://github.com/felipec/git-remote-hg\n')
 
+sys.stderr.write('''WARNING: You can pick a directory on your $PATH and download it, e.g.:
+WARNING:   $ wget -O $HOME/bin/git-remote-hg \\
+WARNING:     https://raw.github.com/felipec/git-remote-hg/master/git-remote-hg
+WARNING:   $ chmod +x $HOME/bin/git-remote-hg
+''')
+
 #
 # If you want to see Mercurial revisions as Git commit notes:
 # git config core.notesRef refs/notes/hg
-- 
2.0.0-rc3-442-ga28c44b
