From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] git checkout -b: unparent the new branch with -o
Date: Wed, 17 Mar 2010 01:40:34 -0500
Message-ID: <20100317064034.GA31749@progeny.tock>
References: <1268763584-14164-1-git-send-email-erick.mattos@gmail.com>
 <7v634v27vf.fsf@alter.siamese.dyndns.org>
 <55bacdd31003161810w1c824570lee1b7d5759568bc1@mail.gmail.com>
 <20100317041307.GA26641@progeny.tock>
 <7v4okfiksh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erick Mattos <erick.mattos@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 07:40:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrmvW-0001jf-F8
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 07:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388Ab0CQGkQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 02:40:16 -0400
Received: from mail-yx0-f199.google.com ([209.85.210.199]:55212 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366Ab0CQGkP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 02:40:15 -0400
X-Greylist: delayed 31992 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Mar 2010 02:40:14 EDT
Received: by yxe37 with SMTP id 37so403363yxe.21
        for <git@vger.kernel.org>; Tue, 16 Mar 2010 23:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=VS86PbJ4uPFSzp5RA4/JBDVUk1O3MEmaYuHQimA771U=;
        b=ZpWST6RjyUtFTbnH5aMJmETxP9CpA2FAu5maIdroLhoIa+un++fqXwHsJ1PCQIgDZf
         XOekIz/nZSS2xCyc+orvmO12ebgB4Iq11f5UtoZcugWM/3BSuZrBiHfFnMzHMnsWiA3L
         WcKKF5+Q9HsSQOADBzxWHvYNt8chmBlZaedpw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=tQxk+BsFjQZCfSyCgAS+9NptRcWoavtoso/ZCA/3EBneck9qDiyoO52UfuKXIQT70U
         IBzu4WtSbzXnA41vuG5K6B8YYxgU3fhG2kHSHQaJ0dqOGRPHz0YZa0C9/mLSHr+/mhPf
         pvtgCCEPzVQjS+gZldVcaE+6S3Ipg6hv1b+DY=
Received: by 10.150.132.13 with SMTP id f13mr3962438ybd.293.1268808013892;
        Tue, 16 Mar 2010 23:40:13 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm6066466iwn.5.2010.03.16.23.40.13
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Mar 2010 23:40:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v4okfiksh.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142367>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>=20
> > Junio was discussing the case B.
>=20
> Well, not really.  Even as an ingredient, "nuke index, leaving files =
in
> the work tree around" is the most difficult-to-use mode of operation.
> Either "try to run 'git rm -f .' from the toplevel and only if it suc=
ceeds
> point HEAD to an unborn branch" (aka "remove both"), or "point HEAD t=
o an
> unborn branch without doing anything else" (aka "keep both") would be=
 an
> ingredient that is far easier to use.

Okay, fair enough.  From the point of view of plumbing, what is there
left to do that

	git rm -f . &&
	git symbolic-ref HEAD refs/heads/new

or

	git symbolic-ref HEAD refs/heads/new

or

	git rm --cached . &&
	git symbolic-ref HEAD refs/heads/new

does not take care of?

I guess I should have said that I would be happier to see something
tailored to a use case or a class of use cases.

I haven=E2=80=99t needed it for a while, but once upon a time I was mak=
ing
isolated branches like crazy for some abuse of git as a compression
tool.

Jonathan
