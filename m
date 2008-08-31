From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] change Perl syntax to support Perl 5.6
Date: Sun, 31 Aug 2008 22:55:15 +0200
Message-ID: <200808312255.16943.jnareb@gmail.com>
References: <20080830173947.GF7185@schiele.dyndns.org> <32541b130808311129u79f4179enfabab8f5845ed522@mail.gmail.com> <200808312223.38222.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	"Jeff King" <peff@peff.net>, "Robert Schiele" <rschiele@gmail.com>,
	git@vger.kernel.org, "Lea Wiemann" <lewiemann@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Petr Baudis <pasky@suse.cz>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 22:56:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZtyF-0005vf-1c
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 22:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757746AbYHaUzU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Aug 2008 16:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757743AbYHaUzU
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 16:55:20 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:53906 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757732AbYHaUzT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 16:55:19 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1109660fgg.17
        for <git@vger.kernel.org>; Sun, 31 Aug 2008 13:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=8YUDN2E6eLwtGdtIEzY4bo/pScaroPTEhGEsC2pxtfE=;
        b=Da00EEB3eI6TE0WWF1DzXdcBhIjSJUNbcYvZxBdF8jQPCKpYhZzgWpAxkMHNxFrN+V
         GE+u9UjsrMHru2mGO7VycYOpEkMBMlR7urIVL2SQhN+gDPrIqSkfBLNMqg5tbhkucZeu
         QxHmMEh/C4+Zt4sX8PKbACbcqs2giGKCcNs3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=SqShI1jzELmu15lLUTJx3sS/cA8+5N4wvsqxq47ME+B7V8OnagYo5nD1fhmIeAUppZ
         ZpH3K1z/2/KHcf8C2Mc8Q7iRWwFDahVW0Ccb/7wDDnZl+fWzX1a20ke8FJUQ5oftNoZU
         aoCZ+RoP51evbfdDSIwTqRsxXQyFg1w/Quwdg=
Received: by 10.86.82.6 with SMTP id f6mr3987940fgb.38.1220216117794;
        Sun, 31 Aug 2008 13:55:17 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.214.20])
        by mx.google.com with ESMTPS id l12sm5697732fgb.6.2008.08.31.13.55.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 Aug 2008 13:55:16 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200808312223.38222.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94509>

Jakub Narebski wrote:

> We have to go to quote.c to get to know why "!" is a special case too=
,
> in addition to "'". =A0The commit message for 77d604c3 (by H. Peter A=
nvin,
> which is CC-ed) states:
>=20
> =A0 =A0 Create function to sq_quote into a buffer
> =A0 =A0 Handle !'s for csh-based shells

Although according to POSIX=20

  Enclosing characters in single-quotes ( '' ) shall preserve the liter=
al
  value of each character within the single-quotes. A single-quote cann=
ot
  occur within single-quotes.

so "!" should be not treated as special character in POSIX shell,
csh unfortunately does not follow this.  Try

  $ echo '!!'

in csh, tcsh (now that's funny) and bash (or dash).

--=20
Jakub Narebski
Poland
