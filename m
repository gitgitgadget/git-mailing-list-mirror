From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/8] revert: prepare to move replay_action to header
Date: Tue, 10 Jan 2012 12:27:00 -0600
Message-ID: <20120110182659.GB22184@burratino>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326212039-13806-1-git-send-email-artagnon@gmail.com>
 <1326212039-13806-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 19:22:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkgKm-0000oq-7H
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 19:22:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932946Ab2AJSWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 13:22:03 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55018 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932311Ab2AJSWB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 13:22:01 -0500
Received: by ghbg21 with SMTP id g21so2291464ghb.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 10:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jzWzCVwCdQqL9dubVXSeqEujCYftYUPY8BxFIHbN38Q=;
        b=SDraQ2iITETMtdnvLJqMCYPWaM32fOQms1bOQCFTV4nogBDqcD6oBVu2+aHwniK8Al
         yaI6nJtttEkQQaIq1+TebLme3ITPsonW0RPFrkodBWnKy3zfh4Yjx3y1H3qMbm2TBgHt
         buZ7RAhMY3U7nsAQJLtnC7CZMsqCnZiWI0Iiw=
Received: by 10.101.197.10 with SMTP id z10mr4300462anp.9.1326219721278;
        Tue, 10 Jan 2012 10:22:01 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id q15sm45804590anm.4.2012.01.10.10.21.59
        (version=SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 10:22:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1326212039-13806-2-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188274>

Ramkumar Ramachandra wrote:

> Later in the series, we will build a generalized sequencer by
> factoring code out of the revert builtin, and leaving it with just
> argument parsing work.  This involves moving "replay_action" to
> sequencer.h, so that both sequencer.c and builtin/revert.c can use it.
> Unfortunately, "REVERT" and "CHERRY_PICK" are unsuitable variable
> names, as their purpose is unclear in the global context; in
> anticipation of the move, rename them to "REPLAY_REVERT" and
> "REPLAY_PICK" respectively.

This could be pruned to just the final bit.  Something like:

	REVERT and CHERRY_PICK and are unsuitable names for an enumerator in
	a public interface, because they are generic enough to be likely to
	clash with identifiers with other meanings.  Rename to REPLAY_REVERT
	and REPLAY_PICK as preparation for exposing them.

The patch proper looks safe and the effect positive to me, so I would
be all for applying it as long as the commit message is cleaned up.
