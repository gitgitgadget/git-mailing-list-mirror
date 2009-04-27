From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: git grep '(' = segfault
Date: Mon, 27 Apr 2009 21:02:31 +0200
Message-ID: <40aa078e0904271202ye89ebf2wf417c623d8fe5689@mail.gmail.com>
References: <37fcd2780904271046r7740ed42t3c9438e7aa93374@mail.gmail.com>
	 <alpine.LFD.2.00.0904271059060.22156@localhost.localdomain>
	 <40aa078e0904271142u71d7ba97w9df80667c0d9b955@mail.gmail.com>
	 <vpqfxfund0m.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Apr 27 21:02:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyW6F-0002DL-7n
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 21:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756025AbZD0TCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 15:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754554AbZD0TCd
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 15:02:33 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:46296 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754525AbZD0TCd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 15:02:33 -0400
Received: by fxm2 with SMTP id 2so99279fxm.37
        for <git@vger.kernel.org>; Mon, 27 Apr 2009 12:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fS+8z9kw5e33kDkmrCyPcnauAWIAfqDvTwR6ZG8ibPw=;
        b=OxrYnTOd/+brKM9E8bmFNvyEPZTPCfBRr9TiPmvlgyGvl+9U9436iapBLHIoEp4cPq
         lGxYQYJKuTV2B3N1BrwPtVWxzHme7EtkOE6mHSwZBptVpgXYzOr1rcnTuafYnrG9kV5V
         PvJJ8f6VpdZltKENu2KHPCK9Xmoq8M7R7QIyI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=h+HtcodrZTDOlpo1DKM1/G8h07AQ9t34Y6KdXkpucb/KrFcGgJ/bDk8RQi2svGBS3+
         lOx96a3/AhPAcVjeQU58xkZVMlZMO9owzsnBiv7VUqQJwN57WxyKhNC2J274+NTKg3xI
         9b/QvLp5DEpRkv0azf9SAHVxSdzNfoOWsA/94=
Received: by 10.223.108.140 with SMTP id f12mr2054117fap.69.1240858951728; 
	Mon, 27 Apr 2009 12:02:31 -0700 (PDT)
In-Reply-To: <vpqfxfund0m.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117708>

Yeah, thanks for explaining. But isn't this functionality kind of
redundant since we have the -E switch?
As far as I can see, "git grep -E "(bar|boz)" should do the same thing
as "git grep -e foo --and '(' -e bar --or -e boz ')'"...

On Mon, Apr 27, 2009 at 8:54 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Erik Faye-Lund <kusmabite@googlemail.com> writes:
>
>> $ git grep '('
>> fatal: unmatched parenthesis
>
> try this: git grep -e '('
>
> The idea is that you can do things like
>
> git grep -e foo --and '(' -e bar --or -e boz ')'
>
> to build a boolean expression of expressions.
>
> --
> Matthieu
>



-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
