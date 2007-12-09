From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove repo version check from setup_git_directory
Date: Sun, 09 Dec 2007 02:24:38 -0800
Message-ID: <7vd4tgrwrd.fsf@gitster.siamese.dyndns.org>
References: <20071209101439.GA18312@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 11:25:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1JLW-0002SG-FF
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 11:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbXLIKYw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Dec 2007 05:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbXLIKYw
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 05:24:52 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:51980 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbXLIKYv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Dec 2007 05:24:51 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B965251DF;
	Sun,  9 Dec 2007 05:24:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 431D451DE;
	Sun,  9 Dec 2007 05:24:41 -0500 (EST)
In-Reply-To: <20071209101439.GA18312@laptop> (=?utf-8?B?Tmd1eeG7hW4gVGg=?=
 =?utf-8?B?w6FpIE5n4buNYw==?= Duy's message
	of "Sun, 9 Dec 2007 17:14:39 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67615>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> setup_git_directory_gently has done the check already.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Sorry, somehow I left this line behind. It should have been gone
>  from my re-fix patch.
>
>  setup.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index e96a316..b59dbe7 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -388,7 +388,6 @@ int check_repository_format(void)
>  const char *setup_git_directory(void)
>  {
>  	const char *retval =3D setup_git_directory_gently(NULL);
> -	check_repository_format();

Ah, because the previous line already calls the same repository format
check, this is now unneeded, indeed.

Thanks.
