From: David Aguilar <davvid@gmail.com>
Subject: Re: [RFC PATCH 2/3] mergetools/kdiff3: allow opting-out of auto-merges
Date: Fri, 10 May 2013 11:40:50 -0700
Message-ID: <CAJDDKr4RUzFXJpuFjCV00TE0ZmrzZzVC4uO=2uJVSxoY_==JcQ@mail.gmail.com>
References: <1368090810-40596-1-git-send-email-davvid@gmail.com>
	<1368090810-40596-2-git-send-email-davvid@gmail.com>
	<7vli7ob0c4.fsf@alter.siamese.dyndns.org>
	<20130509172334.GK25912@serenity.lan>
	<7v38tw9d7r.fsf@alter.siamese.dyndns.org>
	<CAJDDKr4S6=U1d1fWixaiAzf46KLBDNsi85fgvXy0Uu_aRJyoyw@mail.gmail.com>
	<20130510054130.GA29215@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>,
	"Theodore Ts'o" <tytso@mit.edu>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri May 10 20:41:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UasFU-0008UA-DQ
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 20:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186Ab3EJSkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 14:40:52 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:42331 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003Ab3EJSkv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 14:40:51 -0400
Received: by mail-wg0-f50.google.com with SMTP id m15so4256411wgh.17
        for <git@vger.kernel.org>; Fri, 10 May 2013 11:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=invCuXVvgM5NEqoU3wAaSBKvrHaThdzlJf/f9pzA1Js=;
        b=VnkaaJNk29/IdNw5E+IV+a91DtZizVaO4XJxBYrB50rG+8UsM0PhSU1TDacLZHfJNs
         KjPhGcnu7uKjJUugqk6uItaXJzVaZfBRdfuCuGqNhwQ7RokWhAzb/zpq5x64RM9rLKLp
         WoiIAZynCrXlNbtp/dsWT3dUOEEjYsPk5IXyaLm6tCi11Z7ms/9DqHMsbbE4GQfxhNDa
         NpIaUI6OHa0Bx9rMg8Wy1kOCcYxXtZWq9ziu6jPUq7kwDsML+Ek+gwCcK5vtWJ1lEAeU
         NFSvQbl48g694bya1JB/7+w5LLvVk8xqRebgUCzsopqb+4M315lXGpcB0aE186g/I6Rn
         Z5VA==
X-Received: by 10.180.105.195 with SMTP id go3mr5729520wib.2.1368211250704;
 Fri, 10 May 2013 11:40:50 -0700 (PDT)
Received: by 10.194.240.195 with HTTP; Fri, 10 May 2013 11:40:50 -0700 (PDT)
In-Reply-To: <20130510054130.GA29215@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223893>

On Thu, May 9, 2013 at 10:41 PM, Charles Bailey <charles@hashpling.org> wrote:
> On Thu, May 09, 2013 at 03:17:30PM -0700, David Aguilar wrote:
>> Generally, "mergetool.<tool>.cmd" is not general enough since we've
>> always special cased the base vs. no-base code paths and we run
>> different commands depending on whether a base is available.
>
> Then this is a deficiency of the ".cmd" mechanism which should provide
> an "if all else fails" way to do things, even if ugly. We could simply
> add a BASELESS variable to the eval environment of the custom command.
> (Do we always create an empty file for $BASE, now?)
>
>> We could drop --auto altogether, which maybe is a better course of
>> action since it makes the behavior predictable and un-surprising, but
>> I do not know if anyone has come to rely on kdiff3's "auto-merge"
>> feature (hence the extended Cc: list).
>
> I disagree, I think that a mergetool should be allowed to be as
> helpful as possible and if it can resolve the merge unaided then this
> is no bad thing. I've worked with a number of people who were very
> happy with the current kdiff3 behaviour. Nothing prevents you from
> verifying the merge and fixing it up if it wasn't done perfectly by
> the tool, although I haven't ever encountered this with git+kdiff3.

That's the bit of info I was needing.

I can always tell the one person who ran into this that "that's how it
is" and explain why it's a good thing.

"one person" < "number of people" so it's an easy decision, and we
don't need to make the tool worse to cater to someone that's new to
git.

Thanks Charles,
--
David
