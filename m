From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Using clean/smudge scripts from repository
Date: Wed, 10 Jun 2015 08:22:18 -0700
Message-ID: <xmqq1thjoafp.fsf@gitster.dls.corp.google.com>
References: <20150610015349.GA5417@robin.thebellsplace.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Bob Bell <b_git@thebellsplace.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 17:22:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2hpi-0003zC-Hp
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 17:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754265AbbFJPWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 11:22:22 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:33013 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932289AbbFJPWU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 11:22:20 -0400
Received: by iebgx4 with SMTP id gx4so36655185ieb.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 08:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=AIqEfIDqk7+xl7mkaJcpiKYQQ+htBYanWEmlMiYtxBI=;
        b=1JZqnGJC8hKZZAk0xa/AyHWCr9wfQB7HfqRP7ycwC2V21+Cd+3KE53w5TnZA/5agLN
         pUIm/v07byZyc11gVsdQAA57qFffvYiQReTN3aWPEAW0caRhnvrB2elNa539HjlQFL35
         PYaHHn3muHAhhyKk/2knK14lgVsczmAnsD2YTiaNdUNvKxrDnW9B7MgqDGkpdG84GJ+y
         V63s6qHDsyuoxR/BuiKOfAkIYiHQ/JkklOVqzFNmWH6cnXvCsEXOJ9DKyU1OUJ/Yiax/
         ufVsUnrXhk6kf0ZZm9ynmyVXk5Ozuy6AcuE+tZ08YubcN0I8YOdVRR99RsfcVjKQo4Kz
         YmGg==
X-Received: by 10.50.49.46 with SMTP id r14mr28731377ign.45.1433949739679;
        Wed, 10 Jun 2015 08:22:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id lq3sm3449728igb.3.2015.06.10.08.22.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 08:22:19 -0700 (PDT)
In-Reply-To: <20150610015349.GA5417@robin.thebellsplace.net> (Bob Bell's
	message of "Tue, 9 Jun 2015 21:53:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271303>

Bob Bell <b_git@thebellsplace.com> writes:

> Is this a proper solution, or did I just "luck out"?  Am I perhaps
> doing something foolish?

Yes, we happen to run checkout in the index order, but that is not
something we guarantee, so you can call yourself lucky.  You are
being doubly lucky that nobody in your project is committing a
malicious script in the repository.  It may also count as foolish,
depending on how important the security is for you and how
trustworthy your collaborators are.
