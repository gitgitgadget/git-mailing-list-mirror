From: Jakub Narebski <jnareb@gmail.com>
Subject: Request for detailed documentation of git pack protocol
Date: Tue, 12 May 2009 23:29:14 +0200
Message-ID: <200905122329.15379.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 12 23:31:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3zXT-00083t-Oj
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 23:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754801AbZELV3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 17:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754781AbZELV3S
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 17:29:18 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:34538 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754219AbZELV3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 17:29:16 -0400
Received: by fxm2 with SMTP id 2so250714fxm.37
        for <git@vger.kernel.org>; Tue, 12 May 2009 14:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        bh=XMgHmxUp3sQ9Xta6EiAxZnllTxqx8hKF39h78xJhMrA=;
        b=UBapdg/xmAJ9K/akRGzgnAD+ZykrY/JXnWO6Ifn4rdZdWAvXkccxzP4L1FpbA29pL4
         XIg+cazeSN/40au9z1AxHDeAbFr0pTRhp2qoWy4p/XWZBkKxd52E+boNASexrb+oEZs+
         rzhgli8YaOi+5JUO79Gmbrq4GShYf9oPEmT9U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-disposition
         :content-type:content-transfer-encoding:message-id;
        b=N40jvmSjkkpYkAvwKcpW/MSzGU2jPdg48W4AEatpUQzm4WN6nmiS+QFx0DrJoTfiB1
         bT7kWxF7AqTM1Z6R+j1kIcxwTV+EXjqbLFUTGgMqK61iZiYHpFiEXfp4P9TIDC+WAQnK
         /IbAhVbcE/1SKKKu1ijHC6YEBEiLp1wGG5gZk=
Received: by 10.86.25.10 with SMTP id 10mr338236fgy.79.1242163755909;
        Tue, 12 May 2009 14:29:15 -0700 (PDT)
Received: from ?192.168.1.13? (abvp65.neoplus.adsl.tpnet.pl [83.8.213.65])
        by mx.google.com with ESMTPS id 3sm118583fge.24.2009.05.12.14.29.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 May 2009 14:29:15 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118956>

We have now proliferation of different (re)implementations of git:
JGit in Java, Dulwich in Python, Grit in Ruby; and there are other
planned: git# / managed git in C# (GSoC Mono project), ObjectiveGit
in Objective-C (for iPhone IIRC).  At some time they would reach
the point (or reached it already) of implementing git-daemon...
but currently the documentation of git protocol is lacking.

This can lead, as you can read from recent post on git mailing, to
implementing details wrong (like Dulwich not using full SHA-1 where
it should, leading to ordinary git clients to failing to fetch from it),
or fail at best practices of implementation (like JGit last issue with
deadlocking for multi_ack extension).

The current documentation of git protocol is very sparse; the docs
in Documentation/technical/pack-protocol.txt offer only a sketch of
exchange.  You can find more, including pkt-line format, a way sideband
is multiplexed, and how capabilities are negotiated between server and
client in design document for "smart" HTTP server, for example in
  Subject: Re: More on git over HTTP POST
  Message-ID: <20080803025602.GB27465@spearce.org>
  URL: http://thread.gmane.org/gmane.comp.version-control.git/91104/focus=91196

It would be really nice, I think, to have RFC for git pack protocol.
And it would help avoid incompatibilities between different clients
and servers.  If the document would contain expected behaviour of
client and server and Best Current Practices it would help avoid
pitfals when implementing git-daemon in other implementation.

Perhaps in the future it could be sent for inclusion as "official"
RFC to IETF?  (Dreaming big).


Unfortunately I don't know enough about this area of code to write
one myself.

-- 
Jakub Narebski
ShadeHawk or jnareb on #git
Poland
