From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 11/13] Allow helpers to request the path to the .git 
	directory
Date: Thu, 5 Nov 2009 01:15:55 +0100
Message-ID: <fabb9a1e0911041615o2a1afb6akdb120cdc94864e60@mail.gmail.com>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com> 
	<1257364098-1685-12-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.0911041621400.14365@iabervon.org> 
	<fabb9a1e0911041406tce0956ai2ad3fe6cfbdc546d@mail.gmail.com> 
	<7vd43xg7lf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 01:16:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5q1X-0006dV-VE
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 01:16:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265AbZKEAQM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Nov 2009 19:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbZKEAQM
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 19:16:12 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:35520 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbZKEAQL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2009 19:16:11 -0500
Received: by ewy3 with SMTP id 3so3762198ewy.37
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 16:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=5s37mi1ytIG4mhBOHUTyZ+HTmqIk40qdrLbtXotJgYw=;
        b=CidzXkBvSHuBF45cuoeZzLbZFzJvfU7uqQMZAY4sZp8hDRYqMUZhV22Ox+t0rHAK2v
         dIujScOnL/yxPz4kuHrj9cwmvj8qIMzLhCYV7H0Rem71iM3KncQdk/sfSMIXqVEufQ1R
         giHDul7De1k/L5Afsg2yEwPitOTVzGlh/MLp8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=P88XbRh/fOEwDfrIXGsxcqL0gyLfnQKWSUR4EN08xrrKTJcmge4V2tt3z0/sxcQqru
         7IhYvKAEiC1vkrY+CgIWw4iyLJ6VuoQPXDFYJCxKSBDaouNL5RJ/IsVbOS7l7uOrjVLy
         yv9raWiz2isHJwHICiiGPupyZ3OJo3DM9RlLI=
Received: by 10.216.90.65 with SMTP id d43mr723342wef.41.1257380175150; Wed, 
	04 Nov 2009 16:16:15 -0800 (PST)
In-Reply-To: <7vd43xg7lf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132179>

Heya,

On Thu, Nov 5, 2009 at 01:04, Junio C Hamano <gitster@pobox.com> wrote:
> What do you mean by <alias> here? =A0Is it the <alias> in
>
> =A0 =A0 =A0 =A0[remote "alias"]
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0url =3D hg::http://some.where/repo/sit=
o/ry.hg

Yes, that one.

> IOW, can a user ever use the foreign interface directly from the comm=
and
> line, without ever defining such entries in .git/config, perhaps usin=
g
> "git remote"?

No, my primary use case for remote helpers is currently 'git clone
hg::https://soc.googlecode.com/hg/', and to have 'git fetch origin'
Just Work (tm) from that clone. My secondary use case though, is to
support 'git fetch hg:: https://soc.googlecode.com/hg/' just as well
and have 'git log FETCH_HEAD' Just Work (tm) too. In that light
=2Egit/info/remote-<vcs>/ is probably a better idea, so that the helper
can use say '.git/info/remote-<vcs>/fetch/ for one-time fetches.

--=20
Cheers,

Sverre Rabbelier
