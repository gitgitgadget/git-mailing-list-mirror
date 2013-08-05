From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-hg: add shared repo upgrade
Date: Mon, 5 Aug 2013 14:31:18 -0500
Message-ID: <CAMP44s0Wsnqs_t5kJb0Le13MrzN9WNRTrtNEuXHrDU6D7AKjLg@mail.gmail.com>
References: <1375730567-3240-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Joern Hees <dev@joernhees.de>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 21:31:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6QV2-0008Lz-RO
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 21:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690Ab3HETbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 15:31:21 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:42864 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754590Ab3HETbU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 15:31:20 -0400
Received: by mail-la0-f44.google.com with SMTP id fo12so2411937lab.31
        for <git@vger.kernel.org>; Mon, 05 Aug 2013 12:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/gBM2XdwA/63JLzIetSK6ww04RHtMSWC1Dm33Nj7fcM=;
        b=Tp8pBBMo38ZC4np9kBIJZXalUQZquZkUp9RzU53TQVhU7LEbQoKC4zlMlrMqWQzwSA
         tHPU4qa4aPDqV5XHtW2mJrYHAJRP/Imn/r/88hnsgJAKLRPuMVGRNzYtErSSQF2yTtXL
         dj2gW7OBFODncDvIFhsM9KmRZHjYQZQwzZ43+lfaqYl6LDOh+J89PCzCLVAzXQ6i/L0X
         GhgU6HteMabRbAhmtU3YeyrgqbQdHH3NqwStkEt7H/GT7c9qLAQ6vujxnMeMMUGEp4+N
         T+OVkYYBByx9jeVGq7MxkmbXFLjFfAzxz9MMTlifVq4//B4aNa7OewA03gtQHWZpBxr4
         ytZg==
X-Received: by 10.152.9.194 with SMTP id c2mr9411674lab.83.1375731078527; Mon,
 05 Aug 2013 12:31:18 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Mon, 5 Aug 2013 12:31:18 -0700 (PDT)
In-Reply-To: <1375730567-3240-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231695>

On Mon, Aug 5, 2013 at 2:22 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
> From: Felipe Contreras <felipe.contreras@gmail.com>
>
> 6796d49 (remote-hg: use a shared repository store) introduced a bug by
> making the shared repository '.git/hg', which is already used before
> that patch, so clones that happened before that patch, fail after that
> patch, because there's no shared Mercurial repo.
>
> It's trivial to upgrade to the new organization by copying the Mercurial
> repo from one of the remotes (e.g. 'origin'), so let's do so.

In addition to that, simplify the shared repo initialization; if the
repository is shared, the pull on the child will use the parent's
storage, so there's no need for the initial clone.

And make sure the shared repository is always present.

It seems pretty clear to me that we are talking about multiple patches here.

-- 
Felipe Contreras
