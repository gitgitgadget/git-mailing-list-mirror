From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [Improvement?] How do you switch branches in a bare repo?
Date: Fri, 12 Mar 2010 10:48:36 -0600
Message-ID: <20100312164835.GA2303@progeny.tock>
References: <4B99DEA2.6050104@uq.edu.au>
 <b4087cc51003120009o7bd99609w996de02b732fbbd9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 12 17:48:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nq82d-0007y9-2L
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 17:48:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758031Ab0CLQsq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Mar 2010 11:48:46 -0500
Received: from mail-qy0-f179.google.com ([209.85.221.179]:60078 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757969Ab0CLQsp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 11:48:45 -0500
Received: by qyk9 with SMTP id 9so1378975qyk.5
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 08:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=93zaU3TgKwddSI4MWhSF0pcDZ7ac8Gu20Ov6Dkm647I=;
        b=cjFkH5SPBvMP9ZGUfEoE8q/ja/IYFh5j0W3Nic532rag/pD/IboRGcyKLjQCRAs+DJ
         rsNmQLtLGaH7KHwqM2CKh2E7JlrDq3J3Rv96qXCz3Sx0tzCzi0tgy1q6BR3q50HFlBGY
         meh7/1XFHMiS5LyjtLG9kRfkp4oiqC+Vutk7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=PfjJVXOZdqsfE21Nai1PoDkLKNNWUyXt5jIH0oGSczcunVwXuQYUaoCBT+2f++xECH
         n7dCTTmEuHqnxmQEHUVh9n+CmUgKYZSJEBWNliBWKUXDdi16n/Y3RQ0OOdREPgsiDsOB
         PMrr1xIPtnjN3NQqTHBrHPs4mdslKbguGib7k=
Received: by 10.220.107.104 with SMTP id a40mr1314902vcp.67.1268412523532;
        Fri, 12 Mar 2010 08:48:43 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 6sm475605ywd.56.2010.03.12.08.48.39
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 12 Mar 2010 08:48:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <b4087cc51003120009o7bd99609w996de02b732fbbd9@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142042>

Michael Witten wrote:

> Commands like "git checkout" and "git reset" essentially operate on 2
> aspects of a repository:
>=20
>     (1) The repository's state.
>     (2) The repository's working tree.
>=20
> Is there any reason why these commands can't just operate on (1) in a
> bare repository, thereby allowing users to use familiar commands to
> get their work done?

Not that I can think of.  I=E2=80=99d say go for it.  (I=E2=80=99ll be =
glad to help in
any way I can.  Not sure I=E2=80=99ll have much time soon, but I can an=
swer
questions, look over patches, and so on.)

> The "git checkout" command in a bare repository should serve to selec=
t
> on which branch other commands (like "git reset") operate, etc.

My only worry would be low-level scripts that want to be able to use a
separate index or work tree with a bare repository.  Maybe the index
file could be in a special "bare" state to request the semantics
you=E2=80=99re describing.

Jonathan
