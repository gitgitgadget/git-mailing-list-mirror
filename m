From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 0/8] teach --histogram to diff
Date: Mon,  1 Aug 2011 11:16:40 +0800
Message-ID: <1312168608-10828-1-git-send-email-rctay89@gmail.com>
References: <1310451027-15148-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 05:17:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnj0G-0002z9-Nk
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 05:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753411Ab1HADQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 23:16:57 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57478 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926Ab1HADQz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 23:16:55 -0400
Received: by iyb12 with SMTP id 12so6396293iyb.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 20:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=CEBPO7K73caLl80PMcDISyGoMaIdUtL60cq/djzNq4A=;
        b=uTTokSRfUoyUg0Op2YQtKwTR2uWE6tt3B5mngvFeVC5Vv8XHPkvhDDz7tUIV2/pJOl
         dPqNHuoqIvgXmhM7m9AvS6dedKyZdhGDNKWFpSEvB7+pxtjrNr+J9dNO03y4fCKrjtTW
         Y2a+guUr7k8B8QqIDSOtcqKHa31MdBRkny5/g=
Received: by 10.231.111.36 with SMTP id q36mr2560171ibp.142.1312168615055;
        Sun, 31 Jul 2011 20:16:55 -0700 (PDT)
Received: from localhost (cm119.beta238.maxonline.com.sg [116.86.238.119])
        by mx.google.com with ESMTPS id uz2sm3068183icb.0.2011.07.31.20.16.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 20:16:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
In-Reply-To: <1310451027-15148-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178295>

Port JGit's HistogramDiff(Index) over to C. This algorithm extends the
patience algorithm to "support low-occurrence common elements" [1].
Rough numbers show that it is a faster alternative to its --patience
cousin, as well as to the default Meyers algorithm.

Changed from v1/RFC:
 - patch #2 is new
 - patch #6 been changed
 - all other patches are unchanged

Contents:
[PATCH v2 1/8] xdiff/xprepare: use memset()
[PATCH v2 2/8] do away with xdl_mmfile_next()
[PATCH v2 3/8] xdiff/xprepare: refactor abort cleanups
[PATCH v2 4/8] xdiff/xpatience: factor out fall-back-diff function
[PATCH v2 5/8] t4033-diff-patience: factor out tests
[PATCH v2 6/8] teach --histogram to diff
[PATCH v2 7/8] xdiff/xprepare: skip classification
[PATCH v2 8/8] xdiff/xprepare: use a smaller sample size for histogram diff

--
Footnotes:
[1]
http://egit.eclipse.org/w/?p=jgit.git;a=blob;f=org.eclipse.jgit/src/org/eclipse/jgit/diff/HistogramDiff.java;hb=HEAD

-- 
1.7.3.4.730.g67af1.dirty
