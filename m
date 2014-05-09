From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 19/25] contrib: remove 'diff-highlight'
Date: Fri, 09 May 2014 12:45:16 -0500
Message-ID: <536d142c3524_693d7fd30c9d@nysa.notmuch>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <1399597116-1851-20-git-send-email-felipe.contreras@gmail.com>
 <20140509015107.GA9787@sigill.intra.peff.net>
 <xmqqa9aq28a4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 09 19:45:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiorO-00063H-5h
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 19:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755370AbaEIRpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 13:45:22 -0400
Received: from mail-yh0-f42.google.com ([209.85.213.42]:37793 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754353AbaEIRpV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 13:45:21 -0400
Received: by mail-yh0-f42.google.com with SMTP id t59so4092393yho.29
        for <git@vger.kernel.org>; Fri, 09 May 2014 10:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=s8SY6ry0czjao8oBrdw+g9rSC1jg6Bo5bWC0MkQ4BYM=;
        b=v6n+MAN3vd11ZUK98VWQRk3u6BKodjcHcRgvA4CLsdf5BNOvsP5Zvf6Mw+8VgKtm3t
         6u9+Nh8ko3kA78byg4/YgHgZUjqXFS8zTNlnRm10tHvl7NPdNxCFX31JWoj2cP1I2m/2
         yOPjVLweHv1Syzvp7UTc/tCXdERBFcdDO7zSkzkrvubD64BHjVAg9J6W7AyCxyBizvb/
         fUEjzeFrtUymF0sqwZeNYDdkRo3e7EFqCFJQDpEvHCIbRxVeiq9KEZwWByEm641V5kBT
         Zsm8LedQ5dkRx9lMvJW3UGqoofvbDco5pZCDFJi4GJ7KvO8S02n78Hdr2Iywf5/NQ+mR
         BTZA==
X-Received: by 10.236.163.8 with SMTP id z8mr16930579yhk.43.1399657520839;
        Fri, 09 May 2014 10:45:20 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id w47sm7081711yhk.47.2014.05.09.10.45.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 10:45:19 -0700 (PDT)
In-Reply-To: <xmqqa9aq28a4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248597>

Junio C Hamano wrote:
> There is no "prove yourself is worthy or get evicted" purge going on
> in the contrib/ area.  I saw contrib/README referred to a few times
> in the near-by threads, and I think these patches are done primarily
> by deliberately misinterpreting one part of it in order to grab
> attention by many people and also to sabotage the project.

*You* said this[1]:

 - Eject tools in contrib/ that would benefit the users better if
   they were outside my tree.  There are a few points to consider
   when judging "benefit better if outside":

   * Their release cycle requirements are better met outside my tree
     (the "remote-hg depends not just on Git but Hg internal" issue
     we have discussed).

   * They are actively maintained.  The overall Git maintainer would
     merely be being a bottleneck than being a helpful editor with
     respect to these tools if we keep them in my tree, and we
     expect that the tool maintainer would do a much better job
     without me.

 - Keep tools that are not actively maintained but still used by the
   users widely in my tree, but when their external dependencies
   become baggage to Git as a whole, demote them to contrib/ and
   stop installing them by default.

 - I would not mind having install.contrib-frotz target in the
   top-level Makefile for each of the remaining contrib/frotz
   hierarchies for those users and distro packagers who know their
   platform meets the dependency requirements.

So make up your mind. Which tools should be ejected from contrib and for
what reasons?

> The contrib/README file was written back when Git was still a small
> and young project

If contrib/README is not appropriate, then rewrite it. Having a
maintainer making decisions about what goes in and goes outs arbitrarily
helps no one.

Or just remove it and be done with the pretense of haing any
consistency.

> The sole mention of possible removal from contrib/ is this one:

Now you are contradicting what you said in [1]. Surely git-remote-hg/bzr
aren't the only tools that meet the criteria you set in [1].

> in which Felipe said:
> 
>     I don't want to do anything for a "contrib" tool.
> 
> and I suggested that he has an option to make it a standalone
> third-party project.

You are twisting the events incredibly. *You* started by threatening the
removal[2]:

> Having said that, I agree with the conclusion of your message:...
> and I am inclined to be persuaded that the users of remote-hg/bzr
> may better off if they are unbundled from my tree.

I said I wasn't interested in working on this *after* you said they were
not going to the core, and they should move out-of-tree.

> that is one of the only two alternatives I can offer, given that the
> Git ecosystem has matured enough to let third-party tools flourish
> on their own merit.

But it hasn't matured enough. That's *YOUR ASSUMPTION*.

Look at all the fuzz my patch series has created. Does it seem to you
these are the symptoms of an ecosystem mature enough to let third-party
tools to flourish?

If you think so, then let's continue cleaning up contrib. These tools
will "flourish" according to you.

> In any case, that suggestion to remove not related to the "stick",
> either, and certeinly not about "prove yourself" purge that does not
> even exist.
> 
> So I think most of these removal patches can safely be ignored.

Excellent, so you agree you engage in double standards. Tools stay in
the core even when they haven't proven themselves (and even without
tests), tools get dropped from the tree even when they have proven
themselves.

Got it.

[1] http://article.gmane.org/gmane.comp.version-control.git/248233
[2] http://article.gmane.org/gmane.comp.version-control.git/248242

-- 
Felipe Contreras
