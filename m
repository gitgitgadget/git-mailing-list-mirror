From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 1/4] builtin: add git-check-mailmap command
Date: Thu, 11 Jul 2013 13:47:38 +0700
Message-ID: <CACsJy8ADu+RNCgqHQG20nC+0S7sZKwMCg=yX+i906dwhvFrEtQ@mail.gmail.com>
References: <1373483041-27901-1-git-send-email-sunshine@sunshineco.com>
 <1373483041-27901-2-git-send-email-sunshine@sunshineco.com>
 <CACsJy8C6_ycum9RfxgfB0Xa2U7Fk02NyED5VvH6o1pExkcV6vA@mail.gmail.com> <CAPig+cRxuqOvRZQ5WZmUWruvEQytYM+RduYdkkN4_f8UdcuQnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Marius Storm-Olsen <marius@trolltech.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 08:48:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxAfn-0007bM-D5
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 08:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755591Ab3GKGsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 02:48:10 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:54896 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755480Ab3GKGsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 02:48:09 -0400
Received: by mail-ob0-f176.google.com with SMTP id v19so9445681obq.21
        for <git@vger.kernel.org>; Wed, 10 Jul 2013 23:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7sSmH+OQlBISrqfUPxIlQ28mssYqQFB9h0YhJ5hc5J4=;
        b=jlBZeXLF6KGfRrrj1NZjhu0vLM/WA3veCpHpyJITbKKhZ2xh8E9c2CZzu99GUj1Wqh
         uoQtsNfGpBO/BgPD5OVQZLRWIHa/FYdNNiDOo4O7Lpdq1pPJjqmjxp9/ywemzOWcOhf4
         5X5A75eW4TejzDjd68gTGMmTGODqsnbFjHhsiPD79sqpldeiuc+PK5c30y3WTlQNfNeX
         jGdGkmr6oQjOhii6bZSoIH8YyDaHKbaf92iVLx3qqIw8p3y786vUPZu8oWzNRHncpSvF
         M/s8d9cgo21ySp9je3ktZV3GbOSxyISuDUF4kXbMgsYYs5arTagDUymdkr+R0frdpsw/
         6AWQ==
X-Received: by 10.60.97.74 with SMTP id dy10mr30239847oeb.27.1373525288492;
 Wed, 10 Jul 2013 23:48:08 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Wed, 10 Jul 2013 23:47:38 -0700 (PDT)
In-Reply-To: <CAPig+cRxuqOvRZQ5WZmUWruvEQytYM+RduYdkkN4_f8UdcuQnQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230077>

On Thu, Jul 11, 2013 at 12:50 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> +       maybe_flush_or_die(stdout, "contact to stdout");
>>
>> On error this function will print
>>
>> write failure on 'contact to stdout'
>>
>> maybe maybe_flush_or_die(stdout, "write contact to stdout") or
>> something? From i18n point of view, maybe_flush_or_die should not
>> compose a sentence this way. Let the second argument be a complete
>> sentence so that translators have more freedom. But that's a different
>> issue.
>
> Indeed, it's not ideal. I chose "contact to stdout" for consistency
> with other callers, not because of a fondness for it.
>
>   % git grep maybe_flush_or_die
>   builtin/blame.c: maybe_flush_or_die(stdout, "stdout");
>   builtin/check-attr.c: maybe_flush_or_die(stdout, "attribute to stdout");
>   builtin/check-attr.c: maybe_flush_or_die(stdout, "attribute to stdout");
>   builtin/check-ignore.c: maybe_flush_or_die(stdout, "check-ignore to stdout");
>   builtin/check-ignore.c: maybe_flush_or_die(stdout, "ignore to stdout");
>   builtin/hash-object.c: maybe_flush_or_die(stdout, "hash to stdout");
>   builtin/rev-list.c: maybe_flush_or_die(stdout, "stdout");
>   log-tree.c: maybe_flush_or_die(stdout, "stdout");
>
> They seem pretty evenly split between just "stdout" and "foo to
> stdout". (I actually prefer plain "stdout" and will happily change it
> to that.)

Then probably stick to the convention. If this i18n thing is fixed, it
has to be fixed everywhere anyway.
-- 
Duy
