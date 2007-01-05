From: "Chris Lee" <chris133@gmail.com>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Fri, 5 Jan 2007 11:33:45 -0800
Message-ID: <204011cb0701051133r1ede14a6gd5093a3e7fa88cb5@mail.gmail.com>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
	 <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org>
	 <7v1wmbnw9x.fsf@assigned-by-dhcp.cox.net>
	 <204011cb0701040958k884b613i8a4639201ae6443b@mail.gmail.com>
	 <7v1wmalez6.fsf@assigned-by-dhcp.cox.net>
	 <204011cb0701050919w2001105asefe2fd99165dfa95@mail.gmail.com>
	 <7vbqldfg56.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 05 20:34:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2up5-0003BA-FN
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 20:33:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422694AbXAETdr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 14:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422693AbXAETdr
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 14:33:47 -0500
Received: from wr-out-0506.google.com ([64.233.184.238]:35857 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422690AbXAETdq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 14:33:46 -0500
Received: by wr-out-0506.google.com with SMTP id 68so1140335wri
        for <git@vger.kernel.org>; Fri, 05 Jan 2007 11:33:46 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RpmtJPL2pd7aRXqeYjc7ueSRCEA/kB+AssU9UYcQEbMukrBsFLauDqDwaajwpTITZipOfaHX25Qw9J44tBJubOC4QG9Vxpq40X7tYn0CV4TCQ7eFBpB8IX6dNCuZ6a49660J/Dc1eH0fQMuAvjNUHqihKcOTZkCk3/S6T676kjw=
Received: by 10.90.98.10 with SMTP id v10mr873461agb.1168025626337;
        Fri, 05 Jan 2007 11:33:46 -0800 (PST)
Received: by 10.90.81.19 with HTTP; Fri, 5 Jan 2007 11:33:45 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vbqldfg56.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36014>

On 1/5/07, Junio C Hamano <junkio@cox.net> wrote:
> > Using git-verify-pack from master does not fail. It actually does
> > verify the pack (after a pretty decent wait.) I should have tried
> > master first before sending out the first mail. :)
>
> Depends on which "master" -- I pushed out the "chuncked hashing"
> fix on "master" as commit 8977c110 as part of the update last
> night.

Well, that would definitely explain it. :)

I did a fresh 'git pull' on master last night before I ran the
git-verify-pack, and that was around 11PM PST.

> > Junio: Did you still want me to try those steps with that patch
> > anyway, even though it works on master?
>
> It would give us a confirmation that the above actually fixes
> the problem, if your 1.4.1 fails to verify that same new pack
> you just generated, on which you saw that the "master" (assuming
> you mean the one with the above patch) works correctly.
>
> If your "master" before 8977c110 already passes, then there is
> something else going on, which would be worrysome.

The 'master' I had definitely included 8977c110. I can try it out with
the tip from before that commit, though, if you want.

Also, 'git-prune' took about 30 minutes to run to completion. Oddly,
git-prune didn't remove the older packs - does git-prune ignore packs?
'git-repack -a -d' did remove them.
