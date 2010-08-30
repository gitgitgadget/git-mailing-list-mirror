From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 01/13] fast-import: add the 'done' command
Date: Sun, 29 Aug 2010 21:08:58 -0500
Message-ID: <AANLkTimNsVeGLB5=y8WyLqdkiQFwoBkdp_YrfuuT_5Ec@mail.gmail.com>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
 <1283053540-27042-2-git-send-email-srabbelier@gmail.com> <20100829212419.GC1890@burratino>
 <AANLkTik_kPy8p-OTy8E7fcLFMfKFHex2ppw4Oy7BesUX@mail.gmail.com>
 <20100829223218.GL1890@burratino> <AANLkTik3H6hVgViAX5ur9Tq4tFQ9mJEPuTmAwcrLStvU@mail.gmail.com>
 <20100830020236.GH2305@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 04:09:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OptoL-0002C3-Kz
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 04:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534Ab0H3CJV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Aug 2010 22:09:21 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:37649 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754187Ab0H3CJU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Aug 2010 22:09:20 -0400
Received: by gxk23 with SMTP id 23so1801214gxk.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 19:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=+LL4+lB2XzgsiU0ladYKxm8lOkfEcHzf+C1s7+8CPOQ=;
        b=HcqsJ61YgOP+nZA240Ear2XMs7SqSOeZd3sjdKygU0Lc+oQ9GWaVVpG4Z2D+9flFaU
         01OHzfUOih1iHePsYplEpJv/j+85zl4xewEWNaJhCpFHTwbu3pfKrrOkMvwQ2dweSfpc
         tEcSQGWL4tdh5YAkpNjR20JPF/30628jRx9tk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=qso6UVgDQZ00CCEyt1ZH9lU2eTrhY0InYXcLLxFkUuYwYojGD0LvXulU6Z/VcmmJwy
         B+qoR8YC8htMzVpdPy994TbXMMjufwh+GHkTS6HWuJhF4udPfvNyS6gkGQi3/rOzFg1r
         pB/dlUXoU5IQorS+g+uvmmgns1v2uoQeK0WeI=
Received: by 10.150.52.11 with SMTP id z11mr4415630ybz.149.1283134159508; Sun,
 29 Aug 2010 19:09:19 -0700 (PDT)
Received: by 10.151.49.17 with HTTP; Sun, 29 Aug 2010 19:08:58 -0700 (PDT)
In-Reply-To: <20100830020236.GH2305@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154749>

Heya,

On Sun, Aug 29, 2010 at 21:02, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> I was thinking specifically of the case where one is unlucky enough
> for the stream to end at a valid, early spot.

I think it makes sense to say that if you issue a 'feature done', we
change the code that checks for EOF to error instead of quit.

> The way all importers seem to end up is to call "git fast-import" as =
a
> child process (rather than advertising an interface like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0svnrdump dump <URI> | svn-fe | git fast-im=
port
>
> ) so maybe this is not such a big deal.

Does it matter much which way the importer is called? If it ends early
at a valid point nobody will know regardless of how it is called, no?

--=20
Cheers,

Sverre Rabbelier
