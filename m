From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/5] t1508 (at-combinations): more tests; document failures
Date: Thu, 2 May 2013 14:37:46 +0530
Message-ID: <CALkWK0=B_Ym_ei181eV-WeqJZJyHPv-AmLzYwajm13wftJkB6g@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
 <1367425235-14998-2-git-send-email-artagnon@gmail.com> <7va9oe5y6k.fsf@alter.siamese.dyndns.org>
 <CAMP44s31jyuGGG1Wn9D=D9udkJJdXQfwVAnHuOg02FWinpmn7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 11:08:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXpV9-0001RM-SY
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 11:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953Ab3EBJI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 05:08:27 -0400
Received: from mail-ia0-f179.google.com ([209.85.210.179]:41946 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746Ab3EBJI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 05:08:26 -0400
Received: by mail-ia0-f179.google.com with SMTP id g4so296756iae.10
        for <git@vger.kernel.org>; Thu, 02 May 2013 02:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=KgUE4OJ3Ov0NoLITuyqvNc8D/vo9P5px1K8iAxQDQxQ=;
        b=x76lOZI8K2ALvYft+r8OMBAEQfjbujlYr4Rrc2simA2k0+KLSjI2TDw6mEyeoXHfR7
         jBRf585mT6HtC7rkX1W8X8Ox9DDzXrOgt3qEpx2xebiUetLHxvNXyKpI9XkZpWIq21qN
         x8Nn1yP/mUetPaUuF0OZru++Ipe44Sj37Xi0Nk/xZv2mTbthi6GZdTL++xRpg1cNQjoW
         bexgXCQyqNn0YcildIKeddWtYcncDaQmJCQ/WZnMa5vywb9/38GoLokez23y3AJoFM/B
         UzRs05mm8WG+KhVsVdrIP3vRNpmwZUSiGPepv27LrHv9fITNyrAnZkCP0d1GbiULer/U
         e0LA==
X-Received: by 10.50.66.197 with SMTP id h5mr14422252igt.63.1367485706474;
 Thu, 02 May 2013 02:08:26 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 2 May 2013 02:07:46 -0700 (PDT)
In-Reply-To: <CAMP44s31jyuGGG1Wn9D=D9udkJJdXQfwVAnHuOg02FWinpmn7Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223183>

Felipe Contreras wrote:
> [...]

Yes, I'm working on a re-roll.

> Moreover, the symbolic-ref 'HEAD' is quite special, it's mentioned
> everywhere in the documentation, and the code has special cases for
> it. It's not reasonable to expect all relevant places to be updated
> for this functionality, and certainly 'Documentation/revisions.txt' is
> not the only one.

I'm not denying that HEAD is special.  I'm just improving the general
support for symbolic-refs, so that the difference between HEAD and any
other symbolic-ref is smaller.

> For example, in Ramkumar's approach:
>
>  % git branch -u master @
>
> Would replace '@' with HEAD, however:
>
>  % git branch --edit-description @
>
> Would not.

git branch -u master <any symbolic ref> will work just fine.  It has
nothing to do with my series.

Does git branch --edit-description HEAD work?  Then why do you expect
git branch --edit-description <any other symbolic ref> to work?  git
branch --edit-description operates on non-symbolic refs.

Let me make this clear: @ is just another symbolic-ref that always
points to the same thing as HEAD.  Nothing less, nothing more.

> In my opinion, if 'git branch X @{-1}' doesn't work, neither should
> 'git branch X @', and that's what my approach does.

Why shouldn't (doesn't) git branch X @{-1} work?  git branch X <any
expression with or without a symbolic ref> works fine, and it has
nothing to do with my series.
