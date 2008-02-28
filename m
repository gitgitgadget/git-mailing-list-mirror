From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/9] Completely move out worktree setup from
 setup_git_directory_gently()
Date: Wed, 27 Feb 2008 18:17:42 -0800
Message-ID: <7vy795lt89.fsf@gitster.siamese.dyndns.org>
References: <cover.1204130175.git.pclouds@gmail.com>
 <20080227163934.GA28084@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 03:19:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUYMT-0005e6-In
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 03:19:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbYB1CSB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Feb 2008 21:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbYB1CSA
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 21:18:00 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56592 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbYB1CSA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Feb 2008 21:18:00 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C36352E57;
	Wed, 27 Feb 2008 21:17:55 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2DD2B2E54; Wed, 27 Feb 2008 21:17:50 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75340>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> -	prefix =3D setup_git_directory_gently(&nongit);
> -	init_revisions(&rev, prefix);
> +	setup_git_directory_gently(&nongit);
> +	init_revisions(&rev, NULL);


> @@ -233,19 +233,20 @@ int cmd_diff(int argc, const char **argv, const=
 char *prefix)
> ...
> -	init_revisions(&rev, prefix);
> +	init_revisions(&rev, NULL);

Hmm.  How is the effect of this change compensated later to give
proper prefix value to rev.diffopt.prefix?
