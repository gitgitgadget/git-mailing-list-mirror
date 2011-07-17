From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 17/17] revert: Introduce --continue to continue the
 operation
Date: Sun, 17 Jul 2011 13:32:19 -0500
Message-ID: <20110717183219.GB27787@elie>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-18-git-send-email-artagnon@gmail.com>
 <20110712204650.GG14909@elie>
 <CALkWK0==A1a-kzqXuEkjS+FMR1CAzJox8MBdkQGMLukoU15L9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 17 20:32:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiW8l-00033T-I3
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jul 2011 20:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754604Ab1GQSc0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Jul 2011 14:32:26 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40368 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218Ab1GQSc0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jul 2011 14:32:26 -0400
Received: by iyb12 with SMTP id 12so2522276iyb.19
        for <git@vger.kernel.org>; Sun, 17 Jul 2011 11:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BB1ANEHVbYgUSyoZIcnGKG93WFqq8Brr4WAYhB+CgFQ=;
        b=BOs7ysWAvUrBJb3YVnFEtPey19kOImwsyzIFrSCzbUgUThtIrDUU2LBZbsYFdfCPxw
         mlNxMX2gU/m5HVO0aYdmnKMgV1dx8pgEQ7wtOPabXBbJv9XWvs+F8cMy2QsthwGloXFD
         Gnih6IePX/iIq8VaHt8gjs8jyvNVXK7X7Sr9Y=
Received: by 10.42.29.131 with SMTP id r3mr6147755icc.377.1310927545510;
        Sun, 17 Jul 2011 11:32:25 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.ameritech.net [69.209.70.6])
        by mx.google.com with ESMTPS id q4sm2364988ibb.15.2011.07.17.11.32.23
        (version=SSLv3 cipher=OTHER);
        Sun, 17 Jul 2011 11:32:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0==A1a-kzqXuEkjS+FMR1CAzJox8MBdkQGMLukoU15L9w@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177309>

Ramkumar Ramachandra wrote:
> Jonathan Nieder writes:

>> The -s thing doesn't have much to do with this change. =C2=A0But is =
it a
>> bug or not? =C2=A0If it's not a bug, then this is not so much a glit=
ch to
>> note as an important feature to ensure people don't sign off on a
>> conflict resolution without thinking about it. =C2=A0(I guess I thin=
k it's
>> a bug. =C2=A0It's hard to decide.)
>
> Bug, definitely.  It happens because unlike "-x" where the
> cherry-picking machinery appends to the commit message, "-s" is
> handled at commit-time (when it spawns `git commit`).  Ofcourse, if I
> were never to write the sequencing features, this would never been
> seen as a bug -- hence the term "glitch"; an implementation detail
> that doesn't suit our future plans (namely, this series) very well.

Hmm, I thought I remembered this coming up previously and Junio
mentioning that it was intentional (maybe in the context of
CHERRY_HEAD?), but I haven't been able to find the relevant message.
