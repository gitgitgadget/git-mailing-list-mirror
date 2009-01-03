From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH] gitweb: merge boolean feature subroutines
Date: Sat, 3 Jan 2009 08:40:24 -0800
Message-ID: <20090103164024.GA4205@ftbfs.org>
References: <1230996692-7182-1-git-send-email-kraai@ftbfs.org> <9b18b3110901030818i242d81ccl20ef3f264ec64cad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 03 17:42:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJ9ZU-0000bh-RD
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 17:41:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759021AbZACQkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 11:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758945AbZACQke
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 11:40:34 -0500
Received: from neon.ftbfs.org ([83.168.236.214]:40312 "EHLO neon.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758019AbZACQke (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 11:40:34 -0500
Received: from pool-71-119-193-199.lsanca.dsl-w.verizon.net
	([71.119.193.199] helo=macbookpro.ftbfs.org ident=Debian-exim)
	by neon.ftbfs.org with esmtpa (Exim 4.63)
	(envelope-from <kraai@ftbfs.org>)
	id 1LJ9Y3-0001NY-CT; Sat, 03 Jan 2009 08:40:31 -0800
Received: from kraai by macbookpro.ftbfs.org with local (Exim 4.69)
	(envelope-from <kraai@ftbfs.org>)
	id 1LJ9Y0-0006lM-WC; Sat, 03 Jan 2009 08:40:25 -0800
Content-Disposition: inline
In-Reply-To: <9b18b3110901030818i242d81ccl20ef3f264ec64cad@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Score-Int: -40
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104473>

On Sat, Jan 03, 2009 at 05:18:44PM +0100, demerphq wrote:
> 2009/1/3 Matt Kraai <kraai@ftbfs.org>:
> [...]
> > -sub feature_blame {
> > -       my ($val) = git_get_project_config('blame', '--bool');
> > +sub feature_bool {
> > +       my $key = shift;
> > +       my ($val) = git_get_project_config($key, '--bool');
> >
> >        if ($val eq 'true') {
> >                return 1;
> 
> Maybe that should be:
> 
>            return ($val eq 'true');
> 
> as It is not a good idea to use 0 as a replacement for perls false, as
> the two have different behaviour.
> 
> $perl -wle'my $val=shift; my $x=$val eq "true"; print "<$_>" for $x, 0+$x' false
> <>
> <0>

I don't think Perl has *a* false value, but rather has multiple values
that are treated as false, such as undef, zero, and the empty string.
Personally, I find 0 clearer than the empty string, but that's
probably just my C bias sneaking in.

All of the boolean feature values use 0 or 1, so if this should be
changed, I think it should probably be done as a separate patch.

-- 
Matt                                                 http://ftbfs.org/
