From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Avoiding broken Gitweb links and deleted objects
Date: Fri, 10 May 2013 14:04:58 +0700
Message-ID: <CACsJy8CopioiTrEDfuZK=n1DfJ8_chxV9dEObqpVfHHmJvzyqQ@mail.gmail.com>
References: <CAJELnLFrfY=-gOFEe0cJHuyT4UNjbTm8hXMxAmzmQHVbz4iEbg@mail.gmail.com>
 <518C8EAC.6000106@viscovery.net> <7vzjw349y0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matt McClure <matthewlmcclure@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 10 09:05:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UahOY-0004TB-Uc
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 09:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488Ab3EJHFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 03:05:30 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:36474 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893Ab3EJHF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 03:05:29 -0400
Received: by mail-ob0-f179.google.com with SMTP id xn12so3869596obc.10
        for <git@vger.kernel.org>; Fri, 10 May 2013 00:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=qXyjZh5GHwVygS8zHez2XPSVaO4UsFGSzwOljoW1Wu4=;
        b=hOJX+a4RQV6/bJGZNEjhDbIXxtXIwrneBUWz0kLwnMlMr7Vdhy+KqeoRr+LwJ/dliw
         3kO0thI5rGKmJ6/Z1uPf+KAPiRTy2zhUqIdhlbK6/i7vKdpcKl0gyaJ6uiT/vxr1uh2K
         p0ad64OpZ+sXqvUIKwqIC5jac3sfY2BfuewgDpyudMBGXkmm5WoSw+SGnZ9mTI4vZrS8
         p3mHtRzCPIAoPcEZBLWP11NglWVwOzML9exiMMZHpF2Jf61OUywNzY1CVGpD1BgItrNv
         FO3Hu0tWPwZihrqttB46wA8E4BZBCLHipky9NjkgqhqXlKmmD0wV/M+4KCELt2wcdPjv
         BIJQ==
X-Received: by 10.60.83.103 with SMTP id p7mr6080320oey.130.1368169528666;
 Fri, 10 May 2013 00:05:28 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Fri, 10 May 2013 00:04:58 -0700 (PDT)
In-Reply-To: <7vzjw349y0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223820>

On Fri, May 10, 2013 at 1:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> Imagine that a user runs "git rebase" on a history leading to commit
> X to create an alternate, improved history that leads to commit Y.
> What if we teach "git rebase" to record, perhaps by default, an
> "ours" merge on top of Y that takes the tree state of Y but has X as
> its second parent, and "git log" and its family to ignore such an
> artificial "ours" merge that records a tree that is identical to one
> of its parents, again perhaps by default?  "git log" works more or
> less in such a way already, but we might want to teach other modes
> like --full-history and --simplify-merges to ignore "ours" to hide
> such an artificial merge by default, with an audit option to
> unignore them.

What about git-merge? Will it be fooled by these merges while looking
for merge bases?
--
Duy
