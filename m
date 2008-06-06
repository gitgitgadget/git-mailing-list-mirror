From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH v3 2/2] git-add: introduce --edit (to edit the diff vs.
 the index)
Date: Fri, 06 Jun 2008 12:02:34 +0200
Message-ID: <48490B3A.4020900@free.fr>
References: <alpine.DEB.1.00.0806051115570.21190@racer> <4847CCD9.6000305@viscovery.net> <alpine.DEB.1.00.0806051403370.21190@racer> <4847EBC3.8060509@viscovery.net> <alpine.DEB.1.00.0806051441560.21190@racer> <4847F49F.8090004@viscovery.net> <alpine.DEB.1.00.0806051548140.21190@racer> <48480123.7030903@viscovery.net> <alpine.DEB.1.00.0806051719170.21190@racer> <alpine.DEB.1.00.0806051720070.21190@racer> <7vabhz1t2f.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806052304300.21190@racer> <alpine.DEB.1.00.0806060005581.21190@racer> <alpine.DEB.1.00.0806060007000.21190@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 06 12:03:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Yn8-000190-QD
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 12:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907AbYFFKCd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Jun 2008 06:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752909AbYFFKCd
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 06:02:33 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:50410 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752876AbYFFKCc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 06:02:32 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 375D912B6BC;
	Fri,  6 Jun 2008 12:02:31 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id CC6E512B6FB;
	Fri,  6 Jun 2008 12:02:30 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <alpine.DEB.1.00.0806060007000.21190@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84045>

Johannes Schindelin a =E9crit :
> =20
> +int edit_patch(int argc, const char **argv, const char *prefix)
> +{

[...]

> +	if (!result)
> +		result =3D run_command(&child);
> +	free(child.argv);
> +
> +	launch_editor(file, NULL, NULL);

Here, it does not launch the editor I defined with core.editor because =
you
call edit_patch() before calling git_config() in cmd_add().

Also, wouldn't be better to have the edit_patch stuff in add--interacti=
ve
instead ? It seems to work the same way than the --patch option.

Just my thoughts.

Olivier.
