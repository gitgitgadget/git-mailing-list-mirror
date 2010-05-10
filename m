From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Fix a false negative in t5512 when run using sh -x
Date: Mon, 10 May 2010 06:31:13 -0500
Message-ID: <20100510113113.GA5162@progeny.tock>
References: <1273475946-2079-1-git-send-email-j6t@kdbg.org>
 <AANLkTilaZlku8eQpAjMPCPkzeVyg2u21KOcsZkxn4Kxd@mail.gmail.com>
 <20100510103427.GA4806@progeny.tock>
 <4BE7E7FD.7080607@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Tay Ray Chuan <rctay89@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon May 10 13:31:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBRCk-0006Gz-2u
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 13:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756001Ab0EJLbQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 May 2010 07:31:16 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:63851 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755759Ab0EJLbP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 07:31:15 -0400
Received: by qyk13 with SMTP id 13so5952581qyk.1
        for <git@vger.kernel.org>; Mon, 10 May 2010 04:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=MF+jN2g0OtVLtPPgkuJH8q6CzLwZmeW3zZzIKPFnBg4=;
        b=XME0Y/M6PqcSlV2Oec/a0lgqfWZdv7hDx3dC07oNUSr3lskYNME/5AcWYNxUis0cE1
         e2uA1QhkRgm610BnRKw+SGZCO+SVnNOrHTJbZDF9LOXGTCpGmJlS5kmMEdV/0AKxvXP3
         DhH58jFyjL2ovJQHAxcGU4n+HjBNXag3M1Adw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=EffQkg3M0mqLJiCGc3/XCWcoUjEM2D+vBi+3F07DOFnacCuQ9APsx/U1emq34dBj1G
         7GzPUZUPXFL91mdMdpfZcQl+ie5X/0aunJkrJIT6TSMFP1kuJXGBj1brL0DoVb+2kkGv
         ChGW6Osrx25IhHq2vEd4lgMly9XAQjW1e1+nY=
Received: by 10.224.71.130 with SMTP id h2mr2517403qaj.90.1273491074728;
        Mon, 10 May 2010 04:31:14 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm3536423yxe.5.2010.05.10.04.31.13
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 04:31:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BE7E7FD.7080607@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146798>

Johannes Sixt wrote:

> I can just amend my patch, no problem, and we solve the issue as you
> propose (or perhaps not - it *is* ugly as hell).

=46or your application, I=E2=80=99d suggest using BASH_XTRACEFD.  Or no=
t, since
it is good to reveal problems people will run into when they try
sh -x some-particular-test.sh

Since the problem cases seem to be rare, I guess the =E2=80=98grep=E2=80=
=99 trick is
good enough.  It is nice anyway to be able to switch between fatal:
and error: without breaking tests.

t9108 seems to have the same problem.  Maybe you skip svn tests?

Jonathan
