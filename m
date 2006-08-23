From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] gitweb: Whitespace cleanup: realign, reindent
Date: Tue, 22 Aug 2006 18:34:14 -0700
Message-ID: <7virkkjkvd.fsf@assigned-by-dhcp.cox.net>
References: <200608221651.19629.jnareb@gmail.com>
	<200608221652.50443.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 23 03:34:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFhdK-0005vH-JH
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 03:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWHWBeQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 21:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWHWBeQ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 21:34:16 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:62360 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932159AbWHWBeP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 21:34:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060823013415.GFNG27846.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Aug 2006 21:34:15 -0400
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25885>

Jakub Narebski <jnareb@gmail.com> writes:

> This patch tries (but no too hard) to fit gitweb source in 80 columns,
> for 2 columns wide tabs, and indent and align source for better
> readibility.

If you are doing the wrapping, which I think is a good idea, I
do not think you should target for an oddball setting.  Where
did you get the idea of 2-column tabs?

> While at it added comment to 'snapshot' entry defaults for %feature
> hash, corrected "blobl" action in git_blame2 and git_blame to "blob",
> key of argument to $cgi->a from 'class' to '-class'.

All look good otherwise; applied.

> +our %feature = (
> +	# feature => {'sub' => feature-sub, 'override' => allow-override, 'default' => [ default options...]
> +	# if feature is overridable, feature-sub will be called with default options;
> +	# return value indicates if to enable specified feature

I'd prefer if you wrapped these to match the real ones.

> +	'snapshot' => {
> +		'sub' => \&feature_snapshot,
> +		'override' => 0,
> +		#         => [content-encoding, suffix, program]
> +		'default' => ['x-gzip', 'gz', 'gzip']},
>  );

Because making this 3-tuple into a hashref would be an overkill,
it is a very good idea to comment it here.
