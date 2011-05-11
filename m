From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [BUG?] git revert option parsing too lenient?
Date: Wed, 11 May 2011 22:44:48 +0200
Message-ID: <BANLkTin5FMYJkeLTNeZ47jsXtVxvrLRL+Q@mail.gmail.com>
References: <BANLkTi=dPzu0wrDr3aycEv68M2tw7k5m8A@mail.gmail.com> <20110511203645.GB28742@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 11 22:45:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKGHn-0005Hi-Rq
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 22:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755415Ab1EKUpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 16:45:30 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60962 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755257Ab1EKUp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 16:45:29 -0400
Received: by qwk3 with SMTP id 3so461628qwk.19
        for <git@vger.kernel.org>; Wed, 11 May 2011 13:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=ZEeICK5NnhHqBBJtyFq4NzZzqdoIO0nNyYXYyqfOigM=;
        b=QAskeKvI0hNToxkXLu7qBZpxPNejmg2aVdmAfX4/wsPwPWTrhgeh6uUOPvz3GhjXFk
         S4QEHLjAQt7JvG8ZebJRyFlsD1kofwZtxl7+m9GpGzjysDdEB8gxSev9195GIJkoU5co
         KZfbVfp9yz2g5Yu1z4pFQ7fnlLdd4DuS0mAT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=nFeXDXv13wS6lkm2/I976moAVUtKxKCHHiJXHYcbcqn2nWbJ4gupTAnZYUICQKxZYf
         S6HvvEbeBJ1/Hlq13fiwz6u7ytJVg2auSMYkQRcWFkXyA83vV+PbjM6qFz6RIG1ikJcb
         aQOWNJgQuvCBTr03YX1BoOWp3Ia8doCHn2D0o=
Received: by 10.229.33.137 with SMTP id h9mr4738833qcd.255.1305146728226; Wed,
 11 May 2011 13:45:28 -0700 (PDT)
Received: by 10.229.229.5 with HTTP; Wed, 11 May 2011 13:44:48 -0700 (PDT)
In-Reply-To: <20110511203645.GB28742@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173425>

Heya,

On Wed, May 11, 2011 at 22:36, Jeff King <peff@peff.net> wrote:
> So yeah, it's a bug, but it is a known one. The trouble is that fixing
> it means splitting the revision options into a set of "these are OK for
> picking a revision or range of revisions" and "other options", and
> letting commands like revert use one set but not the other.

Doing the splitting doesn't sound that hard, I assume the real problem
is getting the option parser to look through both tables?

-- 
Cheers,

Sverre Rabbelier
