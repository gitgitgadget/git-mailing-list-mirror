From: "Mark Levedahl" <mlevedahl@gmail.com>
Subject: Re: [PATCH] Teach remote machinery about remotes.default config variable
Date: Fri, 11 Jan 2008 15:52:12 -0500
Message-ID: <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	 <1200022189-2400-2-git-send-email-mlevedahl@gmail.com>
	 <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 21:52:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDQry-0003kx-Ch
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 21:52:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbYAKUwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 15:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbYAKUwQ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 15:52:16 -0500
Received: from nz-out-0506.google.com ([64.233.162.227]:14213 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbYAKUwP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 15:52:15 -0500
Received: by nz-out-0506.google.com with SMTP id s18so749320nze.1
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 12:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=b2EeBJe0Ty3TJqi1OtGFewb1hfHZV1vGv5VaDhEh+vI=;
        b=K5g5ad4gtOsHJK6s0oyxPbqvY0G2UmGgudy2p/2idEipIRDbIiT0VJi5BExSab4ewshkmaE2ZxZ6bkwxpWlyN7w3n7grDyL8AQ2vR/RqeahUuRYMb/K7Of74rKraejSoxpLVSzLA3oQ5iSn+nHRdSX6SzedTdR6nLfl3+mqWKkc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ClAhEnzyYFW/bTagfVLo2uwrJ19wPHGaAKNVkFgfuRVJWiq+HKWqukt43NP8chhkBmuRu7++0YxVnQdWZTrJUJqicLCqvt6nzbXWQuVYNQyGsFHKKNHAjoiBmCoyYvtNQ9eYBFK1BjPkJSibvx33XUAABYDpnkilREbhb3rA/+U=
Received: by 10.142.246.8 with SMTP id t8mr1958035wfh.199.1200084732068;
        Fri, 11 Jan 2008 12:52:12 -0800 (PST)
Received: by 10.143.159.5 with HTTP; Fri, 11 Jan 2008 12:52:12 -0800 (PST)
In-Reply-To: <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70199>

On Jan 11, 2008 3:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Does this mean "default" is now a new reserved word that cannot
> be used as "git remote update default"?

oops...git-remote already has a (partially undocumented) use for
remotes.* as well as remote.*, so I need another variable name,
probably core.origin to avoid either defining new namespace or
polluting one reserved for arbitrary end-user use. Will resend patches
later tonight.

>
> However, it is a bit hard to judge how much of inconvenience it
> really is in your real life that the current behaviour does not
> allow you to.

I believe I addressed this in the thread with Dscho.

> >       git_config(handle_config);
> > +     if (!default_remote_name) {
> > +                     default_remote_name = remotes_default_name ?
> > +                             remotes_default_name : xstrdup("origin");
> > +     }
>
> Is this a bit too deep indentation?
>

will fix.


Mark
