From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH v3] worktree: add 'list' command
Date: Tue, 11 Aug 2015 07:42:51 -0400
Message-ID: <CANoM8SUznDcZyH6-O9W2ZS7mwwevUz5ZwX4L_fVFV1cgRrF5xA@mail.gmail.com>
References: <1439239982-42826-1-git-send-email-rappazzo@gmail.com>
 <1439239982-42826-2-git-send-email-rappazzo@gmail.com> <1439261725.5283.9.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 13:43:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZP7xc-0002r4-45
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 13:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbbHKLnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 07:43:12 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:35721 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934168AbbHKLnL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 07:43:11 -0400
Received: by obbop1 with SMTP id op1so146384002obb.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 04:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tI1dGgq4KDkQTa+QA8jtz6EjZAxZiDB8xQWXXDVbpQU=;
        b=vXSyeWZ4RbFjpssgTR5qjuEAgwuHRhvCYKrZT7eQiknyIVx+hXVEPe2h7xNtL9EVcJ
         ihOx7I9ABUZ521holMUV3rXvt0XJCz4JYkPNktNWsGe3ZKxCoNioD1HYAbBYufiOd6Ie
         7Fvt52MjojXVxxYnVwHC/sgLGO12Nt5yRVVfRAyyTFcfhO/8lg5NOUhs99u95j8lqvr9
         PSJWiDC/U3xLtrxjsHCRw+setrulPx+awqCjT64UsdzXg9m9KdORQW2SGmk31axzFA2E
         f+oKhAIeC3Q2IagbXgzN3zCDtWiazKBghzsQrnHKSoutueIO5Rqz1RqMitgEEGh0dxCh
         G3Ig==
X-Received: by 10.60.145.228 with SMTP id sx4mr23705049oeb.79.1439293390692;
 Tue, 11 Aug 2015 04:43:10 -0700 (PDT)
Received: by 10.202.232.213 with HTTP; Tue, 11 Aug 2015 04:42:51 -0700 (PDT)
In-Reply-To: <1439261725.5283.9.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275684>

On Mon, Aug 10, 2015 at 10:55 PM, David Turner <dturner@twopensource.com> wrote:
> On Mon, 2015-08-10 at 16:53 -0400, Michael Rappazzo wrote:
>> +                     while ((d = readdir(dir)) != NULL) {
>
> I think it would be useful to break this loop out into a
> for_each_worktree function.
>
> While looking into per-worktree ref stuff, I have just noticed that git
> prune will delete objects that are only referenced in a different
> worktree's detached HEAD.  To fix this, git prune will need to walk over
> each worktree, looking at that worktree's HEAD (and other per-worktree
> refs).  It would be useful to be able to reuse some of this code for
> that task.
>

I agree, but I will save that for another round.
