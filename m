From: Patrick Welche <prlw1@cam.ac.uk>
Subject: Re: 1.8.4 rebase regression?
Date: Tue, 17 Sep 2013 10:13:33 +0100
Message-ID: <20130917091333.GB289@quark>
References: <20130915235739.GA712@quark>
 <vpqioy1815z.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 17 11:13:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLrLq-0007vu-Tf
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 11:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907Ab3IQJNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 05:13:39 -0400
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:34553 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723Ab3IQJNi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 05:13:38 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from host-92-17-176-162.as13285.net ([92.17.176.162]:65499 helo=quark)
	by ppsw-52.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.158]:587)
	with esmtpsa (LOGIN:prlw1) (TLSv1:DHE-RSA-AES256-SHA:256)
	id 1VLrLj-0000D0-Ex (Exim 4.80_167-5a66dd3)
	(return-path <prlw1@cam.ac.uk>); Tue, 17 Sep 2013 10:13:35 +0100
Content-Disposition: inline
In-Reply-To: <vpqioy1815z.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234866>

On Mon, Sep 16, 2013 at 01:18:48PM +0200, Matthieu Moy wrote:
> Patrick Welche <prlw1@cam.ac.uk> writes:
> 
> > $ git diff
> > ESC[1mdiff --cc glib/gmain.cESC[m
> > ESC[1mindex 738e69c,5aaebd0..0000000ESC[m
> > ESC[1m--- a/glib/gmain.cESC[m
> > ESC[1m+++ b/glib/gmain.cESC[m
> > ESC[36m@@@ -4953,32 -4921,32 +4953,48 @@@ESC[m ESC[mg_unix_signal_watch_dispatch (GSourcESC[m
> >
> >
> > (same xterm, no change of TERM in both invocations above)
> > git status in 1.8.4 does show red, so colour does work...
> >
> > Thoughts on how to help debug?
> 
> Can you try:
> 
> git -c color.ui=never diff
> git -c color.ui=auto diff
> git -c color.ui=always diff
> 
> ?

Got it: the change between 1.8.3.4 and 1.8.4 is that colour is on by
default. If I take 1.8.3.4 and git -c color.ui=always log, I see
the same ESC codes => not a regression! I'll just have to sort my
box out if I want colour. (The only oddity is that git status is
correctly colourful.)

(
> If you have a bit of time, you can use "git bisect" on a clone of
> git.git to find out the guilty commit.

commit e5be297279e8ee8c503eb59da21ab17edc40e748
Merge: a3bc3d0 6897a64

but that is presumably just when the default changed
)

Sorry for the confusion - it just looked like a regression to me,
but isn't!

Cheers,

Patrick
