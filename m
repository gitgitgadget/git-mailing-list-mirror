From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] builtin-remote: better handling of multiple remote HEADs
Date: Sun, 15 Feb 2009 09:13:09 -0500
Message-ID: <76718490902150613i79517e6dwcec8e1e40c56bcc8@mail.gmail.com>
References: <20090214034345.GB24545@coredump.intra.peff.net>
	 <1234607430-5403-1-git-send-email-jaysoffian@gmail.com>
	 <20090215052740.GA11522@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, barkalow@iabervon.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 15 15:14:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYhlY-0003PT-7o
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 15:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032AbZBOONN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 09:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753646AbZBOONM
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 09:13:12 -0500
Received: from rv-out-0506.google.com ([209.85.198.231]:53895 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449AbZBOONM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 09:13:12 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1222196rvb.1
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 06:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tEpFoGzk4bGtH2iS7+wLv0WSXLcz5hcZiRDlqKcpMOQ=;
        b=fLMipGBmSN1wDc/VkepYPjnhmx7BOVhisWXZfjml+qykgtaEG+eLBSOTwOtjnTXfWo
         xcjxk5QD27IFks5JlwhaLRBK0G8dZGJtpqsFnTvbt5WMGylEDajzQYuqo8BRYSIn0nr+
         8qok8N9UOtS9DGBRszgQTaSWOLWAQCVWs/VHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BeW4keemFWbrQOTQi5mhgrZKfAK0SRCP11hLzkfMc1I1DJUKAh5h0DVKdtQ2ovseBW
         qg73/VZm4D1y5VWvAM/zdmiyzEvXUkJqssmE5nSqCj/6Ah81ksupWTejDEoF26fX7Glg
         veOdyjnohAfyRx7xuABM7vkFiMRuikp053Bmw=
Received: by 10.141.29.21 with SMTP id g21mr2171929rvj.44.1234707189940; Sun, 
	15 Feb 2009 06:13:09 -0800 (PST)
In-Reply-To: <20090215052740.GA11522@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110012>

On Sun, Feb 15, 2009 at 12:27 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Feb 14, 2009 at 05:30:30AM -0500, Jay Soffian wrote:
>
>> +test_expect_success 'set-head --auto fails w/multiple HEADs' '
>> +     (cd test &&
>> +      test_must_fail git remote set-head --auto two >& output &&
>> +     test_cmp expect output)
>
> I missed it before, but there is a typo in this test (>&) that causes it
> to barf.

Didn't barf for me, but it turns out it's because it's a bash'ism[1],
and that's the default /bin/sh on OS X. Out of curiosity, on what
platform did it fail for you?

[1] Redirecting Standard Output and Standard Error
       Bash allows both the standard output (file descriptor 1) and
the  standard  error
       output  (file  descriptor 2) to be redirected to the file whose
name is the expan-
       sion of word with this construct.

       There are two formats for redirecting standard output and standard error:

              &>word
       and
              >&word

       Of the two forms, the first is preferred.  This is semantically
equivalent to

              >word 2>&1

j.
