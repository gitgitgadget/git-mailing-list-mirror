From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] rev-{list,parse}: allow -n<n> as shorthand for --max-count=<n>
Date: Sun, 29 Jan 2006 16:25:02 -0800
Message-ID: <20060130002501.GB15482@Muzzle>
References: <20060124072946.GA9468@Muzzle> <7vd5iicauh.fsf@assigned-by-dhcp.cox.net> <20060125063325.GA7953@mail.yhbt.net> <20060129134056.GA3428@Muzzle> <7vbqxukcyo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 30 01:25:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3Mr8-0005Wb-NO
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 01:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWA3AZI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 19:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWA3AZH
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 19:25:07 -0500
Received: from hand.yhbt.net ([66.150.188.102]:35028 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S1751187AbWA3AZE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2006 19:25:04 -0500
Received: from mayonaise.dyndns.org (user-118bgak.cable.mindspring.com [66.133.193.84])
	by mail.yhbt.net (Postfix) with SMTP id 7B8D42DC035;
	Sun, 29 Jan 2006 16:25:02 -0800 (PST)
Received: by mayonaise.dyndns.org (sSMTP sendmail emulation); Sun, 29 Jan 2006 16:25:02 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbqxukcyo.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15252>

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Both -n<n> and -n <n> are supported.  POSIX versions of head(1) and
> > tail(1) allow their line limits to be parsed this way.  I find
> > --max-count to be a commonly used option, and also similar in spirit to
> > head/tail, so I decided to make life easier on my worn out (and lazy :)
> > fingers with this patch.
> 
> I agree with this in principle.
> 
> > diff --git a/rev-parse.c b/rev-parse.c
> > index 7abad35..3790463 100644
> > --- a/rev-parse.c
> > +++ b/rev-parse.c
> > @@ -21,6 +21,7 @@ static char *def = NULL;
> >  static int show_type = NORMAL;
> >  static int symbolic = 0;
> >  static int output_sq = 0;
> > +static int next_arg_is_rev = 0;
> 
> Do you need this here, or can it be made auto in main()?

Oops, I had changes in is_rev_argument() that I eventually
moved entirely to main().  Cleaned up patch on the way.

-- 
Eric Wong
