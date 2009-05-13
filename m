From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Quote LF in urls git fetch saves in FETCH_HEAD
Date: Wed, 13 May 2009 14:10:32 +0200
Message-ID: <81b0412b0905130510n61d59f54rf385a89bbb43a530@mail.gmail.com>
References: <200905112208.21017.Hugo.Mildenberger@namir.de>
	 <7vws8l7w0d.fsf@alter.siamese.dyndns.org>
	 <81b0412b0905122306w4ed41bdiab073a05587fab55@mail.gmail.com>
	 <200905131340.31509.Hugo.Mildenberger@namir.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Hugo Mildenberger <Hugo.Mildenberger@namir.de>
X-From: git-owner@vger.kernel.org Wed May 13 14:10:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4DIO-0005Cc-LS
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 14:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759776AbZEMMKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 08:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759186AbZEMMKe
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 08:10:34 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:34186 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759627AbZEMMKd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 08:10:33 -0400
Received: by bwz22 with SMTP id 22so600681bwz.37
        for <git@vger.kernel.org>; Wed, 13 May 2009 05:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HfdebyNbojJ+tBODiJxQbnMcHgsjMwtk6qXrsgz5is8=;
        b=oJHLJu/omZz4sJMbNmswyf2Ln80XtgSNHjo8CWjvmIaaoM3BWlmxUaczp9MxTbVjyT
         FvOvtZ6ozz8Nkh//L22dAwxQAQHPOCEdazBhyK9reLtmzYyBTir51XDC6fCEYDpbXnw1
         5BvKxvuBYea8+CBv8mjpornzbkhL0N3O9ShsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rO4YWhz4+KoYiNNdM55y19pGuifgQbD83lOrxne22oTC3Qn4MNi3Z+q5GY5AwOMNIF
         Tt1x2/oJ2GFif14xzyNWSPMNvXCKP8D4qiqkO/xxfQbHEyrbzwKfkpiALta+jdJKFa2g
         1IDm60vIPirory8qD0KufXJlJxf2dHjhktPHs=
Received: by 10.204.59.18 with SMTP id j18mr833287bkh.206.1242216632672; Wed, 
	13 May 2009 05:10:32 -0700 (PDT)
In-Reply-To: <200905131340.31509.Hugo.Mildenberger@namir.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119042>

2009/5/13 Hugo Mildenberger <Hugo.Mildenberger@namir.de>:
> Am Mittwoch, 13. Mai 2009 schrieb Alex Riesen <raa.lkml@gmail.com>
>>
>> That'd mean to loose the information completely. Which is just as bad
>> as putting the LF in the url in the first place.
>
> This stray linefeed is not information, but pure contamination. Thus it
> would be much better to simply strip it off.

Not at the place where the patch changes it. In git clone, maybe (the many
times mentioned guessing function). But then, we have to provide an option
to leave the names alone, verbatim (which, I think, the non-quessing form
already provides. No additional coding necessary).

> And besides from the fact that git apply rejects this patch (fatal: corrupt
> patch at line 6),

This is your local problem. Maybe you copied the patch through clipboard
and it kept the presentation in KMail, or KMail generally corrupts
mails, I don't
know. Just save the mail as is and do "git am -3" on it.

> I think it would also not handle the equally wrong repository directory name on disk,

You think wrong. It does handle it perfectly.

And it is not wrong. It is just how it is. Don't spend too much time in MacOS
and that overgrown DOS. They'll wreck your brain.

> which then possibly leads to subsequent make failures (as it actually happend in
> the case I described earlier here.)

The make(1) works in such directories just fine. Fix yours (thinking about
it now - you wont find a make which does not work in such directories).

> Why not just return to your original idea, which proposed testing the
> repository name against a regular expression describing a forbidden
> set of characters (which is "\n", currently) and then terminate with a
> clear message?

The idea was not abandoned nor followed upon. It's just I don't need that
warning and would switch it off immediately anyway (if it was implemented).
I just spent a minute thinking about it (that's where regexp idea came from).
I'm not going to work on it (at least, not right now). I'm even sure you wont
be working on it too, now when you have learned what the problem is and
how to work around it. And that's while all you needed is to put a two-three
lines in that guessing function...
