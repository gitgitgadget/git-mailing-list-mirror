From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 7/7] t7006-pager: if stdout is not a terminal, make
 a new one
Date: Fri, 19 Feb 2010 02:19:47 -0600
Message-ID: <20100219081947.GA12975@progeny.tock>
References: <20100219065010.GA22258@progeny.tock>
 <20100219072331.GG29916@progeny.tock>
 <20100219080819.GA13691@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Sebastian Celis <sebastian@sebastiancelis.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 19 09:19:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiO5S-0007ur-2d
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 09:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222Ab0BSITl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2010 03:19:41 -0500
Received: from mail-gx0-f227.google.com ([209.85.217.227]:42038 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774Ab0BSITk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 03:19:40 -0500
Received: by gxk27 with SMTP id 27so3814700gxk.1
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 00:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=4bcX5vb1XgPQEM7BkCs5383wRlY+APv2BRkWHqpGP1Y=;
        b=P6kQJvbXuKMduDQjXtK8SWXpzfKzq0IESOMdqhanZx0XRDgBsx0XM9jTwtOAdkm99Q
         Wn8u2OWUYFjWi8zHRi/WcM2u15UWd8Kk5Cwro+AO5ax2EOer7DLeyI9vMbEsCpKYiCOP
         5kfWGoAMz+9vCZaWOk8tz0pMhWpie3i9L/K9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Zb+cSl/1x1LkXH9LoL/evdfy2ONg5LRHwyx7b+yX4x3aflASNOE2MlqWHv/fXfPYnN
         6Flb6zaSabGyDdcNa70A9c3l5QGa2c/Z+Cnp71RWVSRPNggHFfxS25xSsoCaJZnwNoeA
         2E36q8sngRHWg95rkmjT2bNNNTgKg9bF16kAc=
Received: by 10.101.189.30 with SMTP id r30mr3019760anp.70.1266567579505;
        Fri, 19 Feb 2010 00:19:39 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 13sm2425917gxk.4.2010.02.19.00.19.38
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Feb 2010 00:19:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100219080819.GA13691@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140433>

Jeff King wrote:

> Solaris 8 and 9 seem to be lacking it. Solaris 10 does have it. AIX 5=
=2E2
> and 6.1 both have it.
>=20
> So it would mean some platforms couldn't run all tests. That is proba=
bly
> good enough, given that most of our terminal-related bugs have not be=
en
> platform-specific problems.

Hmm, how about /dev/ptmx?  (One can check by replacing posix_openpt(...=
)
with open("/dev/ptmx", ...) in the test-terminal.c I sent.)

> Still, it seems like just wrapping isatty would be simpler. I guess y=
ou
> are opposed to carrying around test-specific code in the main git
> binary?

No, not opposed.  Just lazy and not so interested in working on it.
I do not want to just take the implementation you provided because I
want to test the scripted git commands, too, though I haven=E2=80=99t g=
otten
around to that.

Jonathan
