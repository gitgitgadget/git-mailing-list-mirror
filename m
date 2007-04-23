From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-checkout changes the index but not the checked out files?
Date: Mon, 23 Apr 2007 12:45:06 +1200
Message-ID: <46a038f90704221745h1bf2955cyfb40f6e8c08a336d@mail.gmail.com>
References: <46a038f90704221625k216864cdwb2b35bc035fac7e9@mail.gmail.com>
	 <7virbokmx1.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90704221717i8e5c1bkff066dcbdb0a0523@mail.gmail.com>
	 <7vabx0kk4z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 23 02:45:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfmgT-0003ep-48
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 02:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbXDWApJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 20:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbXDWApJ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 20:45:09 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:13391 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030307AbXDWApH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 20:45:07 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1605463wxd
        for <git@vger.kernel.org>; Sun, 22 Apr 2007 17:45:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ggYgsIylfz2Z8r2/c+rYuhUa1/Av0rWVzOZNm0yjBFUHzoYDmD1M5Ol4jL3A4uRvhwrMKTafp4IbmvHHnf/W7LJ9azi8SYYN+Wifn/qzYohbSyEmcE7RrZPAO8qBBwLk1uMS7pvEyRySbs2QFQcysj0G1EA4Cioem41mjShr+zE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k2JHS6uKdwYNoMQ4myHyiCLEqB6SwLApmM0Mk73xcB6CcFhawccdQ5Sz9wNQUxL4SDlwnege8dpT9YQTUgtj+61KoqjJ1Tlw38uWe4lzqvXGdIYZwZewDfbVb/ldADQ7zyQsEOa+RAKoxixyLyMEM7iBPNQ7m6+6ztKPEDSvcJQ=
Received: by 10.90.49.1 with SMTP id w1mr4287161agw.1177289106983;
        Sun, 22 Apr 2007 17:45:06 -0700 (PDT)
Received: by 10.90.52.17 with HTTP; Sun, 22 Apr 2007 17:45:06 -0700 (PDT)
In-Reply-To: <7vabx0kk4z.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45293>

On 4/23/07, Junio C Hamano <junkio@cox.net> wrote:
> > but the ambiguous "git-rev-parse --verify 'mdl18-local^0'" returns the
> > SHA1 for a head called 'mdl18-topnz' that I am not asking for. Why?
>
> Maybe you have a branch that is exactly the same name as a tag?

Nope - none of the tags look _anything_ like mdl18-local. See
http://git.catalyst.net.nz/gitweb?p=moodle-r2.git;a=tags

I think mdl18-topnz was the first local branch I created in this checkout.

Hmmmm. There was a .git/mdl18-local file that had the bogus SHA1 in
it: a26c09be05a08e5f911ef84b5f8010ba155ea77d . I don't know how it got
there and how it had the wrong sha1 in it. Removing it has fixed it.

The _really_ strange bit is that it was attempting to merge 2 heads of
the same name. It'd probably be something to block...

cheers,


martin
