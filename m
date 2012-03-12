From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fmt-merge-msg: show those involved in a merged series
Date: Mon, 12 Mar 2012 02:11:22 -0500
Message-ID: <20120312071121.GA17269@burratino>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org>
 <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com>
 <7vipii27ka.fsf@alter.siamese.dyndns.org>
 <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com>
 <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 08:11:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6zPv-0002cD-Vi
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 08:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635Ab2CLHLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 03:11:35 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35197 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491Ab2CLHLd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 03:11:33 -0400
Received: by ghrr11 with SMTP id r11so2225623ghr.19
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 00:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=RuFUXz5PES9ysmKOZpDyOAfHtjDc8ghd3F0CKMLQSgg=;
        b=v/WGMwcBrVHTBG2rd3TYF4t9iKDQXdbRt2eO34FwJhNS47rjx3E0abPI7Zz40dGuE0
         Fni0g7wOoGb1JMLxOUfQFmO+865bcFnwPO0pUcrL7Tftrfx+3negf/uDGnThmaTWHQHl
         f17CFoWGiPZZwLKfh/ILfKRx29qR678HB89B8jdSASqPiprx/I1s6XxCRQR7Nc37n5gJ
         wR+ByxSjPRRvOKsQ1b22mU9J5ESpZ9x6mzq3jmEUxCNhqzaYNB/NRaNmadWAKGeWJFOI
         etdiwJNih3bSXUd/k99xmAyOpg1VNuaf6XaW0SCdqVv2QH1dwuMet+6fHaAGma4Zi2Y0
         PrGQ==
Received: by 10.182.54.114 with SMTP id i18mr6413799obp.49.1331536293338;
        Mon, 12 Mar 2012 00:11:33 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id n1sm9883833oen.8.2012.03.12.00.11.31
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Mar 2012 00:11:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192845>

Hi,

Junio C Hamano wrote:

> * jc/fmt-merge-msg-people (2012-03-08) 3 commits
>   (merged to 'next' on 2012-03-08 at be31aa9)
>  + fmt-merge-msg.c: make util_as_int() return "int"
>   (merged to 'next' on 2012-03-07 at 76fbac3)
>  + fmt-merge-msg: finishing touches
>   (merged to 'next' on 2012-03-05 at 38de349)
>  + fmt-merge-msg: show those involved in a merged series
>
> The "fmt-merge-msg" command learns to list the primary contributors
> involved in the side topic you are merging.

Ah, so that's where the funny

	By Jonathan Nieder
	via Jonathan Nieder

lines in

	Merge branch 'jn/maint-fast-import-empty-ls' into pu

	By Jonathan Nieder
	via Jonathan Nieder
	* jn/maint-fast-import-empty-ls:
	  fast-import: don't allow 'ls' of path with empty components
	  fast-import: leakfix for 'ls' of dirty trees

come from.  As a person reading the history, I admit I don't like it.
I enjoyed being able to get a simple overview at a higher level of
what has been happening in "pu" with "git log --merges junio/pu" or
"git log --first-parent junio/pu", and these extra lines before and
adjacent to the "* name of topic:" header interfere with that.

By contrast, the

	Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mason/linux-btrfs

	Pull btrfs updates from Chris Mason:
	[more words about that here]

	* 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mason/linux-btrfs:
	 Btrfs: fix casting error in scrub reada code
	[...]

descriptions in Linus's repo are very pleasant.  It's a subtle
difference, but the extra whitespace and the way it presents the
important bits like "Pull btrfs updates" before the mechanics "from
Chris Mason" help.

So I like the goal, but something about this execution does not seem
to be working.  Sorry I have no better news or more concrete feedback
to offer.

Jonathan
