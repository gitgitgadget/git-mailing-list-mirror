From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Useless error message?
Date: Thu, 22 Apr 2010 05:38:30 -0500
Message-ID: <20100422103830.GB701@progeny.tock>
References: <z2o3abd05a91004211417v263d5a0eg497341ddf7bd79a5@mail.gmail.com>
 <20100421221953.GA25348@progeny.tock>
 <7vwrw0573t.fsf@alter.siamese.dyndns.org>
 <20100422094153.GA504@progeny.tock>
 <4BD01E09.8080504@op5.se>
 <20100422101535.GB625@progeny.tock>
 <4BD0247A.4080103@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Aghiles <aghilesk@gmail.com>,
	git list <git@vger.kernel.org>, Kim Ebert <kd7ike@gmail.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Apr 22 12:38:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4tno-00022g-DC
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 12:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753991Ab0DVKiT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 06:38:19 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:50514 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753813Ab0DVKiS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 06:38:18 -0400
Received: by qyk9 with SMTP id 9so10983080qyk.1
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 03:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=KXp1VANtXutmj/VA1W2uCEzyR/KheRI7KOIXmzASvSU=;
        b=Mmi5vlLLbs/HhC8n4LOtSz4mVG+iyR0th9TtZFmfFIo0POcNYU1JmyZcSIoJHvxNru
         daWbVg+/UmoLNQu99CJjGKhqzxEIDSyQ49XSMpuSmenAq8v1sdWBTCGBinCJZWp+TgMv
         tL5RivxINdKamUY07HdAvMeifyTQWRZfQ5FhY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=N8nNqv5F5BEYJ9/lEuBwPOLzjgvR2pIO/u3wLCwTDe6aaAAV/iMN5dd4RDDVMmCzqA
         XmbFcze4zg+FntoyUjIp3mrnsf4Opz4shjzjF9Gfrr06cKhhD+ACo+uqZg6sjNsFPAg4
         h22caY+LCRD6XHR36q75yJb+6ggNY2koa7hCM=
Received: by 10.224.78.104 with SMTP id j40mr3186387qak.251.1271932697125;
        Thu, 22 Apr 2010 03:38:17 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm7260344iwn.3.2010.04.22.03.38.15
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 22 Apr 2010 03:38:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BD0247A.4080103@op5.se>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145518>

Andreas Ericsson wrote:
> On 04/22/2010 12:15 PM, Jonathan Nieder wrote:

>> (*) $ git clone git://git.example.com/~u/foo
>>      remote: Cannot read the specified repo
[...]
> So that would be the new error message for everything that fails, the=
n?

No.  Of course, the opposite is the point.  I just mean there should
be an error message for all conditions that are lumped together with
ENOENT to avoid information disclosure.  I don=E2=80=99t care much how =
the
message is phrased.

> If you have the wrong
> repo address, you'd still have to check up with whoever gave it to
> you to get it right. If it *does* crash, you'd still have to get
> hold of the server admin to tell him that it has crashed.

Many things can go wrong other than a missing repo.  For example,
there might be objects missing, or high load, or memory corruption.

In the =E2=80=9Cwrong address=E2=80=9D case, I know who to go to to fix=
 it: ask the
person who gave me the address.

In the =E2=80=9Ccorrupt repository=E2=80=9D case, I should go to the re=
pository
owner.

In the =E2=80=9Cserver hung up without any good reason=E2=80=9D case, I=
 should try to
narrow down the problem, perhaps with the help of the server admin or
my network administrator.  Is it really so unusual to want to
distinguish this from other cases?

Without code this is all theoretical anyway.  And that=E2=80=99s the re=
al
problem: to the uninitiated, it is not easy to write code to try this
out because the side band is not set up in time.

Sigh,
Jonathan
