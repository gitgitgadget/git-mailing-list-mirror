From: Dan Johnson <computerdruid@gmail.com>
Subject: Re: [PATCH] git-am: Handle "git show" output correctly
Date: Wed, 12 Sep 2012 18:31:03 -0400
Message-ID: <CAPBPrntXCDHwWkYV3pnj3+d8FCZCmEVPHkSxyVg0Jzd0tzZsGA@mail.gmail.com>
References: <1347472823.12986.3.camel@eddie.install.bos.redhat.com>
	<1347473304-21418-1-git-send-email-pjones@redhat.com>
	<7vtxv3atvu.fsf@alter.siamese.dyndns.org>
	<1347482918.21933.5.camel@eddie.install.bos.redhat.com>
	<7vpq5raqiq.fsf@alter.siamese.dyndns.org>
	<CAPBPrntHOpDaH3cSNiKKxVJDbZTpPrLc99TgPM_GdoXecUvs9w@mail.gmail.com>
	<7vhar2c29s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Peter Jones <pjones@redhat.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 13 00:31:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBvSx-0001xz-P4
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 00:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373Ab2ILWbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 18:31:06 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:45400 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522Ab2ILWbF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 18:31:05 -0400
Received: by eekc1 with SMTP id c1so1630092eek.19
        for <git@vger.kernel.org>; Wed, 12 Sep 2012 15:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=i+OjzEpc943SHBu1IFrGDFOgA70x/lVpn66oQwaYcTA=;
        b=oI5YJDcNeNQODusirMjGbLZi/NNeVCm6pFzFeDqBO3exAjjJvvKJtKnjCQ4D2wzJAb
         NZk2L1W/K7wIZa0PwHzK2gMYm1fAXseiieklbA8oqhkydgTFXDZdNbD1cWxDZK9HvvmX
         LYkemH6SZ+hfIuwDu7Cfn4wTCRDLsPMrQGW2etDsZQXGaiqro6Ia1PFC+t6wxcsdIqWQ
         7JDaFdBlz5X6aELOwFLhY042wx2qR2pyRDy91xY1wAi+yjBXQiIM8JrNzcuL3nodsD46
         rfRgOKDjj708s2plQiSTpSsIjmH4PQjM6CitzXvM8pH7BsIkghqFjYsXy94QQFOh8MoK
         L6Jg==
Received: by 10.14.4.201 with SMTP id 49mr92340eej.0.1347489063436; Wed, 12
 Sep 2012 15:31:03 -0700 (PDT)
Received: by 10.14.119.199 with HTTP; Wed, 12 Sep 2012 15:31:03 -0700 (PDT)
In-Reply-To: <7vhar2c29s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205345>

On Wed, Sep 12, 2012 at 6:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Dan Johnson <computerdruid@gmail.com> writes:
>
>>> Not really.  If we start encouraging people to use "git show" output
>>> as a kosher input to "am", we would have to support such use
>>> forever, and we end up painting ourselves in a corner we cannot get
>>> out of easily.
>>
>> If git am emitted a warning when accepting "git show" output, it seems
>> like it would support Peter's use-case without encouraging bad
>> behavior?
>
> Are you seriously suggesting me to sell to our users a new feature
> saying "this does not work reliably, we would not recommend using
> it, no, really, don't trust it." from the day the feature is
> introduced, especially when we know it will not be "the feature does
> not work well yet, but it will, we promise" but is "and it may become
> worse in the future"?
>
> I do not see much point in doing that.
Fair enough.

> Besides, what bad behaviour do we avoid from encouraging with such
> an approach?  As Peter said, the problem is not on the part of the
> user who ended up with an output from "git show", when he really
> wants output from "git format-patch".  Giving the warning to the
> user of "git am" is too late.
I was assuming Peter would accept the patch, and reply with a "in the
future, please submit the output of format-patch", thus correcting the
submitter's behavior. This warning would serve someone who did not
know that they wanted the output of format-patch, and hopefully teach
them to send such a reply message.

> I may be able to be pursuaded to swallow a new script somewhere in
> the contrib/ hierarchy that takes a "git show" output and formats it
> to look like "format-patch" output to be fed to "git am".  That way,
> when a user has trouble with its parsing of "git show" output, at
> least we can ask for the output of the format massaging step to help
> us diagnose where the problem lies.

That sounds like a better approach to me as well.

-- 
-Dan
