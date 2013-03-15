From: Jed Brown <jed@59A2.org>
Subject: git branch: multiple --merged and --no-merged options?
Date: Fri, 15 Mar 2013 14:38:12 -0500
Message-ID: <87fvzwmp23.fsf@59A2.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 20:38:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGaSg-0007yK-GU
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 20:38:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522Ab3COTiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Mar 2013 15:38:15 -0400
Received: from mail-ia0-f177.google.com ([209.85.210.177]:43405 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404Ab3COTiO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 15:38:14 -0400
Received: by mail-ia0-f177.google.com with SMTP id y25so3536345iay.22
        for <git@vger.kernel.org>; Fri, 15 Mar 2013 12:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:subject:user-agent:date:message-id
         :mime-version:content-type;
        bh=bV64E/BxdCrObheu3XKv4ozH44DWhsBTRhLn6AU3FqU=;
        b=cc/6xx7m6eIHky3Ev7mNRqi8bVCNRoBJ5h26bjqnB8JmU9w6S+l1D1fF4M+xdNJhtG
         2Z9S+V+4XFiBBrUX7OgWtNmWbRfbbPru1VsZddiW6foMiCst/YgO4erzWrjSrirAk2vT
         dQwJbr0l0LFidwZRXLW/Re6Uoagdb5RAxQ/sRJa293A6uwCFDLg5gjHfFdT5Gr0zDEtP
         TxAlDefJypYHa/qoebyTx26DB4tI8xfppQSEufaXQQvWQx/CZcCF6m1bs5bBpFbFT6zV
         FXl8mPFCieAkQYQdNvLV2VZmL/rbrxtJHEUpp4+IeVvdLIYVX4kWL/hnG25BSEcuF+Qa
         Phqw==
X-Received: by 10.50.152.173 with SMTP id uz13mr24651990igb.106.1363376294252;
        Fri, 15 Mar 2013 12:38:14 -0700 (PDT)
Received: from batura ([38.69.41.96])
        by mx.google.com with ESMTPS id l2sm2605157igb.1.2013.03.15.12.38.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 15 Mar 2013 12:38:13 -0700 (PDT)
User-Agent: Notmuch/0.15 (http://notmuchmail.org) Emacs/24.2.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218258>

I find myself frequently running commands like this

  $ comm -12 <(git branch --no-merged master) <(git branch --merged next)

when checking for graduation candidates. Of course I first tried

  $ git branch --no-merged master --merged next

but this is equivalent to

  $ git branch --merged next


Isn't this query common enough to have a nicer interface? What do other
people use?
