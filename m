From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] pretty-print: de-tabify indented logs to make things line
 up properly
Date: Wed, 16 Mar 2016 11:21:48 -0700
Message-ID: <CA+55aFxV5PWdSn9Gj=zV464TtJo=QvciZrhc5Pwe+Qfyqt8sXw@mail.gmail.com>
References: <alpine.LFD.2.20.1603160926060.13030@i7>
	<xmqq7fh25mkc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 19:22:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agG5D-0000mY-C7
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 19:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935216AbcCPSVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 14:21:52 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36407 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934911AbcCPSVt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 14:21:49 -0400
Received: by mail-ig0-f170.google.com with SMTP id nk17so102108171igb.1
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 11:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=+qwt5rouzMdbu0jciu94CyDvKbF9KJg+/BlDrFkDOzg=;
        b=n2x3hi/3UrlpVx2ngv7mLutdiGolMASWroCFRDThUoyKZYVFJOxnO+1QE82Bgw/ovF
         Ac9ICTpmMEdtDr4sI84v9zFphjbfas/VtYOuTOU2D5NqyP/AezjvN/H+on8cOVNftv5T
         KgVAyFuWJaQkapiGnfihP3n8txYAiGKSt7mo7PsvFc6DkP/IgGlFu+gDEf+R5i8rrI/Y
         pdlsc8rZFxT5vuq21INrp3oS/AW7ovlPigTi+RjgJrtIOJ6jG7XLv1NDvqFfYfWIpeaS
         UqExQ5vH/mCuYWckr8LLIXgZKFzzqxxHvCgC+nFZy2YCzYSh05l/bQv/DehEcgnWYjV6
         J5DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=+qwt5rouzMdbu0jciu94CyDvKbF9KJg+/BlDrFkDOzg=;
        b=NPWKIoCTfAMTn+Zi5F+fJ02fd4N4pGBEe/6ZXRMFsDW+Mafg2MrOuUpCId6clVdMj1
         C/68NEWsYxbu5pSeL5KYAYh/9aEbZzU2+3CAUYYm8GKv4Olw99SQlk8Ih5N8ruLK7Ama
         LUtT/6JlVEDKkDYk/jCaNoEPHhpMjOrw0Z7xM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=+qwt5rouzMdbu0jciu94CyDvKbF9KJg+/BlDrFkDOzg=;
        b=GWZUKTRyxw+bnLTwsjeaLTX8QpOB5XEaghVyQk43Wxn0tDN1jwUbpSQlZ2QoQWIPT1
         8oz0oUs8EwKiydSXthkVpD3IA9Q4fdAWJRDfz6320LBqEhHbGGltDa3Q6iuhRGc1ddwA
         FikhKmPTJtOCbO4mr2r0NR91ZGz/D7eGvJjZmEVQ/t9UPMVFuMBkOKWlYOTasov25kgI
         TdteXW1+hxeWEmReK6MC8R/qUIFnArxfQf5ztGslL2ezaeZ8mXoxyDZR3zw1erFyczKe
         PEPJJQw1GGTaiKoCdCXW4srM4Qgz8aw7/4C9WfHoGNxKkB8Egaa1rfHTlZR5qfLDbmK0
         Uz0w==
X-Gm-Message-State: AD7BkJKfJPDu3hwV/hSMs3Z/6gBK6ORs91BnciiXp/WxsiFdsSgOBHF1RSeGxJvcQdH5aE1lraJQYZGISN/ICA==
X-Received: by 10.50.112.10 with SMTP id im10mr2897652igb.93.1458152508682;
 Wed, 16 Mar 2016 11:21:48 -0700 (PDT)
Received: by 10.36.93.202 with HTTP; Wed, 16 Mar 2016 11:21:48 -0700 (PDT)
In-Reply-To: <xmqq7fh25mkc.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: 5xFDznJWWHHFcGwW83j-QOf9ZcU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289013>

On Wed, Mar 16, 2016 at 11:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>  (1) if turning your "preparation; do { ... } while()" into
>      "while () { }" would make the result a bit easier to read;

So it's probably partly taste, but I will also disagree with your
"easier to read", because of the way the code is logically structured.

In particular, the "no TAB" case is actually *fundamentally* different
from the "no TAB at the end" case. The return value is different, and
the caller does very different things - the code tries to make it very
clear that that "no TAB" situation is very different from "we found a
TAB".

So it's not "preparation + do-while".

It's "preparation + handle the no-TAB case differently", and then the
"do-while" is very natural because by the time we get to the "ok, we
are now going to need to do something about the line" stage, we
already know we have a tab.

But the code *could* be made to just always do the whole
"strbuf_add()", and not return a return value at all, and the no-tab
case wouldn't be explicitly written to be different.

Let me know if you'd prefer that variant, and I'll send a new version.

>  (2) if we can somehow eliminate duplication of "tab + 1" (spelled
>      differently on the previous line as "1+tab"), the end result
>      may get easier to follow.

Yeah, I considered that. Either by just doing "tab++" before (so the
+1" would come from that in both cases), or by introducing a new
variable like

    ptrdiff_t bytes_used;
    ...
    bytes_used = 1 + tab - line;

and then just doing

    line += bytes_used;
    linelen -= bytes_used;

and the code I wrote just didn't do any of those temporary updates,
and instead just did the "+1" by hand in both cases.

Again, I can redo the patch, just tell me which model you prefer.

                 Linus
