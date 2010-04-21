From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t1304,t2007: quell output to stdout and stderr
Date: Wed, 21 Apr 2010 10:12:36 -0500
Message-ID: <20100421151236.GB8726@progeny.tock>
References: <00e68c9727f8dd3426db6f78d6b583a0dcec4d13.1271858119.git.git@drmicha.warpmail.net>
 <20100421144535.GA8481@progeny.tock>
 <4BCF1160.6020304@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Apr 21 17:12:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4bbU-0004Up-EZ
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 17:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755508Ab0DUPMe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Apr 2010 11:12:34 -0400
Received: from mail-pz0-f186.google.com ([209.85.222.186]:45275 "EHLO
	mail-pz0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754843Ab0DUPMd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 11:12:33 -0400
Received: by pzk16 with SMTP id 16so3605292pzk.22
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 08:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=rrFqJJoudn2bZNMxzbL2dlmdEdKgRUYlly7yha6ih+g=;
        b=NF8Ac4U08HUNv8JPI9YMm28cKWnVxB/Y7EXZ+5nCiX9x5Dfj4dNLGBle/raeTTxCfg
         /x6Z265/5tzZaioZWRcxGBoG8kkeEHMjAcA7hFNVwCKQ7azEOzTKYjoZuRj/pnhwFoZH
         E4h/hN+rSo0RCqjPKoonl2idTb9l/XTFGdghQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=t5fKWyslBLvRj7+S/RFD26+rsc10q8utNBvdFmhRrWLvH49EsD8papGgdqaM4VWVeu
         JbjAxMZ8PzZqPoG0d6sheO9NcnbKCJ3LgGga4o3bx7zrCS2CiXcNRsOEsY/LTPlDkRic
         cRRnslv3ekqgD9ZyiP0xe8DjCllN8aF8l+k/I=
Received: by 10.142.209.6 with SMTP id h6mr485310wfg.265.1271862752976;
        Wed, 21 Apr 2010 08:12:32 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm6679192iwn.2.2010.04.21.08.12.31
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 21 Apr 2010 08:12:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BCF1160.6020304@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145438>

Michael J Gruber wrote:

> I don't think it's OK to exit or test_done
> from within test_expect_something, is it?

exit: the consequences are the same whether you=E2=80=99re in a test or=
 not.
Either way, it=E2=80=99s bad.  I think the intent of that =E2=80=98exit=
=E2=80=99 was to make a
good effort to set up for the next test and skip the test if that
didn=E2=80=99t work, which is a bit old-fashioned.  Emptying the index =
before
the checkout would make it like that the setup should not fail even if
some related bug resurfaces.

test_done: not sure what would happen.  Indeed, it doesn=E2=80=99t soun=
d like
a very sane thing to do. :)

Jonathan
