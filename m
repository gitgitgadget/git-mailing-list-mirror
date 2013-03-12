From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] difftool: Make directory diff symlink work tree
Date: Tue, 12 Mar 2013 23:40:50 +0000
Message-ID: <20130312234050.GG2317@serenity.lan>
References: <CAJELnLGq_oLBiNHANoaE7iEiA6g4fXX0PtJbqPFi4PQ+5LLvnA@mail.gmail.com>
 <CAJDDKr4mTc8-FX7--pd7j0vUbdk_1+KU0YniKEhRdee6SaS-8Q@mail.gmail.com>
 <CAJELnLEL8y0G3MBGkW+YDKtVxX4n4axJG7p0oPsXsV4_FRyGDg@mail.gmail.com>
 <CAJELnLGOK5m-JLwgfUdmQcS1exZMQdf1QR_g-GB_UhryDw3C9w@mail.gmail.com>
 <20130312190956.GC2317@serenity.lan>
 <20130312192459.GD2317@serenity.lan>
 <7906294865355046191@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: Matt McClure <matthewlmcclure@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 13 00:41:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFYoy-0002Os-3X
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 00:41:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593Ab3CLXlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 19:41:00 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:45272 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755329Ab3CLXlA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 19:41:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id A4592CDA59C;
	Tue, 12 Mar 2013 23:40:59 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kqB+ob+l1yQf; Tue, 12 Mar 2013 23:40:58 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 1028FCDA596;
	Tue, 12 Mar 2013 23:40:52 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7906294865355046191@unknownmsgid>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218011>

On Tue, Mar 12, 2013 at 05:12:28PM -0600, Matt McClure wrote:
> On Mar 12, 2013, at 1:25 PM, John Keeping <john@keeping.me.uk> wrote:
> 
> > When I tried this I got the expected behaviour even without this patch.
> 
>     git diff --raw commit
> 
> emits the null SHA1 if the working tree file's stat differs from the
> blob corresponding to commit. Is that the case you observed?

Yes, although it's slightly more subtle than that - the null SHA1 only
occurs if the working tree file has unstaged changes; if you add the
changes to the index then the null SHA1 is no longer used since the blob
is now available in Git's object store.


John
