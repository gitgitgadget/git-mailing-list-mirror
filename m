From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Wed, 21 Jul 2010 17:20:33 -0400
Message-ID: <AANLkTik0gqWjvHhULey89JuatjSSYsCwFegfr6E4bUKx@mail.gmail.com>
References: <4C472B48.8050101@gmail.com> <AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com> 
	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com> 
	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com> 
	<AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bryan Larsen <bryan.larsen@gmail.com>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 21 23:21:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Obgiu-0005uv-DA
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 23:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758546Ab0GUVU5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jul 2010 17:20:57 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46910 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757693Ab0GUVU4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jul 2010 17:20:56 -0400
Received: by wyf19 with SMTP id 19so46524wyf.19
        for <git@vger.kernel.org>; Wed, 21 Jul 2010 14:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=lPi/3V6s111hAvlIdW7V/Yzr/IP/1QAiD6PbHnKb0kQ=;
        b=qz9yrLkRDeiTy2wFWByTpHWrc4OMeYIudNeD6jIQKaO3Y7i97o3Jgw3hsSCNUzDlJ4
         OJoJd5KA8sP9rqcaQL+PxYwtI/LJ+hBeygGLVXsKD9fRS61/NkF/NSmFUfYI9c9ZNvMi
         WXMt4Cqe5EsqrG86mwok8X8ynG60Y4q0Ab/wM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=q9HeGuRzOjzku5juiGBY+iaIrnptVTknPgNhD806Eu4z34/f/P7cDcefFawtTvlW01
         ukZbH7K18/aExaOA7aB5yMQagfcVdutm7RKPlqXc9cEv/h8nopltaaD+9YLegXdYcYci
         TVmSEP+ZG67b0qGuGD0OJLbxtrLoNkFoFU0bw=
Received: by 10.227.156.66 with SMTP id v2mr726962wbw.194.1279747253546; Wed, 
	21 Jul 2010 14:20:53 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Wed, 21 Jul 2010 14:20:33 -0700 (PDT)
In-Reply-To: <AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151420>

On Wed, Jul 21, 2010 at 5:09 PM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
> All the submodules have
> to get pushed to and fetched from the same repo by default. =A0Anythi=
ng
> else is insane.

=2E..and just to clarify, by far the least insane option here is to hav=
e
the whole thing all under a single ref, which is currently impossible
with submodules.

>> What's missing from that (which would be nice) is the ability to che=
ck
>> out a subdirectory from another repository. That could (I think) be
>> done by just adding a normal "tree" entry, and then specifying that
>> that tree can be found in git://... instead of the main tree.
>
> Actually that's already easy with submodules (and git-subtree makes i=
t
> easy too, though slightly different). =A0Just fetch the commit from t=
he
> other repo, and do:
>
> =A0 git checkout FETCH_HEAD -- subdirname

Sorry, that's not right.  You can use this instead for roughly the
effect you want:

    git read-tree --prefix subdirname FETCH_HEAD: && git checkout subdi=
rname

Have fun,

Avery
