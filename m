From: Jeff King <peff@peff.net>
Subject: Re: git add -i doesn't update permissions
Date: Thu, 27 Mar 2008 02:29:32 -0400
Message-ID: <20080327062932.GA11697@coredump.intra.peff.net>
References: <20080326102332.GA26842@alea.gnuu.de> <20080327055746.GA8469@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?B?SsO2cmc=?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Thu Mar 27 07:30:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jelcv-0002cR-Ry
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 07:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820AbYC0G3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 02:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753692AbYC0G3f
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 02:29:35 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3192 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753425AbYC0G3f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 02:29:35 -0400
Received: (qmail 11802 invoked by uid 111); 27 Mar 2008 06:29:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 27 Mar 2008 02:29:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Mar 2008 02:29:32 -0400
Content-Disposition: inline
In-Reply-To: <20080327055746.GA8469@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78336>

On Thu, Mar 27, 2008 at 01:57:46AM -0400, Jeff King wrote:

>   2. 'p' will show you each patch hunk from the file, which can then
>      either be added or not.
> 
> You are using 'p' and expecting it to work with the file mode, when it
> is purely about picking content hunks.

Actually, it is a little more complex than that. "git add -p" will reuse
the header from "git diff", so it will not apply a mode change _unless_
any hunk is selected.

So probably the right behavior is to split the header into "boilerplate"
and "mode change", and then ask whether the mode change should be
included.

-Peff
