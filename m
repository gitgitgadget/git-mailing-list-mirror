From: Roberto Eduardo Decurnex Gorosito <decurnex.roberto@gmail.com>
Subject: Re: Is there way to set git commit --date to be older than 1970 ?
Date: Wed, 29 Oct 2014 17:03:55 -0300
Message-ID: <CABj5xzcigToDam4JGG9POkaZPh8V=ptEW_F8AO621HA0vCqM8A@mail.gmail.com>
References: <CAOE_JxJp0nA_p_42yOyk_nMjsyMaovj0Fx6AJ5nywiEQfB5XAQ@mail.gmail.com>
 <xmqqh9ymy8np.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Peter Vojtek <peter.vojtek@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 21:04:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjZTh-00089P-M7
	for gcvg-git-2@plane.gmane.org; Wed, 29 Oct 2014 21:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755698AbaJ2UER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2014 16:04:17 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:41171 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755357AbaJ2UEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2014 16:04:16 -0400
Received: by mail-ig0-f173.google.com with SMTP id r10so2013038igi.0
        for <git@vger.kernel.org>; Wed, 29 Oct 2014 13:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=E4vxSwv7jqnuXJiNeboucUYP0+J76kJF6dRDBFLCKok=;
        b=M7NlU3pmui4RbqDwgFSdqUOw+pCDbx9r34Cx1IBdEboCWg0hd3Z+39p/TUQaoeCRT+
         KdowuCTwkz7lvIxNUad7CMeFby5bPYrq/+kJZpyNLRKxZThqmuK/bPfDuKuaFTgrjQkT
         c1qjcKfF1LyZMK7dt/D4mL3XqAc8poH3WH8zOSsfSpNBvbC5mmS/ODJwZAhVxHSccOvs
         lGgEnoaltiFBg6zi3/YNG5IAoaj7v8YZTD9VMpwXgapxm5+oG4wyD0Oy43MzqGs7hjDm
         4gTy/iGs0FyWPG2/yltxTJn0meB9VzBcb1uuN7D9NMxQhvcSQJZalvwsXlap3I69U+CR
         Yl9Q==
X-Received: by 10.50.43.200 with SMTP id y8mr40847537igl.7.1414613056162; Wed,
 29 Oct 2014 13:04:16 -0700 (PDT)
Received: by 10.64.228.99 with HTTP; Wed, 29 Oct 2014 13:03:55 -0700 (PDT)
In-Reply-To: <xmqqh9ymy8np.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peter,

You should be happy of getting the error message.

 Since Git 2 invalid years will default to the current year (keeping
the given day and month) without warnings.

--
Roberto Decurnex

On Wed, Oct 29, 2014 at 4:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Peter Vojtek <peter.vojtek@gmail.com> writes:
>
>> It seems the commit date can be between 1970 and 2100 (on my 32bit
>> linux),...
>
> The underlying data representation records time as number of seconds
> since epoch (1970-01-01).  Theoretically the codepaths that read
> data could consider negative timestamps to represent times before
> the epoch, but in the context of source code control, negative
> values are more likely to be an indication of a bug or a user
> mistake, and I do not think any existing code in Git is prepared to
> pass such a timestamp as a sane value---instead they diagnose a
> failure and die.
>
>> I understand that this is rather an esoteric use case :)
>
> Yeah, this is pretty much outside of what we intend to support.
>
> Thanks.
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
