From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] unpack-trees: allow pruning with pathspec
Date: Tue, 30 Aug 2011 20:03:35 +0700
Message-ID: <CACsJy8CBJEimG5am8+aWTGP7kzuZ79WfZ3KQKh7pyjKTx-mR9A@mail.gmail.com>
References: <7vty9054qr.fsf@alter.siamese.dyndns.org> <1314653603-7533-1-git-send-email-gitster@pobox.com>
 <1314653603-7533-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 30 15:04:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyNzB-0008N9-0G
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 15:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753873Ab1H3NEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 09:04:08 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49772 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753706Ab1H3NEG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 09:04:06 -0400
Received: by bke11 with SMTP id 11so5024369bke.19
        for <git@vger.kernel.org>; Tue, 30 Aug 2011 06:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WVjKMg/8txM1BXY8HovLbeTqYQsmn2y/rUZjY9DrchQ=;
        b=cW54t/pJuaFS2ZGb+IBMYF91/9tK+5H+Qgz9pWIJwKPRaoE3nTFNpsaIMGX6abjaAP
         oLD7xxTso3jEKCywq7Qe2h8TxHHotlfbuYjRbJU1Ph0agHboKZd0w/iZR9H/tkO8NylJ
         Zjp3vjSeNMO0FOuTQacz6YB8aX1Cdgrgllqtg=
Received: by 10.204.5.193 with SMTP id 1mr76936bkw.133.1314709445131; Tue, 30
 Aug 2011 06:04:05 -0700 (PDT)
Received: by 10.204.7.138 with HTTP; Tue, 30 Aug 2011 06:03:35 -0700 (PDT)
In-Reply-To: <1314653603-7533-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180410>

On Tue, Aug 30, 2011 at 4:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
> and this codepath probably should not be enabled while running a merge

But do you think if it works with merge (ie. a partial merge)?

There's probably no interest in partial merge now, but if narrow clone
comes, index will be also narrowed and at least fast-forward merge
should work. I think it may work, but I'm not sure. unpack_callback()
and traverse_trees() look like magic to me. There may be some
interactions between index and unpacked trees that make partial merge
fail in a subtle way.
-- 
Duy
