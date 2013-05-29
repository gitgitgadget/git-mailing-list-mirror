From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/3] push: fail early with detached HEAD and current
Date: Thu, 30 May 2013 01:07:50 +0530
Message-ID: <CALkWK0mCY0F-EgO6hQv-LvV1Nb5H9jNXBWLDrY07rVNqLBPjkw@mail.gmail.com>
References: <1369855311-23367-1-git-send-email-artagnon@gmail.com>
 <1369855311-23367-3-git-send-email-artagnon@gmail.com> <7vppw9shq2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 29 21:38:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhmCj-0006EV-4F
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 21:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966297Ab3E2Tid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 15:38:33 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:65100 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966222Ab3E2Tib (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 15:38:31 -0400
Received: by mail-ie0-f174.google.com with SMTP id aq17so2802048iec.19
        for <git@vger.kernel.org>; Wed, 29 May 2013 12:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nLff7hedDyM36ULJOuaU9PEuj8dGT+lktBuXbtUNaCg=;
        b=z023Je8D52K2oS315xPIW9b/6s1OZK0mV8LrpbWnYdcHt0SNsKsnNQ2VD3R8h4LFCf
         a7bnirjRavZ4SrshJtUsgGqMsrPCuam2X0waIWPA4oE9slkX2Gb+d3BJ2JBexJoaabyC
         Uaq5Fp4zab7LacnlOY3+x0Hd1Esl11GIkiuc5lDhGOI1sqDZFttyS9BnuVf+GAZ6nENZ
         us3k9v2diMTXMzLQyHBWetKMVZezaUnKsY3/ADpoIzUT6EAi0b0F31bqmQaSDWB0TtqM
         8+CQMJCXwa7rOYM9uVYOlq2dweldWM+yTEfXMZgTtQ/V4x7pz09KnMGoc/ILJFNGP0VE
         kTBQ==
X-Received: by 10.50.153.6 with SMTP id vc6mr10012661igb.57.1369856310833;
 Wed, 29 May 2013 12:38:30 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Wed, 29 May 2013 12:37:50 -0700 (PDT)
In-Reply-To: <7vppw9shq2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225876>

Junio C Hamano wrote:
>>       case PUSH_DEFAULT_CURRENT:
>> +             if (!branch)
>> +                     die(_(message_detached_head_die), remote->name);
>>               add_refspec("HEAD");
>>               break;
>
> Would it hurt to do
>
>         if (!branch_get(NULL))
>                 die(...);
>
> here, without the first hunk?

And how would I change the add_refspec() call to take branch->name in [3/3]?
