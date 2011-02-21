From: Ping Yin <pkufranky@gmail.com>
Subject: Re: How to recovery a corrupted git repo
Date: Mon, 21 Feb 2011 23:03:55 +0800
Message-ID: <AANLkTim-O+LR_r=N6y7Dcip8xQGcBVP2FiVhu22Zhysf@mail.gmail.com>
References: <AANLkTi=W3RckA=e-YwDJzELaEOAa+7P74V-G0G=bQhex@mail.gmail.com>
	<20110221100454.GM22168@axel>
	<vpqpqql1lw6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git mailing list <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 21 16:04:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrXIu-0005Z7-Mf
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 16:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800Ab1BUPD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 10:03:56 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:54939 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608Ab1BUPDz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 10:03:55 -0500
Received: by gxk8 with SMTP id 8so519092gxk.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 07:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ZdXhwAcXeg8eg8c3ydoslKi/QRp+wiqoOH6fd3QLBBI=;
        b=dT7OSAx8Dj/HJ1233AcGg5J8HYOSK+1cmrxwOJxDPpFVOoFsPKPA3TZgmF0wdAc+g5
         5io+d+SUXJOx/F0oHcRhJkDnbD5WlTWurA5/pQ2j93fnLQhuv8uEXgJoO8dD2A1ci76g
         RzURoSVJpQO/YW2Q4i1iwyU0j9WQPUKtImxv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=wrlSlYRMKo2rUME7xiHASeiEaeE8L5fYr+x7QmE1Ia9HDZ1NybpISHBlMhMTwLCNsr
         rzokeFkzalpGXpGc8qDIO4mUk5T2rer2pSbkBCrSpELgIE/3D60q+1n9LkLhpUgwZ+yj
         D5UspbGXcTD9aM7+nfaQWu6pOt1kKJsYy6GKo=
Received: by 10.147.125.19 with SMTP id c19mr2336311yan.19.1298300635085; Mon,
 21 Feb 2011 07:03:55 -0800 (PST)
Received: by 10.146.168.17 with HTTP; Mon, 21 Feb 2011 07:03:55 -0800 (PST)
In-Reply-To: <vpqpqql1lw6.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167485>

On Mon, Feb 21, 2011 at 10:51 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Axel Freyn <axel-freyn@gmx.de> writes:
>
> There's also the brute-force approach
>
> rsync $good_repo/.git/objects/ $bad_repo/.git/objects/
> cd $bad_repo
> git gc
>
> Notice the absence of --delete in the rsync command: I'm just adding
> new files in the $bad_repo, not deleting any (since files with
> identical names must have identical content).

Thanks. This should be an applicable method. However, before rsyncing,
the pack should be unpacked first.
