From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] Add functions get_relative_cwd() and is_inside_dir()
Date: Fri, 27 Jul 2007 13:51:44 -0700
Message-ID: <7vps2dy3hb.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707271851370.14781@racer.site>
	<Pine.LNX.4.64.0707271956140.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, matled@gmx.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 27 22:52:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEWnN-0001qh-JE
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 22:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763926AbXG0Uvr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 16:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763471AbXG0Uvr
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 16:51:47 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:39376 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763544AbXG0Uvq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 16:51:46 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070727205145.GXPA14885.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 27 Jul 2007 16:51:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Ukrk1X00p1kojtg0000000; Fri, 27 Jul 2007 16:51:45 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53966>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> +char *get_relative_cwd(char *buffer, int size, const char *dir)
> +{
> +	char *cwd = buffer;
> +
> +	if (!dir)
> +		return 0;
> +
> +	if (!getcwd(buffer, PATH_MAX))
> +		return 0;

Can size be less than PATH_MAX?
