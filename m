From: Lasse Makholm <lasse.makholm@gmail.com>
Subject: Re: How to split a big commit
Date: Tue, 5 Apr 2011 04:31:54 +0200
Message-ID: <BANLkTikZ_-OE1u_T+wGkYa3cSN0-KL-bGg@mail.gmail.com>
References: <BANLkTikFXzut7fY5Tr0u-abu5Q0rMUOCmA@mail.gmail.com>
	<20110405000852.GA1704@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 04:32:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6w3k-000828-4d
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 04:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758Ab1DECbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 22:31:55 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50376 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455Ab1DECby (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 22:31:54 -0400
Received: by pwi15 with SMTP id 15so1653985pwi.19
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 19:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=fStMPKRuRq4swA4+ht9c6uswFapDrgrSmltf5fM5jcw=;
        b=kJ2OO2iM2LBi/nwDw51mubk/a17avm5r8qsReC3idy9ApdEoke4oYXQhFFDbMBvkS+
         Hary3y+ZNJWf1RElr6J8Ure7GDo0M7DsZbJhi1Ib+dCDZwZiSXi14e5H2L84essVln4C
         UNcjtH0AiJgnNYez1Y5NzOt6vqEVwMdIDodZE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=svRaj650UEnJKYucc8CaN9bnDcTS3PfXTQXujSs+42TTHdyWy0XAqtqSLq9wSFAU3m
         FFSLgh5/DRT0vAt3EW8Sg5py2hHNBso/XmcN6fCvA8Vn0BNpGm6e+Ib6y0rXwENcC2/B
         C1F8j2XeglnduUfzFfkgUc5SAFremab6kEnoI=
Received: by 10.142.165.14 with SMTP id n14mr328405wfe.109.1301970714332; Mon,
 04 Apr 2011 19:31:54 -0700 (PDT)
Received: by 10.68.46.39 with HTTP; Mon, 4 Apr 2011 19:31:54 -0700 (PDT)
In-Reply-To: <20110405000852.GA1704@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170862>

On 5 April 2011 02:08, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi Duy,
>
> Nguyen Thai Ngoc Duy wrote:
>
>> After a lot of small commits and a few mixed up large commits, it was
>> too messy that I merged them all into one big commit then started
>> spliting it into smaller, reasonable patches. Just wonder if anybody
>> else faces the same thing and how they deal with it. I used "git reset
>> --soft <big commit>^" and "git add -N" because there were new files,
>> but it was clumsy.
>
> I tend to do "git reset HEAD^ -- ." and then "git add -N ." and
> "git add -p", for what it's worth.

In addition, after you've added some hunks, use git stash to stow away
all the other changes to test each new commit seperately.

/Lasse
