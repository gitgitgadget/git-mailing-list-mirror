From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1 1/3] replace: add --graft option
Date: Fri, 23 May 2014 18:59:14 -0400
Message-ID: <CAPig+cRG_LsV3q1qRP7C6LpFA7hcBCDmX8Xm=6AdxtRmY3oYWQ@mail.gmail.com>
References: <20140522211836.27162.80311.chriscool@tuxfamily.org>
	<20140522213307.27162.14455.chriscool@tuxfamily.org>
	<20140523195153.GB19088@sigill.intra.peff.net>
	<xmqqlhtsi7l7.fsf@gitster.dls.corp.google.com>
	<20140523202853.GH19088@sigill.intra.peff.net>
	<xmqqd2f4i41l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 24 00:59:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnyQv-00024q-Pt
	for gcvg-git-2@plane.gmane.org; Sat, 24 May 2014 00:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbaEWW7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 18:59:17 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:46976 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbaEWW7O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 18:59:14 -0400
Received: by mail-yk0-f182.google.com with SMTP id 9so4599496ykp.27
        for <git@vger.kernel.org>; Fri, 23 May 2014 15:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=k/kIWEYSnzdxoWQdQ11E75mL0NIm8tAnNJZaLPAh02U=;
        b=q1GlswSXOJMvZG10a/X2VPzG4SU7MIOFaDgZKZjlrZDfRdVNgmHPYQbjXhNUPCPAjH
         BzS1vwvnntcYPszX9mwWh4oUOYOcR7RQBscivfCR+i1Tr1d/Si6ngKiGlYN0T9FTCIwM
         7+4js88NEUHw1J+09p1/WeFM8R0T2iC4B3jeTYUdYdT4R4F+ygyFSu8nBXLUqClq06Rz
         2WPxSCihcRFN0ERFeymT+AkF8pVB9eWhhkw3SQQoWCyMo3kDENQVeSk0zNfCjL9iKzGa
         8oC347MRqIfBWakpPF6mzT4/M+LfIRem55yWa9ynWhrxylqQPdO0PVY7GXLD4iCMcc2O
         C43g==
X-Received: by 10.236.226.101 with SMTP id a95mr7730113yhq.88.1400885954207;
 Fri, 23 May 2014 15:59:14 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Fri, 23 May 2014 15:59:14 -0700 (PDT)
In-Reply-To: <xmqqd2f4i41l.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: acLq1PPCoLrdNIQ6GRuFCfjH-iY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250045>

On Fri, May 23, 2014 at 5:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Fri, May 23, 2014 at 01:05:40PM -0700, Junio C Hamano wrote:
>>
>>> I just read read_graft_line(); it allows an empty line (both
>>> length-0 before the terminating LF or CRLF, and a line with
>>> isspace() only) and ignore them, so "grep '^[^#]'" is not
>>> sufficient.
>>
>> Thanks, I missed the space trimming. I think:
>>
>>   grep '^[^# \t]'
>>
>> would be enough, though I am not sure that "\t" is portable over a raw
>> tab.

'grep' does not recognize "\t" on BSD or derivatives, such as Mac OS
X. (Nor does 'sed'.)
