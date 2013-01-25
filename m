From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 7/7] mergetool--lib: Improve show_tool_help() output
Date: Fri, 25 Jan 2013 22:02:22 +0000
Message-ID: <20130125220222.GE7498@serenity.lan>
References: <1359107034-14606-1-git-send-email-davvid@gmail.com>
 <1359107034-14606-8-git-send-email-davvid@gmail.com>
 <20130125195446.GA7498@serenity.lan>
 <20130125200807.GB7498@serenity.lan>
 <7vpq0t2f2t.fsf@alter.siamese.dyndns.org>
 <20130125204619.GC7498@serenity.lan>
 <7vlibh2d8a.fsf@alter.siamese.dyndns.org>
 <20130125211601.GD7498@serenity.lan>
 <7vbocd2auo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 23:03:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyrNF-0005Y6-Jp
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 23:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686Ab3AYWCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 17:02:32 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:40533 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485Ab3AYWCa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 17:02:30 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 6F811CDA510;
	Fri, 25 Jan 2013 22:02:29 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qmYji92tEbRC; Fri, 25 Jan 2013 22:02:29 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id B9D42CDA5CD;
	Fri, 25 Jan 2013 22:02:24 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vbocd2auo.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214586>

On Fri, Jan 25, 2013 at 01:47:59PM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> > With the patch above, the block of code at the top becomes:
> >
> >  	test "$tool" = defaults && continue
> >
> >  	setup_tool "$tool" 2>/dev/null || continue
> >  	merge_tool_path=$(translate_merge_tool_path "$tool")
> >
> > which IMHO is pretty readable.
> 
> Of course it is.  The current callers of setup_tool may need some
> adjustments, but that should be fairly trivial, I hope.

There are only two and one of them already seems like it doesn't want
the command to cause the script to exit.

David, can you incorporate the following two patches when you re-roll?
Your original 7/7 with the change above will want to build on 8/7.


John
