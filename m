From: Paul Mackerras <paulus@samba.org>
Subject: Re: Please pull gitk.git master branch
Date: Tue, 14 Dec 2010 08:03:17 +1100
Message-ID: <20101213210317.GA10027@brick.ozlabs.ibm.com>
References: <20101212063135.GA7677@brick.ozlabs.ibm.com>
 <7vwrne8tow.fsf@alter.siamese.dyndns.org>
 <7v7hfe74ea.fsf@alter.siamese.dyndns.org>
 <7vbp4q5ddo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexandre Erwin Ittner <alexandre@ittner.com.br>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 22:03:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSFYT-0001bf-O9
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 22:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756221Ab0LMVD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 16:03:28 -0500
Received: from ozlabs.org ([203.10.76.45]:55700 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755855Ab0LMVD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 16:03:28 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 40E661007D2; Tue, 14 Dec 2010 08:03:27 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <7vbp4q5ddo.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163593>

On Sun, Dec 12, 2010 at 11:40:51PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> -- >8 --
> From: Junio C Hamano <gitster@pobox.com>
> Date: Sun, 12 Dec 2010 23:27:21 -0800
> Subject: [PATCH] Rename po/pt_BR.po to po/pt_br.po
> 
> The "msgfmt --tcl pt_BR.po" (at least on my box, GNU gettext 0.17) command
> generates pt_BR.msg, i.e. the country part gets downcased.  The resulting
> runtime (i.e. Tcl i18n) happily reads from pt_br.msg when run with the
> runtime locale set with LANG=pt_BR and/or LC_ALL=pt_BR so it seems to be
> the expected behaviour.
> 
> However, we seem to expect that the resulting file to be named pt_BR.msg,
> and try to generate and install it.
> 
> Currently our Makefile uses $(wildcard po/*.po) to grab the source PO
> files, expects them to produce $(subst .po,.msg,$(ALL_POFILES)), and its
> dependency rule is set to use "%.msg : %.po" pattern, all of which need
> to be adjusted with downcasing from po to msg files; the poor-man's msgfmt
> script also needs to learn the same downcasing.
> 
> Compared to that, renaming the input file to use lowercase countryname
> throughout the toolchain seems to be a lot cleaner solution to this
> glitch.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  po/{pt_BR.po => pt_br.po} |    0
>  1 files changed, 0 insertions(+), 0 deletions(-)
>  rename po/{pt_BR.po => pt_br.po} (100%)
> 
> diff --git a/po/pt_BR.po b/po/pt_br.po
> similarity index 100%
> rename from po/pt_BR.po
> rename to po/pt_br.po

Sorry about the glitch.  The renaming seems like the best idea, since
all the other .po files have lowercase names.  I was hoping to hear
Alexandre Erwin Ittner's opinion, though.

If I apply this patch in my repo, is that going to cause problems in
yours?  Or, since the commit that adds this file is the head commit, I
could just rewind it and reapply with the lowercase name.  Do you see
problems with that?

Paul.
