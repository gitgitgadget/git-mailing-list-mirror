From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Off-by-one error in get_path_prefix(), found by Valgrind
Date: Wed, 07 Jun 2006 11:47:03 -0700
Message-ID: <7v8xo8hkgo.fsf@assigned-by-dhcp.cox.net>
References: <20060607170140.13372.64613.stgit@dv.roinet.com>
	<20060607180543.GA26638@lsrfire.ath.cx> <1149705204.11931.3.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 07 20:47:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fo33d-0006yB-IP
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 20:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWFGSrG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 14:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWFGSrG
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 14:47:06 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:7625 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750868AbWFGSrF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jun 2006 14:47:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060607184704.EXLI6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 7 Jun 2006 14:47:04 -0400
To: Pavel Roskin <proski@gnu.org>,
	Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <1149705204.11931.3.camel@dv> (Pavel Roskin's message of "Wed, 07
	Jun 2006 14:33:24 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21453>

Pavel Roskin <proski@gnu.org> writes:

> On Wed, 2006-06-07 at 20:05 +0200, Rene Scharfe wrote:
>> Argh, yes.  Thanks, Pavel!
>
> Actually, thanks to Julian Seward for Valgrind.
>
>>   However, the other branch is incorrect, too:
>> accessing path->buf[path->len] is wrong, even if it's within the buffer.
>> In order to use a length variable to point to the end of some string we
>> need to subtract 1. *sigh*  So, how about this one instead?
>
> Fine with me.  Thank you for noticing!

Thanks both.  Applied.
