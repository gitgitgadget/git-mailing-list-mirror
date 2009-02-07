From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Sat, 7 Feb 2009 03:48:27 +0100
Message-ID: <237967ef0902061848g14765b5an6397901c4e81b048@mail.gmail.com>
References: <20090205204436.GA6072@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sat Feb 07 03:53:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVdJV-0003hU-CE
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 03:53:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430AbZBGCsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 21:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752380AbZBGCsa
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 21:48:30 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:52867 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbZBGCs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 21:48:29 -0500
Received: by ey-out-2122.google.com with SMTP id 25so296683eya.37
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 18:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KRcLh/prbHoxvVsdsrpYQ+/RlhvxsxPc1ZDTYbuyXds=;
        b=F97WLe3GxJGJvOIg4bkHLydjwprPaMgxEqFbZ3ceT5RPkhIvyqivnNujVD6mfhhxxb
         Bp7MGoDKDnAYO4y/qnS6RKJNtCaYEnb6OCdJA5KKSjdSpV8qoRM0M9/J20dQZmkTk+mt
         0UNkPIv6cVc9P1DUL3ana6t8NJsmOhM3Qfqtg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lebHx+Bbyrt5xWFI7giNVDoUU/MraZiyC0qZi9czpWN3P6ByTR6Jnv5MAzosdhulzY
         0SLd+2Ngnh9TXlpv4quzP8GijhTwBePyNYbnTkmCvLar33bztecKurzmpT0k1LWtMPCc
         CSuNX7JQJBPlJ8DTfnei9CByOYmRzRGpuIj+w=
Received: by 10.210.87.19 with SMTP id k19mr1822557ebb.152.1233974907815; Fri, 
	06 Feb 2009 18:48:27 -0800 (PST)
In-Reply-To: <20090205204436.GA6072@diku.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108807>

2009/2/5 Jonas Fonseca <fonseca@diku.dk>:
> Hello,
>
> Here is a much needed update fixing multiple regressions from the
> introduction of the IO API in 0.13. Among improvements is the much
> requested ability to restore the position in the stage view when staging
> diff hunks. Also noteworthy is the many optimizations of the screen
> updating to make it work better across slow links. Finally, beware that
> a handful of incompatibilities can cause problems.

I'm having a problem with tig taking 2 seconds to start up, which
seems to be related to the 'typo checking' feature of git. After
figuring out how to stop strace from helpfully saying
write(2, "WARNING: You called a Git program"..., 137) = 137
I got this (with -s 100):
[pid 29708] write(2, "WARNING: You called a Git program named 'git
config', which does not exist.\nContinuing under the assu"..., 137) =
137
[pid 29708] write(2, "in 2.0 seconds automatically...\n"..., 32) = 32

The output however also contains lots of git config strings, which is
confusing. Is tig running git config twice and failing one of the
times? (Running git config from the cmdline works fine).

-- 
Mikael Magnusson
