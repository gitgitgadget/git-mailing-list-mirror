From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 00/11] Completion fixes and improvements
Date: Thu, 19 May 2016 23:58:34 -0500
Message-ID: <1463720325-8853-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 06:58:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3cWT-0001VM-KR
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 06:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300AbcETE6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 00:58:47 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35990 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020AbcETE6r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 00:58:47 -0400
Received: by mail-oi0-f65.google.com with SMTP id g16so7294318oib.3
        for <git@vger.kernel.org>; Thu, 19 May 2016 21:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=LGCNl7buy1YMkPmUZ2RPnkpBcKvVcmGik9tzUJi58mI=;
        b=EsMKjedbwNWf9P9Ziygg6aGG3plghS3Q8GrxoxWUDd1RO3o4ZmZsSPmHR4owaxuRAf
         5ZVxkYacvzM/O+/Om0wUkU+h3wNUzlOt+SM5R/5tJX4Aq3tsKoWyj7WtFIdErdCfvJil
         aNpyJZcv6j61MHhHv0FBbndDjvfG7ZM+eXkvJD0tiUG/V/llaGQAeWTER1AJZ04VCSwy
         jr+NqW0GiTnk4Nccfjt+aPndWornqdZspZ8oW92RBf44aeqK+A1YdVJB9AlADbCiY5lg
         vzbkRhHVXs5uQXZfQg9r1ZIR5WfpGbDaKqdMQOME+LFcuNtr2w3b5iZVLbD9OnCnYAXC
         Aepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LGCNl7buy1YMkPmUZ2RPnkpBcKvVcmGik9tzUJi58mI=;
        b=MUVEoaw9RCDbUiMkLvdZAV8cj/UIyu4+tZmBtKD63s/PqAWZq6Us24dv4BQbQU2DyM
         JtDc3UjKjPka77w9UzIgxPUH6jnrJGsRcncTCA52GPgon3xp7EzGn0qfmypR5Gp3xOA6
         f09VpiDYVDLdMNF3r7h4dP6gw/Iq+RsbwTGX9cG2egFSf1COfbXqCojpghLd3APrFVaC
         mBOV5am30IZUU3bMtVuiscnKvAJzu/n3sDcYXiDCRlkOhE1BNzlJT59mZQwH9EmNKoIz
         UN4iWdNq8m8WZmA3jPC9vWqRUaLrDWjNJQDww6qhC0/byvyxR0bUZjT6aAgFrIw+45Qx
         5gIA==
X-Gm-Message-State: AOPr4FX/VUuJPXdDGDwI6FYBzm+dbX5P1VCUhAzIQT5hmyKyW5Uwg0IfWP+BSMfrFYsYsA==
X-Received: by 10.202.245.140 with SMTP id t134mr612674oih.92.1463720326120;
        Thu, 19 May 2016 21:58:46 -0700 (PDT)
Received: from localhost ([189.208.111.205])
        by smtp.gmail.com with ESMTPSA id m2sm4804689oia.1.2016.05.19.21.58.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 May 2016 21:58:45 -0700 (PDT)
X-Mailer: git-send-email 2.8.0+fc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295139>

Hi,

Here's a bunch of patches I've been using for a long time. I don't recall if
I've sent some of these before.

Here they are in case anybody is interested.

Cheers.


Felipe Contreras (11):
  completion: add missing fetch options
  completion: bash: remove old wrappers
  completion: bash: remove zsh wrapper
  completion: zsh: don't hide ourselves
  completion: remove zsh hack
  completion: zsh: trivial cleanups
  completion: bash: cleanup cygwin check
  completion: zsh: improve main function selection
  completion: zsh: fix for directories with spaces
  completion: prompt: fix for Zsh
  Revert "Update documentation occurrences of filename .sh"

 contrib/completion/git-completion.bash | 86 +++-------------------------------
 contrib/completion/git-completion.zsh  | 26 ++++------
 contrib/completion/git-prompt.sh       |  8 ++--
 3 files changed, 20 insertions(+), 100 deletions(-)

-- 
2.8.0+fc1
