From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 6/6] Add SVN dump parser
Date: Thu, 10 Jun 2010 17:24:33 +0200
Message-ID: <AANLkTinyIvN2cMerCD4oI-1DsvsDLBfhvUZy0-e6dmpz@mail.gmail.com>
References: <1276175389-6185-1-git-send-email-artagnon@gmail.com> 
	<1276175389-6185-7-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 10 17:25:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMjcu-0007bz-Qa
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 17:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759388Ab0FJPY6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jun 2010 11:24:58 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64867 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759362Ab0FJPY5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jun 2010 11:24:57 -0400
Received: by gwj15 with SMTP id 15so17646gwj.19
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 08:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=sZT2cEB2mS0SG2k+pw63nxmbgKqP3SE7UvJTDHzZJhU=;
        b=ujG5ZJxe8D5mixnoPbD7aVOQ68JdPtPTKv5YIHuU/nZaCNBXKCgIUhoh89Uj4WIzqM
         EawXRSMMABN3IiBkKuBDLW8pepY5lnFYtTaucLiEidwDFZzS0q3g3e7FfZg7EpfhE898
         Px5t/A46ukxO/asocBouhmWVSFu5qme+z8KzM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=NCrirFtemeLXX4y48r0I2VuIVapf6wV206U7omLZW8FoVzRx9sOhLe39g1ofSmQdXQ
         fpUFw1yg0/K+jrF9SmVJ/gWYQiCEl81+KbwukfIyHl49gQUIri9da5WiM1WpfrgJUAYT
         HUrM08IKEUdn/JLHO/fPYZr7QScpzHeCCzK98=
Received: by 10.229.228.77 with SMTP id jd13mr268479qcb.177.1276183493319; 
	Thu, 10 Jun 2010 08:24:53 -0700 (PDT)
Received: by 10.229.182.85 with HTTP; Thu, 10 Jun 2010 08:24:33 -0700 (PDT)
In-Reply-To: <1276175389-6185-7-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148882>

Hi,

> +void svndump_reset(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 log_reset();
> + =C2=A0 =C2=A0 =C2=A0 buffer_reset();
> + =C2=A0 =C2=A0 =C2=A0 repo_reset();
> + =C2=A0 =C2=A0 =C2=A0 reset_dump_ctx(~0);
> + =C2=A0 =C2=A0 =C2=A0 reset_rev_ctx(0);
> + =C2=A0 =C2=A0 =C2=A0 reset_node_ctx(NULL);
> +}

Thanks to =C3=86var for pointing this out- kindly read the patch with t=
his
diff squashed in:

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 92c15d7..516a520 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -289,9 +289,6 @@ static void svndump_init(void)

 void svndump_reset(void)
 {
-	log_reset();
-	buffer_reset();
-	repo_reset();
 	reset_dump_ctx(~0);
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);

-- Ram
