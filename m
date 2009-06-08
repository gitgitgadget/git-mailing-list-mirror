From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] show-branch: don't use LASTARG_DEFAULT with OPTARG
Date: Mon, 08 Jun 2009 14:56:29 -0700
Message-ID: <7vd49ewfsi.fsf@alter.siamese.dyndns.org>
References: <4A2ACE32.8080504@gmail.com>
	<1244417955-21226-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Pierre Habouzit <madcoder@madism.org>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 23:56:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDmpY-00079j-MY
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 23:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbZFHV42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 17:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752072AbZFHV41
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 17:56:27 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:55682 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbZFHV41 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 17:56:27 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090608215628.JCKZ25927.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Mon, 8 Jun 2009 17:56:28 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 1ZwV1c00A4aMwMQ04ZwVJT; Mon, 08 Jun 2009 17:56:29 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=edbpq_Dl7RwA:10 a=PbCVjOiWTkEA:10
 a=pGLkceISAAAA:8 a=jDMHLe6-0d2j1Gb4byEA:9 a=qXnyTmgTs6Cdx9nFQBp3ZQLJ4SIA:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <1244417955-21226-1-git-send-email-bebarino@gmail.com> (Stephen Boyd's message of "Sun\,  7 Jun 2009 16\:39\:15 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121117>

Stephen Boyd <bebarino@gmail.com> writes:

> 5734365 (show-branch: migrate to parse-options API 2009-05-21)
> incorrectly set the --more option's flags to be
> PARSE_OPT_LASTARG_DEFAULT and PARSE_OPT_OPTARG. These two flags
> shouldn't be used together. An option taking a default should just set
> the default value desired and parse options will take care of the rest.

Thanks.  Perhaps as a follow-up patch the runtime can check and barf when
parse_options() is called and finds this combination?
