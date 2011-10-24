From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: general protection faults with "git grep" version 1.7.7.1
Date: Tue, 25 Oct 2011 00:58:36 +0200
Message-ID: <20111024225836.GA1678@x4.trippels.de>
References: <20111024201153.GA1647@x4.trippels.de>
 <20111024214949.GA5237@amd.home.annexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: meyering@redhat.com, git@vger.kernel.org
To: "Richard W.M. Jones" <rjones@redhat.com>
X-From: git-owner@vger.kernel.org Tue Oct 25 00:58:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RITTf-0003jv-K2
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 00:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071Ab1JXW6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Oct 2011 18:58:38 -0400
Received: from ud10.udmedia.de ([194.117.254.50]:44203 "EHLO
	mail.ud10.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949Ab1JXW6i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 18:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=mail.ud10.udmedia.de; h=
	date:from:to:cc:subject:message-id:references:mime-version:
	content-type:in-reply-to; q=dns/txt; s=beta; bh=HGIgg3TdPVgRzNqZ
	wo6WJ9sPouyXSwzDE2Lg7ARvw9Q=; b=prECaDXT0XyBCvhr3CK/0WLaNABjxCT9
	Bng5C01rzbybFrQAei9GtQcBD0swhky45Q5x+xq470QF4XNOZCVoNshnIKZuSMq3
	TDvtWhGmdN8BRo1bKY2JhbMhdj6ZClhWyZF+P1J9alLmScroVWevJeIU1Mz4RQul
	B+sJ2Sc34Fg=
Received: (qmail 6207 invoked from network); 25 Oct 2011 00:58:36 +0200
Received: from unknown (HELO x4.trippels.de) (ud10?360p3@91.64.56.160)
  by mail.ud10.udmedia.de with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 25 Oct 2011 00:58:36 +0200
Content-Disposition: inline
In-Reply-To: <20111024214949.GA5237@amd.home.annexia.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184190>

On 2011.10.24 at 22:49 +0100, Richard W.M. Jones wrote:
> On Mon, Oct 24, 2011 at 10:11:53PM +0200, Markus Trippelsdorf wrote:
> > Suddenly I'm getting strange protection faults when I run "git grep" on
> > the gcc tree:
> 
> Jim Meyering and I are trying to chase what looks like a similar or
> identical bug in git-grep.  We've not got much further than gdb and
> valgrind so far, but see:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=747377
> 
> It's slightly suspicious that this bug only started to happen with the
> latest glibc, but that could be coincidence, or could be just that
> glibc exposes a latent bug in git-grep.

Thanks for the pointer.

Compiling git with -O1 "solves" the problem for me. 
This issue is independent of the exact git version being used (I tried
three different ones and always hit the problem).
It happens always on the _second_ run of "git grep" on my machine. The
first run always succeeds. So this might be a cache related issue.

-- 
Markus
