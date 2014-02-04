From: chris <jugg@hotmail.com>
Subject: Re: bug? git push triggers auto pack when gc.auto = 0
Date: Tue, 4 Feb 2014 08:16:43 +0000 (UTC)
Message-ID: <loom.20140204T090417-126@post.gmane.org>
References: <loom.20140204T030158-758@post.gmane.org> <CACsJy8Bo4XgA-g2hy+_pVEKLnerL9WNhpWe==zJANmCMdGXuow@mail.gmail.com> <loom.20140204T055040-646@post.gmane.org> <CACsJy8B0WKfxSYBSgRZQYz6_h+S9pGd03A=rrWM0_twRdKvyZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 09:17:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAbC0-0001GF-0d
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 09:17:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443AbaBDIRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 03:17:12 -0500
Received: from plane.gmane.org ([80.91.229.3]:36864 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752042AbaBDIRL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 03:17:11 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WAbBr-0001CS-Mf
	for git@vger.kernel.org; Tue, 04 Feb 2014 09:17:07 +0100
Received: from 1-165-180-147.dynamic.hinet.net ([1.165.180.147])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 09:17:07 +0100
Received: from jugg by 1-165-180-147.dynamic.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 09:17:07 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 1.165.180.147 (Mozilla/5.0 (X11; Linux i686; rv:26.0) Gecko/20100101 Firefox/26.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241515>

Duy Nguyen <pclouds <at> gmail.com> writes:
> On Tue, Feb 4, 2014 at 12:13 PM, chris <jugg <at> hotmail.com> wrote:
> > However, I question why I should even care about this message?  I'm going to
> > assume that simply it is a lengthy synchronous operation that someone felt
> > deserved some verbosity to why the client push action is taking longer than
> > it should.  Yet that makes me question why I'm being penalized for this
> > server side operation.  My client time should not be consumed for server
> > side house keeping.
> >
> > An obvious fix is to disable gc on the server and implement a cron job for
> > the house keeping task.  However, as often the case one does not have
> > control over the server, so it is unfortunate that git has this server side
> > house keeping as a blocking operation to a client action.
> 
> I agree it should not block the client. I think you can Ctrl-C "git
> push" at this point without losing anything (data has already been
> pushed at this point) but that's not a good advice to general cases.
> Maybe we can do something at the server side to not block the client..

I'd like to avoid a Ctrl-C approach, but if an indication existed that
assured me the push part of the operation had completed successfully, then
that would be sufficient for when I'm impatient.

> Another thing we could do is put "remote: " in front of these strings,
> even in ssh case. They seem to confuse you (and me too) that things
> happened locally.

Yes, I would like to see more explicit clarity in what messages are coming
from the server.  That has always been a source of uncertainty for me with
any remote git command output.

Thanks for the patches and attention to this issue, I appreciate it.

Chris
