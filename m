From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v3] gc: reject if another gc is running, unless --force is given
Date: Tue, 6 Aug 2013 12:15:49 +0530
Message-ID: <CALkWK0m=QDq2mbW9L98qOpAx67heY-Z7VW_=DT83Z1o7+Lartw@mail.gmail.com>
References: <1375510890-4728-1-git-send-email-pclouds@gmail.com>
 <1375712354-13171-1-git-send-email-pclouds@gmail.com> <7vsiyoj932.fsf@alter.siamese.dyndns.org>
 <CALkWK0kZ=5TguAh9krAzFNuF0_sTRxcQKuZMnuQG7FQU0dJe=g@mail.gmail.com> <7vwqnzgvzi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 06 08:46:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6b2Q-0004N0-9Q
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 08:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754607Ab3HFGqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 02:46:30 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:55073 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057Ab3HFGq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 02:46:29 -0400
Received: by mail-oa0-f41.google.com with SMTP id j6so17142oag.0
        for <git@vger.kernel.org>; Mon, 05 Aug 2013 23:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5dmLIwnChqu/cBWwO1RbGgdn9nlzqXfTe7F1zXt/KEU=;
        b=AlJ5QDL+jaLLnA8n62QBk0e7tYRTf8HtfIBBISWc/Jp2S4K8T0R3DGzKCQ/3aggwTR
         updHngTlqoJGDQtbAHkFTTN8GldZ3PdT5o4jQzXUSCjfAAizRCxo4KYjEuM8RYxbM9Mm
         CzadaAYVo9LYWFLRfJDYuxwCJZHxREz6wO2P7XyJ70Uq9ESUkwyNozRUWF8QhdooCBTa
         96LnWa1hC+sdrx37cEOVE1PaGuoPjmvKemqFcEdIBQLbCz6/i9fYLnKYpV6FI3nR2jWV
         SeThOlDsBKM1dRIKP8ENEhFRSzaZvDfhohCvMQsuaGkPxkSYuqzccUhQo38zEe/i+85d
         rqYA==
X-Received: by 10.50.225.40 with SMTP id rh8mr141846igc.1.1375771589396; Mon,
 05 Aug 2013 23:46:29 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Mon, 5 Aug 2013 23:45:49 -0700 (PDT)
In-Reply-To: <7vwqnzgvzi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231728>

Junio C Hamano wrote:
>>> After reading what the whole function does, I think the purpose of
>>> this function is to take gc-lock (with optionally force).  Perhaps a
>>> name along the lines of "lock_gc", "gc_lock", "lock_repo_for_gc",
>>> would be more appropriate.
>>
>> The whole point of this exercise is to _not_ lock up the repo during
>> gc,...
>
> I do not think it is a misnomer to call the entity that locks other
> instances of gc's "a lock on the repository for gc".  Nothing in
> Duy's code suggests any other commands paying attention to this
> mechanism and stalling, and I think my comments were clear enough
> that I was not suggesting such a change.
>
> So I am not sure what you are complaining.

Not complaining; I wrote it down because of your "lock_repo_for_gc" suggestion.
