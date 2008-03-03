From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Redirect stderr to a pipe before redirecting stdout to stderr
Date: Mon, 3 Mar 2008 08:52:42 +0100
Message-ID: <200803030852.43254.chriscool@tuxfamily.org>
References: <20080303082111.24d3ea73.chriscool@tuxfamily.org> <20080303073307.GG8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Xavier Maillard <xma@gnu.org>,
	git@vger.kernel.org, nanako3@bluebottle.com, pascal@obry.net
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 08:48:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW5Ot-0007We-Fn
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 08:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685AbYCCHrG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Mar 2008 02:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754555AbYCCHrE
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 02:47:04 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:51768 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753518AbYCCHq7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Mar 2008 02:46:59 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 3BCE41AB2A8;
	Mon,  3 Mar 2008 08:46:58 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 00C7A1AB2B2;
	Mon,  3 Mar 2008 08:46:57 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <20080303073307.GG8410@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75904>

Le lundi 3 mars 2008, Shawn O. Pearce a =C3=A9crit :
> Christian Couder <chriscool@tuxfamily.org> wrote:
> > With this patch, in the 'start_command' function after forking
> > we now take care of stderr in the child process before stdout.
> >
> > This way if 'start_command' is called with a 'child_process'
> > argument like this:
> >
> > 	.err =3D -1;
> > 	.stdout_to_stderr =3D 1;
> >
> > then stderr will be redirected to a pipe before stdout is
> > redirected to stderr. So we can now get the process' stdout
> > from the pipe (as well as its stderr).
>
> I'm in favor of this patch.  My series to add sideband support
> to send-pack/receive-pack (aka push) needed it for the hooks.

Now that you say it, I remember having seen your patch, so please take=20
ownership of this patch.

Thanks,
Christian.
