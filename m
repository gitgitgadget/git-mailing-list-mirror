From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Test "git log --diff-filter"
Date: Mon, 7 Jan 2008 01:31:56 +0100
Message-ID: <200801070131.57722.jnareb@gmail.com>
References: <1198580807-18802-1-git-send-email-arjen@yaph.org> <200801060033.03672.jnareb@gmail.com> <7vmyrj7kq5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Arjen Laarhoven <arjen@yaph.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 01:32:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBfv2-0000oT-5g
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 01:32:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbYAGAcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 19:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbYAGAcE
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 19:32:04 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:17597 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbYAGAcC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 19:32:02 -0500
Received: by ug-out-1314.google.com with SMTP id z38so3081983ugc.16
        for <git@vger.kernel.org>; Sun, 06 Jan 2008 16:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=1Q6QY5R3nnLPPwwIx9g4nVBOpyGk55bvMcKQLrms+iY=;
        b=CRnk77v8wmsQVWzMcsnmEbVOzGNVcWukD+1rtl8SVkCVj/MEPESTFxSTPWwBDVUzRiGwt7Kot78Bm4vuOqVFo2UG5ZXXTW32ULBF0K4Hyd2znB42nMRwRH8iDye4WiGu5cCwv2e7z28zbIAAhF8DRKZQsNZ+cdCbE1ElDoLrweQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WTivqhX/LCli9pt5oH9HXd6+Bj9ATwe1AY1mvCYW37g86H/YvzU6rDZtUeo4h405MY4pLqrJ+eu3p6J9GbSx6WrKjHv4KLUVjAcgwiuiRkAMzGYUM+hp4+dReC/3lAA3Ky+787A66k1l7G/B4ciSO5lqcGRc37u3KHQWYJE9VB8=
Received: by 10.67.21.11 with SMTP id y11mr2586966ugi.10.1199665920514;
        Sun, 06 Jan 2008 16:32:00 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.217.72])
        by mx.google.com with ESMTPS id c25sm29639510ika.9.2008.01.06.16.31.57
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Jan 2008 16:31:59 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vmyrj7kq5.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69750>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > My test checks all --diff-filter filters relevant to git-diff-tree,
> > i.e. ADMRCBT, and not only AMD.
> 
> Ah, I see.  Thanks --- that could have been stated in the log
> message.  Maybe we would want to add them to existing test
> script, instead of adding a whole new one?

The test as it stands now checks if --diff-filter select appropriate
revisions, even without patch output. I think it is enough, as I don't
see how we could screw up to filter AMD correctly, and not all others...
...perhaps with exception of pair breaking, and how they are filtered
using --diff-filter=M and --diff-filter=B; but this impression might
be caused by the fact that pair breaking is the only one which doesn't
use symbol ('B') in raw diff format output.

> > P.S. By the way, it is IMHO a bit strange that --pretty=oneline uses
> > newline as a terminator (it means that there is a newline at the end of
> > "git log --pretty=oneline), while --pretty="format:%s" uses newline as
> > a separator...
> 
> Yeah, I tend to agree, although I learned to live with it long
> time ago.

IMHO that is design bug. Perhaps it should be changed? This way, at least
conceptually oneline, short, medium, full, fuller, email formats might be
considered simply pre-defined format:<sth> formats.

Am I mistaken in thinking that the rest of git always use terminators,
and not separators for records output?
-- 
Jakub Narebski
Poland
