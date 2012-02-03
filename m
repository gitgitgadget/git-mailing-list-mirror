From: Jeff King <peff@peff.net>
Subject: Re: General support for ! in git-config values
Date: Fri, 3 Feb 2012 07:09:36 -0500
Message-ID: <20120203120936.GC31441@sigill.intra.peff.net>
References: <CANgJU+X+UZmycwE6xkJ-zHfT7ai6nV9zbeR4WYnAXczL5JtqjA@mail.gmail.com>
 <7vliom13lm.fsf@alter.siamese.dyndns.org>
 <CANgJU+XQWdFmfmBJ4KX4GBz1a=TrVbp9BphGmhEb5Gphmzogjw@mail.gmail.com>
 <7v7h06109t.fsf@alter.siamese.dyndns.org>
 <CANgJU+WCdsF+igCWoueYcChYBvNyj5je_kvWorCBOgh5D7Bb9g@mail.gmail.com>
 <20120202023857.GA11745@sigill.intra.peff.net>
 <CANgJU+X2dRP__PFAywGEisDS3xyF7fSszSQG6BO61j2TMKL3Qg@mail.gmail.com>
 <20120202095432.GA19356@sigill.intra.peff.net>
 <CANgJU+XoZd6x6jdSHszigZaPgi+6H3Nbf4OG7p0y1_=7m+qntA@mail.gmail.com>
 <CAGZ=bq++R+X+2r2_zQ4UZ6JvDC9W9_4nF23MQ6+612_Qe2RS4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: demerphq <demerphq@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Kyle Moffett <kyle@moffetthome.net>
X-From: git-owner@vger.kernel.org Fri Feb 03 13:09:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtHxb-0000TZ-LA
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 13:09:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754877Ab2BCMJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 07:09:40 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55520
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753327Ab2BCMJi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 07:09:38 -0500
Received: (qmail 30978 invoked by uid 107); 3 Feb 2012 12:16:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Feb 2012 07:16:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Feb 2012 07:09:36 -0500
Content-Disposition: inline
In-Reply-To: <CAGZ=bq++R+X+2r2_zQ4UZ6JvDC9W9_4nF23MQ6+612_Qe2RS4Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189751>

On Thu, Feb 02, 2012 at 09:08:46PM -0800, Kyle Moffett wrote:

> > I understand. I think we will probably use backtick quoting in git-deploy. So
> >
> > deploy.prefix=`cat /etc/SERVER_ROLE`
> >
> > will execute cat /etc/SERVER_ROLE and use the results as the value of
> > the config option.
> 
> Alternatively, you could extend the recent proposal for GIT config
> "include" statements so that something like this works:
> 
> [include]
>     exec = echo "deploy.prefix = `cat /etc/SERVER_ROLE`"
>     exec = /usr/local/bin/git-config-for-ldap-user
> 
> Thoughts?

I am still undecided on whether the utility of the idea is worth the
potential hassle, but syntactically I like that better. It does put a
little more burden on the called program to handle things like quoting,
though.

-Peff
