From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [CGit RFC/PATCH 0/5] Commit graph on CGit's 'log' view
Date: Wed, 14 Jul 2010 00:57:57 +0200
Message-ID: <AANLkTilWENrG8wf1P4EMlzLSj0CdG9s3M8WAwmAZTYUX@mail.gmail.com>
References: <1279056219-27096-1-git-send-email-johan@herland.net>
	<1279057221-28036-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jul 14 00:58:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYoQU-0005pm-1Y
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 00:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755941Ab0GMW57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 18:57:59 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:49537 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149Ab0GMW56 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 18:57:58 -0400
Received: by qyk35 with SMTP id 35so2156221qyk.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 15:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=dbUJ/rkQBOp/A2iWmul2ikzO65yLrxgQSHXDhu04BAY=;
        b=UGCn//mDj518L4YSGAOHswk6CKVkHfg0VKzLhq4qUFwCiY2ZAqMDjLkLfdb4rvUxUX
         elE+gAzltCMDKyGATFU54pOzpKqxsbw34h5JCnhQA0XEK6k3yYpxo6ApFYx4FM3p051z
         k29Lo5WSduXrZIIWMy9DxrnNO9nL4A0z2q+Bc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=vT5bS+YPsGsNny/VXSOFIR/DHYVdH3mIEcdpeu31tLkEfnyiavoJM4b8SXoD8r/mrw
         iBjA49yMFJFwkYxIQNrsDOY4jnwkaIx6/SEWg7IwZ2oTLb7RBoTpMmo9XO6rZrinDpG+
         qmlVqzLfvT145F6KjSsn22KW1uPIWboG1W/iQ=
Received: by 10.224.115.157 with SMTP id i29mr9288686qaq.262.1279061877303; 
	Tue, 13 Jul 2010 15:57:57 -0700 (PDT)
Received: by 10.229.31.12 with HTTP; Tue, 13 Jul 2010 15:57:57 -0700 (PDT)
In-Reply-To: <1279057221-28036-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150936>

On Tue, Jul 13, 2010 at 23:40, Johan Herland <johan@herland.net> wrote:
> Here are some patches to implement an ASCII-art commit graph on CGit's
> 'log' page. The patches reuse the graph-drawing code from Git's own
> 'git log --graph'. As such, these patches depend on the two patches
> I just submitted to the Git list for extending the graph.h API.

Thanks. I've applied the git patches to the jh/graph branch in
git://hjemli.net/pub/git/git (based on v1.7.1-rc2) and updated the
submodule in cgit to point at the tip of this branch. The cgit patches
are then applied on top of this and merged into the wip branch in
git://hjemli.net/pub/git/cgit.

The end result can be seen in action at http://hjemli.net/git/cgit/log
[1] - it works, but I'll have to think about possible compromises
between correctness and performance (i.e. the dependency on
--topo-order).

--
larsh

[1] If the graph looks strange, you might have a cached cgit.css.
Please force a reload in your browser.
