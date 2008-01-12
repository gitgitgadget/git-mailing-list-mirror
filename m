From: "Stephen Sinclair" <radarsat1@gmail.com>
Subject: Re: [PATCH] Add committer and author names to top of COMMIT_EDITMSG.
Date: Sat, 12 Jan 2008 02:26:24 -0500
Message-ID: <9b3e2dc20801112326p2b4eaf96tbd036ed746eff4a3@mail.gmail.com>
References: <9b3e2dc20801111210n7bd7a71cw437819aa6253ae85@mail.gmail.com>
	 <7v3at42avd.fsf@gitster.siamese.dyndns.org>
	 <9b3e2dc20801111609t3103af1frc23519cab43ae8be@mail.gmail.com>
	 <7vbq7r28qo.fsf@gitster.siamese.dyndns.org>
	 <9b3e2dc20801111733o477b3aadv6ee76d3aafade54a@mail.gmail.com>
	 <7vejcnzu5z.fsf@gitster.siamese.dyndns.org>
	 <9b3e2dc20801111825i644da598i7556ef700b870445@mail.gmail.com>
	 <7vve5zy72p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 08:27:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDalw-0008Qn-FI
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 08:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760634AbYALH02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 02:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760804AbYALH02
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 02:26:28 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:9440 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760323AbYALH01 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 02:26:27 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1166431rvb.1
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 23:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=XGUb4eXBbPnokIeeKDdFfy9ik+AkFgOFVChnBn8FPBk=;
        b=FnX+yPZwINtQmZqkjjgYRbET3GTpa2SDpsbQraGUy72tF4F4vXp1D5BDeNI4xiKcotF+fKYMpJb70KVdd/CRfdAIAXNTvi1TqAos6kp72JQZG08M1vJ3eEOH34SfCtF9mFs+FHGj8nU/fFXj0pgU/Qzi1TLFEtMMo866ml9hERs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UgW7fFQ1Ty9kEJ4EW+f5Fw7szKk7cnNNItNwRdCsY4Hfe5qkFN3hXmdL0OG5zn7/khsWWXa9bn1PjPuxoe1PGziNeZJirpWi4pJpym3j7wNmrm8FVgFid0w6Cn+lroSadftffwZzTXsUXYkpVrsTExGken+GJMwAmJeeQ41TvQM=
Received: by 10.141.145.11 with SMTP id x11mr2520695rvn.264.1200122784174;
        Fri, 11 Jan 2008 23:26:24 -0800 (PST)
Received: by 10.140.188.1 with HTTP; Fri, 11 Jan 2008 23:26:24 -0800 (PST)
In-Reply-To: <7vve5zy72p.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70282>

> You omitted the part that matters from the part you quoted
> above, but this discussion was about "showing AUTHOR if it is
> different from me", which was _one of_ the two conditions I
> suggested in my counterproposal, and I was saying that it is
> useless to expect that you would be able to find a
> misconfiguration when AUTHOR is shown for this first reason.
> This part is _not_ about catching your misconfiguration.
>
> The other part is about the misconfiguration catching.

Okay, sorry I guess I was misreading it because that wasn't really my
original intention with the patch.  However in that context I can see
that showing author information when it differs from yourself could
definitely be useful.


> Yes, and earlier you said one of the undesirable ones was
> "yourname@foo.local" (and others were "yourname@foo.(none)").
> IOW, "localhost" is one of the things you want to catch as
> unconfigured bogosity that you want to catch, isn't it?

Well, it was only an example to show that it's easily possible (in
fact, common) to have hostnames that are not configured as actual
email domains.  The fact that the hostname contained the word "local"
was an indication, but I'm not really sure that filtering for that
word in the hostname would be such a good idea.  I'm also not sure how
many admins will even end up sticking ".local" as their domain, it's
probably just a quirk of the administrator for my lab.

I guess "localhost" really clearly is a "bogus" host name, but other
than that I can't think of any real rules that would make sense.
Rather, IMHO, the error is earlier in the chain: doing anything with
the hostname in the first place.


> To rephrase, you would show AUTHOR when one of the conditions
> holds true, either:
>
>  (1) "not me" (so that we can remind that other's commit is
>      being amended); _OR_
>
>  (2) "funny me" (so that we can catch misconfiguration.

I definitely agree with (1), though having not really done much
amending of other people's commits I can't vouch for it.  I think (2)
might not be very reliable.


Since submitting the patch, I have added a post-receive hook to my
repo which checks all incoming commits and verifies whether any names
or email addresses are not in a whitelist.  If any are flagged, a
warning is displayed.  This is actually quite satisfactory for me,
since it'll warn me when I accidentally push commits with the wrong
name to my private repo, but before I push to public.  Let me know if
something like this would be useful for the contrib folder..

Steve
