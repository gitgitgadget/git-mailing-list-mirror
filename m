From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] commit: disable status hints when writing to COMMIT_EDITMSG
Date: Wed, 11 Sep 2013 05:13:05 -0400
Message-ID: <CAPig+cRfgSrSMHT0OX0H=uh-Wi3TceU+UN8gUH4La1RTpRLETQ@mail.gmail.com>
References: <1378890539-1966-1-git-send-email-Matthieu.Moy@imag.fr>
	<1378890539-1966-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	javierdo1@gmail.com, Jonathan Nieder <jrnieder@gmail.com>,
	judge.packham@gmail.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Sep 11 11:13:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJgU4-0008AN-M2
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 11:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770Ab3IKJNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 05:13:08 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:51611 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150Ab3IKJNH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 05:13:07 -0400
Received: by mail-la0-f42.google.com with SMTP id ep20so7353236lab.1
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 02:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QQxkxDeAnarDFv0zHqfIeKa3/rf+HdD+OdKKtvNsAOI=;
        b=SYdEv0gbw51xqfcLXB9+goQ42e7UCwfhSYnZMl2jLSFoMsKoOb6GuhrqNeN5PUnGxz
         X4d8WGr2A80ls7C9TpJ7X3L+gWniqWyPcoSLJDJxxURTU0Cyt3X2thMIWWqipsPcU5+X
         19itWBKwx47c4fRb9n6kOzVHnrDobRY+mziqBuB22xEa6GblEBbXqaRSmLUK8FqS5Ji1
         R+chhfdeQOViv5/WDkWkRLwCmYAoUf3yhyHLAW9OIfSacAaPiiAbfHXtNPy+KHnu6HIj
         EyoYRXagVi2FM0cT8qyFEvdhesVpEZfdYG/OzBeiK33yNZHENu9tuvUyiovztkt2FWpY
         +f+g==
X-Received: by 10.152.36.98 with SMTP id p2mr484503laj.14.1378890785467; Wed,
 11 Sep 2013 02:13:05 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Wed, 11 Sep 2013 02:13:05 -0700 (PDT)
In-Reply-To: <1378890539-1966-2-git-send-email-Matthieu.Moy@imag.fr>
X-Google-Sender-Auth: ZpHiPmaSl1KsjwrVKSL9VjUGNUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234554>

On Wed, Sep 11, 2013 at 5:08 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Most status hints were written to be accurate when running "git status"
> before running a commit. Many of them are not applicable when the commit
> has already been started, and should not be shown in COMMIT_EDITMSG. The
> most obvious are hints advising to run "git commit",
> "git rebase/am/cherry-pick --continue", which do not make sense when the
> command has already been ran.

s/ran/run/

> Other messages become slightly inaccurate (e.g. hint to use "git add" to
> add untracked files), as the suggested commands are not immediately
> applicable during the edition of COMMIT_EDITMSG, but would be applicable

s/edition/editing/

> if the commit is aborted. These messages are both potentially helpful and
> slightly misleading. This patch chose to remove them too, to avoid
> introducing too much complexity in the status code.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
