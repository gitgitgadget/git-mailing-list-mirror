From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/4] status: give more information during rebase -i
Date: Fri, 03 Jul 2015 10:40:52 -0700
Message-ID: <xmqq7fqh5ecb.fsf@gitster.dls.corp.google.com>
References: <vpq7fqkz48f.fsf@anie.imag.fr>
	<1435739433-18853-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435739433-18853-3-git-send-email-Matthieu.Moy@imag.fr>
	<xmqq4mlnc0lr.fsf@gitster.dls.corp.google.com>
	<vpqk2ujoadw.fsf@anie.imag.fr>
	<xmqqr3or7et9.fsf@gitster.dls.corp.google.com>
	<vpqh9pnm1hu.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jul 03 19:41:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZB4xP-0001BE-T3
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 19:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079AbbGCRk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 13:40:56 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34729 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755088AbbGCRky (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 13:40:54 -0400
Received: by igcsj18 with SMTP id sj18so191954723igc.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 10:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=PkmKM5pLZFwHgo6fN0gOCoHJjL9W3UHACWvA+L5fJkE=;
        b=R+FYTlhC7LZlbhCCjZFC492oGB0PEQZpPvzJfzDKZGZgOPRUebEH+PQ/67pgEi0kAy
         /AbWzcRSoRJCuxzqJcrk9gF0LEvB+Z2DYpIjJJGQi1VE0+yx6WZ9rD1mNYNNRk7fgc3H
         cgssfliEcCGjwoDaACNE+FQnPhYa29iXUdGxq1utJdaaQahf7ndfCgDZB2vyX9PyIQ8o
         ElFAv9FbBi+KK2nmBBlYO9vacACDNleqs4hl3hEdIXvdDBpk2a0sQIKUlMr/38kmvfyN
         1jUYpgUyouBtSy9JrtVHKFVC7ekn/KtTURQY/cq0YPB4KdXPaVtRDb7/MtTGERVyMIhD
         m96g==
X-Received: by 10.50.61.234 with SMTP id t10mr51076201igr.19.1435945253860;
        Fri, 03 Jul 2015 10:40:53 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:846f:c5d0:52c9:d18a])
        by smtp.gmail.com with ESMTPSA id o19sm3859722igi.14.2015.07.03.10.40.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 03 Jul 2015 10:40:52 -0700 (PDT)
In-Reply-To: <vpqh9pnm1hu.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	02 Jul 2015 10:01:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273300>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I would agree with "more strict" is it was about rejecting the input (to
> catch errors), but here we're still accepting it without complaining

Yes, by "more strict", I meant that I would prefer to keep things we
do not understand as intact as possible, while transforming what we
do understand into whatever shape we deem appropriate.

> Actually, there's a hidden benefit in accepting not-well-formatted
> input: it mimicks the shell equivalent closer, which means that we're
> close to replacing the shell's collapse_todo_ids and expand_todo_ids in
> C which would avoid C/shell duplication.

;-)

But as I said above, that is a mere "would prefer" preference, so I
can go either way.
