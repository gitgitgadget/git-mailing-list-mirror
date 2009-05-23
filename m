From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v0 3/3] Build in git-rebase.sh
Date: Sat, 23 May 2009 19:26:03 +1000
Message-ID: <20090523092603.GA7420@dektop>
References: <1242899229-27603-1-git-send-email-pclouds@gmail.com> <1242899229-27603-2-git-send-email-pclouds@gmail.com> <1242899229-27603-3-git-send-email-pclouds@gmail.com> <4A164C85.3000703@viscovery.net> <fcaeb9bf0905220030l45e1b7dfqd30f35b7c8e43b51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat May 23 11:26:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7nVK-0000op-6S
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 11:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbZEWJ0N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 May 2009 05:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752588AbZEWJ0N
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 05:26:13 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:30120 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbZEWJ0M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 05:26:12 -0400
Received: by rv-out-0506.google.com with SMTP id f9so735680rvb.1
        for <git@vger.kernel.org>; Sat, 23 May 2009 02:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GqolDfLiXrpzw5ZoSt7AmZh7nkkCpDLqwBfTbhxN7Ks=;
        b=KuSmwr20oO04QwPjsupLi12SZhpjA2cNj5esIOtjFs0lf6lekvWG9Ga6qpc6FXyzco
         P3Wgr0HHOcY7MLxiS8yzizvzvGdE2wz0vEoLvpeCym3t/ORAIKEEJU0MDD40xCI810e/
         BaBTdzp2NLtoCV8YRTi44b0UbkjXapWcX1I2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=TcYMGzkwP9jEBlZJUOVXsIMIIsABPz01Pr4eFDmW29QgOZKY3Mkc1pKgKRYDGnRW5C
         uM7HFV4ba7jiZYTXpbFqu/y1vADMOJqtLZEF/VvBPD4g5GxhZG8p6zO5nljFCleUStRC
         26OqK3KWocNl+BqJt9cy5zhu4hsnd8GJQ8ZM8=
Received: by 10.140.170.21 with SMTP id s21mr2264428rve.205.1243070774020;
        Sat, 23 May 2009 02:26:14 -0700 (PDT)
Received: from dektop ([121.91.81.118])
        by mx.google.com with ESMTPS id g14sm12528864rvb.22.2009.05.23.02.26.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 May 2009 02:26:11 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sat, 23 May 2009 19:26:03 +1000
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0905220030l45e1b7dfqd30f35b7c8e43b51@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119769>

On Fri, May 22, 2009 at 05:30:31PM +1000, Nguyen Thai Ngoc Duy wrote:
> 2009/5/22 Johannes Sixt <j.sixt@viscovery.net>:
> > Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy schrieb:
> >> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@=
gmail.com>
> >
> > Is it possible for you to test this series on Windows? Many rebase =
tests
> > fail, but I haven't investigated why.
>=20
> I'll try it this weekend.

This patch makes t3*rebase*.sh pass for me except t3412 (more exactly
t3412.8). That test failed even with git-rebase.sh. Hmm... Anyway
could you try again to see what tests still fail?

--<--
diff --git a/builtin-rebase.c b/builtin-rebase.c
index 2acea59..5582f1d 100644
--- a/builtin-rebase.c
+++ b/builtin-rebase.c
@@ -56,7 +56,8 @@ static int rebase_config(const char *var, const char =
*value, void *data)
 			((struct rebase_opt*)data)->flags |=3D REBASE_STAT;
 		return 0;
 	}
-	return 0;
+
+	return git_default_config(var, value, data);
 }
=20
 /* utility functions */
@@ -504,7 +505,7 @@ static void run_interactive(int argc, const char **=
argv)
 	ret =3D run_command(&cp);
 	if (IS_RUN_COMMAND_ERR(ret))
 		die("Failed to run git rebase--interactive");
-	exit(ret);
+	exit(-ret);
 }
=20
 /* from diff.c */
--<--
