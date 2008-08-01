From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: git help broken
Date: Fri, 1 Aug 2008 06:28:52 +0200
Message-ID: <200808010628.52875.chriscool@tuxfamily.org>
References: <C0DB03B0-8AF5-4B6A-A9DB-16608128EB31@sb.org> <alpine.LSU.1.00.0807310144040.3486@wbgn129.biozentrum.uni-wuerzburg.de> <20080731000454.GJ32057@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 06:26:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOmDS-0002Oa-SQ
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 06:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbYHAEZI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Aug 2008 00:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbYHAEZI
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 00:25:08 -0400
Received: from smtp7-g19.free.fr ([212.27.42.64]:55544 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004AbYHAEZH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2008 00:25:07 -0400
Received: from smtp7-g19.free.fr (localhost [127.0.0.1])
	by smtp7-g19.free.fr (Postfix) with ESMTP id C0703B0171;
	Fri,  1 Aug 2008 06:25:05 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 17FC0B0122;
	Fri,  1 Aug 2008 06:25:05 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080731000454.GJ32057@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91027>

Le jeudi 31 juillet 2008, Miklos Vajna a =E9crit :
> On Thu, Jul 31, 2008 at 01:44:36AM +0200, Johannes Schindelin=20
<Johannes.Schindelin@gmx.de> wrote:
> > > And from the patch, it is pretty obvious that it does not come cl=
ose
> > > to the "man" code path.
> >
> > Oh, so it was involved?
>
> Yes. The command list is no longer loaded automatically and the defau=
lt
> for non-git commands on git help foo was 'gitfoo', I guess for
> gittutorial and such manpages.

Yeah, and it seems that "git help help" doesn't work any more since my =
patch=20
that does that:

2dce956e397be8a769624e8693565b8a30056060 help: check early if we have a=
=20
command, if not try a documentation topic

I didn't realize that the function "is_git_command" would not work=20
for "help".

Perhaps there should be another function like is_git_command that could=
 work=20
using the "struct cmd_struct commands" defined in "handle_internal_comm=
and"=20
in "git.c". That may be faster and more accurate.

Unfortunately I won't have time to work on this as I will leave for vac=
ation=20
in a few hours. Sorry to leave this behind.

Best regards,
Christian.
