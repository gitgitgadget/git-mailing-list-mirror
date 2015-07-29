From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Log messages beginning # and git rebase -i
Date: Wed, 29 Jul 2015 08:54:48 -0700
Message-ID: <xmqqvbd39cxj.fsf@gitster.dls.corp.google.com>
References: <loom.20150727T133256-715@post.gmane.org>
	<CAPig+cRT6=YCHz+phfE+84y27ey-6ScjPxP2cHiVqumJmR6mOw@mail.gmail.com>
	<loom.20150728T115023-269@post.gmane.org>
	<vpqsi88qp6q.fsf@anie.imag.fr>
	<xmqqr3nsfdmw.fsf@gitster.dls.corp.google.com>
	<vpq3808p40o.fsf@anie.imag.fr>
	<CACsJy8ABsHBA1TubB+6fypT0LGQF_O+CmHPqL+C7nMVjjWy38w@mail.gmail.com>
	<vpq8u9zjgzl.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>, Ed Avis <eda@waniasset.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 29 17:54:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKTh1-0003fx-U5
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 17:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080AbbG2Pyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 11:54:51 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33165 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbbG2Pyu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 11:54:50 -0400
Received: by pdbnt7 with SMTP id nt7so8116423pdb.0
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 08:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=QmNM1qn73Nl2ZOCAAORh/8KiG/wO/5XTDa/z/bWPXbs=;
        b=SOdpjxBdOYeZQcON5LRD8eEz7ODud2KdqCeaHw9yzJ8aO6yBrEbC244lqYdtlGhO7H
         lstK85Whkh1qqLK7hkKzK3J2NHNodKHkk2E3WJ7n4D+bK5thwPWEUlXwrczDb6lYx/TL
         TZD2VBbOJEMJhD8tWy/zAxXxQIMGvAt8jXsCeY9uWPvQbTIDGwTHR5+6VsOl8WvLZ+bk
         kR1H/bdNirzNGlBp5KwkJOUjY9l2UGO3emRdt+xhbyoD54UPJ+KD3vBD4GsQT7mpMH34
         ILisfVcJanUay6Vrazjo574/FHnrNZ/JZExVwE9mUqWuaP1Uq9KUhNrfNVKfLd72+gYw
         XurQ==
X-Received: by 10.70.98.170 with SMTP id ej10mr96223166pdb.12.1438185290390;
        Wed, 29 Jul 2015 08:54:50 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c0b:2701:e242:17dc])
        by smtp.gmail.com with ESMTPSA id nz12sm4770667pdb.12.2015.07.29.08.54.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 29 Jul 2015 08:54:49 -0700 (PDT)
In-Reply-To: <vpq8u9zjgzl.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	29 Jul 2015 14:17:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274909>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Wed, Jul 29, 2015 at 12:48 AM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>>> If the user wants whatever she types in the resulting commit
>>>> literally, there is the "--cleanup=<choice>" option, no?
>>>
>>> $ GIT_EDITOR=touch git commit --cleanup=verbatim
>>> [detached HEAD 1b136a7] # Please enter the commit message for your
>>> changes. Lines starting # with '#' will be kept; you may remove
>>> them yourself if you want
>>> to. # An empty message aborts the commit. # HEAD detached from
>>> 5e70007 # Changes to be committed: # modified: foo.txt # # Changes
>>> not staged for commit
>>> : #     modified:   foo.txt # # Untracked files: #      last-synchro.txt #
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> You really don't want that in day-to-day use.

I do not quite follow this example.

The user said "I'll be responsible for cleaning up" by giving the
option.  It is up to the user to use an editor that is something a
bit more intelligent than "touch" to remove the instructional
comments meant for humans after reading them.

> 2) Modify Git to add scissors by default, and use --cleanup=scissors by
>    default.

I just did "$ git commit --amend --cleanup=scissors" (with and
without --amend) and it seems to do exactly that ;-).
