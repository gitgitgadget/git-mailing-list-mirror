From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] Add hint interactive cleaning
Date: Mon, 02 Mar 2015 11:39:39 -0800
Message-ID: <xmqq7fuzb344.fsf@gitster.dls.corp.google.com>
References: <1425137944-13667-1-git-send-email-jn.avila@free.fr>
	<1425211105-18873-1-git-send-email-jn.avila@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jean-Noel Avila <jn.avila@free.fr>
X-From: git-owner@vger.kernel.org Mon Mar 02 20:39:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSWC0-0000V0-Au
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 20:39:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755057AbbCBTjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 14:39:44 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64299 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755043AbbCBTjm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 14:39:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 563673BDAA;
	Mon,  2 Mar 2015 14:39:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/9LS4LKj8XVEzV5n5E+KQU1Eavo=; b=RJ/nP6
	pkokf+tvDY6+Usox6Q3NWaom4z/uBDXwgQfLS63ulSF20bnHjjMAEoSGI8I3QLLa
	6lWPo1hxqhlTBncLv5gTstP9eqmCC2Z+hnL+PrbIeqCAb7S6t5StFRQxEFCfiw/c
	kN335lzbjwncjGLUpwBc0XG7YJHo1LfTgwsno=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dOwQYRyhYdsxNWp1q13ZuI8iJWXUagD9
	Pxw3TbanSf2cL3qvqM0xP3vcoxQNLtd2lsg46/ynVg96KkJWtw1tYLgtrUj3HCIX
	8qV2t52hN8QubpNq5Z4XDDhxhrZ+AfM/loPzmZSOaRRy86Bp/dgd8mBH7BIyPq27
	CwRb+ShgXSQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E9F63BDA9;
	Mon,  2 Mar 2015 14:39:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C67E23BDA7;
	Mon,  2 Mar 2015 14:39:40 -0500 (EST)
In-Reply-To: <1425211105-18873-1-git-send-email-jn.avila@free.fr> (Jean-Noel
	Avila's message of "Sun, 1 Mar 2015 12:58:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DE6E3842-C113-11E4-8195-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264611>

Jean-Noel Avila <jn.avila@free.fr> writes:

> For translators, specify that a  y/N reply is needed.
>
> Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
> ---
>  builtin/clean.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/clean.c b/builtin/clean.c
> index 7e7fdcf..98c103f 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -754,7 +754,8 @@ static int ask_each_cmd(void)
>  		/* Ctrl-D should stop removing files */
>  		if (!eof) {
>  			qname = quote_path_relative(item->string, NULL, &buf);
> -			printf(_("remove %s? "), qname);
> +			/* TRANSLATORS: Make sure to keep [y/N] as is */
> +			printf(_("Remove %s [y/N]? "), qname);
>  			if (strbuf_getline(&confirm, stdin, '\n') != EOF) {
>  				strbuf_trim(&confirm);
>  			} else {

Thanks. All other interactive prompts from this command
(i.e. menu_opts.prompt) seem to capitalize their first word, so
upcasing this message is a good change, too.
