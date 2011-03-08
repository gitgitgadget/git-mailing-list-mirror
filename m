From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: how to list commits on branch since last merge
Date: Tue, 8 Mar 2011 04:35:16 -0500
Message-ID: <AANLkTinOEutM92k4SUGEXbfTpzGcQitpW4CZbcQbg0R4@mail.gmail.com>
References: <AANLkTi=zW9hOhnddw6HsjQwV2qLf_R_qeNna+XeN6U6x@mail.gmail.com> <4D75ED72.8030203@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 08 10:35:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwtKf-0000cW-2x
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 10:35:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212Ab1CHJfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 04:35:50 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38065 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156Ab1CHJfr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 04:35:47 -0500
Received: by iwn34 with SMTP id 34so4697714iwn.19
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 01:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=vPd0HVjMgvOamKuDVUdbtdjjAH4i1dzyCGBCgV4Qt64=;
        b=GTAkBeqfgmPV0OH8CSbSCuG8OoKmK6wIXro9lphi4UHbKJxovd/K7U0x29WQ+CvKqX
         y2/58Ha0XLhAYG0rFa72mRFJ0/RLzYJNRLS+7i8uz4apbdP4oMGm+TnFpvimZTAMSBPj
         cFwgfu5uPBR9ojaHMuNtYgbaSY5zqXODjh7+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=gkbyuhTIhNN0e3jvYBJ+7UPd4bgCbR0OHeQfFfwEw54+PRLIRNYCENle885a4n3pxp
         7LMQyj77cPJaF4cummX0y1rZOY1wTAVvG6+BQFPKDlwSD2NXuTTFzZYFo0nQXdyLuu6S
         9Xr6kiXqjTE1Mh3tGMMZN5aKwGzsi7GrEog6U=
Received: by 10.231.112.211 with SMTP id x19mr3730460ibp.182.1299576946187;
 Tue, 08 Mar 2011 01:35:46 -0800 (PST)
Received: by 10.231.34.7 with HTTP; Tue, 8 Mar 2011 01:35:16 -0800 (PST)
In-Reply-To: <4D75ED72.8030203@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168649>

On Tue, Mar 8, 2011 at 3:48 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Have you tried:
>
> git rev-list --ancestry-path --left-right foo...bar
>
> If the ">" commits are the ones that you want you only have to wait for
> the "--right-only" option which is cooking in pu. And grep '^>' for now ;)

Ah. The rev-list man page entry on --ancestry-path only talks about
using it with '..', so I didn't even try it with the symmetric diff
operator ('...').

That said, seems it would be useful to have an easy way to get to the
merge which has a merge-base as one of its parents. Maybe even a
generic way to find all commits which have a particular parent. I
think rev-list --parents | grep is the only way to do that today.

Thanks,

j.
