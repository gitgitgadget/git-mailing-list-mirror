From: dloewenherz@gmail.com
Subject: Re: newbie question
Date: Fri, 3 Jul 2009 12:12:30 -0700
Message-ID: <20090703191230.GA2446@andros>
References: <e4a904790907031139rc61c2e0t6b9dbbc0c3dc379e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Alex K <spaceoutlet@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 21:12:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMoBM-00020s-LW
	for gcvg-git-2@gmane.org; Fri, 03 Jul 2009 21:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758869AbZGCTMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2009 15:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758020AbZGCTMQ
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jul 2009 15:12:16 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:58625 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758676AbZGCTMP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2009 15:12:15 -0400
Received: by rv-out-0506.google.com with SMTP id f6so855024rvb.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2009 12:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:x-os:user-agent;
        bh=e0OcLE8wH0Sv4Wet6FTgnvFKWZJo+5LzfU47jzQDiJ4=;
        b=T6HnsQ+aVSS/aFB4fF7hvrCmbUbMyn1GCjZMOdvp1hMNH8VTKWb5hwzc9x/oEx0V17
         Jk38o7Xrv3LZzaWQ7EMuHivF9W/8HUSvS6YAosaQd9TYqnigf/mYe6JvsqbjxIuSfkhx
         gPOZ66PvEjuA3Pd5f1ApYpbTxCHdyx1FN7tww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to:x-os
         :user-agent;
        b=kKlMOhmtVx/9cfiR+W5Rd7wKwsg6Y/uKs7ik/+N6yJmjJyPuiegWWoHPp0YLLPZfiZ
         hv/lY/fVc8sLW7DzNmnCujt0zAC+fMQaGvJskaqSD5zZptp5xyhKgWNorRrb08oRJqKz
         Z0X2ocQiPeistsS7oEbaf8IeNpufRJS0GXSts=
Received: by 10.140.171.18 with SMTP id t18mr1342643rve.109.1246648337862;
        Fri, 03 Jul 2009 12:12:17 -0700 (PDT)
Received: from andros (cpe-76-172-95-58.socal.res.rr.com [76.172.95.58])
        by mx.google.com with ESMTPS id g22sm17421767rvb.25.2009.07.03.12.12.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Jul 2009 12:12:16 -0700 (PDT)
Mail-Followup-To: Alex K <spaceoutlet@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <e4a904790907031139rc61c2e0t6b9dbbc0c3dc379e@mail.gmail.com>
X-OS: Darwin andros 9.7.0 i386
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122706>

Until you commit the files, the changes will follow you to whatever branch
you go to. If you don't want to commit, but still want to switch to B and
not see the changes in A, I would recommend using `git stash`.

e.g.

git checkout A
...edit...
git stash save changes
git checkout B
git status

You'll see that your tree is clean. To get your changes back to A, just run

git checkout A
git stash pop changes

Best,
Dan

On 03/07/09 11:39 -0700, Alex K wrote:
>Hello,
>
>I would think the following simple pattern would be possible:
>
>Create two branches A and B. Switch to A, modify some files, do not
>commit to A, switch to B. Now B should not show any of the changes
>performed to A? However a git status while on B does show that the
>files on A have been modified. Is there something I am missing?
>
>Thank you,
>
>Alex
>--
>To unsubscribe from this list: send the line "unsubscribe git" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
