From: Michal Nazarewicz <mpn@google.com>
Subject: [PATCHv4 0/6] git-credential support in git-send-email
Date: Tue, 12 Feb 2013 15:02:27 +0100
Message-ID: <cover.1360677646.git.mina86@mina86.com>
Cc: git@vger.kernel.org
To: peff@peff.net, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Feb 12 15:04:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5GSx-0000kl-Sy
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 15:04:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933268Ab3BLODP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 09:03:15 -0500
Received: from mail-ee0-f52.google.com ([74.125.83.52]:58600 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933221Ab3BLODN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 09:03:13 -0500
Received: by mail-ee0-f52.google.com with SMTP id b15so56086eek.11
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 06:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=VGqKg5uckVlPHYeR5QJMNKR9vfu4y11uyH91/kG9/q8=;
        b=DBzI/jIuDgcoY/Wgt2VndxmOgivXi5ZjaBlvIk6ssRmetTRAX0keWjobEsWIKzrVKR
         vrj9lBqxRbiUE9M2rr1z+gsxz2vqLS835f4+icvnXw2ZAbzy1FiyXdhslU5qOWca5DDC
         fncoOE7cQrtniH66sXA3iuDbj5w3q+ZVcq9CDbaDghj2tXW5kjNCMbR9ZmMHV2EJyaQu
         6885F0c57+0OIf4R5ZMaqdX+BwNff6x3TLkAjo/cUn8rafs9Pf0c8Rg25dKsOKBJyCd3
         FLGKf4SeVFr+RIUCNbvw9pTBAo52wFG2yszvJ0AJYvPhw7BwnYRc0xgQC2/3BG3v7AnP
         b3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer
         :x-gm-message-state;
        bh=VGqKg5uckVlPHYeR5QJMNKR9vfu4y11uyH91/kG9/q8=;
        b=IblOsV9aIGUg2BL1EM4h6ewc2icwPQTr+qYCjGxapSmi7qhNcNCGT+Jdp3/5JV74k9
         ulQho5CGA6AGduywCIAYEm4ogUgj5rChQWDrpT9B4crhQjp8XfONwSutnd1QS9jBpkWV
         Y31toX0stlJZ4svdwEwkcym5I9fmvqLslZvdlJ7uF/IRhyPDVmkOwJbonNiWXYLvQp9j
         j8mmRlmkoOSWhVlA1Wd8drrgomXGpMtkIdL4ePXdEHuf6yLhjNoKHnz9wBd811M9kw0h
         YxNRBh6lkpwXJqFcJ7GbJakWwYv77AV8rskLdXwhvxc+NRVPXLHA0t2V7Fy95BLsngZP
         jrsA==
X-Received: by 10.14.1.65 with SMTP id 41mr46965364eec.35.1360677778010;
        Tue, 12 Feb 2013 06:02:58 -0800 (PST)
Received: from mpn-glaptop.corp.google.com ([2620:0:105f:5:6552:be17:7596:e60d])
        by mx.google.com with ESMTPS id 44sm68000941eek.5.2013.02.12.06.02.56
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 06:02:56 -0800 (PST)
X-Mailer: git-send-email 1.8.1.3.572.g32bae1f
X-Gm-Message-State: ALoCoQl9xeUeuXm69c6plnm+NgMIW0rdvpTt3Q5KX+Tx9A7YkUy9sos0VylKCKJqIoZEWbIZFa87CE1RjJzrkWyAJ1+TVQXz4RNlzVIusi65PH5O3kk7J0uSih2jVYB6P0rN0GSUA0YDCCAHIVZT5tR9WPGJZ34mxUO1GdxUMHqe0u5Mt9eEA6QiBmPeho6PkgFjHtpxvp1D
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216153>

From: Michal Nazarewicz <mina86@mina86.com>

Besids git-credential support in git-send-email, there are some other
minor improvements to Git.pm in this patchset.  Patch 3/6 is new
compared to the previous patchset.

Michal Nazarewicz (6):
  Git.pm: allow command_close_bidi_pipe to be called as method
  Git.pm: fix example in command_close_bidi_pipe documentation
  Git.pm: refactor command_close_bidi_pipe to use _cmd_close
  Git.pm: allow pipes to be closed prior to calling
    command_close_bidi_pipe
  Git.pm: add interface for git credential command
  git-send-email: use git credential to obtain password

 Documentation/git-send-email.txt |   4 +-
 git-send-email.perl              |  59 +++++++-----
 perl/Git.pm                      | 198 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 213 insertions(+), 48 deletions(-)

-- 
1.8.1.3.572.g32bae1f
