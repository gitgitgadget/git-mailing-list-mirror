From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH 6/9] pretty: two phase conversion for non utf-8 commits
Date: Sun, 23 Sep 2012 15:54:35 +0200 (CEST)
Message-ID: <189332269.134567.1348408475044.JavaMail.root@dewire.com>
References: <1348391433-11300-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 15:55:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFmeC-0002a0-EQ
	for gcvg-git-2@plane.gmane.org; Sun, 23 Sep 2012 15:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246Ab2IWNyh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Sep 2012 09:54:37 -0400
Received: from zimbra.dewire.com ([83.140.172.131]:44150 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948Ab2IWNyg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Sep 2012 09:54:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 62D0E823E8;
	Sun, 23 Sep 2012 15:54:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bECBP3mkXpYb; Sun, 23 Sep 2012 15:54:35 +0200 (CEST)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id 1C068823DB;
	Sun, 23 Sep 2012 15:54:35 +0200 (CEST)
In-Reply-To: <1348391433-11300-7-git-send-email-pclouds@gmail.com>
X-Originating-IP: [213.65.101.30]
X-Mailer: Zimbra 7.2.0_GA_2681 (ZimbraWebClient - FF3.0 (Mac)/7.2.0_GA_2681)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206239>


A few nitpicks

----- Ursprungligt meddelande -----
> Always assume format_commit_item() takes an utf-8 string for
> simplicity. If commit message is in non-utf8, or output encoding is
> not, then the commit is first converted to utf-8, processed, then
> output converted to output encoding.
>=20
> This of course only works with encodings that are compatible with
> Unicode.
Such as? Unicode was defined to encompass all knows encodings.

> -static size_t format_commit_one(struct strbuf *sb, const char
> *placeholder,
> +static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
> +				const char *placeholder,
>  				void *context)
>  {
>  	struct format_commit_context *c =3D context;

Which parameter does the comment apply to? I believe most conventions
nowadays include parameter documentation in the comment preceding
the function header.

[...]

> b/t/t6006/commit-msg.iso8859-1
> new file mode 100644
> index 0000000..f8fe808
> --- /dev/null
> +++ b/t/t6006/commit-msg.iso8859-1
> @@ -0,0 +1,5 @@
> +Test printing of complex bodies
> +
> +This commit message is much longer than the others,
> +and it will be encoded in iso8859-1. We should therefore
> +include an iso8859 character: =EF=BF=BDbueno!

"8859-1" to be exact. Only three 8859 encoding has the
character.

-- robin
