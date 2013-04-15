From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Mon, 15 Apr 2013 22:15:54 +0530
Message-ID: <CALkWK0nrVZo3MSgqpPmX2+T3JJ8uP=hzH3PMv+qd4ZaqNVwEsw@mail.gmail.com>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
 <1365887729-9630-4-git-send-email-artagnon@gmail.com> <vpq38us2oov.fsf@grenoble-inp.fr>
 <CALkWK0mdC_tK2CGqAa67fr189PQCjSjzAOPujipOHFfoiYW0qA@mail.gmail.com>
 <vpqppxvoqsc.fsf@grenoble-inp.fr> <CALkWK0nqrw7DFQSnMvULYjJtBHRnadKWqCLQOAjzJH0o7USo+A@mail.gmail.com>
 <vpqwqs3lqlf.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 15 18:46:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URmYC-0008QL-Ue
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 18:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635Ab3DOQqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 12:46:37 -0400
Received: from mail-ia0-f170.google.com ([209.85.210.170]:62048 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535Ab3DOQqg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 12:46:36 -0400
Received: by mail-ia0-f170.google.com with SMTP id j38so4545680iad.15
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 09:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=eDuD/8OADPkAGs4LrB1sCuNSKyzhsiEHXnSEmRCpAwM=;
        b=jbY3qX3TiR5sLjLR2tA1vfpJhByPfkl1+T53mJke31u1TY0j0e1bLAyrqF+7wiQrjp
         WJ5u+Ee6yGUVgR8z/Aw5m5aYAkqnm6edK+Pc+Qc7w1rrZQjvwN6K2wmHty7y2hTmSHPd
         TVYBMkG/mSH8mwMcU0k/BWYum4yTMU7WsJ0U+jejygnckf8GaS7y3Cp8LKRzk0FqCWNx
         gP1d5glJrriFd90zE19NyanyHJTO/00U5TyuBP6NDQLhIa0KTxDf5f50iJEDsaLisui1
         YqMR+1gZBLcoXimcn/azrbZ/1Y7WUWj/hKK3gBvC6s4j6AlyJ7k2Mw3TKZVCf7IKnW3A
         yxoA==
X-Received: by 10.42.204.79 with SMTP id fl15mr12145362icb.57.1366044395968;
 Mon, 15 Apr 2013 09:46:35 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Mon, 15 Apr 2013 09:45:54 -0700 (PDT)
In-Reply-To: <vpqwqs3lqlf.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221252>

Matthieu Moy wrote:
> No, you don't. Just try if you're not convinced:

Oh, I trusted the documentation on this one and never tried with a
dirty worktree myself.  Please fix the documentation, if you know how
exactly to correct it.

> No, I'm not proposing to do anything for merge. There's no reason to try
> being uniform in conflict resolution for pull-merge and pull-rebase as
> it is already different now. We already have "git rebase --continue", we
> don't have "git merge --continue". So what? The fact that merge doesn't
> have the equivalent doesn't mean we should not do something for "rebase
> --continue".

Well, you can't blame me for the misunderstanding then.

In a previous email, you wrote:
> Shouldn't this belong to "git merge" instead (i.e. implement "git merge
> --autosquash" and call it from "git pull")? Users doing "git fetch &&
> git merge" by hand should be able to use --autosquash, I think.

Junio's criticism of pull.autostash hurting pull-merge people is
cogent; my current plan is to ditch pull.autostash altogether, and
implement rebase.autostash for the reduced case of a non-interactive
rebase.
