From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 0/4] Teach 'git grep' about
 --open-files-in-pager=[<pager>]
Date: Sat, 12 Jun 2010 17:12:55 -0500
Message-ID: <20100612221255.GA2718@burratino>
References: <20100605005116.GA8774@progeny.tock>
 <alpine.DEB.1.00.1006051810300.1732@bonsai2>
 <20100612075542.GB2918@burratino>
 <alpine.DEB.1.00.1006121139290.2689@bonsai2>
 <20100612162945.GB1406@burratino>
 <alpine.DEB.1.00.1006122335190.2689@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 13 00:13:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONYwz-0006u4-Ka
	for gcvg-git-2@lo.gmane.org; Sun, 13 Jun 2010 00:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647Ab0FLWNH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jun 2010 18:13:07 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33576 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633Ab0FLWNG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 18:13:06 -0400
Received: by iwn9 with SMTP id 9so1801772iwn.19
        for <git@vger.kernel.org>; Sat, 12 Jun 2010 15:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ENrrkMYiqQt9oaQ8Bb/Q2AEJkpTTeQTxW4eu3TMBOB0=;
        b=f94fKP7HIq1kSOAWfzsVgmlUJFKJAXKpvjon0arwZ44alPXpjWhBa40UipdUxOY8qh
         0gGTeB02gFwGboSD9hy1m5DsoPa/opmwSeIYENQ1DsC3OnQhziwjaFPwrISIixj0I5BZ
         KYMzw9imt+a1uLcGgjFv2fvtNhFht4SVUHzB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=V/mxlJPjDmh5UMdbSYZe1zoZmfyMw8Djtv/FJMeYgYZ3ARQkpqrdAXtAlidAcMFdtl
         pianbS1XIIVXvkFqpN3pgve19Tiuplcg/jyon8r+5Gdt/cPutGjugzhX+3hyOZdQlA6K
         lts3eenLGAR3Dav6wcq/m75zveAQsWYNT0CfA=
Received: by 10.231.193.209 with SMTP id dv17mr3986058ibb.134.1276380783835;
        Sat, 12 Jun 2010 15:13:03 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id f1sm12289043ibg.21.2010.06.12.15.13.02
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 12 Jun 2010 15:13:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1006122335190.2689@bonsai2>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149031>

Johannes Schindelin wrote:

> But in my tests, it just does not work=20
> on multi-core machines without the patch.

Did you try the v2 series I sent earlier?  I tested it on a machine
with two multi-core CPUs.

Now that I=E2=80=99ve read your patch, though, I don=E2=80=99t want to =
go back.  The
code duplication in the v2 series was ugly and did not leave the door
open to easily adding threading support later, because it ran the
pager _before_ waiting for pending threads.  And besides, the "Unify
code paths" patch contains an important fix for grep without -O.

Thanks for both patches.
Jonathan
