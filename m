From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Split fetch and merge logic
Date: Mon, 19 Feb 2007 10:47:15 +0100
Message-ID: <8aa486160702190147ta95ed31ld0e72d214c16db4b@mail.gmail.com>
References: <874ppmplw7.fsf@gmail.com>
	 <7vwt2i7bq7.fsf@assigned-by-dhcp.cox.net>
	 <8aa486160702160040t3f42b5a0xbd12f333805ad4d7@mail.gmail.com>
	 <7vd54950ed.fsf@assigned-by-dhcp.cox.net>
	 <8aa486160702161230r6f5825a2v861315c1aa52520e@mail.gmail.com>
	 <7v4ppl4xfe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 19 10:47:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ57H-0008Al-RF
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 10:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbXBSJrR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 19 Feb 2007 04:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbXBSJrR
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 04:47:17 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:6453 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbXBSJrR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Feb 2007 04:47:17 -0500
Received: by ug-out-1314.google.com with SMTP id 44so523330uga
        for <git@vger.kernel.org>; Mon, 19 Feb 2007 01:47:15 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H4vDQfLTV6ThdWhC06DTocbm2qlmv2VsSajxe6+972ti8NyjfYizyw2ZmweTSqBp2znCJWp9f6TOWSj9p1xLOeie/KS5lU/aMPkribiScg9MxmCxr0zbhTHYVz05Jn8af5XWA7EyI5mxl3mwRrwQ1z9WRxEKLTJ84F6nWJLt+VM=
Received: by 10.78.123.4 with SMTP id v4mr1010888huc.1171878435568;
        Mon, 19 Feb 2007 01:47:15 -0800 (PST)
Received: by 10.78.69.4 with HTTP; Mon, 19 Feb 2007 01:47:15 -0800 (PST)
In-Reply-To: <7v4ppl4xfe.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40110>

On 2/16/07, Junio C Hamano <junkio@cox.net> wrote:
> "Santi B=E9jar" <sbejar@gmail.com> writes:
>
> > In the past we've had problems when we have changed the merge logic
> > (as shows 4363dfbe3). This patch makes the two process completely
> > independent, and concentrate the merge logic in one place (leaving
> > git-parse-remote.sh independent of the merge logic).
>
> But that is a solved problem, isn't it?  What else does it
> solve?  The justification for moving around the logic could be
> something like "these three patches do not do that themselves,
> but it opens a door for further work such as ...", but without
> something concrete in "..." part, your response makes the patch
> look mostly needless code churn.
>
> I was hoping to hear something like "now git-fetch has to do
> much less than before, eventual C-rewrite of the command, which
> can borrow some code already written for 'pu' branch, will
> become much easier" ;-).

On 2/16/07, Junio C Hamano <junkio@cox.net> wrote:
> "Santi B=E9jar" <sbejar@gmail.com> writes:
>
> > This sounds like a good justification, also :-)
>
> What I said was an example.  I do not think your code churning
> actually would make it easier.
>
>

What I said was an example of why having the two logic intermixed can
be problematic. Anyway, basically:

* It is a cleanup
* It makes the code cleaner
* It makes the code easier to maintain
* It makes the future changes easier
* It makes git-parse-remote and almost all git-fetch independent of
the merge logic
* The merge logic is in a few lines
* Do one thing and do it well

Regards,

Santi
