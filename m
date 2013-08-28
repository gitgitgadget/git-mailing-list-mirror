From: David Aguilar <davvid@gmail.com>
Subject: Re: [RFC/PATCH v2 3/3] status: introduce status.displayCommentChar to
 disable display of #
Date: Wed, 28 Aug 2013 14:59:52 -0700
Message-ID: <CAJDDKr6RDiAxgUdaE5aH4-wxYRY7fKnUukX1D-t07=-_P0CZAg@mail.gmail.com>
References: <vpqhaeaasuf.fsf@anie.imag.fr>
	<1377694024-24173-1-git-send-email-Matthieu.Moy@imag.fr>
	<1377694024-24173-3-git-send-email-Matthieu.Moy@imag.fr>
	<xmqq1u5da8dp.fsf@gitster.dls.corp.google.com>
	<20130828201803.GB8088@sigill.intra.peff.net>
	<xmqqmwo18pgw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 00:00:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEnmT-0001CR-0Y
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 00:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754628Ab3H1V7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 17:59:53 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:49935 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754067Ab3H1V7w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 17:59:52 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld10so21499pab.36
        for <git@vger.kernel.org>; Wed, 28 Aug 2013 14:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2NulcEEVtrc3ocdiuqu/RiJl9ziY8iHiXFNSMISTGaE=;
        b=bSmflzd4K2FIrO+FgVHX/rXdsQlCEWVNDcs0T3LqAZt319iRBUW8cFlzbEMVGPPVuW
         XtgUQMTZ1SHiMeTouSwroysNynezPHXbuQi/yDptHcxbfG1HNpzhVn0iZOK/OmtdomeG
         A9dd0fsnhbW2olGHkhrWyXWpDJSOYyYBbhMcJwtN9CyhQCF0Yzam/ZxnWNndeoSuMzRx
         qcG6Tn+qj9BMAMuD9Kms/VhNydqXyIAARtM+C5cCiGBETV1D4ycJkn0XXNAhJatogBjb
         vTvfnNK12jLlLPs3uICh73d5wOc6MkLXNh1YOeX6tyFsOPDMau3h4Wgx5Jjcfs1hRVLu
         9qog==
X-Received: by 10.68.201.6 with SMTP id jw6mr4686645pbc.202.1377727192496;
 Wed, 28 Aug 2013 14:59:52 -0700 (PDT)
Received: by 10.70.95.230 with HTTP; Wed, 28 Aug 2013 14:59:52 -0700 (PDT)
In-Reply-To: <xmqqmwo18pgw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233224>

On Wed, Aug 28, 2013 at 2:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Wed, Aug 28, 2013 at 01:05:38PM -0700, Junio C Hamano wrote:
>>
>>> What are our plans to help existing scripts people have written over
>>> time, especially before "status -s" was invented, that will be
>>> broken by use of this?
>>
>> I thought that our response to parsing the long output of "git status"
>> was always "you are doing it wrong". The right way has always been to
>> run the plumbing tools yourself, followed eventually by the --porcelain
>> mode to "git status" being blessed as a convenient plumbing.
>>
>> I will not say that people might not do it anyway, but at what point do
>> we say "you were warned"?
>
> OK, sounds good enough.

I personally think it's a little strange for this to be configurable.

I have a poor imagination and cannot imagine why it needs to be
switchable.  If someone switches it to "a" does that mean that any
commit message line that starts with the letter "a" will be filtered
out?

Specifically, core.commentchar seems really unnecessary to me.  What
is the benefit?

I do see downsides -- folks do parse the output, they don't read the
release notes, they don't know any better, but, hey, "it works", so
they'll be broken just because someone doesn't like "#"?

What about hooks that write custom commit messages?  Do they need to
start caring about core.commentchar?

Curious,
-- 
David
