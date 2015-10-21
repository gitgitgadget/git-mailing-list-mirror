From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] fix flaky untracked-cache test
Date: Wed, 21 Oct 2015 12:32:33 -0400
Organization: Twitter
Message-ID: <1445445153.8302.5.camel@twopensource.com>
References: <1445284095-6602-1-git-send-email-dturner@twopensource.com>
	 <562725AC.9090500@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com, larsxschneider@gmail.com
To: Torsten =?ISO-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 21 18:32:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZowJe-0007Od-EX
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 18:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532AbbJUQch convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Oct 2015 12:32:37 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34211 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894AbbJUQcg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 12:32:36 -0400
Received: by padhk11 with SMTP id hk11so59255231pad.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2015 09:32:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=8F1zpaT+ln3FeWjHnUNXxAPPlL47vNIttrLBw5mZS/E=;
        b=RcaKSJGaBAj8tkS7MwqujQSKW/qinQWsUX3YhEHdNNm1oV/EGFU4+QxA+DQ8fb63au
         A1eIl6qq7XstGkY3eBZ9rKT4rofcCFmDLoN556ObN4z4Zh5pSK4DMELJVr8mevtPSl6s
         xxwQBEhHls8A68HnkOROYxe1HZamZum+dKtV2APCRVNRNxLkmXpoIb9cgZpf09CoJRzV
         C2TX1Uy+d0D8zMMjbY26USIz0pT1fB0aS6W1DfHbpEiRaX1ZwRptU+M45GhMW6USO43G
         UQ4R0Wjct64aB2/RtFnzsbpBo7fpN9jRT+qGu15Pvco5/ye4TwEMnljdP+AamPlZ+lTN
         Brgg==
X-Gm-Message-State: ALoCoQmUMvfhVJJhKZT2KvUAL1pF2lNXuY1+lUoTJrd6oL8zWwXr9S+DFmFHJGxSXQJyU6B2yEel
X-Received: by 10.69.26.101 with SMTP id ix5mr11570376pbd.144.1445445156358;
        Wed, 21 Oct 2015 09:32:36 -0700 (PDT)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id ns1sm9981255pbc.67.2015.10.21.09.32.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2015 09:32:35 -0700 (PDT)
In-Reply-To: <562725AC.9090500@web.de>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279988>

On Wed, 2015-10-21 at 07:42 +0200, Torsten B=C3=B6gershausen wrote:
> On 19.10.15 21:48, David Turner wrote:
>=20
> > +	echo test >base && #we need to ensure that the root dir is touche=
d
> > +	rm base
> >  '
> Thanks for working on this, (I can run the test as soon as I have acc=
ess to a Mac with SSD)

I don't think this depends on a Mac (I can repro on my Thinkpad running
Ubuntu).

> Minor remark, the echo test can be removed (and may be the comment ?)

All the other lines in this test have echo, so I would rather be
consistent.

> > +	>base &&
> > +	rm base
> >  '
