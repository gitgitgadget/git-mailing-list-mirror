From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH v2 4/4] diff.c: convert builtin funcname patterns to non-GNU
 extended regex syntax
Date: Thu, 18 Sep 2008 17:59:27 -0500
Message-ID: <azRDXO9YgAHlqbMUTpBfy26HVw0xzYFwnT5x-l_nqDw@cipher.nrlssc.navy.mil>
References: <7vskry1485.fsf@gitster.siamese.dyndns.org> <4i0Mu795rKpv37JoHytmE6kODBjwgwITn0-DuKdZiFs3ZnUlyJC-Fw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Arjen Laarhoven <arjen@yaph.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	Boyd Lynn Gerber <gerberb@zenez.com>,
	Git Mailing List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johan Herland <johan@herland.net>,
	Andreas Ericsson <ae@op5.se>, Kirill Smelkov <kirr@mns.spb.ru>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Gustaf Hendeby <hendeby@isy.liu.se>,
	Jonathan del Strother <maillist@steelskies.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 19 01:02:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgSWM-0003rJ-JC
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 01:02:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755412AbYIRXBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 19:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755527AbYIRXBf
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 19:01:35 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:41202 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755412AbYIRXBe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 19:01:34 -0400
Received: by mail.nrlssc.navy.mil id m8IMxSQe004326; Thu, 18 Sep 2008 17:59:28 -0500
In-Reply-To: <4i0Mu795rKpv37JoHytmE6kODBjwgwITn0-DuKdZiFs3ZnUlyJC-Fw@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 18 Sep 2008 22:59:28.0602 (UTC) FILETIME=[3435E3A0:01C919E2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96252>

Brandon Casey wrote:

> +	{ "java", "!^[ 	]*(catch|do|for|if|instanceof|"
> +			"new|return|switch|throw|while)\n"
> +			"^[ 	]*(([ 	]*"
> +			"[A-Za-z_][A-Za-z_0-9]*){2,}"

I don't understand the last two lines above.

Is it possible for the second bracketed space and tab to match
anything? Wouldn't the first one consume all space and tab?

Assuming it is possible for the second brackets to match
successfully, why would we want to capture this leading
space?

It looks like both of the following lines would match:

   ' a'
   'ab'

but not this

    'a'

Would it be better written like:

"^[ 	]*(([A-Za-z_][A-Za-z_0-9]*)"

> +			"[ 	]*\\([^;]*)$", REG_EXTENDED },

<snip>


-brandon
