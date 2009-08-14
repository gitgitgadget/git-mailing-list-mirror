From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH 1/2] add a --delete option to git push
Date: Thu, 13 Aug 2009 23:40:44 -0700
Message-ID: <fabb9a1e0908132340n10da3e38kfab07ab2cff18c82@mail.gmail.com>
References: <1250226349-20397-1-git-send-email-srabbelier@gmail.com> 
	<1250226349-20397-2-git-send-email-srabbelier@gmail.com> <20090814052153.GA2881@coredump.intra.peff.net> 
	<fabb9a1e0908132324td6869aydc752f67b95546f1@mail.gmail.com> 
	<20090814063359.GA6898@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 14 08:43:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbqVq-0004vo-AK
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 08:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753810AbZHNGlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 02:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752777AbZHNGlF
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 02:41:05 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:34097 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbZHNGlE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 02:41:04 -0400
Received: by ewy10 with SMTP id 10so1298730ewy.37
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 23:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=tuQYaE6hurwS/lZbGwYRWBr311+yo50PPfw4qn1NXKU=;
        b=uzlw3UCzCYC1TDcl5uffZalUGWBwfkrqDxClIdCulEc8sqJzw79hTxsJozT+ps9fA9
         egCgvmRhXDHpzyRIxrPeZz/X7cERWVeLmooV4UhzIb0OoeimDR7GqNQC1eJNn2gRAgDD
         F1xUeyR/Dl5xT81HhLYWHJCOWL1BBkNRnDPgo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=uM3Ou9ETiH03m46BWURTfGQ/X2431mXPpPzPi2e3t8zoT2ELD+dt8ISVVN+mPONETs
         4ccwcJHPG/6EQwJXSNw30x3VlkTqdQ477HjaQFXfLg2fNd4mbFqwrl4alM7JLY4u4Tb0
         gOlC8aOumYhKGaxaPOE/dHvbNFF0VBZCwNZTA=
Received: by 10.216.11.210 with SMTP id 60mr364552wex.188.1250232064088; Thu, 
	13 Aug 2009 23:41:04 -0700 (PDT)
In-Reply-To: <20090814063359.GA6898@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125904>

Heya,

On Thu, Aug 13, 2009 at 23:33, Jeff King<peff@peff.net> wrote:
> On Thu, Aug 13, 2009 at 11:24:05PM -0700, Sverre Rabbelier wrote:
>> I don't think we should touch any configured refspecs, think about how
>> often one would use that vs. the inconvenience of doing so
>> unintentionally.
>
> I think you are right. My previous message was sort of thinking out
> loud, but I think on the whole, the annoyance caused by accidental
> deletion is not worth it. :)

Thinking out loud is good :).

> I guess I find what you are doing _more_ complex, because you are really
> introducing a whole new mode to push, which is "I am deleting some
> stuff". As opposed to some syntactic sugar to replace the confusing
> ":ref" syntax, which is what I thought the goal was.

Yes, replacing the confusing ":ref" syntax was the goal, but I think
the current solution does that as well.

> On the other hand, "--delete <ref>" introduces its own syntactic
> problems.  [...]

It does indeed, and I don't think that's the way to go.

> Perhaps saying that "--delete=<ref>" is equivalent to ":<ref>" would be
> a reasonable way of adding just the syntactic sugar. [...]

That would work too I guess, although it would be technically more difficult.

> Of course, maybe the goal of a "delete mode" is useful to people. I
> can't think of a time when I would have used it, but then I also tend to
> think ":<ref>" is elegant and obvious. ;)

I don't think it's that confusing either, but it's hard to stumble
upon, yes? When you're looking at the man page for git push it is
easier to deduct that '--delete' is what you need, than ':master'.

-- 
Cheers,

Sverre Rabbelier
