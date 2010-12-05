From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 01/10] parse-options: Don't call parse_options_check()
 so much
Date: Sun, 05 Dec 2010 19:14:43 +0100
Message-ID: <4CFBD693.20305@lsrfire.ath.cx>
References: <20101201232728.GA31815@burratino> <20101201232852.GB31815@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stephen Boyd <bebarino@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Pierre Habouzit <madcoder@debian.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 05 19:15:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPJ7C-0002jJ-Tf
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 19:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756549Ab0LESPD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Dec 2010 13:15:03 -0500
Received: from india601.server4you.de ([85.25.151.105]:38337 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756446Ab0LESPB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Dec 2010 13:15:01 -0500
Received: from [10.0.1.100] (p4FFDAADD.dip.t-dialin.net [79.253.170.221])
	by india601.server4you.de (Postfix) with ESMTPSA id 55DA82F81B7;
	Sun,  5 Dec 2010 19:14:59 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <20101201232852.GB31815@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162955>

Am 02.12.2010 00:28, schrieb Jonathan Nieder:
> From: Stephen Boyd <bebarino@gmail.com>
>=20
> parse_options_check() is being called for each invocation of
> parse_options_step() which can be quite a bit for some commands. The
> commit introducing this function cb9d398 (parse-options: add
> parse_options_check to validate option specs., 2009-06-09) had the
> correct motivation and explicitly states that parse_options_check()
> should be called from parse_options_start(). However, the implementat=
ion
> differs from the motivation. Fix it.

Good idea.

>  void parse_options_start(struct parse_opt_ctx_t *ctx,
>  			 int argc, const char **argv, const char *prefix,
> -			 int flags)
> +			 int flags, const struct option *options)

It might be better to put options before flags, i.e. to use the same
order as in parse_options().

Ren=C3=A9
