From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v3] Add log.abbrevCommit config variable
Date: Mon, 16 May 2011 01:53:52 -0400
Message-ID: <BANLkTi=iFgJ12=_amoxT8x+hNMEhQtOVBg@mail.gmail.com>
References: <BANLkTi=og+e6JW8t+sCvkFJUnR=SrFtWGg@mail.gmail.com>
 <1305413341-56450-1-git-send-email-jaysoffian@gmail.com> <7vei3zoab9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 16 07:56:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLqn7-000323-Si
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 07:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200Ab1EPFyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 01:54:23 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49811 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab1EPFyW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 01:54:22 -0400
Received: by pwi15 with SMTP id 15so1974920pwi.19
        for <git@vger.kernel.org>; Sun, 15 May 2011 22:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=45hFK5vo/10Alcx62pnCE7jyE7EWmiUf6cfjOuUdtN4=;
        b=wdzc0ImLubspKov6ho5mJLsENhapZRd/Kvk5yUviDuhLan+GAOBOsKPE9q1brbvqqK
         ZS9JEErDsM/rcRrboEY3DyvII2wNtNu9KpekumX93T9YjAWRLPq9/GY78lQ+/TOqdIPR
         Pq+kVl4mcxUndEXfC6IRw/EGJLrQ7WWpeHExI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=komLdWCES5gWU+JKlyZc2/LAPVPBob+cKRccv0y9ooGWpGe8N5LAghVox+8Zt25Yyq
         E9t+hjOSNqUQe94rdPQCbnEuqqOp8cVIBRtVgPZdKNi+pWO8dwPD8CYCQ7bjl5UhzGq2
         oV9ShJlwxo0Upv3bMFJZQnG6YcMLDgz0oyh80=
Received: by 10.142.247.7 with SMTP id u7mr2710193wfh.255.1305525262067; Sun,
 15 May 2011 22:54:22 -0700 (PDT)
Received: by 10.142.174.16 with HTTP; Sun, 15 May 2011 22:53:52 -0700 (PDT)
In-Reply-To: <7vei3zoab9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173704>

On Sun, May 15, 2011 at 6:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I am not entirely happy about this change. The "ditto" refers to an ugly
> workaround we had to add with 4f62c2b (log.decorate: only ignore it under
> "log --pretty=raw", 2010-04-08) only because it was too late to revert the
> change in 72d9b22 (Merge branch 'sd/log-decorate', 2010-05-08) that was
> about to become part of 1.7.2-rc0 release. If we knew better, we probably
> wouldn't have added the log.decorate variable that requires this hack that
> requires us to say that 'log --pretty=raw' is special.
>
> If we stop before adding a new configuration, we do not have to repeat the
> same mistake we made earlier.
>
> I dunno.

I disagree that log.decorate is a mistake and that the workaround is
ugly. It would be nice if we didn't need the workaround, but I don't
think we should have to tie our hands because there are scripts that
are parsing git log's output. I think it's a pragmatic solution to
remaining backwards compatible while still being able to provide new
functionality.

FWIW, I use log.decorate, and I'd like to be able to use log.abbrevCommit.

j.
