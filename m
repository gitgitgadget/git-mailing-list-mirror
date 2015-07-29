From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 0/5] pseudorefs
Date: Wed, 29 Jul 2015 13:58:03 -0400
Message-ID: <1438192688-8048-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, sunshine@sunshineco.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Jul 29 19:58:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKVcZ-0002ay-23
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 19:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbbG2R6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 13:58:22 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33758 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbbG2R6V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 13:58:21 -0400
Received: by qged69 with SMTP id d69so8237865qge.0
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 10:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=UaUftK7tH4jHlvfbzwW7VQW7iTOSKmEYpRE+Wh1QgC4=;
        b=VC65CmLmQU6/7EV1GjXO1zrbmCRrmkh/y/9SWIQICy58p2+yd5oAveoP8RekOSS4W3
         4MMLabxTquPXRFqOCw7M9ZiFLBHGt2mEs1m26uHH5XuTt2tdGn9MkJuUSTbCy0hYOA3b
         tqVKOW551bHNH6Nkw1WsvcSCJrFO03rkSyIBKTHOq6NigTsOQaBBM54f9SM1mxIBbZLx
         3tLAQjcJUEV6QKauytbaL5ElDJw9fT0augy0X47mKNi+teTru83pjhLwcrWflBQR0BD/
         SjE0OXDTfvYHWN89CR38lkoUh5O8ldsGHJ1SviyH/7TRWxIFIOCCCC0uhnqavfvpG/L3
         Sl/Q==
X-Gm-Message-State: ALoCoQnhBSmwVu6QJ2UGNRBphFpF3Ud0qh4E5+CmiQR9nE7E6/38bOs0Bi/Do37kh/IBvhirPbed
X-Received: by 10.140.48.171 with SMTP id o40mr63781816qga.0.1438192700717;
        Wed, 29 Jul 2015 10:58:20 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id w68sm14275247qge.18.2015.07.29.10.58.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Jul 2015 10:58:19 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274927>

This version removes the old patch 2/6, which changed notes to use
normal refs instead of pseudorefs.  We don't actually want to forbid
per-worktree notes merge; instead, we want to either ensure that they
don't conflict, or use a completely different merge mechanism.  So we
omit this patch.

In addition, this version fixes a style issue reported by Eric
Sunshine.  It also fixes a lock leak and removes some redundant code;
Eric also suggested both of these changes.

It also corrects the word "rebase" with "bisect" in a commit message;
Junio noticed this one.
