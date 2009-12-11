From: Jeenu V <jeenuv@gmail.com>
Subject: Re: Ambiguous ref names
Date: Fri, 11 Dec 2009 13:33:09 +0530
Message-ID: <5195c8760912110003u6deabf7ey44b1f2dd448ce7fe@mail.gmail.com>
References: <5195c8760911200218v5b75d690hbaaf00b44c8df6af@mail.gmail.com> 
	<7vzl6h3319.fsf@alter.siamese.dyndns.org> <5195c8760911200248v1f3d6b56q78987edfceae5541@mail.gmail.com> 
	<7vpr7dzckl.fsf@alter.siamese.dyndns.org> <5195c8760911200355x1aff9781l848f974c9f09f416@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 11 09:03:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJ0TS-0008R4-G2
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 09:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760802AbZLKIDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 03:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760686AbZLKIDX
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 03:03:23 -0500
Received: from mail-vw0-f197.google.com ([209.85.212.197]:54948 "EHLO
	mail-vw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759529AbZLKIDW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 03:03:22 -0500
Received: by vws35 with SMTP id 35so191137vws.4
        for <git@vger.kernel.org>; Fri, 11 Dec 2009 00:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type;
        bh=Ne4R/jnkfrAVBCFtQHygCcbCMCd0eKXbBNip6yUradg=;
        b=PDxmxNTTU1AdbOBxcopHoUqCYVbhKzhkzNT9ETGa7A4NUQSC7w0AI7uCcty0v3zgdk
         t+H+apezlUPSMQrL3I7yUKI0abqvo/KVHotFTj4qEqYeTH40/Ys9HyfaldNo5Y2sUsuT
         upe0fQslGIG0ewd5fb3hOfwC+BUkMFiTdRrAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=MfrPJEFDKaaXPdDkmeTdNKXcSFngoer6phDqgi68wsyqja6AMBiQsIjurq62UC1dNt
         j1/iSc7pmn/fnpCht0BMYbmJHUGUs9SmUNboh36lflAwKB/hpVOuxZRtfqUtn93Y8XzT
         1OXPijGyc6llFvhARiNVPQ3K03hwMRzrda8Sw=
Received: by 10.220.124.223 with SMTP id v31mr152765vcr.89.1260518609163; Fri, 
	11 Dec 2009 00:03:29 -0800 (PST)
In-Reply-To: <5195c8760911200355x1aff9781l848f974c9f09f416@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135073>

On Fri, Nov 20, 2009 at 5:25 PM, Jeenu V <jeenuv@gmail.com> wrote:
>
> On Fri, Nov 20, 2009 at 4:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Jeenu V <jeenuv@gmail.com> writes:
> >
> >> On Fri, Nov 20, 2009 at 3:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >>> [...]
> >>> It could be that you have a tag and a branch that are both named a.b.c,
> >>> though.
> >>
> >> Hm, right. But I'm getting this from an existing local repo of mine. I
> >> can't see any tags; 'git tag -l' is empty. Is there any more info that
> >> I can provide?
> >
> > man git-for-each-ref?
>
> It does list all refs that I know of, but I don't see any duplicate entries.

Ah, I think I get what happened here: I had used git update-ref, which
turned out to be used wrongly. My intention was to update a.b.c to a
new ref, but I used it 'git update-ref XXXXXX', rather than 'git
update-ref refs/heads/a.b.c XXXXXX'. The wrong usage created
.git/a.b.c and I guess this was causing the warning.

--
:J
