From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 23/73] gettextize: git-checkout "HEAD is now at"
 message
Date: Fri, 25 Feb 2011 02:04:28 -0600
Message-ID: <20110225080428.GG23037@elie>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
 <1298418152-27789-24-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 09:04:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PssfP-0004io-Ga
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 09:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755764Ab1BYIEh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Feb 2011 03:04:37 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:32896 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754907Ab1BYIEg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 03:04:36 -0500
Received: by qwd7 with SMTP id 7so1072626qwd.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 00:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=BthcFtf/PpmUC6aUcpNl1VO+uTTQITgVplGq+YAnemQ=;
        b=tAx8UY1esmG4nQnrYNEK0KfqfmrTeRntM0nLxCULICyHfA/ZX76bNLumDcBcatyirK
         38/XbxgFeNCWdQDsagpkwdb7zqknqxhFmMebIbBvrc2PGSBY6vqdW6IlXAKc4xXoxexE
         49A/VQ4Fi489cB28v5zbhTCn77iEWwz2Cuin8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=BbKVZJ0Tk04R6Jdy2gLF6+LjibTg467pu0SuSNnInuY7QuPocQe1d9h5jX6Jmf4jem
         ImguMY+Ljyo/dEQZaiey4Q920jbDlX3hNQbvE2O44vM+PP1bkKiWaVyLI2Jde+wQnDPn
         ZySivYmXLXVz4iYG63Wb/cftFx6RhP+oW4xZM=
Received: by 10.229.221.17 with SMTP id ia17mr1615595qcb.6.1298621075493;
        Fri, 25 Feb 2011 00:04:35 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.sbcglobal.net [69.209.53.52])
        by mx.google.com with ESMTPS id g32sm332306qck.46.2011.02.25.00.04.33
        (version=SSLv3 cipher=OTHER);
        Fri, 25 Feb 2011 00:04:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1298418152-27789-24-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167882>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -571,7 +571,7 @@ static void update_refs_for_switch(struct checkou=
t_opts *opts,
>  		if (!opts->quiet) {
>  			if (old->path && advice_detached_head)
>  				detach_advice(old->path, new->name);
> -			describe_detached_head("HEAD is now at", new->commit);
> +			describe_detached_head(_("HEAD is now at"), new->commit);

It might make sense to squash patches 22 and 23 with the following.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/checkout.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index fb93d63..dca0935 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -305,7 +305,14 @@ static void describe_detached_head(const char *msg=
, struct commit *commit)
 	struct pretty_print_context ctx =3D {0};
 	parse_commit(commit);
 	pretty_print_commit(CMIT_FMT_ONELINE, commit, &sb, &ctx);
-	fprintf(stderr, "%s %s... %s\n", msg,
+
+	/*
+	 * TRANSLATORS: The first '%s' is either "Previous HEAD position was"
+	 * or "HEAD is now at".  The second '%s' is an abbreviated hexadecima=
l
+	 * commit id for HEAD and the third '%s' is the first line of its
+	 * commit message.
+	 */
+	fprintf(stderr, _("%s %s... %s\n"), msg,
 		find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV), sb.buf);
 	strbuf_release(&sb);
 }
--=20
1.7.4.1
