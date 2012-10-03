From: Phil Hord <phil.hord@gmail.com>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 3 Oct 2012 08:59:11 -0400
Message-ID: <CABURp0pbX4Fk4sNWCicfF7Gm52-KTMBrasdi_XHnjtE2zmSBFg@mail.gmail.com>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
 <506AA51E.9010209@viscovery.net> <7vzk449449.fsf@alter.siamese.dyndns.org> <CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 15:01:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJOYO-0001c4-5V
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 14:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780Ab2JCM7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 08:59:34 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:34727 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932145Ab2JCM7d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 08:59:33 -0400
Received: by lagh6 with SMTP id h6so2957625lag.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 05:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mCy69vCFnePimkr32PJ5FQDBUlkuZ5gvlupSrqOfs9U=;
        b=WRxaipFKv7YUJEvPrdGEeKTYdTo9P+xcTgYz4VmaheVuRRdTvbffTFnmaCsI8hrR8Q
         qXBIJySLHCekIrI+4Pe/7JCAIJ7ED006dkofOEtJFu2qCMvvQ78ycA/UmgftWYW2LSKz
         cRkPUjGZZ7bwtXSMNn4B6THBQgm0Uh/9Mzo9l7jUP0wM9Y1GE+CcuuvIwWg9kY8WfsUw
         Mbvjv+1CG8Bcgo0Q6ujb1PZTArg6uIYvGEbHyNN9JSvU7h9nhhymLMTcEInvSwfkXxBC
         wfeafCDixGblg793nz0ZV9VhJxEAm0HkMMpU9+FXREOq//3K3rk21gzwskBK+nJTYG6F
         oDGQ==
Received: by 10.152.47.112 with SMTP id c16mr1648681lan.50.1349269171313; Wed,
 03 Oct 2012 05:59:31 -0700 (PDT)
Received: by 10.114.17.225 with HTTP; Wed, 3 Oct 2012 05:59:11 -0700 (PDT)
In-Reply-To: <CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206888>

On Tue, Oct 2, 2012 at 3:34 PM, Angelo Borsotti
<angelo.borsotti@gmail.com> wrote:
>
> "Usually recording a commit that has the exact same tree as its sole
> parent commit is a mistake, and the command prevents you from making
> such a commit. This option bypasses the safety, and is primarily for
> use by foreign SCM interface scripts."

Perhaps the confusion arises from the the meaning of "the safety".  In
this case, the safety mechanism in place is to prevent you from
creating a child commit which has the same "tree" contents (working
directory) as the parent commit.  It will not be the same commit
because it has different parent(s) than its parent commit; but the
tree (working directory) is the same and git normally prevents you
from doing this because normally this is an accident, a mistake.

--allow-empty tells git you intend to do this and so it should bypass
this "no changed files" safety mechanism.  It is not a safety to
prevent you creating a new commit with the exact same sha1; the safety
is concerned only with the exact same "working directory" file
contents.

Can you suggest a rewrite of this description which would make it more clear?

Phil
