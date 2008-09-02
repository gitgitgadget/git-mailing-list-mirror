From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fast-import: add ignore non-existent files option.
Date: Mon, 1 Sep 2008 21:39:51 -0700
Message-ID: <20080902043951.GB13248@spearce.org>
References: <94a0d4530809011501n651c42c8xebb5cc39a93aac4c@mail.gmail.com> <1220308173-20392-1-git-send-email-felipe.contreras@gmail.com> <20080901223802.GK7482@spearce.org> <94a0d4530809011552h59e476e0q9033f0b917288a8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 06:41:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaNhQ-0003wj-MU
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 06:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbYIBEjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 00:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbYIBEjw
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 00:39:52 -0400
Received: from george.spearce.org ([209.20.77.23]:54966 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbYIBEjw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 00:39:52 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B332938375; Tue,  2 Sep 2008 04:39:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <94a0d4530809011552h59e476e0q9033f0b917288a8f@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94644>

Felipe Contreras <felipe.contreras@gmail.com> wrote:
> On Tue, Sep 2, 2008 at 1:38 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> > Felipe Contreras <felipe.contreras@gmail.com> wrote:
> >> This is useful for SCMs that don't have proper changesets in each
> >> revision (monotone).
> >
> >> +--tolerant::
> >> +     Avoid fatal exceptions when actions are executed in non-existent
> >> +     files.  For example removing a file that is not there.
> >> +
> >
> > Yea.  But I'm not sure --tolerant is the best name.  --ignore-errors
> > or --treat-errors-as-warnings sounds better to me.
> 
> I initially named it --ignore-non-existent, but I thought the option
> was too specific.
> 
> --ignore-errors or --treat-errors-as-warnings imply all errors. It
> might make sense to always fail at certain errors, like 'mark not
> found'. I thought 'relaxed' or 'tolerant' would imply that only some
> errors will be allowed, not all.

OK, that argument makes sense.  Then I wonder if more specific
error ignoring would be better:

  --ignore-error=already-deleted
  --ignore-error=already-deleted,missing-mark,missing-copy-source

I'm not really fond of turning an existing error condition that
exists to catch broken frontends into a generic tolerant flag.
But being able to selectively turn it off while leaving other
errors as errors isn't entirely unreasonable.

-- 
Shawn.
