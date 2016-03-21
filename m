From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH][Outreachy] branch -D: allow - as abbreviation of @{-1}
Date: Mon, 21 Mar 2016 13:56:10 -0400
Message-ID: <CAPig+cQNBeBaLb-znNgxOanUz++pQLae=c8vUtFXjqxOns4d-g@mail.gmail.com>
References: <1458573317-15532-1-git-send-email-elena.petrashen@gmail.com>
	<vpqfuvju4km.fsf@anie.imag.fr>
	<xmqqtwjzn2nu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Elena Petrashen <elena.petrashen@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 18:56:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai43s-00015U-Au
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 18:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757552AbcCUR4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 13:56:12 -0400
Received: from mail-vk0-f52.google.com ([209.85.213.52]:36157 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757376AbcCUR4L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 13:56:11 -0400
Received: by mail-vk0-f52.google.com with SMTP id q138so131951919vkb.3
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 10:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=B2JRlWpwqvulu/3cRhCQLaynclgkF83P90JjfoESCyo=;
        b=twx7ZURhGAIfcNLZObbuMe/iM5dO5koHAknM0CTzfZ0DfJLX4G9NdD6du5JcGhSO/5
         onuiklwOR8XN3gvkUJs8FidUhOYv9w3yQ+neG8HG/17zr2cAbi+2Lvsu8w6rjdkHxGUK
         m0nHU8Y7nt4SA8SYhXLtz/003UsS3gqBeV16Tceya4zmAHaOh6203nE9DKrxgWeZs4Hq
         gNMNeaNiiLtqXib8tvEiHtVkOPPfkEBE9/QcRlmy/CtHOgBc08ED3DYo4NM+XKNbyhkI
         s0xxDMy8ftXx1A2W2+a+ruAe+plsr5D3c6kyeXTpnpFHdPp3w7V99/eKTIYTWMLMnl6A
         JgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=B2JRlWpwqvulu/3cRhCQLaynclgkF83P90JjfoESCyo=;
        b=c3NU7H84gUBkmLq82pkkwDAZUnWfYin+wVcKmgzn1xEGkmT2n7xonnlfcsCUb1Ai99
         jPLUOG2ReDh0+Qs44iTSMxXwJeqXF9wlij2PwMLqL/zHayb5EiVj3VcsteL8r7JjdHfl
         ubsmZAr4OjPXMud4F90Gm/HL5Db2lFmyNYe+ZbNEJMHoWVyFduP4q6J6TjFsygHP/LWx
         cAirssV4OQ8c3Nnn4NDCvLmLnppxu1u5uStyFZcCdwBHsB2SfnJHo9dE9LBpurp0yNfA
         QG/ykKS1ZTzKLrgUzahkGtwvbeF1EcHGIUtxRtSIEYdTnjU5h6GeGtaAWyRt5zBap9Ml
         WXNg==
X-Gm-Message-State: AD7BkJJQk+0rnBjI8u7Fc04y744ZJ0ZKZEGceLz9fVzy5QBO5kVA1TO5+qsC5vGH/pB0z2G4jdcxisyxRhCQZA==
X-Received: by 10.176.3.48 with SMTP id 45mr2223628uat.123.1458582970135; Mon,
 21 Mar 2016 10:56:10 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Mon, 21 Mar 2016 10:56:10 -0700 (PDT)
In-Reply-To: <xmqqtwjzn2nu.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: 6bLrkjpYMJkP5XeQlc1RYgQBC_U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289431>

On Mon, Mar 21, 2016 at 1:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>> But I'm not sure how often people want to delete (force-delete according
>> to your message) the branch they just come from.
>
> One that I heard was this sequence:
>
>     $ git checkout -b work master
>     $ work work work ...
>     $ git checkout master
>     $ git merge work
>     $ git branch -d work
>
> where their argument was that they are done with the work branch,
> and it no longer is needed.

I frequently use throwaway branches when messing around with some idea
or when reviewing patches submitted to the mailing list, and the
workflow ends up being similar to the above:

    $ git checkout -b throwaway master
    $ ...work work work...
    $ git checkout master
    $ git branch -D throwaway

So, I can see how having "git branch -D" (force-delete) recognize "-"
could be a convenience.
