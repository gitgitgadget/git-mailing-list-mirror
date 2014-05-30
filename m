From: Eddie Monge <eddie@eddiemonge.com>
Subject: Git stash gpg prompting
Date: Fri, 30 May 2014 13:07:16 -0700
Message-ID: <CALp-zYGRLKJfC5rVygRg8adjsxP0h2dguNSYsvmcZxq7tcEQfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 30 22:09:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqT7R-00020K-DS
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 22:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030470AbaE3UHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 16:07:23 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:54410 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932413AbaE3UHS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 16:07:18 -0400
Received: by mail-wg0-f47.google.com with SMTP id x12so2455164wgg.18
        for <git@vger.kernel.org>; Fri, 30 May 2014 13:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=Do1ymoC0WvhQnlQlvmI+FUAAot4Ee8avh3Tw8erTB0U=;
        b=YhHUbCt1Z2+/SO7yXq716hDNWIFn2nmTOBFU4r1xxIbLwj8Wss7lXBF4KIcNOvaRCg
         FCoAU/dxY91xrQH9/F5Jtvk8aTLSLwGo00V1kN3K6oVxWdtVOk6CkRgR+VfeIvDSEbRk
         NawlzfBCd1M9SniwKRIbD5Ivr6JYS1E2vZaVKbqBv1RWYdWXsvnWh9MjeiJa7RJVM5JD
         PUnTBCoOCA7GPodZBEWzhaUGuP0/xKlXMAOn/m3jEqwZsENMVjQhfAQS1/hgZDG3vsnM
         VzcEFIKhSMEF1ZV56OErnwddmKWwY+JHH/FjYPRf7i26Or2PjcEkgAhqnOyLChLNWzf2
         g50g==
X-Gm-Message-State: ALoCoQkJvRKeCu/inHkM2S1xFpvj21I3hswjHlcxaYf/dgXyfz1zx2ia2qqLmxBobf15AYxI5lYI
X-Received: by 10.180.77.68 with SMTP id q4mr10062449wiw.21.1401480436571;
 Fri, 30 May 2014 13:07:16 -0700 (PDT)
Received: by 10.216.80.135 with HTTP; Fri, 30 May 2014 13:07:16 -0700 (PDT)
X-Originating-IP: [66.211.109.190]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250473>

Git stash is prompting for passphrase to try to "sign" the changes
being stashed.

Reproduce:
Add to global gitconfig with signing key:
```
[commit]
  gpgsign = true
```
Go to a repo, make some changes, and then run `git stash`

Expected: stash the changes as normal
Actual: git prompts for passphrase (if set)
