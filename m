From: Pete Wyckoff <pw@padd.com>
Subject: Re: git-p4.skipSubmitEdit
Date: Wed, 19 Oct 2011 21:16:10 -0400
Message-ID: <20111020011610.GA7292@arf.padd.com>
References: <1315514452.10046.0.camel@uncle-pecos>
 <4E6DB5F0.7080303@diamand.org>
 <1315847540.10046.29.camel@uncle-pecos>
 <20111018004500.GA31768@arf.padd.com>
 <4E9DBD0B.7020505@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "L. A. Linden Levy" <alevy@mobitv.com>, git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu Oct 20 03:16:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGhFG-0000bx-CE
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 03:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755878Ab1JTBQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 21:16:15 -0400
Received: from honk.padd.com ([74.3.171.149]:40899 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755865Ab1JTBQO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 21:16:14 -0400
Received: from arf.padd.com (unknown [50.55.131.180])
	by honk.padd.com (Postfix) with ESMTPSA id 79A7B96;
	Wed, 19 Oct 2011 18:16:13 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 064D35AEBA; Wed, 19 Oct 2011 21:16:10 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4E9DBD0B.7020505@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183996>

luke@diamand.org wrote on Tue, 18 Oct 2011 18:53 +0100:
> Looks good, one minor nit (see below) and a comment.
[..]
> >+        # invoke the editor
> >+        if os.environ.has_key("P4EDITOR"):
> >+            editor = os.environ.get("P4EDITOR")
> >+        else:
> >+            editor = read_pipe("git var GIT_EDITOR").strip()
> >+        system(editor + " " + template_file)
> 
> This is where we should really check the return code. However, doing
> so seems to break lots of the existing tests so it's not as easy as
> it looks.

Indeed.  I'll not fix that now, but agree it should be.

> >+
> >+        # If the file was not saved, prompt to see if this patch should
> >+        # be skipped.  But skip this verification step if configured so.
> >+        if gitConfig("git-p4.skipSubmitEditCheck") == "true":
> >+            print "return true for skipSubmitEditCheck"
> 
> You print a helpful/annoying(?) message here, but not further up at
> skipSubmitEdit?

Aargh.  Leaked debug code.  Thanks for noticing.  I got rid of
it.

		-- Pete
