From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [PATCH] rebase -i: Teach "--edit" action
Date: Mon, 10 Sep 2012 12:46:45 -0400
Message-ID: <CADgNja=z7EDTV8_2CU9Uc7w=Dmtp90GrPkDUFSPbucfyrEsBaQ@mail.gmail.com>
References: <1347293683-27996-1-git-send-email-andrew.kw.w@gmail.com>
	<1347293683-27996-2-git-send-email-andrew.kw.w@gmail.com>
	<vpqk3w1j15v.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 10 18:47:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB78W-0005ek-U7
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 18:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756045Ab2IJQqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 12:46:47 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61134 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753771Ab2IJQqp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 12:46:45 -0400
Received: by pbbrr13 with SMTP id rr13so2714470pbb.19
        for <git@vger.kernel.org>; Mon, 10 Sep 2012 09:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nb4bIYCwyMGLXAWHhLK82NG1C2+1HIV7ZDHP27XxbrM=;
        b=erZlIzeKsb2f6/XWQXxaKdgOcfUvP7qNsLpAEUg9Pq/EzpBhgHbioM7zlQLPVdE8HC
         G3xeSRqBDOjud/2q+x2c/f6KB/VF5Ewl+A131foFzegGp1tAXvI7qXFhikD4tVatxPcs
         aGH2IB6gE17btAqj2Hn4NgCaorzfoQBrlUoP1aAH44Ys+jj6qNtBkhRBgmszRCGJAGBE
         PW7EgbXs7SlxiYud1IugThhiFOIrOy7gh9fsUGZjtpTHgbo1O98YK0i/lxLswfITZP0E
         IM5pz4+Cm0jttg0M73lDXai3kvMObsjKg+snEUQXBTxyuJuLU68kWLArO/IoAIddnXf/
         DC3g==
Received: by 10.66.84.6 with SMTP id u6mr22315196pay.75.1347295605446; Mon, 10
 Sep 2012 09:46:45 -0700 (PDT)
Received: by 10.68.8.100 with HTTP; Mon, 10 Sep 2012 09:46:45 -0700 (PDT)
In-Reply-To: <vpqk3w1j15v.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205146>

On Mon, Sep 10, 2012 at 12:25 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Indent with space. Please, use tabs (same below).

Ah, thanks. Good catch.

> Just "edit" may be a bit misleading, as we already have the "edit"
> action inside the todolist. I'd call this --edit-list to avoid
> ambiguity.

I thought that might be a bit confusing too. "--edit-list" doesn't
seem informative about what "list" we're editing though. What about
"--edit-todo"? Any suggestions are welcomed.

> This lacks tests, IMHO, as there are many corner-cases (e.g. should we
> be allowed to --edit-list while the worktree is in conflict?) that would
> deserve to be at least discussed, and as much as possible automatically
> tested.

It does seem risky to do, since we're exposing something that used to
be internal to "rebase -i". Though I don't see harm in allowing
modifications even when there's a conflict, since we're not really
committing anything, modifying index, or any worktree file. As long as
the todo file exists, and we're stopped in the middle of a rebase, I
think editing it shouldn't cause any problems.
