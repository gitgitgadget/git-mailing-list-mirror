From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Mon, 6 Jan 2014 12:42:03 -0800
Message-ID: <20140106204203.GI3881@google.com>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
 <1389028732-27760-3-git-send-email-artagnon@gmail.com>
 <xmqqlhythrzq.fsf@gitster.dls.corp.google.com>
 <CALkWK0kZn44x98td9YXNT5VfhVs=ueeSty9M7Vh08bdoGjGQYg@mail.gmail.com>
 <xmqqa9f8j2n8.fsf@gitster.dls.corp.google.com>
 <20140106201854.GA28162@sigill.intra.peff.net>
 <CAEBDL5UaS2Hd-Yb417W+Fw_7j1+5sRAgszko-PbU7z901_X+cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Mon Jan 06 21:42:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0H01-00063H-TE
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 21:42:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755628AbaAFUmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 15:42:09 -0500
Received: from mail-yh0-f45.google.com ([209.85.213.45]:34266 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753702AbaAFUmI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 15:42:08 -0500
Received: by mail-yh0-f45.google.com with SMTP id v1so3760863yhn.32
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 12:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=RU4Q3iPpciAi1FtS+zWGOyWETqPfw/zEIj39NId2VUQ=;
        b=jZyR2M43ZFTolepq1B/pmSulufRDYuTDgovhYNWO0NPGsvzMeu+2uU3ESbjANNjTLP
         MUQuUHuCyC4AZ2vOYGQLTEg/lQHU+VJKqxMPlJaKvgosBt/Yn+n84y0FD0xsnH6Qntti
         Gzk7WxMaENVW+5OWUh06a6FgFuJwwnYD8Q6m6fRvJUih9B71/4rh24i4FaB30zS39Mdc
         RunxWTR5/yLvAzFfhIb3TbBOeXjUFp8SRn7Law6dYedrfwQ1nZcpg2CV4m7mJUetLdyM
         D1BcbSvBoFoQSqFA19yWvTy4eFTBlnB4IC95s+GQjRURlMwvIHZ19o0/qfHEN2SK/dlb
         jb7Q==
X-Received: by 10.236.51.71 with SMTP id a47mr45046028yhc.22.1389040926640;
        Mon, 06 Jan 2014 12:42:06 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id m68sm20673363yhj.22.2014.01.06.12.42.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jan 2014 12:42:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAEBDL5UaS2Hd-Yb417W+Fw_7j1+5sRAgszko-PbU7z901_X+cw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240061>

John Szakmeister wrote:

>                                                        I think in a
> typical, feature branch-based workflow @{u} would be nearly useless.

I thought the idea of @{u} was that it represents which ref one
typically wants to compare the current branch to.  It is used by
'git branch -v' to show how far ahead or behind a branch is and
used by 'git pull --rebase' to forward-port a branch, for example.

So a topic branch with @{u} pointing to 'master' or 'origin/master'
seems pretty normal and hopefully the shortcuts it allows can make
life more convenient.

It is *not* primarily about where the branch gets pushed.  After all,
in both the 'matching' and the 'simple' mode, "git push" does not push
the current branch to its upstream @{u} unless @{u} happens to have
the same name.

Hoping that clarifies,
Jonathan
