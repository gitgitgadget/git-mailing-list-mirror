From: David Turner <dturner@twopensource.com>
Subject: [PATCH v8 0/7] ref backend preamble
Date: Thu,  9 Jul 2015 18:50:53 -0400
Message-ID: <1436482260-28088-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, j6t@kdbg.org
X-From: git-owner@vger.kernel.org Fri Jul 10 00:51:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDKf8-0006yc-1S
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 00:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbbGIWvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 18:51:21 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34414 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbbGIWvU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 18:51:20 -0400
Received: by pabvl15 with SMTP id vl15so157217272pab.1
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 15:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=vLJlvzmwLOIr5971AZS8jius9l6l9YcuxO/h890adGU=;
        b=lXYHJFzKzQN2BZ/ZQpg0YP8/AjPSHOAsKJgZhq4/7thGqWV49GJa5naeQGtitx/5+x
         rknizpzb8PD3627wrtJHQalg33LoWL2X8U7QoffPpgtyQ1zoVXq5BpAIZhmN8HgHY3Mq
         19Fpmw3OMXzW3YSlQ2Lxi+rw/BCUlroD/NsD+XsMxRTdQloYcaZMFnVNBT4K8G3/W4Lu
         330Qai77ZVc7S7vSrqpv6xko9G6VP674CQuq3D94kamQKEwS3KNMORFteD3W1LXcdkD0
         xPk4dBY1tliJrd26+kC3RCMcIQGRHBJi31c1yogwikuQLo0cDVF2gpoN5F5/+DeTnrSm
         YYXg==
X-Gm-Message-State: ALoCoQlXLDea0iHrDotNyNtNJ3nPgI0BopZ1NVhj54wM3GVoxNXA1DPVhwT7kPI/u/kOlZM9BRyk
X-Received: by 10.68.205.100 with SMTP id lf4mr35138379pbc.87.1436482280039;
        Thu, 09 Jul 2015 15:51:20 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id fr2sm7129684pdb.22.2015.07.09.15.51.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Jul 2015 15:51:18 -0700 (PDT)
X-Mailer: git-send-email 2.0.5.499.g01f6352.dirty-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273786>

The current state of the discussion on alternate ref backends is that
we're going to continue to store pseudorefs (e.g. CHERRY_PICK_HEAD) as
files in $GIT_DIR.  So this re-roll of the refs backend preamble
doesn't do anything to pseudorefs.  It just does reflog stuff.

In addition, this version removes the over-aggressive die() on reflog
update failure from v7.  It adds the REF_FORCE_CREATE_REFLOG flag, as
Michael Haggerty suggested.  And it fixes commit message or two, as
suggested.  I believe this addresses all comments I've seen on v7.

This addresses Johannes Sixt's concerns too, by removing the offending
code.
