From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [PATCHv2 1/2] add basic tests for merge-tree
Date: Wed, 14 Jul 2010 08:01:33 +0100
Message-ID: <1279090893.2789.21.camel@dreddbeard>
References: <1278854215-9022-1-git-send-email-wmpalmer@gmail.com>
	 <1278854215-9022-2-git-send-email-wmpalmer@gmail.com>
	 <7vaapv0xin.fsf@alter.siamese.dyndns.org>
Reply-To: wmpalmer@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 09:01:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYvyQ-0002Zv-Ua
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 09:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364Ab0GNHBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 03:01:38 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33608 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834Ab0GNHBh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 03:01:37 -0400
Received: by wyb42 with SMTP id 42so712497wyb.19
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 00:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=JLyLaa/HUwyS/b7UWRIsQWtCMmdG/fkhcCc8Teiu2ok=;
        b=ZudPHJyFv2pzL7XuzYC4QPtOnAkmjdA8pLndrGcb0TDFjGb+6g56zSKUt92xTImcId
         BkUDBIu1PVwjUVZ9N+3T06r/6uZ13DImkf9xeyQvcqUXpG0mFdylysnMSQCIFxSUhZF/
         zvVapLWTpt2Uxlho4MoVUdqHVFgxs7QHgf1YY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=S0GzJkH4W/Vmuvs9qMrruy79qXff5efKAcle38nMgb6G4zCu82Va5FbqWs/pVjW5Z+
         5cAGEXeMHztAnm1Imc5WLTL3EG2zg0554XtIBdUqFYKs3azJXcuYl9a+aZ7ynf8yCVA9
         De9srqu+AdNwVpA0G4feUNb87GHA37D6i3Uio=
Received: by 10.227.201.85 with SMTP id ez21mr3736405wbb.151.1279090895850;
        Wed, 14 Jul 2010 00:01:35 -0700 (PDT)
Received: from [192.168.0.129] (5acc3a9a.bb.sky.com [90.204.58.154])
        by mx.google.com with ESMTPS id j60sm1299581weo.7.2010.07.14.00.01.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Jul 2010 00:01:34 -0700 (PDT)
In-Reply-To: <7vaapv0xin.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150969>

On Tue, 2010-07-13 at 16:31 -0700, Junio C Hamano wrote:
> Will Palmer <wmpalmer@gmail.com> writes:
> 
> > merge-tree had no test cases, so here we add some very basic tests for
> > it, including some known-breakages.
> >
> > Signed-off-by: Will Palmer <wmpalmer@gmail.com>
> > ---
> >  t/t4300-merge-tree.sh |  277 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 277 insertions(+), 0 deletions(-)
> >  create mode 100755 t/t4300-merge-tree.sh
> 
> This does not sound like part of "the diff commands", unlike apply/diff/log.
> Perhaps somewhere in t3xxx "other basic commands" series?

I was a bit iffy on this one. Part of this was, admittedly, because
t3[0-9] were all taken, and I'm not sure about what number should be
used after that (perhaps t/README needs to be updated? It only mentions
three digits, but lists the template as tNNNN)

However, merge-tree has a function similar to diff (it shows differences
between trees) and apply (it creates the "result" object when there are
no conflicts), and its purpose seems to be more of a "shower" than a
"do-er" (contrasted with something like git-merge, which actually
creates a commit object, for example), so I thought that diff-commands
would be a good classification.

If you can tell me what number it should be, I'll change it.


-- 
-- Will
