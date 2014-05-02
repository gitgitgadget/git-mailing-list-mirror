From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Evil
Date: Fri, 02 May 2014 15:34:34 -0500
Message-ID: <5364015a94900_135215292ec28@nysa.notmuch>
References: <20140501200703.GB6227@odin.tremily.us>
 <5362d7dc7b12_12fe14dd31095@nysa.notmuch>
 <20140502000208.GB28634@odin.tremily.us>
 <5362e8b09aba1_429131b31038@nysa.notmuch>
 <20140502011004.GD28634@odin.tremily.us>
 <5362f1755f2a9_d1310572f0fa@nysa.notmuch>
 <20140502145433.GF28634@odin.tremily.us>
 <5363ea28d3c14_70ef0f30c94@nysa.notmuch>
 <20140502190746.GJ28634@odin.tremily.us>
 <5363ee55ac2af_70ef0f30cf3@nysa.notmuch>
 <20140502194637.GL28634@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: "W. Trevor King" <wking@tremily.us>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 22:45:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgKKk-0001SB-NG
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 22:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143AbaEBUpU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 May 2014 16:45:20 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:65071 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115AbaEBUpP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2014 16:45:15 -0400
Received: by mail-ob0-f179.google.com with SMTP id wo20so18853obc.38
        for <git@vger.kernel.org>; Fri, 02 May 2014 13:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=hmbZYlwCz+qIp/nfF9A/m9nLW3vX8j+4RGnoI5zV33w=;
        b=x9U/dJJCuxyQRfGCaP/Sa1/Os400fYmVSGOZWM4yxFiQwr9s3igb7EcUOrRFPsDPi6
         e05sCbd9/sxudoOaDTVZSXFu85NKlBU8FbTLdOfYduKlvQvAYk+c5SzxK1we7rVmT141
         FRALV9OotUocBGFIWY19yjYaM6hbagrKuBM+NXpIjzjGjkq/SDh6xwgT7Ha5muw8oRAo
         FpnKJn40Uql1/tLdpKKrzXPdfiWIAtGAvc5c/KanKahxdaZUA/h+XuSPjta+b1GrstFA
         XRrXef6++eA4DIIqfGv7aQ3FCaNa77xtstz/L6m0kJuSoHokbILdmH8HXL7V4hOKCUnR
         YrSQ==
X-Received: by 10.60.16.103 with SMTP id f7mr18937191oed.8.1399063514760;
        Fri, 02 May 2014 13:45:14 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f1sm333929oej.5.2014.05.02.13.45.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 May 2014 13:45:12 -0700 (PDT)
In-Reply-To: <20140502194637.GL28634@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247971>

W. Trevor King wrote:
> On Fri, May 02, 2014 at 02:13:25PM -0500, Felipe Contreras wrote:
> > It would matter almost exactly zero.
>=20
> Some folks have explicit merge policies, and deciding how much that
> matters is probably best left up to the projects themselves and not
> decided in Git code.

Let's make some fake numbers to see around how much this would matter.
The amount of people that are not used to Git could be around 60%.

Of these, the amount that would be doing integration is probably 30%, a=
s
those tasks would be relegated to more advanced users. A project that
lets non-advanced users to integration probably wouldn't care if the
merges are fast-forward or not, but let's say 10% of them do. That make=
s
3%.

On the other hand, user might do merges when trying to bring their loca=
l
repositories up-to-date, let's say 100% of them do. Of those, the ones
in a project that doesn't want fast-forward merges is probably 10%. Tha=
t
makes 10%. However, such projects wouldn't want them merging
'origin/master' to 'master', but 'topic' to 'master', so they shouldn't
be using `git pull` anyway, but for the sake of argument let's say that
they do.

That would make around 8%, and 6% of those wouldn't be using `git pull`
anyway.

So no, for all intents and purposes it doesn't matter. I would rather
concentrate on the issue more than 90% of the users face.

> > And just as they can do pull.promot =3D true, they can do pull.mode=
 =3D
> > fetch-only.
>=20
> Why would you run a fetch-only pull instead of running 'git fetch'?  =
I
> think it would make more sense to have 'pull.mode =3D none' with whic=
h
> 'git pull =E2=80=A6' turns into a no-op suggesting an explicit
> fetch/{merge|rebase}.  Having something like that available would
> help with the training issue that pull.prompt was addressing.

I fail to see how training them to do this:

  % git config --global pull.mode none
  % git pull
  % git fetch
  % git merge --no-ff

Is preferable than training them to do:

  % git pull --no-ff

--=20
=46elipe Contreras