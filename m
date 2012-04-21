From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Documentation: explain push.default option a bit more
Date: Fri, 20 Apr 2012 21:08:00 -0700
Message-ID: <xmqqpqb1zpzz.fsf@junio.mtv.corp.google.com>
References: <vpqfwbye9re.fsf@bauges.imag.fr>
	<1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
	<1334933944-13446-2-git-send-email-Matthieu.Moy@imag.fr>
	<20120420201357.GA13103@sigill.intra.peff.net>
	<xmqq62cum6tf.fsf@junio.mtv.corp.google.com>
	<4F922ECC.4040103@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Apr 21 06:08:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLRcl-0004Zo-AN
	for gcvg-git-2@plane.gmane.org; Sat, 21 Apr 2012 06:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849Ab2DUEID (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Apr 2012 00:08:03 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:60969 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722Ab2DUEIB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2012 00:08:01 -0400
Received: by qabg24 with SMTP id g24so134762qab.1
        for <git@vger.kernel.org>; Fri, 20 Apr 2012 21:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=+HIDSi7KvFfEcnpFKdzUb3sZRJ+8pDvTzikEyE19gcA=;
        b=MLB0TYozuaCuRZz5JCEU21iDYufQjRj3EdSHyi1c0TPrTLudKpI/+g+iDuvuyJz/sT
         E4VyrDS8jmOomXPiCjeodZOutr2lEAye5PRbQr0UnV7VqdZ5Gzq7/0pm4qbDAzB1Y1wN
         Whx3mr0/A9bgteCKJKg8MWTk+o5y58t+6vDP/wdjsmh962YpyB4/S6JBxnk2XB8KEWfi
         xP+sR+rMBJSfbi4uvBFRlWEiOTiRoJMsBj0pprpqyx12Y2YLzbBO6wMx6aI6WGEkOwk+
         nGITeJoMBf78BlXIoC9KnTaekt5USEZpsdBV6ypzLWs1vJLo7cPz7gYOVCXmIVqoaoSX
         h1JQ==
Received: by 10.100.77.1 with SMTP id z1mr3158054ana.5.1334981281089;
        Fri, 20 Apr 2012 21:08:01 -0700 (PDT)
Received: by 10.100.77.1 with SMTP id z1mr3158041ana.5.1334981280982;
        Fri, 20 Apr 2012 21:08:00 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id j51si7379043yhi.1.2012.04.20.21.08.00
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 20 Apr 2012 21:08:00 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id DB0B910004D;
	Fri, 20 Apr 2012 21:08:00 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 852BFE120A; Fri, 20 Apr 2012 21:08:00 -0700 (PDT)
In-Reply-To: <4F922ECC.4040103@alum.mit.edu> (Michael Haggerty's message of
	"Sat, 21 Apr 2012 05:51:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQkfKju+6ROIT3zXnWLr+m7ogpytoShjANNVxIBkDhnu6qHIhrYvrxxvR+zfqtkh7VE/kMDCJe+3BvACjQY/0OjdEMBeKcU+jxOPXUvQsMfPTH29FOPx09Vy4eICCulxsQJ2zU+BC5d62TxebR2QLpnIa3ppV6omg0DM6Nt3PhmRhl77ULM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196037>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> "Atomic" implies that either the whole push succeeds or the whole push
> fails, and that readers will never see part of the push.

Oh, I didn't mean "atomic" in that strict sense.  After all this was a
description at the workflow level--what the human user perceives.

When pushing into the repository you control and nobody else messes
with, you may want update both 'master' and 'devel' with the same "git
push", and that is quite different from current/upstream/simple
model. That is all I meant.

At the mechanical level, we:

 - read all the refs we are going to update and remember their values;
 - send and store all the necessary objects; and
 - for each ref:
    - lock it;
    - read it;
    - is it different from what we read originally?
      - if so, do not update it and remember the fact that we saw a failure;
      - otherwise update it;
    - unlock it;

so it won't be the kind of "atomic" in the "if 'master' will fail to
update due to non-fast-forward, not just 'master' but also 'devel' is
not updated" sense.


Also, if you happen to observe 'devel' and 'master' when a push is in
progress, you may get lucky and see the new value of 'devel' and old
value of 'master'. In that sense, too, it is not "atomic", either.

In the workflow where 'matching' is appropriate, the former won't be an
issue. The latter might be, but it is not like you push objects for
devel, update devel, then push objects for master and the update master,
so the window of race is very small.
