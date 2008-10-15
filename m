From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2008, #03; Tue, 14)
Date: Wed, 15 Oct 2008 18:54:44 +0700
Message-ID: <fcaeb9bf0810150454g572f6147w6a61d770ba28e808@mail.gmail.com>
References: <7v8wsq7rt5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 13:56:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq4yv-0005LL-7h
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 13:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506AbYJOLys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 07:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752455AbYJOLys
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 07:54:48 -0400
Received: from ik-out-1112.google.com ([66.249.90.176]:33957 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbYJOLyr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 07:54:47 -0400
Received: by ik-out-1112.google.com with SMTP id c30so1972160ika.5
        for <git@vger.kernel.org>; Wed, 15 Oct 2008 04:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=k97evNmXBYdj/a0N5Y2tY1YiYjiVhgr3XqN2vFksQbQ=;
        b=VM6r0I+Oo103WPySI2DJ0/i/QZOUNvP2sxJMTLwW+95v6JGjarWpDmnGwMQW7h5A9k
         FRiUgJeh3vMUDsd9g4bNTIMG78WgdGNilBvqqD22PTvLAw2RtuRx8jbyeU3t7pTyTcnG
         aDIeeMdnnHGop3+3iccIvxL2MXcVGJtdk4H+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=xQzw6rihB69onIs20LOqaYICbrWDt1uVoL/ve9szaNIaZqUaptZ1weo0e0KkAzpOnf
         pugmcrOaH6iXEJfxCbBrUUumo/+alzHckFJrmTSMh67gAXP2t+T0qa7EgBLjc2eC1LwK
         VT6Ji/w2goQkBEDZuwRsmSkPvx1IjktC6FxWo=
Received: by 10.86.51.10 with SMTP id y10mr1223017fgy.51.1224071684813;
        Wed, 15 Oct 2008 04:54:44 -0700 (PDT)
Received: by 10.86.95.9 with HTTP; Wed, 15 Oct 2008 04:54:44 -0700 (PDT)
In-Reply-To: <7v8wsq7rt5.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98265>

On 10/15/08, Junio C Hamano <gitster@pobox.com> wrote:
>  [Stuck Topics]
>
>  * nd/narrow (Wed Oct 1 11:04:09 2008 +0700) 9 commits
>   - grep: skip files outside sparse checkout area
>   - checkout_entry(): CE_NO_CHECKOUT on checked out entries.
>   - Prevent diff machinery from examining worktree outside sparse
>    checkout
>   - ls-files: Add tests for --sparse and friends
>   - update-index: add --checkout/--no-checkout to update
>    CE_NO_CHECKOUT bit
>   - update-index: refactor mark_valid() in preparation for new options
>   - ls-files: add options to support sparse checkout
>   - Introduce CE_NO_CHECKOUT bit
>   - Extend index to save more flags
>
>  Recently updated with a repost.  Shawn says he's been too swamped at
>  day-job to actively review the series.  There has been some discussion on
>  list about it so its not stalled, but it needs more eyeballs.

Just a bit of update. I'm still working on the second half. Code
change is even more than this, so I will wait until the first half
gets reviewed and accepted before sending the rest.

BTW, in the first half, unpack_trees()-related commands may refuse to
work if there is orphaned/stale entries in working directory
(verify_*() functions still look at working directory no matter
whether entries are no-checkout). Those entries are troublesome anyway
so encouraging people to clean them out is, IMHO, a good idea, rather
than fixing unpack_trees() to ignore them.
-- 
Duy
