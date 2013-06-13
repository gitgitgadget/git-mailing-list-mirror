From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/6] status: do not depend on flaky reflog messages
Date: Thu, 13 Jun 2013 23:45:41 +0530
Message-ID: <CALkWK0=FLerEwaLzSbiT0fuBApgJFcH1eLfnLHQTCHFYvDm=DA@mail.gmail.com>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
 <1371130349-30651-6-git-send-email-artagnon@gmail.com> <7vvc5hubox.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 20:16:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnC4Q-0006fW-E7
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 20:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758262Ab3FMSQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 14:16:22 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:43082 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754414Ab3FMSQV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 14:16:21 -0400
Received: by mail-ie0-f170.google.com with SMTP id e11so11545038iej.29
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 11:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EnE5hiI9ARsxpAm08+e8YV6qF+/i5Zq9GofGh+uEkaQ=;
        b=Twxy3Ka3tknYt3wJLvUh+NhUVvVwXPHgZLDm26pgpwEeVDBqT20EVCjBlpv3EqYNEC
         MVk8owheeD1xTZa39nLHBBAbFX0DL0fOrsDZEm1c5g0LbRPLBxzVyFdCh2+VhYoh+Y73
         3RW8s9TQzrUaRBBICD2XkJsMTgtSF0kzBk0N+dWoVE2qgeGdNtMigbnRG0hOXUc8wZEy
         HrE3nVVxjdaGTDxrHcZZ3NJvIerA6XcVh+uRlPk2hRiu1YdYOeF21gGYSFWHu5TQDo5I
         4z1TMgCORiZJnuMAfaCf6ofvBafTlNA8aT+37MP/mWOhWml9ZqevQKATOUgiixiTPQ7A
         gXnQ==
X-Received: by 10.50.3.37 with SMTP id 5mr941206igz.0.1371147381506; Thu, 13
 Jun 2013 11:16:21 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Thu, 13 Jun 2013 11:15:41 -0700 (PDT)
In-Reply-To: <7vvc5hubox.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227761>

Junio C Hamano wrote:
> [...]

I'd just like to point out quickly that I first attempted to write 6/6
without this patch.  It is absolutely impossible, because the
"detached HEAD from/to" messages no longer make any sense when
checkout starts respecting GIT_REFLOG_ACTION.  At that point, I'm was
just monkeying around the trash-directory running describes to somehow
try and make the expected output equal to the actual output.  There
was no method to the madness, and I was literally losing my mind.

This is _the_ patch that makes this series possible.

If you want to be convinced, please attempt to drop this patch and fix
the tests in 6/6.  You will see what I mean.
