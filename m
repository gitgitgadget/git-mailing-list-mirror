From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fmt-merge-msg: show those involved in a merged series
Date: Tue, 13 Mar 2012 00:23:35 -0500
Message-ID: <20120313052335.GA16664@burratino>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org>
 <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com>
 <7vipii27ka.fsf@alter.siamese.dyndns.org>
 <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com>
 <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org>
 <20120312071121.GA17269@burratino>
 <7vipi9mfhx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 06:23:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7KDG-0005Tl-6T
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 06:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754623Ab2CMFXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 01:23:54 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43511 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753398Ab2CMFXx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 01:23:53 -0400
Received: by yhmm54 with SMTP id m54so151390yhm.19
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 22:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=TrmBCtaid1TFwIN7hzOiTb5xmtyf7YBsBzJt31ooamo=;
        b=OybAbenkA1RLdU8u9xBO4I4WUZMsxMgvIAwhJAD8U81NK7ieYYdTJ9tV24eUzHMNdo
         JrPPKaRkUlvgxfaiCSycvhkbKbHS8arskSHZ1V0Um/uwtLFnjKMelIbB69tVPAN51BwB
         btJByuszCKEybG3pCcHyxV2mCWyJsAzuz3Jnskmv5cqb1V+QwOxjrZlfAEjAzm5+eGHG
         3v759FjNDdZvUmyeZoSlodl/jn/KjN2bXOHI5n7Pjt9sXyuWBdB6S33aMyMEsG1eM5F/
         LOFFAVEJ6sSuQtWxsFXkEr34MHrTfNLjoAvZSQoO+DHJrpuUP3MI4VLUTaN1LhKip96I
         ysSw==
Received: by 10.182.216.2 with SMTP id om2mr5573664obc.46.1331616232387;
        Mon, 12 Mar 2012 22:23:52 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id g2sm24414440obw.10.2012.03.12.22.23.50
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Mar 2012 22:23:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vipi9mfhx.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192979>

Junio C Hamano wrote:

> Having said that, I tweaked the automated rebuilding procedure a bit
> today, and made it annotate these merges with snippets from the
> branch description in the "What's cooking" document, so the commits
> on master..pu are hopefully "very pleasant"ly annotated.

Yes, that helps.

I also wonder if it would make sense to change

	Merge branch 'mm/push-default-switch-warning' into pu

	... description ...

	By Matthieu Moy
	* mm/push-default-switch-warning:
	  push: start warning upcoming default change for push.default

to

	Merge branch 'mm/push-default-switch-warning' into pu

	... description ...

	* 'mm/push-default-switch-warning' by Matthieu Moy:
	  push: start warning upcoming default change for push.default

which makes the author less distractingly prominent (since they will
be right there in the log soon later once we hit the commits
themselves) and makes the start of the list of commits easier to find
by eye.  This is what I was inarticulately hinting at in my message
before.  With two authors it still looks reasonable:

	* 'jc/pickaxe-ignore-case' by Junio C Hamano (2) and Ramsay Jones (1):
	  ctype.c: Fix a sparse warning
	  pickaxe: allow -i to search in patch case-insensitively
	  grep: use static trans-case table

If this seems worth a patch, I'd be glad to try it (and even gladder
to learn that someone else already tried it).

Jonathan
