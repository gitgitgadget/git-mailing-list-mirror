From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: sporadic git failures on interactive rebase
Date: Wed, 14 Jan 2015 16:00:37 -0500
Message-ID: <CAPig+cQ9GpL9r6Rr96jc6G=EvCArodSXC-qMzSBp=e7c7QQbtA@mail.gmail.com>
References: <trinity-5098e61e-b59a-4225-9d4c-8879dc78bb53-1421146472532@3capp-gmx-bs08>
	<20150114121915.GB30383@peff.net>
	<20150114123536.GA31530@peff.net>
	<xmqqvbk9b81d.fsf@gitster.dls.corp.google.com>
	<20150114205437.GB1155@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Henning Moll <newsScott@gmx.de>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 14 22:00:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBV3T-0007Sc-0V
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 22:00:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894AbbANVAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 16:00:39 -0500
Received: from mail-yk0-f171.google.com ([209.85.160.171]:49946 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbbANVAi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 16:00:38 -0500
Received: by mail-yk0-f171.google.com with SMTP id 142so5199446ykq.2
        for <git@vger.kernel.org>; Wed, 14 Jan 2015 13:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=oZbEPjriYGHZJ2VveidCbm/L5yrUtl/ABowovy+6fe8=;
        b=ZCh1NUVRr128ovF11yqnVJfeWyf0JteFcpwMGKRAN8JSrCklLfnxvQP5I/cG74zd15
         2Zl+RX6l/k0lda+0MiGMnsYSYJmsevQamUlo2KNMKhEbx6rMBXQXsJhwdWsnQ5G3MEro
         34QypiVe2AGHmlZ5ul5fIkaIDU9NlVY8E4NeDhMcxk34+4R7rA1MfxRQOpTB2rw2uUy6
         VWq0Zs0IH93/W8kJMmjK2FEbB17ff4KThG18t9IWL7bvpPUPYez+REXTIJxNUPkTonj/
         ROytiXdgPyRZBYbln2K7c3ITgs5xNdUAzlSuKO74YFnYNEGScGR1i32wEs+OfAyeCoKl
         BH1Q==
X-Received: by 10.236.63.6 with SMTP id z6mr3404938yhc.65.1421269237622; Wed,
 14 Jan 2015 13:00:37 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Wed, 14 Jan 2015 13:00:37 -0800 (PST)
In-Reply-To: <20150114205437.GB1155@peff.net>
X-Google-Sender-Auth: 85HfpUrueyqxPeRIUU8SG3eegNk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262426>

On Wed, Jan 14, 2015 at 3:54 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Jan 14, 2015 at 09:12:46AM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> > What happens if we rebase with it?
>> >
>> >   $ git checkout 01319837
>> >   $ git rebase -i HEAD^
>> >
>> > will yield a todo file with the 8-character unambiguous abbreviation.
>> >
>> > So I guess all is working as intended there. Perhaps you really were
>> > just very unlucky and an earlier step of the rebase created a
>> > conflicting sha1.
>>
>> That would mean 75c69766 (rebase -i: fix short SHA-1 collision,
>> 2013-08-23) did not fix what it intended to fix, no?  Is the symptom
>> coming from pre-1.8.4.2 version of Git?
>
> Yeah, you're right. I didn't even remember that commit at all. On the
> off chance that the abbreviation code was different in that earlier
> version, I also checked rebasing 01319837 with an older version, but it
> does work fine.
>
> So yeah, the most plausible theory to me so far is unluckiness combined
> with pre-1.8.4.2. That should be easy to disprove if Henning tells us
> his git version.

Henning mentioned it at the very top of his original problem report:

    "(git version 2.2.0)"
