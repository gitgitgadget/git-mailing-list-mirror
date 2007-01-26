From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] fmt-merge-msg: detached HEAD
Date: Fri, 26 Jan 2007 10:45:38 +0100
Message-ID: <8aa486160701260145i4c50d564n90967a07f7ee62a9@mail.gmail.com>
References: <87zm875d9u.fsf@gmail.com>
	 <7vireu63rg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 26 10:45:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HANeR-0008OM-RA
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 10:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161006AbXAZJpl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 26 Jan 2007 04:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161012AbXAZJpl
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 04:45:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:20800 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161006AbXAZJpk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jan 2007 04:45:40 -0500
Received: by ug-out-1314.google.com with SMTP id 44so671024uga
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 01:45:39 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kAQ7l51PsGpp3LNrsHwDBcmFGcmYRum1DQjnKrTCL1IZqdHD7CyyV/9RJ/pGgo3Ee8jhTtuqbxdSerWK3rs2NO2XENkjnNaquHiRjTop1GX7GjvwNjnBKviK161aE1wJTwc7+5Vtfon9nFX5RF+ORs+MBA2VUxoRWkDJ0V8V0Ws=
Received: by 10.78.170.17 with SMTP id s17mr677569hue.1169804738896;
        Fri, 26 Jan 2007 01:45:38 -0800 (PST)
Received: by 10.78.68.8 with HTTP; Fri, 26 Jan 2007 01:45:38 -0800 (PST)
In-Reply-To: <7vireu63rg.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37826>

On 1/26/07, Junio C Hamano <junkio@cox.net> wrote:
> Santi B=E9jar <sbejar@gmail.com> writes:
>
> > Do not say 'Merge ... into HEAD' when detached.
> >
> > Signed-off-by: Santi B=E9jar <sbejar@gmail.com>
> > ---
> >  builtin-fmt-merge-msg.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> >
> > diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
> > index 87d3d63..8cef425 100644
> > --- a/builtin-fmt-merge-msg.c
> > +++ b/builtin-fmt-merge-msg.c
> > @@ -331,7 +331,8 @@ int cmd_fmt_merge_msg(int argc, const char **ar=
gv, const char *prefix)
> >                       printf(" of %s", srcs.list[i]);
> >       }
> >
> > -     if (!strcmp("master", current_branch))
> > +     if (!strcmp("master", current_branch) ||
> > +         !strcmp("HEAD", current_branch))
> >               putchar('\n');
> >       else
> >               printf(" into %s\n", current_branch);
>
> Hmph.
>
> The reason is?

=46or me, 'Merge ... into master' and 'Merge ... into HEAD' are equally
useful, so do not show them by default. And git always merges into
HEAD.

Santi
