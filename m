From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Mon, 6 Jan 2014 10:35:48 -0800
Message-ID: <20140106183548.GG3881@google.com>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
 <1389028732-27760-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 19:35:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0F1o-00041a-Qt
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 19:35:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755461AbaAFSfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 13:35:53 -0500
Received: from mail-qe0-f49.google.com ([209.85.128.49]:35975 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755235AbaAFSfw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 13:35:52 -0500
Received: by mail-qe0-f49.google.com with SMTP id w7so18538839qeb.22
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 10:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8qAPChVzcpB2LMh38SetvPp+musq1XDd2xMuYcL4vkA=;
        b=NFFyvjrGbU2EXZMXn2KUez6ZRLdridq6PWkxsPfkwan2MQ/LFa0sQH7FqGeKZZTy/c
         RTi7Dl1zA7Hdaam7qhzt9UZW4kOt5D6udEbYgo/KGad1HQjg+ivpyTiuMpYj46BAmbtB
         H5BtlFhoE7q9VL4xWlgTH5t+5EyBe9uI8/jRG9D/yaaOpF9k6wJigPvRVcV1U47SX+qt
         IdKf/qr0TAtnnx/hNg1dhr1xmBjqhQmoNrMmibr4ZPy6Q7xwu0IdUNS0HVeIF91O3E30
         owZP+XNTnIuGn1F0WI/4LRa8CrNdvskMYe0dqtgPayQJyNAQJ7aupq19+dphGqMOv3ez
         +zhw==
X-Received: by 10.49.127.205 with SMTP id ni13mr190458889qeb.40.1389033351594;
        Mon, 06 Jan 2014 10:35:51 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id nq5sm106556143qeb.8.2014.01.06.10.35.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jan 2014 10:35:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1389028732-27760-3-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240044>

Hi,

Ramkumar Ramachandra wrote:

>                      a plain
>
>   $ git format-patch -o outgoing
>
> is a no-op on a topic branch, and the user has to remember to specify
> 'master' explicitly everytime. Save the user the extra keystrokes by
> introducing format.defaultTo

Not excited.  Two reasons:

 1. Most config settings are in noun form: e.g.,
    "[remote] pushDefault = foo".  That makes their names easy to guess
    and makes them easy to talk about: I set the default remote for
    pushing by changing the remote.pushdefault setting.

    '[url "<foo>"] insteadOf' is an exception to that and a bit of an
    aberration.

    This new '[format] defaultTo' repeats the same end-with-a-preposition
    mistake, while I think it would be better to learn from it.

 2. Wouldn't a more natural default be @{u}..HEAD instead of relying on
    the user to do the make-work of keeping a local branch that tracks
    master up to date?

Hope that helps,
Jonathan
