From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v2 00/13] Use ref transactions from most callers
Date: Tue, 22 Apr 2014 15:43:56 -0700
Message-ID: <CAL=YDWmCLvQRe6CQddKQxhHXrPnTx7iXh=t0JQ_GhE2jvmgNhQ@mail.gmail.com>
References: <1398120811-20284-1-git-send-email-sahlberg@google.com>
	<xmqqzjjd40q3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 00:44:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcjQ4-0001JU-OO
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 00:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbaDVWn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 18:43:58 -0400
Received: from mail-vc0-f171.google.com ([209.85.220.171]:39691 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723AbaDVWn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 18:43:57 -0400
Received: by mail-vc0-f171.google.com with SMTP id lg15so169324vcb.16
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 15:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zFAMFHGOld2hZFni1IQfHz/moFyO1iJDURhJec+j/Hg=;
        b=YhfQdOabTVuQdUAXj1nsIHoQfRD0+/J9ueW6DWD3bjhgYNONps78Z4/tFqgEPEN+qB
         2dTHgDZlMyFW5z6TKMkrsA7eiABEqMRlvKXP+SeCFWVkSVbjhFWVMDeWOMqkCTpHHoNX
         lVkErZhrKjEnOa1P2Rl1EnZG2c6DR41lCAo9V80RIgM52NeHqLCR5J2J+syZjNoAmnPc
         8eIJLFyiwEeODdLO/LjJSXN5/dV7myB7HXxvocMGt/RN4MKbwsDbrVNGVlzaDhAUwrFG
         wD/TDIaErKaA0ilrU6j9Wa55FxTDSr5JlOKTKQaPlZouIydn31g8YqDjMGNnYeQ5Aja1
         7wVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=zFAMFHGOld2hZFni1IQfHz/moFyO1iJDURhJec+j/Hg=;
        b=RBI8b134Ake4IgEQJfQTghGPXiSVmVuf36uFsF137cNYWCXrZCdiiOxKYKnNWGK54M
         BJ4G2k18vDYIaU97iVRvpogHFfj+O1CJB+w0dFHsRRh9izxNLQCO930ChgAqARD1h9qk
         fgq7rTXoztnajp+As7UE2cIVn8SHP+D2SHshOAbMcbOeOB98KcNE1/cW1ntaNjp1/dUB
         ixmZNTeTFxx+3MSRu1TTOvvsuHfVWGWG0p1cRIT4AiD1P+U2p+m1Ng2MDQiBECoEtLpr
         xYwHVF+mUEqjzSXL9KS+XL/WjbX2p+12UeILFmslOvEbzCv734l+est5vJt58k+E3a9P
         Br3Q==
X-Gm-Message-State: ALoCoQkL+4vA54WMQRb9l51Vq6FKPNLm2BBSoDCwKazLBSy7iEfNdQciTlht4fBl60qEn/7X5Q8imRPkcRN+izi5jLE8SwF0b6Yn3VCicx8qn1GUJKG1JVyT4FVtxnlvlngryML5q/bFpxNs5Qlsyom0u9BIl+hZuFSONq++lfZJ1PS1cF5rg37474aoSiIHUorFJLQO3cuy
X-Received: by 10.220.103.141 with SMTP id k13mr9806111vco.25.1398206636577;
 Tue, 22 Apr 2014 15:43:56 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Tue, 22 Apr 2014 15:43:56 -0700 (PDT)
In-Reply-To: <xmqqzjjd40q3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246799>

I will look at this once i finish the next respin.

On Tue, Apr 22, 2014 at 12:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> This patch series changes most of the places where the ref functions for
>> locking and writing refs to instead use the new ref transaction API. There
>> are still three more places where write_ref_sha1() is called from outside
>> of refs.c but those all will require more complex work and review so those
>> changes belong in a different patch series.
>>
>> Version 2:
>>  - Add a patch to ref_transaction_commit to make it honor onerr even if the
>>    error triggered in ref_Transaction_commit itself rather than in a call
>>    to other functions (that already honor onerr).
>>  - Add a patch to make the update_ref() helper function use transactions
>>    internally.
>>  - Change ref_transaction_update to die() instead of error() if we pass
>>    if a NULL old_sha1 but have have_old == true.
>>  - Change ref_transaction_create to die() instead of error() if new_sha1
>>    is false but we pass it a null_sha1.
>>  - Change ref_transaction_delete die() instead of error() if we pass
>>    if a NULL old_sha1 but have have_old == true.
>>  - Change several places to do  if(!transaction || ref_transaction_update()
>>    || ref_Transaction_commit()) die(generic-message) instead of checking each
>>    step separately and having a different message for each failure.
>>    Most users are likely not interested in what step of the transaction
>>    failed and only whether it failed or not.
>>  - Change commit.c to only pass a pointer to ref_transaction_update
>>    iff current_head is non-NULL.
>>    The previous patch used to compute a garbage pointer for
>>    current_head->object.sha1 and relied on the fact that ref_transaction_update
>>    would not try to dereference this pointer if !!current_head was 0.
>>  - Updated commit message for the walker_fetch change to try to justify why
>>    the change in locking semantics should not be harmful.
>
> Will queue, but when applied on top of mh/ref-transaction and tested
> standalone, it appears to fail test #14 of t5550-http-fetch-dumb.sh
> for me.
>
> It seems that the culprit is that this step:
>
>     git http-fetch -a -w heads/master-new $HEAD $(git config remote.origin.url) &&
>
> creates ".git/heads/master-new" when what it was asked to create was
> ".git/refs/heads/master-new".  Perhaps there is something fishy in
> the conversion in walker.c?  We used to do lock_ref_sha1() on
> "heads/master-new", which prepended "refs/" prefix before calling
> lock_ref_sha1_basic() that expects the full path from $GIT_DIR/, but
> ref_transaction_update(), which wants to see the full path, is still
> fed "heads/master-new" after this series.
>
