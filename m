From: Orgad Shaneh <orgads@gmail.com>
Subject: Re: git gui replaces amend message when prepare-commit-msg hook is used
Date: Thu, 4 Jul 2013 15:46:27 +0300
Message-ID: <CAGHpTBJhwzLdxiTynx-eBWj7wUwe4e6HPAB4g0jDHTeVF2rfeg@mail.gmail.com>
References: <CAGHpTBKOX8G1PZqE2njQ1UbFJeC_L6WxjnTC5NyT8LSbiBNGXw@mail.gmail.com>
	<20130704103440.GH9161@serenity.lan>
	<CAGHpTB+ObJjqvQ-xfQOdGG+ZSZdCijVZXh1NBp97TZ=hO-QVgQ@mail.gmail.com>
	<20130704111901.GI9161@serenity.lan>
	<CAGHpTBJzwuPw6u=DKUkik5w=hQoCF3F_4wqjuU3UJ528gfcdpA@mail.gmail.com>
	<CALWbr2zAt4a6vkQy8PhP-dH5eZ9_5VMzbiWqSEKE_1V5rsfh+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Keeping <john@keeping.me.uk>, git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 04 14:46:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uuivl-0001bO-Mc
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 14:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980Ab3GDMqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 08:46:30 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35336 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964922Ab3GDMq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 08:46:28 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd20so1599939obb.33
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 05:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QQPhEAV0o4ds1nAtEOoGOJ5jgOyJ7ZOPgghyadA0q54=;
        b=RrUgW1U1i2EN2T06IpriejAhX1q7B1zkF/ccu2z0QBi1PrQJq+vi7/FBU8AeH011h0
         dbESMCURNNOa9RDqV3I7Ti5p/RenGEFWE+952RRgKtYBs9wRKdf2nR394Gumi0781fgs
         YJ8TgzIllFhjX1XOa5u6CKgpVHrS84aTcdj/VIRWZz9DL+gyDhqigpr+/DHXm5yVUAfu
         r25Y+ka9rA+Sh5S6A7blqkGeJY9tD+UZOWYF/D2S3Djv1nJ9XQaq+oCDHx1akNwsrRTG
         jlpDAsnrPR6CUnKNmeECKbuGgxGQsJkvRKNkmVsG1xJmVErulqpFjJpaf/dvU/HVpbKo
         TlWw==
X-Received: by 10.182.237.107 with SMTP id vb11mr5906305obc.84.1372941987613;
 Thu, 04 Jul 2013 05:46:27 -0700 (PDT)
Received: by 10.182.128.72 with HTTP; Thu, 4 Jul 2013 05:46:27 -0700 (PDT)
In-Reply-To: <CALWbr2zAt4a6vkQy8PhP-dH5eZ9_5VMzbiWqSEKE_1V5rsfh+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229581>

On Thu, Jul 4, 2013 at 3:42 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
>>> Your problem is that your hook script is not checking $2 so it is
>>> overwriting the message even when you do not want to do so.
>>
>> No, it isn't. Not by git-gui at least. Check /tmp/hook.log with the
>> hook I provided...
>
> So what you mean is that the hook is not executed with the correct parameters?
> Could you please provide the output of the /tmp/hook.log file (I can't
> reproduce right now) ?

It only runs for "New commit" (possibly with merge or squash as
arguments). In my case the log is:
.git/PREPARE_COMMIT_MSG
.git/PREPARE_COMMIT_MSG
.git/PREPARE_COMMIT_MSG
...

Not running the hook for amend is another problem.

What I referred to was that handling the hook's result is done without
checking if the state has changed while it was running, like Fredrik
has already pointed out.

- Orgad
