From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [RFD] Notes are independent: proposal for new notes 
	implementation
Date: Tue, 9 Feb 2010 15:26:27 -0500
Message-ID: <32541b131002091226p58b40237j40d3cd6cfaa91df5@mail.gmail.com>
References: <201002092105.25636.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jon Seymour <jon.seymour@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 21:26:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Newfe-000899-Fq
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 21:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025Ab0BIU0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 15:26:49 -0500
Received: from mail-gx0-f224.google.com ([209.85.217.224]:36183 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288Ab0BIU0s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 15:26:48 -0500
Received: by gxk24 with SMTP id 24so2149748gxk.1
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 12:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=qKTP08eCOZfvD2aEktHIVyGDgK2FSlPWYs1ZNTv77Kg=;
        b=CB1W4/whyqzGWqdq4OaJ8rOUXzTHtJJFhl9srSjMxRREIoM9dNWtT/F5SkIICZGiO0
         3S/UBHu0FEONrSd50fCfCWYmKE7CwOseEtsxydTcJJzLVBxo32dC1geJhbIJOkkTYcY+
         1u24DI2f6RTdhps3bi+foiaMAHkH9SD0JkzEw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=FbxoFJeYd/4L3jHDDUxdq/BlC8I8UrikP9Orv7/eBlapBdiLv1gz2uGWn892LWuH+H
         79vVkOqsaCf1hINujWos2Iw3qlp7lJbstR7/t/VW3XCOFkw63R6igxKB92W3POBDupUT
         tTXXfindY+Rt1n990K5BQd6N7wb6vI0z9O0ec=
Received: by 10.150.31.5 with SMTP id e5mr907922ybe.45.1265747207475; Tue, 09 
	Feb 2010 12:26:47 -0800 (PST)
In-Reply-To: <201002092105.25636.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139440>

2010/2/9 Jakub Narebski <jnareb@gmail.com>:
> But
> what if the answer was to change implementation, decoupling history of
> notes from each other, and keeping history of each note separate.

Congratulations, you've re-invented CVS! :)

Seriously though, I'm not sure what problems this solved.  Notes that
are related to each other can (and perhaps should) be in the same
notes commit history; notes that are not related to each other can
exist in separate histories with their own ref.

> This means for example that if in repository A somebody annotated
> commits foo and bar creating notes in this order, and in repository B
> somebody annotated bar and foo (creating notes in reverse order), then
> merging those changes would require generating merge commit even if
> those notes are identical.

That's a feature; now you have the true history of your notes, which
is good for all the same reasons it's good in git.

Of course this whole line of reasoning could lead to questions like
"can I rebase my notes history?" and "what about rebase -i" and "can I
maintain a notes patch queue" and so on.

Have fun,

Avery
