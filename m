From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/2] fix weird git --paginate behavior
Date: Mon, 5 Apr 2010 23:01:46 -0500
Message-ID: <20100406040145.GA30403@progeny.tock>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
 <1270492888-26589-44-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 06:01:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nyzyd-00084k-OG
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 06:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717Ab0DFEBR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 00:01:17 -0400
Received: from mail-yx0-f200.google.com ([209.85.210.200]:62035 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695Ab0DFEBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 00:01:16 -0400
Received: by yxe38 with SMTP id 38so1052369yxe.22
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 21:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=VB6+JfwffuR0mkGMSfYjfKc6BSnGYXrJjog/O1ZiCwA=;
        b=OCPrZ8BIjcPdjmCQxf38H76Q+IcXAus1fcew4pOsxKG+xNGO0qLtOKCV9nAdsQEn8p
         b4ElPvUYZlBJ0UIf6Movg1suz5iTJHERU67XJQSywlCzm9/D6sQBo4oF3ibKD4B8l+s8
         iV9CJ4XACetQ7zYm6dmIrWPo12eWQK0p6An9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ejzwa68lyZuy4WwTyNveAWTlbz+ayscbLOoj9L8FNPTigbLcBqLx8Q4nAuDRl1bQpk
         NFh1v0hcEEIqBtOZRc25D0QkzQ7WY+wkvJTqc9/6u4hDv4O6hDDvOzYDX2FPzqQBYI0j
         fnFzXiq8SZKblSqB/Rk1YxpT/oXwlwnzVcb/g=
Received: by 10.150.170.11 with SMTP id s11mr7714801ybe.241.1270526475658;
        Mon, 05 Apr 2010 21:01:15 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm5097661iwn.5.2010.04.05.21.01.14
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 21:01:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1270492888-26589-44-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144090>

Hi,

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks for posting this series.  I had not read it in full before.

The series is very long and it is hard to make certain it does not
introduce regressions.  Here is my idea for working around this: the
idea is to grab patches from the series to form short, independently
justifiable mini-series.  Once most of the functional changes are
merged, it should be a lot easier to evaluate the core code change
that makes setup more brittle (which I like a lot).

What do you think?  Is it worth the trouble?

Here=E2=80=99s an example mini-series.  Patch 1 adds a test case for
some weird git -p behavior.  Patch 2 fixes it.

Jonathan Nieder (1):
  t7006: test an edge case for git --paginate

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
  builtins: do not commit pager choice early

 git.c            |    1 -
 t/t7006-pager.sh |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletions(-)
