From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Fixing segmentation fault when merging FETCH_HEAD
Date: Sat, 19 Mar 2016 21:23:43 -0400
Message-ID: <CAPig+cRVtzLjKTW7FZ-h8thEXkTqBJtbSwpKJs3+wdRHYV1qrQ@mail.gmail.com>
References: <1458411460-26146-1-git-send-email-joseivan@lavid.ufpb.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: "Jose Ivan B. Vilarouca Filho" <joseivan@lavid.ufpb.br>
X-From: git-owner@vger.kernel.org Sun Mar 20 02:23:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahS5t-0002nH-Tc
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 02:23:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932693AbcCTBXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2016 21:23:44 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:34551 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932622AbcCTBXo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2016 21:23:44 -0400
Received: by mail-vk0-f48.google.com with SMTP id e185so181385474vkb.1
        for <git@vger.kernel.org>; Sat, 19 Mar 2016 18:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=o6fVMGdiov81Y1mrne8bVVigtpc86RS6EoWIFYnQnfA=;
        b=oWYv6rAPhWkU40o/di+Vr7u7mveF+2rEL6Lh8P5zEq1uiaN2U53/huH/kJ+PqB6BQl
         DMmpob1Fu/S0+dEfELasxFN5i25pYOHILgXMMzhzWWkY4e8LMD0XkcqbkLu9MH8XOiu1
         MLPPzT57K1eI9CMJ5Q6QLAj8PzPolQ+noogowIFBgSyCwcWBjCHF76FOTjdj7q5PWcTX
         TIUF/wf74sLqO7sKdyqTc2qEYdmh0i0GPLpg+mOmm+FVGheX6NeWZbOanH5Bja2zEktE
         i7FszeoVWELqPb9jYOFJYooiN5c513Mc8wA1kZX35BRBBr656pTmdAxXPlZK9lG0UW0s
         R+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=o6fVMGdiov81Y1mrne8bVVigtpc86RS6EoWIFYnQnfA=;
        b=EF8Wm4GOo6Ggk+Bp2JNplzYw/27b6OjLZL9LSofNgMuE3fjyzokINTzKqL2Aqnm7F3
         zaWqEEcVG1p02/wVL21GsWZVHLDdeRXruUBwr8GLcO7pHwpVzBcUzPShCiUlI0kLOSmS
         vMuZBNsOnwZKjHoiVWTKZNjMp/9o8bxSsdgwLHUUvtf/65K7uZQytwQtYZM4h+FRpO2Q
         fXm4WF7gFE77cFQ82oqKK0BP18xBPsVZq0aVkniaSLGDnUk0JsOkm4QJ4DUruV0Sqd1Q
         zjN85kyEnuulIL8LsIWz0sgxQWH6jcdjjAdVQ7d4nDChHqC4fYAT6P7tSpjQBBnijWfl
         8DPg==
X-Gm-Message-State: AD7BkJJrWa/ZmDGkBtVEbi4VKEaO0sYNpC+mOBJIaBkTtq50JSghhNYvnnGSXU8WJL+6jXGWMDf5oe2E/oUiEw==
X-Received: by 10.176.2.238 with SMTP id 101mr850093uah.139.1458437023192;
 Sat, 19 Mar 2016 18:23:43 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Sat, 19 Mar 2016 18:23:43 -0700 (PDT)
In-Reply-To: <1458411460-26146-1-git-send-email-joseivan@lavid.ufpb.br>
X-Google-Sender-Auth: 2wCAx-CEOn_0bji3VnjpbeU8MqM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289326>

On Sat, Mar 19, 2016 at 2:17 PM, Jose Ivan B. Vilarouca Filho
<joseivan@lavid.ufpb.br> wrote:
> From: "Jose Ivan B. Vilarouca Filho" <joseivan@lavid.ufpb.br>

You can drop this line since it is the same as the From: line in the
email envelope.

> Fixing segmentation fault when merging FETCH_HEAD

Alternate:

    merge: don't dereference NULL pointer

> A segmentaion fault is raised when trying to merge FETCH_HEAD
> formed only by "not-for-merge" refs.
>
> Ex:
>     git init .
>     git remote add origin ...
>     git fetch origin
>     git merge FETCH_HEAD

Can you add a test to ensure that some future change doesn't regress
this fix? The above recipe would make a good basis for the new test.

> Signed-off-by: Jose Ivan B. Vilarouca Filho <joseivan@lavid.ufpb.br>
> ---
> diff --git a/builtin/merge.c b/builtin/merge.c
> @@ -1270,9 +1270,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>                             "an empty head"));
>                 remoteheads = collect_parents(head_commit, &head_subsumed,
>                                               argc, argv, NULL);
> -               remote_head = remoteheads->item;
> -               if (!remote_head)
> +               if ((!remoteheads) || (!remoteheads->item))

Style: drop unnecessary parantheses

    if (!remoteheads || !remoteheads->item)

>                         die(_("%s - not something we can merge"), argv[0]);
> +               remote_head = remoteheads->item;
>                 if (remoteheads->next)
>                         die(_("Can merge only exactly one commit into empty head"));
>                 read_empty(remote_head->object.oid.hash, 0);
> --
> 1.7.10.4
