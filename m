From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: how to list commits on branch since last merge
Date: Tue, 8 Mar 2011 04:43:26 -0500
Message-ID: <AANLkTikK8Uc8=wKROYWWxZ_6OtQtqBmFCZN760M1LO+c@mail.gmail.com>
References: <AANLkTi=zW9hOhnddw6HsjQwV2qLf_R_qeNna+XeN6U6x@mail.gmail.com>
 <4D75ED72.8030203@drmicha.warpmail.net> <AANLkTinOEutM92k4SUGEXbfTpzGcQitpW4CZbcQbg0R4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 08 10:44:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwtSx-0003gx-F1
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 10:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753962Ab1CHJn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 04:43:58 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42531 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367Ab1CHJn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 04:43:57 -0500
Received: by iyb26 with SMTP id 26so4686889iyb.19
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 01:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=4zDXTQY/VuDLzKlXrQ8t+cJPBNrjopa/X1KzCjM0xIw=;
        b=e2vkmr0bNwnWenMgsovWHFtDahBt7tJYcyNzZwAJLZ2OE3PtbhReq6J2KTZnzR/rcZ
         yCF/qLTdnGCH/ZrJm2IfOMwPIckciVZVPsodvvTECZcsfLYQVk1NOm4fDecYVznR0Du7
         NqWPhsCNnCutq2oyhGAj019pIDlIVSGBz1IME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=oMskdIyu72WG/8QKFOjK3R7OVGPBzNji0p6FbP0qbkrgwy2mo0RJlUd+vqcNkBG7wd
         Zysh9A4i2nxJ5mMzDSKCPcJpetg2V+GikjYe9FTIrQ7o8bXvc+yGbPLAR18Qq5fbGi87
         Z1eJHZF1WoDnc/Ht3893zQvD2YdArBbuQca9Y=
Received: by 10.42.137.198 with SMTP id z6mr6240049ict.261.1299577436226; Tue,
 08 Mar 2011 01:43:56 -0800 (PST)
Received: by 10.231.34.7 with HTTP; Tue, 8 Mar 2011 01:43:26 -0800 (PST)
In-Reply-To: <AANLkTinOEutM92k4SUGEXbfTpzGcQitpW4CZbcQbg0R4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168651>

On Tue, Mar 8, 2011 at 4:35 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
> On Tue, Mar 8, 2011 at 3:48 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Have you tried:
>>
>> git rev-list --ancestry-path --left-right foo...bar
>>
>> If the ">" commits are the ones that you want you only have to wait for
>> the "--right-only" option which is cooking in pu. And grep '^>' for now ;)
>
> Ah. The rev-list man page entry on --ancestry-path only talks about
> using it with '..', so I didn't even try it with the symmetric diff
> operator ('...').

And with the clue to use '...', it's easy:

  $ git log --ancestry-path foo...bar ^foo

Still want an easy way for merge-base to report the merge which
contains the merge-base. That will wait for another day.

j.
