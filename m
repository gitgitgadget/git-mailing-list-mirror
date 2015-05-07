From: Luke Diamand <luke@diamand.org>
Subject: [PATCH 0/2] Re: Bug: git-p4 edit_template() and P4EDITOR w/options
Date: Thu,  7 May 2015 18:24:59 +0100
Message-ID: <1431019501-30807-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Chris Lasell <chrisl@pixar.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 19:25:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqPYQ-0007fy-0Q
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 19:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbbEGRZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 13:25:41 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35584 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbbEGRZk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 13:25:40 -0400
Received: by widdi4 with SMTP id di4so251180637wid.0
        for <git@vger.kernel.org>; Thu, 07 May 2015 10:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ft2qo5bV6ByZtgxqeI863WqDa0GdDFvoE+n6qGjqmEw=;
        b=cG8tH0ijn6FSZtwV2sqtqHhec511Eu0fENMZC5DOaA3WJUsd5vDWjEE8LVTuD+0OHX
         4aIBmCadx/XieCd0JAKzaRlifuQDNn7WDMcpW7PhDXCjeDWoIlwstfNg7ovkpbkuoDl2
         FOpnsTbiRZw5hvi7TdvUgfhabRy2fHnR0pWPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ft2qo5bV6ByZtgxqeI863WqDa0GdDFvoE+n6qGjqmEw=;
        b=k9ICbZAq3Wkxt8uttVZa7yv/1nesrOtxFL1gRleAF9AV9gG2OLcMeh/4+McG74bmkG
         nkpqmNWerspUd9Cs43ycXirnw81U54YYgqsQ3OAW0IPyW1iykqPS2KCSTVFGXKAbX8yP
         NhxOVYaWlYgG2v+YKMdz2a/PWa0vbQ1gGpF1EU+Z91iwZQd3CoQoGhtXEGQTOr95QqCH
         bBHmgiZKZQCT2YLFmb4Su/ieinP2AceE7SgXss7bk/i74TNJ3J4lv3FD9itUsHcIxdeR
         IZQ+b/RKld2wB+DezHkdu7RDdCC1FbklcASUr88XtvxZrQi3RiKUz5XaIQ8N7vy9DJxW
         6Lug==
X-Gm-Message-State: ALoCoQmAaFQ8JJ0woMwnqCRwKlMNy6qDqRTlUPJkEjkepGAKK0aEFfCpMXvUUzEQcUStf1OSz21x
X-Received: by 10.194.86.101 with SMTP id o5mr975713wjz.8.1431019539081;
        Thu, 07 May 2015 10:25:39 -0700 (PDT)
Received: from ethel.cable.virginmedia.net (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id b5sm8416807wiw.8.2015.05.07.10.25.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 May 2015 10:25:37 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc3.380.g8e2ddc7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268557>

This adds a test case, and Jonathan's fix, for the git-p4 edit_template
problem found by Chris.

Luke Diamand (2):
  git-p4: add failing test for P4EDITOR handling
  git-p4: fix handling of multi-word P4EDITOR

 git-p4.py                         |  2 +-
 t/t9820-git-p4-editor-handling.sh | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100755 t/t9820-git-p4-editor-handling.sh

-- 
2.4.0.rc3.380.g8e2ddc7
