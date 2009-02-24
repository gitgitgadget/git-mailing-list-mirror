From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 04/13] remote: make get_remote_ref_states() always 
	populate states.tracked
Date: Mon, 23 Feb 2009 22:09:49 -0500
Message-ID: <76718490902231909n44b4ddebl1ce974090f90daff@mail.gmail.com>
References: <cover.1235368324.git.jaysoffian@gmail.com>
	 <2185ca69c518d60276ba1bc613b7699a6bca7c68.1235368324.git.jaysoffian@gmail.com>
	 <7vvdr0pqhp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 04:12:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbniE-0007v2-2b
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 04:12:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757464AbZBXDJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 22:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752902AbZBXDJv
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 22:09:51 -0500
Received: from rv-out-0506.google.com ([209.85.198.232]:13762 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757363AbZBXDJu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 22:09:50 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2246707rvb.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 19:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BnCvniwbLywjBsK50Lgh5/dNvyIsE/zVQDss7adL8Bo=;
        b=v6treS1CckQz8wV/0knnAUyVL6TydE1a2UZ1SEmvgsWzaI4q5kjvsSJRXF0O92uEUa
         IsDvtWVBRR6DGXxsF7UQ7U8IP9tcS7qf3LoSyQHUVtllJXFNQiiwVcZxU9uV+9CXjsJK
         7Lkhq0roIwWXq9e9fjetRREWcb0dPiJo+eNTM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KUwdWQkIcBAnpC/1LWHiZxOPDU3tlLglQFGSruDe4wwxhTphHt2Lt/oWcqsgM2KGS8
         /IU3JRqY15hAUitChJ1mxMRPXZItIix6ufYBNElbxtbRF2JoE0urH5qXt0zykUTOqUEG
         9HCUdCMadsbDuiECZkXHI4fubV52SLlmd4cb0=
Received: by 10.141.37.8 with SMTP id p8mr2313652rvj.243.1235444989194; Mon, 
	23 Feb 2009 19:09:49 -0800 (PST)
In-Reply-To: <7vvdr0pqhp.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111201>

On Mon, Feb 23, 2009 at 8:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Does this series _semantically_ depend on topics other than your other
> "set HEAD" topic that is still not in 'master'?

No, but I wanted Jeff's changes. I have checked that I can apply the
"set HEAD" series, then Jeff's changes, then this latest series all to
next w/o conflict.

I've not tried it w/o Jeff's changes in the middle.

> I see you made it cleanly apply on top of 'pu', but frankly, I really hate
> to see a series based on 'pu' as a matter of principle and discipline.
>
> Other topics in 'pu' may not be ready for a long time, and you do not want
> this series to be taken hostage to them.  Having to fork your topic off of
> many other topics not even in 'next' means it would be more cumbersome for
> me to handle your series when any of the other topics that you base your
> work on need to be discarded or replaced.

Understood. I thought this situation was a little different though due
to Jeff's changes in the middle which really build on my set HEAD
topic.

> In other words, you make your series unworkable with if you introduce too
> many dependencies.
>
> I've rebased it on top of Peff's jk/head-lookup topic (which in turn
> depends on your js/remote-set-head topic), but I suspect that you would
> want this series fork from and only depend on js/remote-set-head topic.
> In any case, please check the result after I push the results out to make
> sure that I did not make any silly mistakes while rebasing the series.

Will do, thanks.

> I also suspect that you would want to reroll the entire series anyway; see
> separate comments on 10/13 and 11/13.

I've replied to those. Would you mind applying 10/13 and 11/13
independently of this series? This topic depends on them since
otherwise there will be double-frees, but they can go anywhere before
the topic.

j.
