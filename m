From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/3] vcs-svn: Introduce svnload, a dumpfile producer
Date: Wed, 2 Feb 2011 08:23:24 +0530
Message-ID: <20110202025320.GB11339@kytes>
References: <1296570403-9082-1-git-send-email-artagnon@gmail.com>
 <1296570403-9082-2-git-send-email-artagnon@gmail.com>
 <AANLkTikUUojgj_H0r0L=XBi7H714xUvAS=vPsgMRNNjr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 02 03:52:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkSph-0002RG-7i
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 03:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757Ab1BBCwc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 21:52:32 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40375 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540Ab1BBCwb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 21:52:31 -0500
Received: by gyb11 with SMTP id 11so2777014gyb.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 18:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=eyvO5GaCsJjgTS17nUZSXY5uemyUhtjrNR66JvC0PCQ=;
        b=ON+VqmqH4CGxRfyHhDkPcIhDEG5Sss1DpTLT1SISdHYKKyasFC+tO/ffDJGO+Pb5cb
         yxNIqfmKkvVHiXxopqowOBjfF0o3Md7melk9QFFgJjX/fB2Y1TdfyoPZebbzG8jbqA3s
         Jak7yRd00d7Ov9UTfLMLobtOG2KnBxgHVwvNg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=FksyzoZQnbc3RP7jfK7qyY/x8NTSW5bQUUyDPIlraEga3JOSBpQdvnSY45KiOBDZZ0
         azWLu98GZxz81rEQ12wNhzy5pHNJaCZwEDvrl8ktCYgdVa2AVMCfKvZvWEwqw66w1FC/
         HVzNHVMtI5A35+/QYApH1ZHUDIsHhm0SZPfyI=
Received: by 10.150.215.1 with SMTP id n1mr10693944ybg.90.1296615150929;
        Tue, 01 Feb 2011 18:52:30 -0800 (PST)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id j3sm14741514ybe.23.2011.02.01.18.52.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Feb 2011 18:52:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikUUojgj_H0r0L=XBi7H714xUvAS=vPsgMRNNjr@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165889>

Hi Erik,

Erik Faye-Lund writes:
> A very superficial review, because I don't have much time, and don't
> know the surrounding code well. Sorry about that.

Thanks. I have to often switch back and fourth between GNU-style (for
Subversion) and Linux-style (for Git), so please bear with my silly
style errors.

> On Tue, Feb 1, 2011 at 3:26 PM, Ramkumar Ramachandra <artagnon@gmail.=
com> wrote:
> > + =A0 =A0 =A0 if (!val) die("Malformed author line");
> > + =A0 =A0 =A0 if (!(tz_off =3D strrchr(val, ' '))) goto error;
> > + =A0 =A0 =A0 *tz_off++ =3D '\0';
> > + =A0 =A0 =A0 if (!(t =3D strrchr(val, ' '))) goto error;
>=20
> style: use
> "if (x)
> 	do_stuff();"
> instead of
> "if (x) do_stuff();"

This was intentional -- I'm only using it when do_stuff() is 'goto
error'. I thought it looked nicer that way.

-- Ram
