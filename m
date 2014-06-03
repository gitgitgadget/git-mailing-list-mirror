From: Mara Kim <mara.kim@vanderbilt.edu>
Subject: Paper cut bug: Why isn't "git clone xxxx" recursive by default?
Date: Tue, 3 Jun 2014 13:11:03 -0500
Message-ID: <CAJdEhSa20ODuN4LkdvaWi0cSztgbJ+p50AYbtZs2oYWLitnjbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 03 20:26:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrtPu-0005Vc-J8
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 20:26:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754692AbaFCS0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 14:26:30 -0400
Received: from co9ehsobe004.messaging.microsoft.com ([207.46.163.27]:23266
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754244AbaFCS0O (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jun 2014 14:26:14 -0400
Received: from mail50-co9-R.bigfish.com (10.236.132.253) by
 CO9EHSOBE018.bigfish.com (10.236.130.81) with Microsoft SMTP Server id
 14.1.225.22; Tue, 3 Jun 2014 18:11:07 +0000
Received: from mail50-co9 (localhost [127.0.0.1])	by mail50-co9-R.bigfish.com
 (Postfix) with ESMTP id 43D80B405F8	for <git@vger.kernel.org>; Tue,  3 Jun
 2014 18:11:07 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:129.59.94.73;KIP:(null);UIP:(null);IPV:NLI;H:hub.vanderbilt.edu;RD:error;EFVD:FOP
X-SpamScore: 8
X-BigFish: VPS8(zz1447Izz1f42h2148h1d77h1ee6h1de0h1fdah2073h2146h1202h1e76h2189h1d1ah1d2ah21bch2297h1fc6h208chzzz2dh2a8h839h93fhf0ah107ah1288h12a5h12a9h12bdh137ah13b6h1441h1504h1537h153bh15a8h162dh1631h1741h1758h17eeh1946h19b5h19ceh1ad9h1b0ah1b2fh2222h224fh1fb3h1d0ch1d2eh1d3fh1dc1h1dfeh1dffh1e1dh1fe8h1ff5h2216h22d0h2336h2438h2461h24d7h2516h2545h255eh25f6h2605h268bh26d3h27e2h282bh1a81i1b1cn15a9i1b1bi181ch)
Received: from mail50-co9 (localhost.localdomain [127.0.0.1]) by mail50-co9
 (MessageSwitch) id 1401819065354940_12141; Tue,  3 Jun 2014 18:11:05 +0000
 (UTC)
Received: from CO9EHSMHS009.bigfish.com (unknown [10.236.132.226])	by
 mail50-co9.bigfish.com (Postfix) with ESMTP id 52DDD2C00B2	for
 <git@vger.kernel.org>; Tue,  3 Jun 2014 18:11:05 +0000 (UTC)
Received: from hub.vanderbilt.edu (129.59.94.73) by CO9EHSMHS009.bigfish.com
 (10.236.130.19) with Microsoft SMTP Server (TLS) id 14.16.227.3; Tue, 3 Jun
 2014 18:11:05 +0000
Received: from mail-vc0-f172.google.com (209.85.220.172) by
 smtpauth.vanderbilt.edu (10.1.154.73) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Tue, 3 Jun 2014 13:11:04 -0500
Received: by mail-vc0-f172.google.com with SMTP id lf12so7098389vcb.17
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 11:11:03 -0700 (PDT)
X-Received: by 10.52.5.129 with SMTP id s1mr23675810vds.31.1401819063474; Tue,
 03 Jun 2014 11:11:03 -0700 (PDT)
Received: by 10.221.41.10 with HTTP; Tue, 3 Jun 2014 11:11:03 -0700 (PDT)
X-Originating-IP: [209.85.220.172]
X-OriginatorOrg: vanderbilt.edu
X-FOPE-CONNECTOR: Id%0$Dn%*$RO%0$TLS%0$FQDN%$TlsDn%
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250637>

Hello git devs!

I'd like to start off by saying that git is an amazing piece of
software and every one of you deserve major kudos for your work on the
project.  However, I'd like to point out a few "paper cut" bugs (to
use the Ubuntu parlance).

Apologies if this question has been asked already, but what is the
reasoning behind making git clone not recursive (--recursive) by
default?  I have just recently started splitting my projects into
submodules, and I feel like this is a major usability issue,
especially for newbies.  Wouldn't it be better to have a
"--non-recursive" option and clone recursively by default?  Similarly,
I feel that "git pull" should automatically "git submodule update
--recursive --init" as well, with the current behavior able to be
specified with a "--non-recursive" option.

I feel like these sorts of choices make submodules seem very much like
second class citizens in git and make git much less user friendly.  I
feel that the most common use case that people want is to keep
submodules properly in sync.  In addition, I feel that power users
that really want to make shallow clones, non-recursive clones, etc.
could still be served with a simple option.  I guess there are
problems with changes in submodules being overwritten, so I suppose
there would need to be additional warnings or even just refusal to
pull into dirty directories, similar to the way git behaves in a
regular repository.

Thanks for the excellent work,
Mara Kim

Ph.D. Candidate
Computational Biology
Vanderbilt University
Nashville, TN
