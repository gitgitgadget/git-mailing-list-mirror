From: Vijay Lakshminarayanan <laksvij@gmail.com>
Subject: Re: [PATCH] Disallow creating ambiguous branch names by default
Date: Thu, 18 Aug 2011 09:05:57 +0530
Message-ID: <87k4abfl2a.fsf@gmail.com>
References: <1313569298-3879-1-git-send-email-conrad.irwin@gmail.com>
	<7vhb5fev8a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Conrad Irwin <conrad.irwin@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 05:36:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QttOy-00073m-Kc
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 05:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755021Ab1HRDgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 23:36:12 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:43300 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754959Ab1HRDgL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 23:36:11 -0400
Received: by pzk37 with SMTP id 37so2234161pzk.1
        for <git@vger.kernel.org>; Wed, 17 Aug 2011 20:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=VkxFep4/bBTQluKrNbgCd7uEEQjyGKStg6ddwbEiJ2U=;
        b=KiD7ZsZabp2dU1G8fsdqjLVLBHeC3SbWO6G6VMfvX3LmjeJ8qODb8CGT9NTuNoKnZL
         ngoWPNvE3toxQ1sud/dktg6hQW3Klri4yLOduOYC/vBDLxbg2jMAOBISTTgMpneChlFw
         rBvVR4n9I1X2Licybu/+WKJZtO8HYZLCpfgE8=
Received: by 10.142.241.3 with SMTP id o3mr130732wfh.344.1313638570573;
        Wed, 17 Aug 2011 20:36:10 -0700 (PDT)
Received: from BALROG ([59.92.97.42])
        by mx.google.com with ESMTPS id i8sm1125586pbi.12.2011.08.17.20.36.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Aug 2011 20:36:09 -0700 (PDT)
In-Reply-To: <7vhb5fev8a.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 17 Aug 2011 11:41:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (windows-nt)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179554>

Junio C Hamano <gitster@pobox.com> writes:

> We should be giving these warning messages immediately after creating
> potentially problematic refs, i.e. just after "git branch v1.0.0" and
> "git checkout -b v1.0.0". The user experience should look like this
> instead:
>
> 	$ git branch v1.0.0
>         warning: refname 'v1.0.0' is ambiguous.
>         advice: you may want to rename it to an unambigous name with
>         advice: git branch -m v1.0.0 v1.0.0-branch
> 	$ git branch -m v1.0.0 v1.0.0-branch ;# thanks for an advice
>
>         $ git checkout -b v1.0.0
>         warning: refname 'v1.0.0' is ambiguous.
>         advice: you may want to rename it to an unambigous name with
>         advice: git branch -m v1.0.0-branch-2
> 	$ git branch -m v1.0.0-branch-2 ;# thanks for an advice

I'm not familiar with the git codebase, but I'm guessing this is
ambiguous because there's already a tag by name v1.0.0.  /If/ that's the
case, wouldn't be be prudent to explain why the branch name is
ambiguous?

Just my 2c.

-- 
Cheers
~vijay

Gnus should be more complicated.
