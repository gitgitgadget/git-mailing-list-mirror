From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] Flags and config to sign pushes by default
Date: Fri, 14 Aug 2015 14:03:34 -0700
Message-ID: <xmqqk2sxh9ax.fsf@gitster.dls.corp.google.com>
References: <1439492451-11233-1-git-send-email-dborowitz@google.com>
	<xmqqbne9ivry.fsf@gitster.dls.corp.google.com>
	<CAD0k6qSjZW-5eMw-OOHP0cGdj08PesdKVgE9OAFvESwCueyH6w@mail.gmail.com>
	<xmqqwpwxha4r.fsf@gitster.dls.corp.google.com>
	<CAD0k6qR2HkHHYu8429mvdvN1bkLeTpD-5EbO4Mt+o69rC+P6aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 23:03:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQM8b-0003o7-36
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 23:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017AbbHNVDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 17:03:37 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35674 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722AbbHNVDg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 17:03:36 -0400
Received: by pacgr6 with SMTP id gr6so66867293pac.2
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 14:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=l5KJPgFq61QzURDA42J5ZVwvWWr9UAcHfooTEbnIK4s=;
        b=Hef+QUbAoJ1x+eMDc7Mi/HMBtrRerDRUJ9ypZfvStunKxKDzBdoYNSc47+kBLv+vB7
         dWZm7D/YWaqUDWYuUnsPT9v5+c1lLJoFZXJfQF5c5hHVQzHMn7J9WIiCKbw4aRN70AvH
         1Xy8Lf0/otV1e5lIWQ8AjRTI2SN5i/zBsXaubPn4d4b4dzb4nSzWNJdC+hYfv/pcZIfQ
         IvSFJ/Gs3/H4HLN9gGZyLgoUasA49ovH63Nudro3zfSSmujXJSmUnBoe/MetFG5h+Ku3
         ldr9/xHXh/C0CmCbxgZ8BTBA6YHbSxXj7SyBLNrCqX0Mm0Cr1i4Gh6hSvZ8WLwXI9KGk
         zEZQ==
X-Received: by 10.68.198.37 with SMTP id iz5mr90839482pbc.129.1439586215875;
        Fri, 14 Aug 2015 14:03:35 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a820:aa0d:2b52:954f])
        by smtp.gmail.com with ESMTPSA id hz5sm7010889pbb.39.2015.08.14.14.03.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 14 Aug 2015 14:03:35 -0700 (PDT)
In-Reply-To: <CAD0k6qR2HkHHYu8429mvdvN1bkLeTpD-5EbO4Mt+o69rC+P6aQ@mail.gmail.com>
	(Dave Borowitz's message of "Fri, 14 Aug 2015 16:55:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275953>

Dave Borowitz <dborowitz@google.com> writes:

> Ok, so let us bikeshed a bit further.
>
> Bikeshed 1.
> Option A: --signed/--no-signed--signed-if-possible
> Option B: --signed=true|false|if-possible, "--signed" alone implies "=true".
>
> Bikeshed 2.
>
> Option A: if-possible
>
> The possibly confusing thing is one might interpret missing "gpg" to
> mean "impossible", i.e. "if gpg is not installed don't attempt to
> sign", which is not the behavior we want.
>
> I don't have another succinct way of saying this.
> "if-server-supported" is a mouthful. I think Jonathan mentioned
> "opportunistic", which is fairly opaque.

I would call what we agreed is a good behaviour during this
discussion "--sign-if-asked".
