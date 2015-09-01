From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 0/3] submodule--helper: Have some refactoring only patches first
Date: Mon, 31 Aug 2015 17:40:26 -0700
Message-ID: <1441068029-19158-1-git-send-email-sbeller@google.com>
References: <xmqq1tejuscs.fsf@gitster.mtv.corp.google.com>
Cc: Stefan Beller <sbeller@google.com>, sunshine@sunshineco.com,
	git@vger.kernel.org, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Sep 01 02:40:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWZd0-0001Gz-BO
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 02:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753156AbbIAAkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 20:40:42 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36307 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483AbbIAAkl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 20:40:41 -0400
Received: by pacgr6 with SMTP id gr6so5103207pac.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 17:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DnIuxk+ckfmktNXvuRhWDM5nC8EF5bzxQuzDOtgXgcg=;
        b=YGZ7CeYyn0xb0IyaX3E3sPFRrneIL7c/Oj3CiFDBmbJiGhBsygw1qZoD8n51KhIc4e
         QnyH9gbCD5uBFDaxpLt6Noq+TNbZbP8y5dI8Ki9IXyx5GwdPsNZthLyK+wFssOJoe+dH
         VbcjaOc9UfrksRAHGJ8nHanc8ez+hDell1k75HdjXEPOHcDovHStL1Z/MEpY9hivTAN2
         YIVAmu6oKrOthYnGFBgxSHR1FdEzAIDsqbSaP+NCMLEC19V451s4UC74wqgynRqGg6uw
         pwfma4Olnj8XFG7sJuCQihCbh0j/u7tfTC0RZc7LiIkpvFogN2nSQZ6ZRkwDiP8SmxeU
         oieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DnIuxk+ckfmktNXvuRhWDM5nC8EF5bzxQuzDOtgXgcg=;
        b=igE0c8YQOeKuT2qhWnQoMnS0zsJ0pJuWceCbe/TfpZBlolZx5XoHQBdG8ld4DweDKP
         Wf9slNT60SzEC+NV7WCsDASp2RsZV83rSYSFO+5CUHvBjJYkcLOrUkCMPl3HvBhlXq6a
         IJ4gWJW5kJg0ZyLzg4bRBlmdmgB7xj9JYjwB59ATwDaqjsZRFVprumjf2pAhhtQEbb2S
         RbdULiLAhsw3iFrE8at98dfc4UHAjf98qVKlN6U4T4kdMeSfStqSfLPeleMe48QwKmDS
         Wbdq/c5LkyrkPWpnwqDwJHO8T9gqHPtz7qJS0gHGkWkO6jZ4ioUEthyLbsVqrKJP4/xT
         VYmw==
X-Gm-Message-State: ALoCoQlrJPUyiYdqkwbwJV86yKWKOdOw/J5dPHhWC+ZoIWQ2L/4onAPajjDyyl7ZTFNSPJCjlRK+
X-Received: by 10.67.30.161 with SMTP id kf1mr42151109pad.89.1441068040732;
        Mon, 31 Aug 2015 17:40:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:3828:a7a8:276e:e72a])
        by smtp.gmail.com with ESMTPSA id qe3sm15877338pbc.73.2015.08.31.17.40.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 31 Aug 2015 17:40:40 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.256.gb62b30d.dirty
In-Reply-To: <xmqq1tejuscs.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276955>

* Implemented different error messages as suggested by Junio
* Implemented all of Erics suggestions,
  including renaming to module-with-dash-now

Stefan Beller (3):
  submodule: implement `module-list` as a builtin helper
  submodule: implement `module-name` as a builtin helper
  submodule: implement `module-clone` as a builtin helper

 .gitignore                  |   1 +
 Makefile                    |   1 +
 builtin.h                   |   1 +
 builtin/submodule--helper.c | 282 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 166 +++-----------------------
 git.c                       |   1 +
 6 files changed, 302 insertions(+), 150 deletions(-)
 create mode 100644 builtin/submodule--helper.c

-- 
2.5.0.256.gb62b30d.dirty
