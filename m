From: Klas Lindberg <klas.lindberg@gmail.com>
Subject: Re: Submodules can't work recursively because Git implements policy?
Date: Mon, 6 Apr 2009 16:47:22 +0200
Message-ID: <33f4f4d70904060747h72019846gca18255bd71adc22@mail.gmail.com>
References: <33f4f4d70904060642m25b2cff8nafed433eeabfb6c4@mail.gmail.com>
	 <20090406135618.GA17793@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Users List <git@vger.kernel.org>
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Mon Apr 06 16:49:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqq8d-0002Ov-LQ
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 16:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbZDFOr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 10:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbZDFOr4
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 10:47:56 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:51298 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbZDFOrz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 10:47:55 -0400
Received: by bwz17 with SMTP id 17so1909323bwz.37
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 07:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FEpDyB3C1TOLYv96KUi3Tvrb7z5oiPJEbYX4lF/k4EU=;
        b=c7fvI0EV7fZtd39SvfyG01AXqWtBzj0mrRoRJE+VjE0zftdHHUZsz2v1EWsxuzDB55
         OCbOJSME23k+0nxLItgwwzZgt2+gSuvCmXXpkck5mlMqdZ6HUkUk6z5I7dm1uVgyyuuA
         4gVjCTvqxmYse/A3sgIvr3UTk5ub4HhT+U5bQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=C/gej2UQEpXU50fDibqlPVJb0bFtH5ZHu1IMrBRzSp2rPSHuYSmx96fS1YoNO/Zngj
         FoaCI6Xdf08rG9WvLd8XhbroFZouJpB6oMtVWJNUdn4KratsfCJBi/hkNz5iX4eCF08z
         RkQmP3ptCm2yoeUPc53k+B07thc1W37hkEVaw=
Received: by 10.223.126.10 with SMTP id a10mr3826681fas.17.1239029272140; Mon, 
	06 Apr 2009 07:47:52 -0700 (PDT)
In-Reply-To: <20090406135618.GA17793@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115840>

On Mon, Apr 6, 2009 at 3:56 PM, Finn Arne Gangstad <finnag@pvv.org> wrote:

> Yes, I could not agree more.  You may also end up writing some really
> complicated wrappers around git push to get things going (where do you
> push, for example). We made some interesting "concept art" around this
> last year at $dayjob, but decided to drop it.

I don't see how pushing could work at all without recursion.

> Maybe the security concerns could be handled by adding some
> functionality to (quickly) get rid of unwanted commits?

Why not simply allow users with write permissions to "pop" revisions
from the top of the history DAG in a way that actually really deletes
the them? Or at least moves those commits to a separate, locked down
DAG that cannot be read by people without write permissions?

But anyway: If I implement support for fetching SHA keys and full
recursive behaviour in the presence of submodules; would my patches
automatically be rejected because of the rationale for the current
behaviour?

/Klas
