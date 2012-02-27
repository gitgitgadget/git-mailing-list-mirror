From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 06/11] column: add column.ui for default column output
 settings
Date: Sun, 26 Feb 2012 22:20:32 -0800
Message-ID: <7vvcmsbxvz.fsf@alter.siamese.dyndns.org>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
 <1330170078-29353-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 07:20:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1twx-0007OB-3i
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 07:20:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753977Ab2B0GUi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 01:20:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48115 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753454Ab2B0GUh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2012 01:20:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA9BB7A82;
	Mon, 27 Feb 2012 01:20:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4XN9y5FJ11je
	WKkdTXFkvwFxUJw=; b=frwlxVCtXs+9WyopAQKFMh8zN4Akuwf750TajHiY7v4A
	zOaTtJZOlR5F7dNI1CLp0vWUt33nS0SFBOABp3UOcx3mhpKL6jFJWtujCEAgih8B
	6S9DgqNx1Ontpv50eR/WNULQ7Wws+7nZ6fQ37/zpu0WHQS2mC1+hxlX3Q1ZEAsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=x3hpEG
	AxCtOHFtVpIL3UAUa5Gwy+ZYcUIXkNC01PLm6WsvzOA/Yfe3/Ok7tZYPozr9jqJU
	TAkaC56c2DayAg8eGsA7O1Sjk6QiRbw7HArP+i02H8QoNBLeK1qzL2hnUv7PupwZ
	5BsbYSV+5oZ7+6FLNrkLyVKsaNiANf1XIJ8hk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C17E97A81;
	Mon, 27 Feb 2012 01:20:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 444287A80; Mon, 27 Feb 2012
 01:20:34 -0500 (EST)
In-Reply-To: <1330170078-29353-7-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 25 Feb
 2012 18:41:13 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 28162A0C-610B-11E1-84F9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191600>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/config.txt     |   26 ++++++++++++++++++++++++++
>  Documentation/git-column.txt |    6 +++++-
>  builtin/column.c             |   21 +++++++++++++++++++++
>  column.c                     |   28 ++++++++++++++++++++++++++++
>  column.h                     |    2 ++
>  5 files changed, 82 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index abeb82b..5216598 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -821,6 +821,32 @@ color.ui::
>  	`never` if you prefer git commands not to use color unless enabled
>  	explicitly with some other configuration or the `--color` option.
> =20
> +column.ui::
> +	Specify whether supported commands should output in columns.
> +	This variable consists of a list of tokens separated by spaces
> +	or commas:
> ++
> +--
> +`always`;;
> +	always show in columns
> +`never`;;
> +	never show in columns
> +`auto`;;
> +	show in columns if the output is to the terminal
> +`column`;;
> +	fill columns before rows (default)
> +`row`;;
> +	fill rows before columns
> +`dense`;;
> +	make unequal size columns to utilize more space
> +`nodense`;;
> +	make equal size columns
> +`color`;;
> +	input contains ANSI escape sequence for coloring
> +--
> ++
> +	This option defaults to 'never'.

I tried comparing output from=20

    $ git help -a
    $ git -c column.ui=3Drow help -a

but did not spot differences.  What am I doing wrong?
