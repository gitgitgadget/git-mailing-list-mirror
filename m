From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Can a git push over ssh trigger a gc/repack? Diagnosing pack explosion
Date: Thu, 21 Nov 2013 16:57:38 -0500
Message-ID: <CACPiFC+RmmhH9GuE+3ecP7Hj4C+iRfyk1px9EP+j45kOBExM5Q@mail.gmail.com>
References: <CACPiFC+TqD_DhMaG+posoK4fTOLCoi=3jhJUPjt_72HTm9xjeQ@mail.gmail.com>
 <CACPiFC+xbnYjZUG49Em=aDUXnS_3_Cp=ZZBCrQCHM-sL78HCdA@mail.gmail.com> <xmqq61rl4jo0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Sam Coffland <sam.coffland@remote-learner.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 21 22:58:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjcGD-000513-Vd
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 22:58:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753406Ab3KUV6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 16:58:01 -0500
Received: from mail-ve0-f177.google.com ([209.85.128.177]:45975 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163Ab3KUV6A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 16:58:00 -0500
Received: by mail-ve0-f177.google.com with SMTP id db12so291395veb.8
        for <git@vger.kernel.org>; Thu, 21 Nov 2013 13:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nM9QmafyYC5MbAvgYOiFYpYnpzgYgdn/U70VFU3lTLQ=;
        b=FA8J9e8QW8to7IaZgamDQRm17G/T783Wu+EvOxCYlQxyJjIBfQG44QhdK+WOgvCTfc
         gWsB7nkiwus+g93ALhmL9UMGwvMHhNazNKX0vqi7t3/Eq/qRhjf/K06bicYGIvQ9UNxS
         /O4Tr8ykIExyyBpTA0D41m0+dvlcAC33lAx3KqSwrJ2KgXN2LjpuhHdMi1JW3uDZQgCV
         NbflAlIl2FfERZES5SA2t+rZ9TRIghSXPKraDt4g4FjZrLJB5+0+0dz9Uy+pHLDCl0gy
         Z0e397jETiB+mKfyGYJJtKjrTNP1NHyhMe2dUlT1SDJNnuey+LBVFvdOE6CZ+aVuIZM8
         ur8A==
X-Received: by 10.58.67.168 with SMTP id o8mr7986963vet.22.1385071080116; Thu,
 21 Nov 2013 13:58:00 -0800 (PST)
Received: by 10.221.61.210 with HTTP; Thu, 21 Nov 2013 13:57:38 -0800 (PST)
In-Reply-To: <xmqq61rl4jo0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238157>

On Thu, Nov 21, 2013 at 2:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>  - if it's receiving from many pushers, it races with itself; needs
>> some lock or back-off mechanism
>
> Surely.
>
> I think these should help:
>
>     64a99eb4 (gc: reject if another gc is running, unless --force is given, 2013-08-08)
>     4c5baf02 (gc: remove gc.pid file at end of execution, 2013-10-16)
>
> They should be in the upcoming v1.8.5.

Ah, great to hear. For the record, this hit me on git 1.7.1, current on RHEL6.

thanks!



m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
