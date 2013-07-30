From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Help using git subtree
Date: Tue, 30 Jul 2013 11:58:46 +0200
Message-ID: <20130730095846.GA19369@paksenarrion.iveqy.com>
References: <51F78826.1040502@cells.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Gabriel Jover <gjover@cells.es>
X-From: git-owner@vger.kernel.org Tue Jul 30 11:56:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V46fJ-0001n9-Ja
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 11:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758597Ab3G3J4Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Jul 2013 05:56:16 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:61231 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758699Ab3G3J4N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 05:56:13 -0400
Received: by mail-la0-f41.google.com with SMTP id ec20so1262000lab.14
        for <git@vger.kernel.org>; Tue, 30 Jul 2013 02:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=y+9PaLdiVPruWi4XpoZtzHmTXijq8LlwxgWvkawhjvk=;
        b=ypvQqXy/AayVrWuxH2lVuq1bIqhLYQxwQsj8eY1Gq2vb2xXwkR/2S4fcMdk7B6D19f
         n2d43zyyOsydAHb6NGsVURFd4D2t2/Dq6npW7exsFsPyN4pK8JSRQSwxmjtY5SfR/06j
         bWgFR3j0/kP3/esIGPZHOG2L2wpEpXzAsWyfiEx1nE/lOrewqEU21arPLdNECd9tGxmr
         zNKWvu+Ohz5nJ4qXa1h5oY7cRiMXp9xht1TGqEKP2I0gWf2VhdR5bcdgQfnG7r+QHBea
         5CEjpr9dcPGSQRMPwzv2HO9/05wBvUPIdGnhrdJOqqjn5VYL6QLsNpLHoDeIxMfReE0s
         nIlQ==
X-Received: by 10.112.63.132 with SMTP id g4mr14521857lbs.25.1375178172156;
        Tue, 30 Jul 2013 02:56:12 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id am8sm25860830lac.1.2013.07.30.02.56.11
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jul 2013 02:56:11 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1V46ha-0008M1-6Z; Tue, 30 Jul 2013 11:58:46 +0200
Content-Disposition: inline
In-Reply-To: <51F78826.1040502@cells.es>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231358>

On Tue, Jul 30, 2013 at 11:32:22AM +0200, Gabriel Jover wrote:
> Dear all,
>=20
> I am trying to avoid using git submodules and thus I am testing if
> git subtree fit my needs.
> I have a set of sub-projects linked to a main-project.

Just out of curiosity, why are you trying to avoid submodules?

>=20
> Git subtree is very convenient to get all the sub-projects into the
> main-project directory tree
> and to send back sub-project commits to the corresponding repository.
> But I don't understand the work flow very well.

I haven't used subtree that much however how do you commit to upstream?
AFAIK every commit to the subtree must be done in the subtree branch an=
d
then merged back to the "superproject"-branch with a subtree merge.

>=20
> I can add a subtree with a given prefix and pull/push my commits to
> the repository,
> but how do I do to pull/push commits from the main-project to the
> corresponding repository
> avoiding sub-projects to be sent?

You don't. A subtree is a subtree in your git-repo and is therefore a
part of your repository. When you're using subtree that project will be
a part of you project.

>=20
> An other question I have is when will be subtree included in git pack=
ages.
> I had to compile git from sources in order to get this feature.
>=20

git-subtree is a part of git, located in the contrib section. When your
software distribution choose to distribute that with your git-package
is not up to the git project to decide but something you need to ask
your package maintainer.

If you're asking when git-subtree will move from contrib/ to core git, =
I
don't know. That's a decision for Junio. I would argue that it shouldn'=
t
because submodules can do everything that subtrees are good at and
git.git should focus on doing one solution well instead of doing the
same thing in two bad ways. However since git.git already uses a
subtree-like style for gitk, git-gui, etc.  it doesn't seem like Junio
agrees with me on this point.

>=20
> Si heu rebut aquest correu per error, us informo que pot contenir inf=
ormaci=F3 confidencial i privada i que est=E0 prohibit el seu =FAs. Us =
agrairiem que ho comuniqueu al remitent i l'elimineu. Gr=E0cies.
> Si ha recibido este correo por error, le informo de que puede contene=
r informaci=F3n confidencial  y privada y que est=E1 prohibido su uso. =
Le agradecer=E9 que lo comunique a su remitente y lo elimine. Gracias.
> If you have received  this e-mail by error, please note that it may c=
ontain confidential and private  information, therefore, the use of thi=
s information is strictly forbidden. Please inform the sender of the er=
ror and delete the information received. Thank you.

Is this really something to have in e-mails to a public list? Some list=
s
won't accept this type of e-mails, or simply just ignore you.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
