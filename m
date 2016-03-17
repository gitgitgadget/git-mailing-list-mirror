From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC] Code reorgnization
Date: Thu, 17 Mar 2016 21:43:55 +0000
Message-ID: <20160317214355.GA32317@serenity.lan>
References: <20160317111136.GA21745@lanh>
 <CAGZ79kbcwFcPSJ9xwE6xi4gQ871m3brtfAut2TChGNzL-foxdQ@mail.gmail.com>
 <xmqqy49gzzrf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>, Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 22:44:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agfiQ-0000ye-Vb
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 22:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936206AbcCQVoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 17:44:15 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:39921 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935552AbcCQVoN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 17:44:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 77A4ECDA548;
	Thu, 17 Mar 2016 21:44:12 +0000 (GMT)
X-Quarantine-ID: <NWgAPe6xoCSv>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=5
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NWgAPe6xoCSv; Thu, 17 Mar 2016 21:44:11 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id A0E0BCDA48A;
	Thu, 17 Mar 2016 21:44:01 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <xmqqy49gzzrf.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289157>

On Thu, Mar 17, 2016 at 12:10:44PM -0700, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
> 
> > For now I would just go with 3 directories:
> >
> > non-git/ (or util, helpers, or anything that could be ripped out and be useful
> >     e.g. strbufs, argv-array run-command, lockfile
> > git/ (maybe called lib? All stuff that is pure Git and is used for libgit
> >
> > builtin/ (as we have it today + all that stuff that doesn't go into
> > git/ very well?)
> 
> It is unclear where you want to have standalone programs in the
> above.  I'd say lib/ and src/ for the first two, where lib/ is for
> things that could be lifted without any Git dependencies and src/
> for everything else.
> 
> Aren't there some folks who link directly with our codebase (I am
> thinking about cgit, but hjemli.net/git/cgit does not seem to be
> responding anymore)?

CGit lives at https://git.zx2c4.com/cgit/ these days.

The organisation of the git code shouldn't make a difference since CGit
just links with libgit.a, even if it does CGit pulls in git.git as a
submodule so it can just fix any problems in the same commit that
updates the submodule reference.
