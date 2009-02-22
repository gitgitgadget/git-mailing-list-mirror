From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 4/6] object: add one bit to let creation of private
 types  (OBJ_MAX + n)
Date: Sun, 22 Feb 2009 10:21:56 -0800
Message-ID: <7vocwuxrgb.fsf@gitster.siamese.dyndns.org>
References: <e29894ca0902221006u77fdaa89s9cc01fb27bffce0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 19:23:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbIzH-0000kK-VH
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 19:23:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbZBVSWJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Feb 2009 13:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbZBVSWG
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 13:22:06 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33101 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131AbZBVSWE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Feb 2009 13:22:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 094612BB32;
	Sun, 22 Feb 2009 13:22:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 55E4F2BB30; Sun,
 22 Feb 2009 13:21:58 -0500 (EST)
In-Reply-To: <e29894ca0902221006u77fdaa89s9cc01fb27bffce0b@mail.gmail.com>
 (=?utf-8?Q?Marc-Andr=C3=A9?= Lureau's message of "Sun, 22 Feb 2009 20:06:49
 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B2983078-010D-11DE-9E09-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111041>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> ---
>  object.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/object.h b/object.h
> index 89dd0c4..83d3644 100644
> --- a/object.h
> +++ b/object.h
> @@ -21,7 +21,7 @@ struct object_array {
>  	} *objects;
>  };
>
> -#define TYPE_BITS   3
> +#define TYPE_BITS   4
>  #define FLAG_BITS  27

This would increase the value of (TYPE_BITS+FLAG_BITS).  We spent a lot=
 of
effect to keep sizeof(struct object) to absolute minimum, and you need =
to
have a very good reason if you are breaking it.
