From: Roberto Tyley <roberto.tyley@gmail.com>
Subject: [PATCH v2] Tweaked notes on gfb<->bfg differences
Date: Wed, 18 Dec 2013 14:25:15 +0000
Message-ID: <1387376716-72615-1-git-send-email-roberto.tyley@gmail.com>
References: <xmqqr49ak8fi.fsf@gitster.dls.corp.google.com>
Cc: gitster@pobox.com, jrnieder@gmail.com,
	Roberto Tyley <roberto.tyley@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 18 15:25:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtI4G-0004Fj-3R
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 15:25:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703Ab3LROZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 09:25:40 -0500
Received: from mail-we0-f175.google.com ([74.125.82.175]:36565 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754636Ab3LROZj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 09:25:39 -0500
Received: by mail-we0-f175.google.com with SMTP id t60so7657774wes.34
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 06:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yIa/+yPvldoTdb8bCGRkDY+xKNfPk7jYKdA3iQRcEMk=;
        b=Y1zDnn7QGeOXtgtfhkfrLoryQZbJ3hUZ8OFSgz0sEyauWus0lDCohy3DgZO3ppQzJn
         1HnTV3U2GsYP8WYcTlPxf/jf6ok8h8lHVbdpqqU9+z9vbFxVtzcsLmgYXo+q9xwafwVD
         1M68CtEmqGuzsSoqz6RYR21IEc+zFXglpFRsCDuwnunVjtY1dceViWj1PvxSHPthfp1/
         HYiUaya+H0fEE6H90EQxJj4v5Xzr1fnsLg4kC1USNusRviEQYzaMxdDS+GEw4d9fzqIa
         GTOSxYg9pHsnZwrSr7tktTR9TF/Ox9qplVlJ1gOyuBVkML+ZJxZExP0WXSZUupBoZKml
         HZsQ==
X-Received: by 10.180.106.229 with SMTP id gx5mr8178984wib.55.1387376738601;
        Wed, 18 Dec 2013 06:25:38 -0800 (PST)
Received: from localhost.localdomain (nat-123-249.guardian.co.uk. [77.91.249.123])
        by mx.google.com with ESMTPSA id o9sm4277293wib.10.2013.12.18.06.25.36
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 18 Dec 2013 06:25:37 -0800 (PST)
X-Mailer: git-send-email 1.8.3.4 (Apple Git-47)
In-Reply-To: <xmqqr49ak8fi.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239436>

On 18 December 2013 05:57, Junio C Hamano <gitster@pobox.com> wrote:
> The first bullet point may be somewhat misleading, though.  Nothing
> stops your script you use in filter-branch from processing blobs
> belonging to a single tree in parallel---the user just needs to do a
> bit more work to do so.

Thanks, I've moved this entry down and clarified the capabilities -
I think there's quite a big difference to the user (of a multi-core
machine) as to whether parallelism happens by default, or whether they
have to work out how to introduce it into the operation they're trying
to perform.

> I think the second point is the most characteristic in BFG (and that
> is what allows easy parallelization of the filtering).  Also, it
> cannot be stressed enough that the "removing unwanted contents" use
> case can take advantage of the "bad contents in a blob is bad, no
> matter where in the tree and when in the history the blob appears".
> That is what makes BFG particularly shine  for the use case. Its
> design very much aligns the objective the use case wants to achieve.

I've moved this up to the first bullet-point and added text emphasising
the significance the constraint plays in making the BFG work quickly
while satisfying the common use-case.


Roberto Tyley (1):
  docs: add filter-branch notes on The BFG

 Documentation/git-filter-branch.txt | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

-- 
1.8.3.4 (Apple Git-47)
