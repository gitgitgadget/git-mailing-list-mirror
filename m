From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] parse-options: add PARSE_OPT_CUSTOM_ARGH for complicated argh's
Date: Sun, 17 May 2009 23:14:22 -0700
Message-ID: <7vd4a7ey4h.fsf@alter.siamese.dyndns.org>
References: <1242557224-8411-1-git-send-email-bebarino@gmail.com>
	<1242557224-8411-2-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 08:15:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5w8N-0006SM-Kg
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 08:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbZERGOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 02:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752761AbZERGOX
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 02:14:23 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:39855 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbZERGOW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 02:14:22 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090518061422.TQQC17135.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Mon, 18 May 2009 02:14:22 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id suEN1b00M4aMwMQ04uENlY; Mon, 18 May 2009 02:14:23 -0400
X-Authority-Analysis: v=1.0 c=1 a=ckEMPOoq4BcA:10 a=gN7GTBdjX9cA:10
 a=pGLkceISAAAA:8 a=pjNEf22y5Xh0qvrXHRgA:9 a=vPWMMqnQht55loCrjHehdiuGbvQA:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <1242557224-8411-2-git-send-email-bebarino@gmail.com> (Stephen Boyd's message of "Sun\, 17 May 2009 03\:47\:03 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119418>

Stephen Boyd <bebarino@gmail.com> writes:

> If argh is complicated, i.e. the option takes more than one argument,
> don't add the brackets around argh in the usage message.

I think later user wants a bit more descriptive explanation, like...

	Usually, argh element in struct option points at a placeholder
	value (e.g. "val"), and this is used to show

	    --option=<val>

	by enclosing the string inside of angle brackets.

	When the option takes something more complex (e.g. optional part
	separated by comma), you would want to produce a help that looks
	like

	    --option=<val1>[,<val2>]

	In such a case, the caller can pass a string to argh with
	placeholders already enclosed in necessary angle brackets
	(e.g. "<val1>[,<val2>]") and set this option.

Please update Documentation/technical/api-parse-options.txt as well.
