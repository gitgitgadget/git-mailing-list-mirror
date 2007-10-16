From: Jan Wielemaker <wielemak@science.uva.nl>
Subject: Re: Some git mv questions
Date: Tue, 16 Oct 2007 23:09:27 +0200
Message-ID: <200710162309.28739.wielemak@science.uva.nl>
References: <200710161733.49185.wielemak@science.uva.nl> <8c5c35580710160905v69787856m7ed11b037c1adef1@mail.gmail.com> <alpine.LFD.0.999.0710161030430.6887@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Lars Hjemli <hjemli@gmail.com>, git list <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 23:11:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihtfn-0007l8-9z
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 23:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934704AbXJPVJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 17:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760191AbXJPVJo
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 17:09:44 -0400
Received: from smtp-vbr16.xs4all.nl ([194.109.24.36]:3276 "EHLO
	smtp-vbr16.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934704AbXJPVJn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 17:09:43 -0400
Received: from ct.xs4all.nl (ct.xs4all.nl [82.92.39.12])
	by smtp-vbr16.xs4all.nl (8.13.8/8.13.8) with ESMTP id l9GL9T6E014873;
	Tue, 16 Oct 2007 23:09:37 +0200 (CEST)
	(envelope-from wielemak@science.uva.nl)
User-Agent: KMail/1.9.5
In-Reply-To: <alpine.LFD.0.999.0710161030430.6887@woody.linux-foundation.org>
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61256>

On Tuesday 16 October 2007 19:34, Linus Torvalds wrote:
> On Tue, 16 Oct 2007, Lars Hjemli wrote:
> > On 10/16/07, Jan Wielemaker <wielemak@science.uva.nl> wrote:
> > >         * On a somewhat bigger test I moved a large directory using
> > >         "git mv dir newdir" (where newdir is an existing directory).
> > >         Now "git status" gives a lot of new and deleted files!?
> >
> > You could try to adjust diff.renameLimit in .git/config
>
> Yes. The default rename limit I did has turned out to be a disaster. It's
> quite common to have more than a 100x100 matrix of deleted files.
>
> For people with any kind of beefy hardware, I'd just suggest doing a
>
> 	git config --global diff.renamelimit 0
>
> which disables the rename limiting entirely.
>
> There's a related (embarrassing) problem, namely that I think that the
> current released versions (1.5.3.3 and 1.5.3.4) don't honor the
> renamelimit configuration for merging, so if you do merges across renames
> with changes to the renamed files, you need to use either an older git
> that didn't have the rename limit at all (nor any of the speed-ups) or you
> need to use current git from the 'master' branch.

Thanks both of you.  I can master that.  I understand I only should ensure
to be running the latest version if I start the merge?

	Cheers --- Jan
