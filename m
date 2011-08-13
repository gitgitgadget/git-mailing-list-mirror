From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Reusing changes after renaming a file (Re: [PATCH 5/6] sequencer:
 Expose API to cherry-picking machinery)
Date: Sat, 13 Aug 2011 12:50:13 -0500
Message-ID: <20110813175012.GD1494@elie.gateway.2wire.net>
References: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
 <1313088705-32222-6-git-send-email-artagnon@gmail.com>
 <20110811215650.GA13839@elie.gateway.2wire.net>
 <CALkWK0migSRUmhPp0069O_NiRs3gQJbrU8QLdwUJ-kUYAsLz4Q@mail.gmail.com>
 <alpine.LNX.2.00.1108131215170.2056@iabervon.org>
 <CALkWK0=seEY+O8qmNKoPyYPW-QT9zpwGsh8SB89qcd6kUQRdKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 13 19:56:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsIRv-000245-Kw
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 19:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459Ab1HMRuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Aug 2011 13:50:21 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55986 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083Ab1HMRuT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2011 13:50:19 -0400
Received: by gya6 with SMTP id 6so2579976gya.19
        for <git@vger.kernel.org>; Sat, 13 Aug 2011 10:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=C+paGOINXy/jECkT3Jtc1dbHVBpZpSaFM3xCAoSh+QA=;
        b=dzLDqQGTEw8aaCgIGp9jVVEaIVV8LgmY7+KblhZ1GyinQFDFkk89LoeMP5U29f7oQm
         ZBauRWHs0ANBoxa09C34thXpWc4RhcQKilB9J9Nv2bTbyAvlUXquYOsOiEcZFmkIxsaM
         hGasKf6utXNCdmUsPvdz7plsEcEQsBqrXEFFo=
Received: by 10.236.155.9 with SMTP id i9mr7351865yhk.168.1313257818534;
        Sat, 13 Aug 2011 10:50:18 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-68-255-106-30.dsl.chcgil.ameritech.net [68.255.106.30])
        by mx.google.com with ESMTPS id z28sm4604535yhn.21.2011.08.13.10.50.17
        (version=SSLv3 cipher=OTHER);
        Sat, 13 Aug 2011 10:50:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0=seEY+O8qmNKoPyYPW-QT9zpwGsh8SB89qcd6kUQRdKg@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179286>

Ramkumar Ramachandra wrote:

> Hm, I was actually thinking of a much less ambitious helper that would
> kick in when the heuristic correlation between two files is above a
> certain threshold.

Doesn't that already work?  For example:

	git cherry-pick -Xrename-threshold=50 foo
