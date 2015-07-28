From: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC/PATCH] Port branch.c to use ref-filter APIs
Date: Tue, 28 Jul 2015 12:25:34 +0530
Message-ID: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 28 08:56:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJyo7-0005oF-Lk
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 08:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbbG1G4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 02:56:06 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:32933 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbbG1G4F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 02:56:05 -0400
Received: by oige126 with SMTP id e126so64431825oig.0
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 23:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=QFicv0KUT7pY+NGw1+mga3G+syJvgCnRizC6Hv4f2yg=;
        b=TSuZhHdW+wV9JewxMi0ldAw31luV7HL7MsVvRNKZKqJfxdDTrI6aPVj4PxHNjIbbSd
         +GqpLo/k4PjDFnPI0MladZM9YASK/uYcxoZcplCjDBVKGs2aVPmr/kP1KL8kYTDEOCYV
         NTQSP7Z/Jwv2o29KI+3dhzyrBdGbRQJxI2KtxyWIOJl8E8dTr6xLee+r+DuOzo0BovfB
         iGkl8+k4AjfIWoFwr2lqb9O14w9Wln7wEAOCh2IuD/2DCC37rpanuOYOmmSphjzv9wH1
         Nd4Z7tfZ55Evrw0M88P5D0Kb/7uQdKiXPBTC+bOVZ1K5U/fP6pqQyVxy11WbvMLnieFr
         RbKw==
X-Received: by 10.202.186.132 with SMTP id k126mr30943916oif.60.1438066564242;
 Mon, 27 Jul 2015 23:56:04 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Mon, 27 Jul 2015 23:55:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274737>

This is part of my GSoC project to unify git tag -l, git branch -l,
git for-each-ref.  This patch series is continued from: Gmane (v6)
http://article.gmane.org/gmane.comp.version-control.git/274726

This is a RFC version and I'm sending to ensure that I'm on the right path.

This version also doesn't use the printing options provided by
branch.c. I wanted to discuss how exactly to go about that, because in
branch.c, we might need to change the --format based on attributes
such as abbrev, verbose and so on. But ref-filter expects us to verify
the format before filtering.

Any tips or suggestions are welcome, thanks all :)

-- 
Regards,
Karthik Nayak
