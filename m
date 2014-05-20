From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Tue, 20 May 2014 16:28:10 -0500
Message-ID: <537bc8ea6ced9_1d08f2d2f8fd@nysa.notmuch>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
 <20140516084126.GB21468@sigill.intra.peff.net>
 <xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
 <20140516225228.GA3988@sigill.intra.peff.net>
 <5376f2ca5c90d_65b915db2f877@nysa.notmuch>
 <20140517062413.GA13003@sigill.intra.peff.net>
 <xmqq1tvq4r43.fsf@gitster.dls.corp.google.com>
 <53795ef8e4023_10da88d30825@nysa.notmuch>
 <xmqqegzp1tl7.fsf@gitster.dls.corp.google.com>
 <537bbd6c1daf_a6f166b308b0@nysa.notmuch>
 <xmqqy4xwrw8o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 23:39:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmrkx-0003bN-UR
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 23:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbaETVj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 17:39:28 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:58878 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbaETVj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 17:39:26 -0400
Received: by mail-oa0-f45.google.com with SMTP id l6so1259877oag.32
        for <git@vger.kernel.org>; Tue, 20 May 2014 14:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=wmJzfln27J22mRZJ54Jvst4L5xFTWy5YK12LQwhhPIs=;
        b=jXj31fSpLq21DVqly5FQ5ZJ0Od346OlfdtP1jqtedQiekxORN846TJPlRyjA7C/lkg
         BTK8TvFqgx+QeTsJV5Dkqtfb2lV/fspNeY+V1qI/PDA1qN1LGuiHXlMexkgU5umt0Fyz
         8zc/6fTZ5OLjI9hUNT0nEO8oW/SkYvdyW+gTBf8qnaEkpTUWehfyyNIHFXrf5vHJcRl6
         8ixSYCylwYpMP1h2tpXsopFWaNAsAHwja0jHG5cUo0cv9GryCodWMc686T6furDH8lIq
         y2Q5HyTxYuTOl9PjKuFJ8p6vfkjxTGkKh++D0tZNqe8PDcMYLj9atHpV7bW3cAXkz+Ru
         w/Xw==
X-Received: by 10.182.60.4 with SMTP id d4mr47186446obr.4.1400621965722;
        Tue, 20 May 2014 14:39:25 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ld8sm39947133obb.9.2014.05.20.14.39.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 May 2014 14:39:22 -0700 (PDT)
In-Reply-To: <xmqqy4xwrw8o.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249749>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> >> Let's try this in a different way, as I sense there is a
> >> misunderstanding somewhere about your "wish".
> >> ...
> > No, I already said I do not want the code removed from v2.0, that's why
> > I sent patches that simply added a warning, and I specifically said
> > those were for 2.0.
> 
> Yeah, I think there are mails crossing.  I sent that "different way"
> way before I read your "already said" happened.
> 
> > So to make it clear, I now request that you do:
> >
> >  1) Remove all the code.
> >
> >     Since my patches were removed from the list, here's an updated patch
> >     that applies on top of 'master'
> >
> >     https://github.com/felipec/git/commits/up/remote/remove
> 
> I'll do that, but just one thing to make sure---do you want the
> helper to exit with status 0?

It doesn't matter; if the remote helper doesn't respond to the commands
transport-helper exits with 128.

> >  4) Re-add the following release note:
> >
> >     * "git push" via transport-helper interface (e.g. remote-hg) has
> >       been updated to allow forced ref updates in a way similar to the
> >       natively supported transports
> 
> I am not sure if this one is consistent with 1), as remote-hg will
> no longer be with the release.

Remove '(e.g. remote-hg)', the rest still applies.

-- 
Felipe Contreras
