From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] git-help -i (info): finishing touches
Date: Mon, 10 Dec 2007 21:27:26 -0800
Message-ID: <7vprxdhkch.fsf@gitster.siamese.dyndns.org>
References: <1197279969-10613-1-git-send-email-gitster@pobox.com>
	<7v8x42n9s4.fsf@gitster.siamese.dyndns.org>
	<200712110622.51583.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Kastrup <dak@gnu.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 06:28:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1xf4-0005jK-MD
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 06:28:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbXLKF1p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Dec 2007 00:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbXLKF1p
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 00:27:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49611 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbXLKF1o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2007 00:27:44 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 393B340A5;
	Tue, 11 Dec 2007 00:27:39 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A7F240A0;
	Tue, 11 Dec 2007 00:27:35 -0500 (EST)
In-Reply-To: <200712110622.51583.chriscool@tuxfamily.org> (Christian Couder's
	message of "Tue, 11 Dec 2007 06:22:51 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67792>

Christian Couder <chriscool@tuxfamily.org> writes:

> Le lundi 10 d=C3=A9cembre 2007, Junio C Hamano a =C3=A9crit :
>> Junio C Hamano <gitster@pobox.com> writes:
>> > This series attempts to add finishing touches to "git help -i" (in=
fo)
>> > support.
>
> It looks like the patch series you talk about was not sent to the lis=
t.

Hmph, it appears that there was a misconfiguration on my part to drive
send-email.  Look into 'next' branch.

> In the last patch there is:
>
> diff --git a/help.c b/help.c
> index 9d7ad6f..c96b167 100644
> --- a/help.c
> +++ b/help.c
> @@ -286,6 +286,7 @@ static void show_man_page(const char *git_cmd)
>  static void show_info_page(const char *git_cmd)
>  {
>         const char *page =3D cmd_to_page(git_cmd);
> +       setenv("INFOPATH", GIT_INFO_PATH, 1);
>         execlp("info", "info", "gitman", page, NULL);
>  }
>
> But I wonder if something like this would be better:

I do not think so, as MANPATH has that funky semantics of "appending th=
e
system path where a single colon separates an empty path component from
the rest." but I do not think there is anything like that in INFOPATH.
