From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: sadly requesting help
Date: Tue, 30 Mar 2010 19:14:15 -0400
Message-ID: <32541b131003301614iad1fedfl85020ba9e285045f@mail.gmail.com>
References: <eaacf13c1003301543r45bb18b2n1d10d209f01e3326@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Raymond Auge <raymond.auge@liferay.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 01:15:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwkeL-0002Ca-3X
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 01:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756498Ab0C3XOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 19:14:39 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51972 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756692Ab0C3XOh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 19:14:37 -0400
Received: by gyg13 with SMTP id 13so2421559gyg.19
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 16:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=OPOP+l9EkeZMSy5eePZbdI5Cr3t6ndryImlFAN/KCo8=;
        b=LryxEn9v/5XADwGKnHduHFxoay/op9KumTQ7u4jwOty866tpBlKRlvS0QrzkPzuwog
         1c+RH9fNp5sOOLLjOUlo4A1cCkHiwWu010E6BS/6AFyNe5nD7hlntBqAEmoa0NSwxK1H
         HPLOwZp6d9eMIFDWhntYk8vpRoMbMMt/JEROY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=MjsVGW5V++6RIf2U2/c+H6EAr2X+c9QO5Wx7RwjtGeA8SbFT0eL4Wtqcv9Wo2SiZ61
         FG2pLHeQMOMESHetQobczdG/04Qt6RgoD9oTyDDEyyP4i3Lacex3nrGXyZoFkuTgOO3+
         8URNAq0C2D2dyALV4mHDu74yeYRifH8k2NSG4=
Received: by 10.150.203.4 with HTTP; Tue, 30 Mar 2010 16:14:15 -0700 (PDT)
In-Reply-To: <eaacf13c1003301543r45bb18b2n1d10d209f01e3326@mail.gmail.com>
Received: by 10.151.86.14 with SMTP id o14mr6498078ybl.43.1269990875078; Tue, 
	30 Mar 2010 16:14:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143623>

On Tue, Mar 30, 2010 at 6:43 PM, Raymond Auge <raymond.auge@liferay.com> wrote:
> I tried using:
>
> git svn reset --revision 49343
>
> where 49343 is the last revision before the failure.
>
> But I'm at git version 1.6.3.3 which doesn't support the "reset" operation.

I don't know about this option, but if it sounds like it would work,
why not just upgrade your git?  It's very easy (easier than most
programs) to compile it from source.

> I tried various incantations of
>
> git reset --hard <hash>
>
> where <hash> matched the subversion revision obtained

You probably need something like:

    git update-ref refs/remotes/git-svn <commitid>

Where "refs/remotes/git-svn" is the ref that git-svn is using (you can
usually find this with "git branch -r" and then prepend refs/remotes/
to the name it gives you).  And <commitid> is the commit you want to
be the "most recent" one from svn.

You may or may not also need to delete your svn cache dir (.git/svn).
This should be harmless since git-svn can regenerate it later by
reading through your local commits.

MAKE SURE YOU BACKUP YOUR REPO BEFORE TRYING ANY OF THIS ADVICE.

Good luck,

Avery
