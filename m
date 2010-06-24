From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH/RFC v2 0/9] Subversion dump parsing library
Date: Thu, 24 Jun 2010 15:06:50 +0200
Message-ID: <AANLkTilGNaF05EW2IFUpjOx-lP8sDoCkSrsa1-vMZo6B@mail.gmail.com>
References: <20100624105004.GA12336@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 15:10:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORmCL-0000wM-S4
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 15:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755301Ab0FXNHP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 09:07:15 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49227 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810Ab0FXNHN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jun 2010 09:07:13 -0400
Received: by gwaa18 with SMTP id a18so694099gwa.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 06:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=jiAArWmujTnkChG6ZVJ5ZR641Zvd5P+38E7c1slusKU=;
        b=IJ+oCkHu0qf6tCQr+lnA6qbocfE5EdXLdoN19yRwMswxBu0XYeo3T8Jt9M4Jt5C6Hc
         KwD2fma+cjN6Dgc13VylM/OklK50iBucShJweWIGxTPbkv82naUYx64IIJqCXaq3errv
         /EB6tQdun08ENYTZK7yZCYK1i9S626k39/MEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=aV0+mfQ25WGFHaI4r/x1bnOZEv5YiZBUcorp1ca9s4PSqHR9+uVzormK/kGhQJoIkL
         9uEkn6m9lgzcmEZ8olqvKiZKHxUtxRhuMokkWCVqR0/RWP6acqnIZX1xG0eauvb22c30
         AV2JPbAO1iqnYHq4KGXOD5s5Fyzc5UcrA2YrE=
Received: by 10.229.182.5 with SMTP id ca5mr5161814qcb.98.1277384831876; Thu, 
	24 Jun 2010 06:07:11 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Thu, 24 Jun 2010 06:06:50 -0700 (PDT)
In-Reply-To: <20100624105004.GA12336@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149591>

(+CC: Junio)

Hi Jonathan,

Jonathan Nieder wrote:
> Ram last sent this series a couple of weeks ago[1], and it was
> merged to pu then as rr/svn-export. =C2=A0Here=E2=80=99s another iter=
ation
> of the same for discussion, now including David Barr=E2=80=99s progra=
m
> that demonstrates the functionality.

There's a lot of work happening in the exporter and the series will
probably need to be re-rolled again: I recommend the following.
1. Review this series thoroughly, but don't actually merge it because
it's going to be re-rolled soon.
2. Split the series in two: The infrastructure part in vcs-svn/ will
be re-rolled later. Another part for contrib/ should be made into a
separate series and merged.
3. As soon as the client is complete, I'll roll a series that puts it
in vcs-svn/ (infrastructure again).
4. Finally, I'll roll out a series for the remote helper itself that
puts it in $GIT_ROOT.

To summarize, there should be four series:
1. David's exporter in vcs-svn/ (yet to be re-rolled): Either Jonathan
or I will handle this.
2. David's independent svn-fe program in contrib/: Jonathan will handle=
 this.
3. The RA client to generate a full-text dumpfile on-the-fly: This
isn't done yet; as soon as it's finished, I'll roll a series.
4. The remote helper: This done, but it doesn't make sense to send
this in before everything else has been merged.

-- Ram
