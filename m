From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 08/12] initial_ref_transaction_commit(): function for initial ref creation
Date: Mon, 15 Jun 2015 11:39:07 -0700
Message-ID: <xmqqy4jk95pw.fsf@gitster.dls.corp.google.com>
References: <cover.1434206062.git.mhagger@alum.mit.edu>
	<19f421f504ae22538fd2a902840209c0799e67cb.1434206062.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 15 20:39:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4ZHv-00019T-Hl
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 20:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622AbbFOSjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 14:39:12 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:34502 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755845AbbFOSjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 14:39:09 -0400
Received: by igboe5 with SMTP id oe5so37178423igb.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 11:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=do41pxrIehh10QNL+OezqGWoyKIY09KvYvmna/r2dII=;
        b=x7W6nr51R5FiUN9qIHll+HbaydoKvYxOmYmKbJUtYzOc+qYxYI7y304na9M0EvqzS3
         R+1c/1HwMMLQRGr18F3x1W5xaNKamerSiuZdnp/IRHwYHxusbd+qcOas96FrC4fW6dXB
         xjksGeEJebWrHwOnmKOJAeB9plaJKGk9q10aJifwPgxaSMDsZjDlgLuqcM8ryiMNiasG
         oWuv4C6aBtvuELwMWIvCjCZQThCYxBy3Wdu++E+lWzTbgLnawaykiPdgCZK325V40dzW
         UcOa8D1MAPG/8CaHlBm1WxhZwdG2bj35h6O5SIKgtJ30Xf+mxXNA/4rKxlR4ohCFrGYo
         bkjQ==
X-Received: by 10.50.59.211 with SMTP id b19mr22355387igr.42.1434393548948;
        Mon, 15 Jun 2015 11:39:08 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:16f:c4ab:c37f:75f8])
        by mx.google.com with ESMTPSA id 17sm9395938ioq.39.2015.06.15.11.39.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jun 2015 11:39:08 -0700 (PDT)
In-Reply-To: <19f421f504ae22538fd2a902840209c0799e67cb.1434206062.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Sat, 13 Jun 2015 16:42:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271703>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> It would seem to make sense to add a test here that there are no
> existing references, because that is how the function *should* be
> used. But in fact, the "testgit" remote helper appears to call it
> *after* having set up refs/remotes/<name>/HEAD and
> refs/remotes/<name>/master, so we can't be so strict.

Is "testgit" so hard to fix (or so sacred to break) that we want to
sacrifice the quality of this part that is nearer to the core?

> For now, the
> function trusts its caller to only call it when it makes sense. Future
> commits will add some more limited sanity checks.

OK.

Thanks.
