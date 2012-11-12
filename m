From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] send-email: add proper default sender
Date: Tue, 13 Nov 2012 00:42:02 +0100
Message-ID: <CAMP44s0emar-C27SX-FDsUVB6Sevuy4fBFHuO2OD6xELCEjmGg@mail.gmail.com>
References: <1352653610-2090-1-git-send-email-felipe.contreras@gmail.com>
	<20121112233546.GG10531@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 00:42:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY3dy-0007sx-Fa
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 00:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970Ab2KLXmE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 18:42:04 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59028 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539Ab2KLXmC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 18:42:02 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so6842204obb.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 15:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wbKeCb4PSrya9YHiLf3HLacViftiwCDQ9prZCdr7K6w=;
        b=eFLq4HVOB5MFS5g3D0v0lQPo8Y3+WUwwU4dWGt4KALeCCsFcHgEX8uX+eUKWENP8/L
         AWs3Dm46U2ZuGCZLCMHr7rn4PSxotvXOCY06rKq5aMXLGXLjE4XgI87nDgqeuE06iYqu
         3UB9sh9wGegIwDXRA0v8tcYmRQs0hN+zYEMc2l6H1JxYIfXGzO32EsMYeEWl0QQifGRk
         TubIBoAIdMlC2WiKUAHIfsI5NvQRPUrA4DpK4cMsq5nO2POfKRUNYkmFen/+9F9cTYpI
         Ie5IDF8/Mg6q09kDnJl2uWqyBYZQZ4Roqw2DqGnc9WiutuTzII4Zvq34nm+zS+o9i5Ir
         J+JA==
Received: by 10.182.116.6 with SMTP id js6mr16399898obb.82.1352763722165; Mon,
 12 Nov 2012 15:42:02 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Mon, 12 Nov 2012 15:42:02 -0800 (PST)
In-Reply-To: <20121112233546.GG10531@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209549>

On Tue, Nov 13, 2012 at 12:35 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Nov 11, 2012 at 06:06:50PM +0100, Felipe Contreras wrote:
>
>> There's no point in asking this over and over if the user already
>> properly configured his/her name and email.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>
>> I got really tired of 'git send-email' always asking me from which address to send mails... that's already configured.
>
> It should be defaulting to your regular git ident, and you just have to
> hit enter, right?

Yes.

> I think it's probably reasonable to skip that "enter" in most cases. But
> I'm not sure why we ever asked in the first place. What do people input
> there if they are not taking the default?

Beats me.

> Why not use Git::ident_person() here? It saves some code, and would also
> respect environment variables. Or better yet...

I assume there was a reason why that code was asking for input;
precisely because it would use the environment variables. For some
reason the user might have exported GIT_AUTHOR_EMAIL, or maybe EMAIL
is not right, or the full name config.

OTOH user.name/.email configurations come clearly from the user.

>>  my $prompting = 0;
>>  if (!defined $sender) {
>>       $sender = $repoauthor || $repocommitter || '';
>
> Why not just use $repoauthor or $repocommitter, as the prompt default
> already does?

See above.

Cheers.

-- 
Felipe Contreras
