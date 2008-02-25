From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] Teach git-describe --long to output always the long format
Date: Mon, 25 Feb 2008 21:51:02 +0100
Message-ID: <8aa486160802251251u74a19b93l77ca3930d2387cb8@mail.gmail.com>
References: <1203864412-27977-1-git-send-email-sbejar@gmail.com>
	 <20080225023634.GK8410@spearce.org>
	 <7vwsotpwbr.fsf@gitster.siamese.dyndns.org>
	 <8aa486160802250034ncdf20b6s13856ca8612bc2ea@mail.gmail.com>
	 <7vbq65ju0y.fsf@gitster.siamese.dyndns.org>
	 <8aa486160802250105p4f98cb6eu1d6ac4fa700f11fe@mail.gmail.com>
	 <7vwsoshk3s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 21:52:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTkIr-0000Zy-KD
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 21:52:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759904AbYBYUvJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2008 15:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756861AbYBYUvJ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 15:51:09 -0500
Received: from ti-out-0910.google.com ([209.85.142.184]:60952 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864AbYBYUvG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Feb 2008 15:51:06 -0500
Received: by ti-out-0910.google.com with SMTP id 28so1086834tif.23
        for <git@vger.kernel.org>; Mon, 25 Feb 2008 12:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=wTcx9oqmnAHiegErOdFBr8v/MSerTmV3FRUVhCYf3Ak=;
        b=hcmA4pMvLvhkmTjbT1sNF1GgIq8TY6gr4p+gdzI8CfAQGjn1+FCeT3hQqJDftD3TPUedXpBOjqRgP2of0E6z3zd6cs1g4ovbgZDJhlbaU8R4skUFZb/ubWhJu5nm+1eO9pAHc4jWtMWhgpFSqU+qcOUe6occ9qKezD70QqLNIdo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VoZWQ98bEPaxlaUyESb2lqv4/g+Qxb6cbKyaK9HefAQTX0UHzf7VrdO6v57OInKr/0gGkEtqCl+9q6FqSJ06FWVf9pbm5WKn2uVJvWdzz8mspyF2slqZp91bmqEJdMBrIzpuKMwRyKZ7Hv951w55xadPEz+oTYT2iXNPDQ8/Nrs=
Received: by 10.150.155.1 with SMTP id c1mr1276541ybe.15.1203972662382;
        Mon, 25 Feb 2008 12:51:02 -0800 (PST)
Received: by 10.150.205.9 with HTTP; Mon, 25 Feb 2008 12:51:02 -0800 (PST)
In-Reply-To: <7vwsoshk3s.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75067>

On Mon, Feb 25, 2008 at 9:11 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> "Santi B=E9jar" <sbejar@gmail.com> writes:
>
>
> >>  That's backwards.  If you want reliable unique identifier, you
>  >>  would use 40-hexdigit.  If you want human readable, you would
>  >>  use tags, and if you allow different people to distribute tags
>  >>  with the same name that point at different things, _you_ have a
>  >>  problem at higher level.
>  >
>  > Yes, I have a "problem" at a higher level, but I cannot "solve" it=
=2E
>  > This patch "workaround" this "problem", we want all to be able to =
tag
>  > and have descriptive and uniqe names. I think git should allows us=
 to
>  > work this way.
>
>  Why can't you solve it?  Your example of two people giving the
>  same name to different things shows a lack of communication
>  between developers, and as long as you and the other guy are
>  talking with each other the problem can be solved, can't it?

But there are times when you can't/don't want to communicate
(private/testing/forks, whatever).

Anyway, even if this problem is solved I feel more confortable with a v=
ersion in
my binary (and output) with a descriptive name and a revision id.

>  SCM or any other tools may facilitate developer communication,
>  but it is not a replacement for communication.

I know, but my problem is not lack of communication.

>
>  "git describe" output can be unique only within a local
>  repository, as it cannot read your mind and inspect random
>  repositories other people own.  In one repository, abbreviating
>  an object name to 4 hexdigits may be enough to make it unique,
>  but in another it may need 6 hexdigits.

If you always use "git describe --long" it is globally unique, as long =
as sha1
is globally unique (at least unique enough).

>  If you are trying to guarantee uniqueness of something that
>  lives for a long time (e.g. release version number that is
>  embedded inside binaries, which is what you use "git describe"
>  to generate), _and_ if you worry about two people in different
>  repositories giving the same name to different things which
>  would introduce a bogosity to that long-lived name, you would
>  need a way that is external to the uniqueness guarantee "git
>  describe" can give.

See above.

>  I do not mind low-impact new options and new features like this.
>  Everybody loves bells and whistles.  But I do want valid use
>  cases attached to them so that (1) we can justify their
>  existence; and (2) we can document them to explain what purpose
>  they serve, to help people to decide when to use them.

OK.

>  I even suspect that the --long flag might be useful in some
>  situation, but I do not think "a tag with the same name" is one
>  of the problems this patch lets you solve or work around.
>
>  Jakub's "it looks more uniform and does not treat a tagged
>  version any specially" may probably be a better argument for
>  this new feature.  I dunno.
>

Maybe.

Santi
