From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: [PATCH] Add documentation on how to integrate commands.
Date: Mon, 26 Nov 2012 00:25:00 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121126052500.GA15605@thyrsus.com>
References: <20121124122333.BAD7B4065F@snark.thyrsus.com>
 <7vy5hpvukk.fsf@alter.siamese.dyndns.org>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 06:26:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcrCr-0007Sm-D6
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 06:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631Ab2KZFZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 00:25:54 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:46844
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282Ab2KZFZx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 00:25:53 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 860A44065F; Mon, 26 Nov 2012 00:25:00 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vy5hpvukk.fsf@alter.siamese.dyndns.org>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210414>

Junio C Hamano <gitster@pobox.com>:
> As the first sentence in this paragraph does not make it clear
> enough that you are defining a new term "git execution directory",
> "execution directory" here may be misleading and can easily be
> mistaken as if we look something in the directory where the user
> runs "git" in.  We usually call it "exec path".

Fixed.

> Actually, we tend to avoid Python dependency for anything important
> and allow it only on fringes; people who lack Python environment are
> not missing much, and we would want to keep it that way until the
> situation on the Windows front changes.

Added:

    Python is fine for import utilities, surgical tools, remote helpers
    and other code at the edges of the git suite - but it should not yet
    be used for core functions. This may change in the future; the problem
    is that we need better Python integration in the git Windows installer
    before we can be confident people in that environment won't
    experience an unacceptably large loss of capability.

I will also take this as a part-resolution of the related policy thread. 
Issue perhaps to be revisited when the Windows port gets the Python support
to a good state.

I will submit for separate consideration a patch proposing the following
new guidelines:

1. Python code SHOULD NOT require an interpreter version newer than 2.6.

2. Python code SHOULD check the interpreter version and exit gracefully
   with an explanation if it detects that its dependency cannot be satisfied.

> I would prefer to see this sentence not call libgit.a a "library".
> We primarily use libgit.a to let linker pick necessary object files
> without us having to list object files for non-builtin command
> implementations and it is not designed to be used by other people.

Fixed.  I now refer to it as a "collection of functions".

> And when sending a patch in, do not forget to sign off your patches
> ;-)

Added.  I will submit a third time with a signoff. :-)
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
