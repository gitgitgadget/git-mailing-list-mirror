From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] status: really ignore config with --porcelain
Date: Mon, 24 Jun 2013 22:23:30 +0530
Message-ID: <CALkWK0m5Q--G+KuNBoGdXphiBPnhcvMF2Jz+y4Rt0W2zx3m2KQ@mail.gmail.com>
References: <1372077912-18625-1-git-send-email-artagnon@gmail.com>
 <1372077912-18625-2-git-send-email-artagnon@gmail.com> <vpqhagnwraj.fsf@anie.imag.fr>
 <CALkWK0=F_i95S+53eZmOAJtA+jG=jvi5-sDc3BgW3rNQo=n3Ng@mail.gmail.com>
 <vpqhagnv9xq.fsf@anie.imag.fr> <7vk3ljbh5r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 18:54:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrA1v-00037t-Rm
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 18:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646Ab3FXQyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 12:54:12 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:46341 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939Ab3FXQyL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 12:54:11 -0400
Received: by mail-ie0-f171.google.com with SMTP id qd12so25494504ieb.16
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 09:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rcGrbM3/TASrcFGRL1YqGNixLLg4yxa9bVokgsvAKk4=;
        b=P3K1RwmeMoCer7unl9+Xx+nEhyCBL2juQcj2CRi2ZOHokDqhK2pURBL/UozYFboFJY
         S++gryJ/5LReLTBRP/l1JKHe1VSHdOB8GQEkURIc1Gzfz0nEg2P+uVJjMyt7VxZ8u7rp
         XLh6+bLYWDvFK78uHTW5PIICwjtt+JxTXtmUYmLCDAcMPPHlxgFrXoHFL3VeK5YtYNbK
         GkLefSQyJu01CmFr5acDm8C/D5qTSJzijnK1ZkZQhb6GVKDh6/S+gNKFfCTX7mHXiIdH
         mufu6eco+fRJ6FYzj09YdHaDMpUxpJnrJZfWPan7gXusHa7mMfdPsIYxVyq11yFhr/VA
         GFSQ==
X-Received: by 10.43.88.3 with SMTP id ay3mr8467529icc.61.1372092850824; Mon,
 24 Jun 2013 09:54:10 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 24 Jun 2013 09:53:30 -0700 (PDT)
In-Reply-To: <7vk3ljbh5r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228871>

Junio C Hamano wrote:
> In any case, I am still not convinced yet that status.short is a
> real problem if --porcelain readers trip with "## branchname"
> output.  Isn't it that the readers are broken and need fixing?

If you're going to read the configuration and then scramble to reset
it in wt_porcelain_print(), why did you read the configuration in the
first place?  Should column.branch, status.submodulesummary,
status.showuntrackedfiles affect the --porcelain output too?  Isn't
your expectation of my parser unreasonable?

I will argue that --porcelain should skip the branch config, and drop
down one level lower directly: to the diff-ui configuration.
