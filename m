From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: git add without whitespace
Date: Mon, 30 May 2016 14:50:05 -0500
Message-ID: <CAHd499Drdt6GoScdksNNWLrsvG3Dex7fTYNhatL-qboCPW5RZQ@mail.gmail.com>
References: <CAHd499Agn=vLBxDpHi2dy1HMy-_58PZGs7VNtFJnBfP5zXatTA@mail.gmail.com>
	<xmqqlh2r8ixu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 30 21:50:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7TCb-0006i7-MX
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 21:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933475AbcE3TuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 15:50:08 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:35366 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933361AbcE3TuG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 15:50:06 -0400
Received: by mail-vk0-f51.google.com with SMTP id d127so73066770vkh.2
        for <git@vger.kernel.org>; Mon, 30 May 2016 12:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=slhljaAsvLTbnH3bGYwo+aZGF6pR+9L7+CIZiOHVAPs=;
        b=zgefaOeqosUvbM27lCKrHsyXU/FXwdBN/lApxhw14HSicBgJSPaS7qUalp9QdvjQhs
         M4z2BRbETq3hxBqFMt5J3Q4lRe4GYa/0GSsuQ4m9ChmeoqZrZut5SRGO7gK0kMEwX0q5
         LpRTnODPVLTz2idKi8yZwLQjayOiFvXXBM5k1oaN5cdOsjuWKgUl0sElcVTYEHfL3z53
         do2jDayoW6MI/ocMER73KJgQzR/hHvKAF+LxXxbwL68uSJqV0zEFLZF+E3UuQoH4isQ3
         grcHF8u+XH4m+MBhF0O+yrcxZ2mbODZYV0+aTTPudYUzs5TeEgqnrTmvIi9nHd4xCd39
         rNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=slhljaAsvLTbnH3bGYwo+aZGF6pR+9L7+CIZiOHVAPs=;
        b=eRMO9safyaXSG5+LzqcRLy5hMo6T0/tvE7rT/oAd37Jv/TDRUTpQ/eZ8xUmuHlLm/J
         /c8cgS6v15g3dJ25hPcNam1nYXpjG0UlKdY5Q8HXV8k2h7ZqQJWPXBpJk1VWIw3WJMnl
         81vMOv+QTpcB1cAMSJHLpCJTKcbCH0Xxb4pD6UOEJKZcv7MAtxzOMeKvXzXwvuIRKHdg
         2os+HaxV0Mtal3FzD10wQsQYl560T4o6PqdQ2h1bWA+3I6HISbaKVUhbOnMc0mgED3a5
         0HmfRN6W/9sLDNoCmH6DI1zayAynsWCQJuRdVlR+ZAIe1/20LOvs8UQS1ezg3t54OmGk
         TZcg==
X-Gm-Message-State: ALyK8tK1d+ipab+q6y1KLKayKuxGHV61usb28P22AJPHa/7gWXdLLPaW5rZuM1Phdt79rbYOMTtMZ2yKTIrR0g==
X-Received: by 10.31.181.83 with SMTP id e80mr13615527vkf.26.1464637805368;
 Mon, 30 May 2016 12:50:05 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.159.34.134 with HTTP; Mon, 30 May 2016 12:50:05 -0700 (PDT)
In-Reply-To: <xmqqlh2r8ixu.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: 2cfHl9D3zaAPbwjaCn64e80ROi4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295930>

On Mon, May 30, 2016 at 2:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I have had this in my ~/.gitconfig for a long time.
>
> [alias]
>         wsadd = "!sh -c 'git diff -- \"$@\" | git apply --cached --whitespace=fix;\
>                 git co -- ${1-.} \"$@\"' -"
>
> That is, "take what's different from the _index_ and the working
> tree, apply that difference while correcting whitespace errors to
> the index, and check the result out to the working tree".  This
> would _not_ touch existing whitespace-damaged lines that you are not
> touching, and honours the customized definition of what is
> considered whitespace breakage for each paths (which you set up with
> the attributes system).
>

I like your solution better than mine because it utilizes the rules
defined in .gitattributes. I think that's a really good idea. But
other than that, yours is functionally the same as what I'm doing,
right? I just want to make sure I understand: What ends up in the
index/staging area is the code MINUS the trailing whitespace (e.g.
whitespace errors)?

What does the checkout at the end do? That part confuses me (granted
I'm not well-versed with bash script).

Thanks for the feedback. Looks like this is niche enough that an
alias/script is probably the best solution.
