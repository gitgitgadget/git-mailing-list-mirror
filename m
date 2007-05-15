From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH] Don't use patches/<branch>/current
Date: Tue, 15 May 2007 20:25:49 +0200
Message-ID: <20070515182549.GB17851@diana.vm.bytemark.co.uk>
References: <20070506150852.8985.98091.stgit@yoghurt> <b0943d9e0705150856n771cb696h6e8225a0bbd5d43d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 15 20:26:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho1ip-0005ff-AV
	for gcvg-git@gmane.org; Tue, 15 May 2007 20:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754403AbXEOSZx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 May 2007 14:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754460AbXEOSZx
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 14:25:53 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4829 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754403AbXEOSZw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 14:25:52 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Ho1iX-0004gd-00; Tue, 15 May 2007 19:25:49 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0705150856n771cb696h6e8225a0bbd5d43d@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47361>

On 2007-05-15 16:56:33 +0100, Catalin Marinas wrote:

> On 06/05/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > The name of the current patch, if any, is always the last line of
> > patches/<branch>/applied (and there is no current patch if and
> > only if the "applied" file is empty). So use that instead, and
> > stop having to worry about keeping the redundant "current" file
> > up-to-date.
>
> I applied this patch. Could you also send me a patch for the
> bash-completion script as it uses this file?

I realized this myself yesterday or so, and patched it to not need the
current, applied, and unapplied files. Are you OK with that patch, or
would you like one that keeps using {,un}applied?

> I think the self.__current_file (same for the base file removed in a
> different patch) should still be available in the Series object and
> removed when deleting a branch, otherwise you get a "Series
> directory ... is not empty" exception.

Ah, very true. I'll whip up a fix.

Same question there: are you OK with a single fix for base, current,
applied, and unapplied, or do you want them separate?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
