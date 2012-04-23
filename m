From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] t5528-push-default.sh: add helper functions
Date: Mon, 23 Apr 2012 10:09:37 -0700
Message-ID: <xmqqmx62jrxq.fsf@junio.mtv.corp.google.com>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335170284-30768-4-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqipgqlass.fsf@junio.mtv.corp.google.com>
	<vpqobqil9ml.fsf@bauges.imag.fr>
	<xmqq8vhml8z7.fsf@junio.mtv.corp.google.com>
	<vpqfwbuju8a.fsf@bauges.imag.fr> <vpqobqigzcx.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 23 19:09:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMMlk-0006Nf-UF
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 19:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448Ab2DWRJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 13:09:42 -0400
Received: from mail-fa0-f74.google.com ([209.85.161.74]:63079 "EHLO
	mail-fa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754243Ab2DWRJj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 13:09:39 -0400
Received: by faaa19 with SMTP id a19so156294faa.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 10:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=H9iCgx3yIclmW6FmrzO8KXGzWhyyn3TXkLA6IvdTHXc=;
        b=SJYT7sGbSxr4rkFgwyHGq+hXuQWWDeO4FLqc5y+rqRR5AlWT7d+tAAOOQUzv57xN0t
         y2nPxk83gIYEalT0Q9YWi4NZI1gyG5PXznDwAMnq7O3NeLjNeBXUDvpWHYpoZ/5ed7vi
         6L2GWbCgCF4+vVXU/3KkGK0WoJMKwcSSlON6cmcenzD4eDAQXo+yaYOPld1amOBLEGUW
         KIjOLbXsLLbcfewfsSumy73rwnjqabxBmdVNXA5ivAh7zvdTwrYfsisH1Sw49DRbu8t6
         W6DL7qMHwkNgNbvr8aDq/eP2FC4K09LaiqKJRY9KYvvq3FxiIThfvftV0iFgBT/GLX6T
         Bm2w==
Received: by 10.14.188.12 with SMTP id z12mr3967014eem.8.1335200978285;
        Mon, 23 Apr 2012 10:09:38 -0700 (PDT)
Received: by 10.14.188.12 with SMTP id z12mr3966997eem.8.1335200978166;
        Mon, 23 Apr 2012 10:09:38 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id t8si10390906eef.1.2012.04.23.10.09.38
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Mon, 23 Apr 2012 10:09:38 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id F11E75C0050;
	Mon, 23 Apr 2012 10:09:37 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 4CF49E120A; Mon, 23 Apr 2012 10:09:37 -0700 (PDT)
In-Reply-To: <vpqobqigzcx.fsf@bauges.imag.fr> (Matthieu Moy's message of "Mon,
	23 Apr 2012 18:57:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQl52Ls59qNfcCHOUG9+OZVXHylkailCmtMxHhjkj9Wu5zQiWdG/WJ8WD+AYqwkx0k4/hrIGOkOEpPyzejlZW+g/SbY1e+Dt9UsoSlW1XKqVCVEfB3TC+SWmaa1vCMJ6c7RfexxsxX5F9oE0qg9nEf+Mf7yceKPHVAWWITo29gj4AUPqJ/s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196150>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Actually, there's a much stronger argument: we're talking about
> test_push_failure (not success), so whatever the mode is, no branch
> should be updated.

Not really.  When you have 'master' and 'side' (two branches), have
updated both but the remote side has only updated 'master', a push with
'matching' behaves like this:

$ git -c push.default=matching push
Counting objects: 8, done.
Delta compression using up to 12 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (6/6), 399 bytes, done.
Total 6 (delta 1), reused 0 (delta 0)
Unpacking objects: 100% (6/6), done.
To /var/tmp/j/src
   9e1359e..4d3f497  side -> side
 ! [rejected]        master -> master (non-fast-forward)
error: failed to push some refs to '/var/tmp/j/src'
hint: Updates were rejected because a pushed branch tip is behind its remote
hint: counterpart. Check out this branch and merge the remote changes
hint: (e.g. 'git pull') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
$ echo $?
1

Notice the mention of "some refs" on the "error:" line.  'side' branch
successfully fast-forwards.
