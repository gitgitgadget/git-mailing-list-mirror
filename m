From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 12/14] revert: Introduce --reset to cleanup sequencer data
Date: Wed, 6 Jul 2011 14:56:10 -0500
Message-ID: <20110706195610.GA23984@elie>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-13-git-send-email-artagnon@gmail.com>
 <CALkWK0nhH=_3+Gj=O4Ov2zOGBoVquzD--+RW_QYYnb8YMAHniA@mail.gmail.com>
 <20110706192141.GA23516@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 21:56:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeYCu-0000ie-Ov
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 21:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755924Ab1GFT4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 15:56:20 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41209 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755704Ab1GFT4T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 15:56:19 -0400
Received: by iyb12 with SMTP id 12so240058iyb.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 12:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FsSW8VwPZ3Pq66tt9PajHN6sSgJSwg1Bo8VAl5ggp14=;
        b=mvf5lCIXEE/2HzF6m7pWAQkmpZkTzrr9RTUiKLBO0zZ0MeDpi6y2d5q3ayH/IM/YbB
         hxmeL+wPJ9J5fz6Y0c/bMUXjtAl//xrRsONuxQNHxfL7C1PL3j75cFEMjgbGanUAk7Ia
         T2hU+EiK4KL7OCBAGrKV9OajwVkIbKpyS//S8=
Received: by 10.42.144.194 with SMTP id c2mr9707238icv.120.1309982178531;
        Wed, 06 Jul 2011 12:56:18 -0700 (PDT)
Received: from elie (adsl-69-209-76-243.dsl.chcgil.sbcglobal.net [69.209.76.243])
        by mx.google.com with ESMTPS id vn4sm9074686icb.7.2011.07.06.12.56.16
        (version=SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 12:56:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110706192141.GA23516@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176728>

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:

>> and it's
>> possible to achieve this effect in another way: when a conflict is
>> encountered in the sequencer && length(todo_file) == 1, throw away the
>> sequencer state.
>
> Yep, that seems like basically the same effect.  Are there downsides?
> (Maybe years from now when a "git cherry-pick --rewind" is introduced
> we would regret this?  But that can be figured out years from now.)

Doh, I'm not thinking straight.  Would this break "git cherry-pick
--abort", or is there some hack layered on top to avoid that?  Making
"git commit" remove the .git/sequencer for the last commit of the
sequence seems a little saner.
