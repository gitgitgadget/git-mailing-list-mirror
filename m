From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsserver: Make always-binary mode a config file option
Date: Tue, 27 Feb 2007 15:56:38 -0800
Message-ID: <7vslcr9mtl.fsf@assigned-by-dhcp.cox.net>
References: <7v4ppedj3r.fsf@assigned-by-dhcp.cox.net>
	<200702271346.55520.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 00:56:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMCBe-0003xu-JN
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 00:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbXB0X4n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 18:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752660AbXB0X4n
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 18:56:43 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:38910 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbXB0X4l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 18:56:41 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070227235638.UGZU2670.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Feb 2007 18:56:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Unwe1W0141kojtg0000000; Tue, 27 Feb 2007 18:56:39 -0500
In-Reply-To: <200702271346.55520.andyparkins@gmail.com> (Andy Parkins's
	message of "Tue, 27 Feb 2007 13:46:55 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40855>

Andy Parkins <andyparkins@gmail.com> writes:

> +    unless ( defined ( $cfg->{gitcvs}{allbinary} ) and $cfg->{gitcvs}{allbinary} =~ /^\s*(1|true|yes)\s*$/i )
> +    {
> +		# Return "" to give no special treatment to any path
> +		return "";
> +    } else {
> +		# Alternatively, to have all files treated as if they are binary (which
> +		# is more like git itself), always return the "-kb" option
> +		return "-kb";
> +    }
> +}

This is not your fault as you copied existing code to check
boolean, but I am unhappy every time I see "git-config -l"
forces such an eyesore on us X-<.

Anyway, will apply.  Thanks.
