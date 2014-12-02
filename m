From: John Keeping <john@keeping.me.uk>
Subject: Re: [BUG] Documentation: git log: --exit-code undocumented?
Date: Tue, 2 Dec 2014 12:27:05 +0000
Message-ID: <20141202122705.GA22967@serenity.lan>
References: <87zjb78u7g.fsf@osv.gnss.ru>
 <xmqqegsjqqox.fsf@gitster.dls.corp.google.com>
 <874mtfl1hx.fsf@fencepost.gnu.org>
 <xmqqwq6bp8ey.fsf@gitster.dls.corp.google.com>
 <87ppc2xp9k.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, David Kastrup <dak@gnu.org>,
	git@vger.kernel.org
To: Sergey Organov <sorganov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 13:33:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvmeF-00050t-Pw
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 13:33:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754527AbaLBMdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 07:33:40 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:36752 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521AbaLBMdj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 07:33:39 -0500
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Dec 2014 07:33:39 EST
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id AE66586606A;
	Tue,  2 Dec 2014 12:27:22 +0000 (GMT)
X-Quarantine-ID: <3ae1wwkz+CTe>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3ae1wwkz+CTe; Tue,  2 Dec 2014 12:27:21 +0000 (GMT)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id F1714866062;
	Tue,  2 Dec 2014 12:27:11 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <87ppc2xp9k.fsf@osv.gnss.ru>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260564>

On Tue, Dec 02, 2014 at 02:30:31PM +0300, Sergey Organov wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > David Kastrup <dak@gnu.org> writes:
> >
> >> I disagree that --exit-code does nothing: it indicates whether the
> >> listed log is empty.  So for example
> >>
> >> git log -1 --exit-code a..b > /dev/null
> >>
> >> can be used to figure out whether "a" is a proper ancestor of "b" or
> >> not.
> >
> > Hmph.
> >
> >     $ git log --exit-code master..maint >/dev/null; echo $?
> >     0
> >     $ git log --exit-code maint..master >/dev/null; echo $?
> >     1
> >
> > That is a strange way to use --exit-code.
> 
> What's the best way then to tell if "a" is an ancestor of "b"?

git merge-base --is-ancestor a b
