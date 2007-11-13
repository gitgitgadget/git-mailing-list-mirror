From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [Newbie] How to *actually* get rid of remote tracking branch?
Date: Tue, 13 Nov 2007 19:17:51 +0100
Message-ID: <8c5c35580711131017p451f831bqd928ef033c9a0e98@mail.gmail.com>
References: <874pfq9q8s.fsf@osv.gnss.ru> <200711131703.16357.jnareb@gmail.com>
	 <A919E788-C5D0-4404-95D4-869BAFE868AC@zib.de>
	 <200711131842.03622.jnareb@gmail.com> <87d4ue81tv.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Steffen Prohaska" <prohaska@zib.de>, git@vger.kernel.org
To: osv@javad.com
X-From: git-owner@vger.kernel.org Tue Nov 13 19:18:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is0L0-0000Pk-Cx
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 19:18:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755963AbXKMSRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 13:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756126AbXKMSRx
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 13:17:53 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:45449 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755963AbXKMSRw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 13:17:52 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2033685wah
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 10:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=GEbWPmBPJDTUVv5KeyalYTroQCYCIRiyusgFPspG6us=;
        b=APkF1xr3jQ78rSMlTnsWUqk+F8PjhptQv2Ou6fQlRgxlIJ19ss75CiGwki8bMZlkqEmj22hIYrY52wSicDI6o089uQz6sMKhJ6iQnZxz8hh97iPmWq2vcQt75gLPUkCBxtaBk+FVX/XcUu5T3Xyx6scXQX5ARZHZJTJefa4/XPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=poe8cqPqn5vtCuZt33mYskqhQFGB1m66DaYvCit4O9gQvBKwH8HMDuub1zdHuWjpkJ62l7KlMEhMjMaUXW74QzEBJlqa64TLOR3HBiX6sqmLQ+ip8IS5CXfYLQyyCKGOiSb/GZvbDMNizRBbJHf9yQQymVOIByNLtcUU4E+7vNU=
Received: by 10.114.92.2 with SMTP id p2mr297415wab.1194977871720;
        Tue, 13 Nov 2007 10:17:51 -0800 (PST)
Received: by 10.114.235.4 with HTTP; Tue, 13 Nov 2007 10:17:51 -0800 (PST)
In-Reply-To: <87d4ue81tv.fsf@osv.gnss.ru>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64821>

On Nov 13, 2007 6:58 PM,  <osv@javad.com> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> > Steffen Prohaska wrote:
> >> It doesn't make sense to delete remote-tracking branches
> >> locally if they are still present at the remote.  The main
> >> purpose of a remote-tracking branch is to be identical to the
> >> real remote branch.
> >
> > True, but it would be nice to have an option to _exclude_ some
> > branches from fetching (for example 'html' and 'man' branches
> > of git.git), while still picking up new branches automatically
> > on fetch.
>
> Guys, could you please read man git-branch?

I understand that the man-page could be confusing, the problem is that
these examples are quite old: they made more sense when git didn't
support wildcards in refspecs.

You want an easy way to tell git to stop tracking the pu-branch. This
can be achieved by editing the [remote "origin"] section in
.git/config: remove the fetch-line containing refs/heads/* and add one
fetch line for each ref you'd like to track. But beware that you have
to add any new branches which you would like to track in the same way
(editing .git/config).

The reason git-branch -d -r doesn't do this automatically is probably
that nobody has seen a need for it to do so...

--
larsh
