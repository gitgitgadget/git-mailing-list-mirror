From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] added #define DEFAULT_MAX_REQUESTS for USE_CURL_MULTI mode
Date: Sun, 20 Jan 2008 16:13:49 -0800
Message-ID: <7v1w8c6nnm.fsf@gitster.siamese.dyndns.org>
References: <1200756171-11696-1-git-send-email-gb@gbarbier.org>
	<1200756171-11696-2-git-send-email-gb@gbarbier.org>
	<1200756171-11696-3-git-send-email-gb@gbarbier.org>
	<1200756171-11696-4-git-send-email-gb@gbarbier.org>
	<1200756171-11696-5-git-send-email-gb@gbarbier.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Gr=C3=A9goire?= Barbier <gb@gbarbier.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 01:14:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGkJD-000101-DZ
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 01:14:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754784AbYAUAOG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jan 2008 19:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754764AbYAUAOG
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 19:14:06 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46069 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754712AbYAUAOF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jan 2008 19:14:05 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 711AC214D;
	Sun, 20 Jan 2008 19:14:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CD463214B;
	Sun, 20 Jan 2008 19:13:58 -0500 (EST)
In-Reply-To: <1200756171-11696-5-git-send-email-gb@gbarbier.org>
 (=?utf-8?Q?Gr=C3=A9goire?=
	Barbier's message of "Sat, 19 Jan 2008 16:22:51 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71204>

Gr=C3=A9goire Barbier <gb@gbarbier.org> writes:

> From: Gregoire Barbier <gb@gbarbier.org>
>
> I'm not sure of which value is the good one, but 4 seems good since i=
t's
> not very high which would lead to resouce consumption problems.
> ---
>  http.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/http.c b/http.c
> index 8b04ae9..7b1bcb8 100644
> --- a/http.c
> +++ b/http.c
> @@ -4,6 +4,7 @@ int data_received;
>  int active_requests =3D 0;
> =20
>  #ifdef USE_CURL_MULTI
> +#define DEFAULT_MAX_REQUESTS 4
>  static int max_requests =3D -1;
>  static CURLM *curlm;
>  #endif

Why is this needed?

How does this interact with an existing #define in http.h that
defines it to 5?
