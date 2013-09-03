From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/4] t: branch: improve test rollback
Date: Tue, 3 Sep 2013 17:10:25 -0500
Message-ID: <CAMP44s2BU86zZ_KE78BPYpsjBZJ7Mj0MJqM4Lj28AKxYfeLVDQ@mail.gmail.com>
References: <1377923511-20787-1-git-send-email-felipe.contreras@gmail.com>
	<1377923511-20787-5-git-send-email-felipe.contreras@gmail.com>
	<xmqqwqmxr9a7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 00:10:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGynv-0006q3-S8
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 00:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754644Ab3ICWK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 18:10:27 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:63589 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754129Ab3ICWK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 18:10:27 -0400
Received: by mail-lb0-f180.google.com with SMTP id q8so5471862lbi.39
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 15:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lW379bEVYWK8LzlO3pgT7wndPN5FaEl/b9cU7psasYY=;
        b=MEZyoD/nmqpYv2nklnGXdYTk/I33L8Cv0ESXoN9kxsbmztXaKYy0alJtFngYU/cvzd
         1ouMcwU09TLrf208mdt9MW+pab1v82htYDY19A9WJO2186tNgU2puFY1I7P9tqxAqsMR
         U2TEdfWHFgscD9htvlhfJk8TIBZp5N+nqhyk9l9unG/TUMD9GoyvuOpWe+RruvUjMcmS
         ibEQbiFRL/5Bp/QApkNFf1Gj+OmVGBq4Qx66LzUI+u6yDQkpMnKOwNPjERldF0gN+TaB
         4WFDs1TOI3CmlZ3kvC6BAIvJRzp/8ymnyRZQoqgDdw+8qVC0JYpBaXjaa78TxElFtZ4H
         aLgg==
X-Received: by 10.152.21.165 with SMTP id w5mr3687233lae.33.1378246225872;
 Tue, 03 Sep 2013 15:10:25 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Tue, 3 Sep 2013 15:10:25 -0700 (PDT)
In-Reply-To: <xmqqwqmxr9a7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233790>

On Tue, Sep 3, 2013 at 2:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:

>>  test_expect_success 'refuse --edit-description on unborn branch for now' '
>> +     test_when_finished "git checkout -" &&
>
> I am not sure if this is a good change.  Depending on the outcome of
> the "git checkout" in the test (it may succeed and set @{-1} to the
> branch we were on when we entered the test, or it may fail and leave
> @{-1} to the branch before we were on when we entered the test),
> this will take us to a different place, no?

It is better than leaving Git in an unborn branch. Many tests could
not care which is the current branch, as long as HEAD does points to a
branch, and that is the default, the tests should be messing with the
default.

-- 
Felipe Contreras
