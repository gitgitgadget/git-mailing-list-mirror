From: David Turner <dturner@twopensource.com>
Subject: Re: [RFC] On watchman support
Date: Tue, 18 Nov 2014 16:12:03 -0500
Organization: Twitter
Message-ID: <1416345123.27401.11.camel@leckie>
References: <20141111124901.GA6011@lanh> <1416270336.13653.23.camel@leckie>
	 <CACsJy8BfxP7KF1XF29BOgC6XhO8iAy-ycEoLkDG5rn6TYH_DrA@mail.gmail.com>
	 <1416334360.27401.10.camel@leckie>
	 <xmqqioicut32.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 22:12:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqq4L-0002X7-Dv
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 22:12:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbaKRVMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 16:12:08 -0500
Received: from mail-qc0-f176.google.com ([209.85.216.176]:49002 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932287AbaKRVMH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 16:12:07 -0500
Received: by mail-qc0-f176.google.com with SMTP id i17so4990516qcy.35
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 13:12:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=sE5CA0dA3s+CnJBaFF8oUEJx6H5hODPDqHTEPWowANM=;
        b=ldUZLpcOTtiRXuRv73yKWUw8HucTWzDm4cbGz439AenI5yxIYf9bw/mbuL23fz1EZF
         K6ybcDQJE7jiaa9BT1bm8khh+zK94f4+0Q6FHjXtt3ifP144QkIkcBzkCF+5o6qzmMlY
         m2JPTGrD4yw5MzWdAQa9JpULSPU52AHGmzq/6pHdyr9h1KHeEUtGkzQ3eDX+yAOWlEfu
         GRFpqUbMyPvaRhhKjjohphkYK5wgPmP97CCIbY9tZky9G5a8/xtqq8ExneTh2MhJ9BaF
         mwdL5Dv+xm/rfPgi+5Tst2UPin6wgm+Z5vl2GnCjlzZc4v7oVBtqMBBVvGRBA6PuzMfr
         sYdQ==
X-Gm-Message-State: ALoCoQmgU+uZOO/MrTEmjsxk3xB3kOfgUADtAWALmnO1ah8FYLCquLNK3nP9AgL7JA5s+ou8lxJG
X-Received: by 10.224.98.148 with SMTP id q20mr42665685qan.18.1416345126432;
        Tue, 18 Nov 2014 13:12:06 -0800 (PST)
Received: from [172.17.131.24] (ip-66-9-26-66.autorev.intellispace.net. [66.9.26.66])
        by mx.google.com with ESMTPSA id j10sm3720328qai.18.2014.11.18.13.12.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Nov 2014 13:12:05 -0800 (PST)
In-Reply-To: <xmqqioicut32.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2014-11-18 at 12:55 -0800, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > On Tue, 2014-11-18 at 17:48 +0700, Duy Nguyen wrote:
> >> > My patches are not the world's most beautiful, but they do work.  I
> >> > think some improvement might be possible by keeping info about tracked
> >> > files in the index, and only storing the tree of ignored and untracked
> >> > files separately.  But I have not thought this through fully.  In any
> >> > case, making use of shared memory for the fs_cache (as some of your
> >> > other patches do for the index) would definitely save time.
> >> 
> >> By the way, what happened to your sse optimization in refs.c? I see
> >> it's reverted but I didn't follow closely to know why. 
> >
> > I don't know why either -- it works just fine.  There was a bug, but I
> > fixed it.  Junio?
> 
> I vaguely recall that the reason why we dropped it was because it
> was too much code churn in an area that was being worked on in
> parallel, but you may need to go back to the list archive for
> details.

OK, in that case I'll try to remember to reroll it once the rest of the
refs stuff lands.
