From: Marc Branchaud <mbranchaud@xiplink.com>
Subject: Re: [PATCH v2] submodule: add 'deinit' command
Date: Thu, 13 Dec 2012 10:47:10 -0500
Message-ID: <50C9F87E.6090902@xiplink.com>
References: <20121130032719.GE29257@odin.tremily.us> <50B54A68.60309@web.de> <20121130175309.GA718@odin.tremily.us> <CABURp0qNBcFnxbvhn7PsKWLUOsTiK4u5vx-=6cG3JQHw9aUeHA@mail.gmail.com> <50BA2892.7060706@web.de> <50BA3412.60309@web.de> <7vy5hhmcwp.fsf@alter.siamese.dyndns.org> <50BBB22A.7050901@web.de> <7vhao31s9e.fsf@alter.siamese.dyndns.org> <50BE6FB9.70301@web.de> <50C89DF3.20303@drmicha.warpmail.net> <50C8BD6B.9010702@web.de> <7vr4mv3w2x.fsf@alter.siamese.dyndns.org> <50C90469.8080303@web.de>
Reply-To: marcnarc@xiplink.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Phil Hord <phil.hord@gmail.com>,
	"W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Dec 13 16:47:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjB01-0004LF-9Y
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 16:47:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754735Ab2LMPqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 10:46:44 -0500
Received: from smtp138.ord.emailsrvr.com ([173.203.6.138]:39565 "EHLO
	smtp138.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248Ab2LMPqn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 10:46:43 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp18.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id DFC88300B0;
	Thu, 13 Dec 2012 10:46:42 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp18.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 144A830140;
	Thu, 13 Dec 2012 10:46:42 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <50C90469.8080303@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211456>

On 12-12-12 05:25 PM, Jens Lehmann wrote:
> 
> So unless people agree that deinit should also remove the work
> tree I'll prepare some patches teaching all git commands to
> consistently ignore deinitialized submodules. Opinions?

I agree with Trevor's suggestion that deinit should restore the user to the
state he would be in if he were never interested in the submodule.  So clean
up .git/config and remove the work tree.  (Maybe just issue a warning instead
if the submodule's work tree is dirty.)

Also, given that semantic, I agree with Michael that a bare "git submodule
deinit" should *not* deinitialize all the submodules.  It should require a
"--all" for that.  The bare command should just print a usage summary.

		M.
