From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] diff and apply: fix singular/plural grammar nit.
Date: Sun, 27 Nov 2011 06:47:21 -0800 (PST)
Message-ID: <m37h2lmxk9.fsf@localhost.localdomain>
References: <4ED23EB5.1030208@ripton.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Ripton <dripton@ripton.net>
X-From: git-owner@vger.kernel.org Sun Nov 27 15:48:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUg1S-0002jS-94
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 15:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755641Ab1K0Or1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Nov 2011 09:47:27 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61977 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094Ab1K0Or0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2011 09:47:26 -0500
Received: by bke11 with SMTP id 11so7069165bke.19
        for <git@vger.kernel.org>; Sun, 27 Nov 2011 06:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=MQrdBzL4WRe3e8vlumZkl0oEqlamm6zfofzHQCzpFF4=;
        b=vzrEINiAzECQQ7QgAASYf3lQgm54WVA2oXCk8zNIxeytB6opQanTkF7LIeYAoG6+re
         +G/5ogkEW54xZQsV5S89p18CMcY+qWnt1+awguiLdvP42+FHAmu4wpqDXVtTBH6kcHeY
         cYfU9MZjIw1RMIBMiYTp2VD+rwcXHtn8D6ATY=
Received: by 10.204.149.89 with SMTP id s25mr30064679bkv.47.1322405243278;
        Sun, 27 Nov 2011 06:47:23 -0800 (PST)
Received: from localhost.localdomain (abwo176.neoplus.adsl.tpnet.pl. [83.8.238.176])
        by mx.google.com with ESMTPS id y2sm35855465fag.12.2011.11.27.06.47.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 Nov 2011 06:47:21 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pARElqah026944;
	Sun, 27 Nov 2011 15:47:53 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pARElpTH026940;
	Sun, 27 Nov 2011 15:47:51 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4ED23EB5.1030208@ripton.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185986>

David Ripton <dripton@ripton.net> writes:

> Remove the trailing 's' from "files", "insertions", and "deletions"
> when there is only one of the item.
>=20
> Signed-off-by: David Ripton <dripton@ripton.net>
> ---
[...]
> -       printf(" %d files changed, %d insertions(+), %d
> deletions(-)\n", files, adds, dels);

Whitespace damaged.  Please turn off word wrapping (limiting line
width) when sending patches.

> +       printf(" %d file%s changed, %d insertion%s(+), %d deletion%s(=
-)\n",
> +              files, (files =3D=3D 1 ? "" : "s"),
> +              adds, (adds =3D=3D 1 ? "" : "s"),
> +              dels, (dels =3D=3D 1 ? "" : "s"));
>   }

=46irst, I think this is an API / plumbing and should not be changed.
But I might be mistaken about that.

Second, it is a perfect example ho to *not* handle plural form in the
presence of internationalization (i18n) efforts.  See e.g.

  http://www.gnu.org/s/hello/manual/gettext/Plural-forms.html

--=20
Jakub Nar=EAbski
