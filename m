From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v8 4/8] notes: allow use of the "rewrite" terminology for
 merge strategies
Date: Mon, 17 Aug 2015 14:54:18 +0200
Message-ID: <CALKQrgfLzWdRxC5saBXJ_-iKmVDfs+mBfDKKrSU2-tP7eO5+Zg@mail.gmail.com>
References: <1439801191-3026-1-git-send-email-jacob.e.keller@intel.com>
	<1439801191-3026-5-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 14:54:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRJvs-0004Vm-Qq
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 14:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754963AbbHQMy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 08:54:28 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:56286 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbbHQMy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 08:54:27 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1ZRJvl-0001BH-42
	for git@vger.kernel.org; Mon, 17 Aug 2015 14:54:25 +0200
Received: by ykfw73 with SMTP id w73so71384993ykf.3
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 05:54:18 -0700 (PDT)
X-Received: by 10.129.133.199 with SMTP id v190mr1207995ywf.38.1439816058124;
 Mon, 17 Aug 2015 05:54:18 -0700 (PDT)
Received: by 10.37.201.134 with HTTP; Mon, 17 Aug 2015 05:54:18 -0700 (PDT)
In-Reply-To: <1439801191-3026-5-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276049>

On Mon, Aug 17, 2015 at 10:46 AM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> notes-merge.c already re-uses the same functions for the automatic merge
> strategies used by the rewrite functionality. Teach the -s/--strategy
> option how to interpret the equivalent rewrite terminology for
> consistency.

I'm somewhat negative to this patch. IMHO, adding the rewrite modes as
merge strategy synonyms adds no benefit - only potential confusion -
to the existing merge strategies. Words that have a sensible meaning
in the context of rewrite, do not necessarily have the same sensible
meaning in the context of merge (and vice versa). I'd rather have the
rewrite code map ignore/overwrite/concatenate to ours/theirs/union,
without teaching the notes-merge code about these words. Or maybe even
drop this patch (and the next?) entirely, and let the future author
(who implements notes rewrite in terms of notes merge) decide how to
deal with this? By committing to these synonyms now, you might
actually be making things harder for the future author: once the
synonyms are part of the user-visible and documented interface, they
cannot easily be removed/changed again.

...Johan

> Add tests for the new synonyms.
>
> Teaching rewrite how to understand merge terminology is left for a
> following patch.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>



-- 
Johan Herland, <johan@herland.net>
www.herland.net
