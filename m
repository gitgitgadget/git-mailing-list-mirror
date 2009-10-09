From: Christian Couder <christian.couder@gmail.com>
Subject: Re: combine git repo historically
Date: Fri, 9 Oct 2009 09:40:47 +0200
Message-ID: <c07716ae0910090040j4868edf4x12eea330416b8ccb@mail.gmail.com>
References: <20091009012254.GA3980@debian.b2j> <4ACED204.3000907@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 09:43:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwA8t-0004jG-IR
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 09:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427AbZJIHlZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Oct 2009 03:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbZJIHlY
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 03:41:24 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:51889 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbZJIHlY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Oct 2009 03:41:24 -0400
Received: by fxm27 with SMTP id 27so6172232fxm.17
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 00:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=F7NfbsymxMzffNY5Y3fdAjpDDrluVd6fajqfQT0x2ZI=;
        b=LMhWzEHTul+1HBxM8Kw7FLKF2PqsnNl4j93pGiE9moT+dC2bwvyq68+xLT0OLtIDn9
         2a2h8caLYsofs1p5gWCNjmcHO362Le2bu90C/XVpAMTgGFRNY2m2+TK3flslQexw3BGs
         vBvwwZenJYfN1mNaojGeX8+ckcuOuir0PrY1A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jakMDSUBuxgrIme0O4huA3Qy5J6YEsEznn6CP6CTWcc8uNyTkg1Q0H2X39otPf2jOS
         BzKy3rEr/avWQHM975jWaGmxBlx5X5JAL3y+r04rid/IYex/yA6dTrJ746M5lhzWHsoc
         KspZOwn7Crvdo551tFMXoPMRYF7fRcD4VoFsk=
Received: by 10.103.84.12 with SMTP id m12mr928064mul.79.1255074047197; Fri, 
	09 Oct 2009 00:40:47 -0700 (PDT)
In-Reply-To: <4ACED204.3000907@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129749>

On Fri, Oct 9, 2009 at 8:02 AM, Johannes Sixt <j.sixt@viscovery.net> wr=
ote:
> bill lam schrieb:
>> I have two git repos, no branches.
>>
>> repo 1.
>> =A0 emptyrootcommit -- A ... M
>>
>> repo 2.
>> =A0 emptyrootcommit -- N ... Z
>>
>> N was evolved from M but the time gap is large, how can I combine th=
em
>> into one repo
>>
>> emptyrootcommit -- A ... M -- N ... Z
>>
>> so that snapshots N .. Z will not be changed.
>
> $ echo $(git rev-parse N) $(git rev-parse M) >> .git/info/grafts
> $ git filter-branch --tag-name-filter cat -- --all --not M
>
> i.e. you graft the older history right before the younger history, th=
en
> you use git filter-branch to rewrite the parentship of the younger co=
mmits.

If you cannot create a new history, using "git replace" could be
better than using grafts.
("git replace" is in the "master" branch in the git repository. It
will be in git 1.6.5 that should be released soon.)

Regards,
Christian
