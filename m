From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: feature request: consider picked commits in "branch --contains"
Date: Fri, 29 Nov 2013 18:45:35 +0100
Message-ID: <CAN0XMOL60kX4TkPkop3wA1p5dgLMh0i7_=5mB1Gwwg620QRedA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 29 18:45:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmS8L-0005a9-GK
	for gcvg-git-2@plane.gmane.org; Fri, 29 Nov 2013 18:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051Ab3K2Rph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Nov 2013 12:45:37 -0500
Received: from mail-wg0-f48.google.com ([74.125.82.48]:48369 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690Ab3K2Rpg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Nov 2013 12:45:36 -0500
Received: by mail-wg0-f48.google.com with SMTP id z12so9627778wgg.15
        for <git@vger.kernel.org>; Fri, 29 Nov 2013 09:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=0fxSALx7+H4tT1A7P+4VRx0HqFzTRTcefbivdjONE+k=;
        b=qhZwKGCMGPZbWwt7mlJuY1aerJKKlEktTFyW1VAYrOyBCIA4oUEyMMAALUy2uImfYR
         iSrDMuJfCGfdJ4X54fPB3V+h4wVuy1vy64QzYIS3E7mm1Z05g9ViBS4HO/iznm2XH4ED
         rNKeZ2ctDLB+bzhg4bavMpT51AgcYFho5k9UJkXGQoExojGZXgTKm/uyDAEHNCjDm0sD
         0yQJCTTjenZAFqHxYvgtXmvboyaVKA9fQRTSjgC38+C4hwoUxvpGCbqWsaAg8fDRABvs
         6O1ABAmyxvz5pUgS4RPVO/gKHVzVWjDdxmKzvNEdGnRs9vrM3X9SgBfyivscKrFi8TKB
         2mjA==
X-Received: by 10.180.215.3 with SMTP id oe3mr7684855wic.35.1385747135770;
 Fri, 29 Nov 2013 09:45:35 -0800 (PST)
Received: by 10.194.165.163 with HTTP; Fri, 29 Nov 2013 09:45:35 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238529>

Hi,

there are development workflows where a feature or fix is
by definition implemented in the dev branch and perhaps picked
into a stable/rc branch.
A question often being asked in such a workflow is "Is this fix in this
stable branch?". Usually I would call "git branch -r --contains $commit"
to figure this out, but this command does not work in such workflows
because it's a different commit since it was picked.
git-log knows the --cherry-pick option to identify commits with identical
changes.
Wouldn't it be nice to say "git branch --cherry-pick --contains $commit"
to see branches containing a commit even if the commit was picked?!

Ralf
