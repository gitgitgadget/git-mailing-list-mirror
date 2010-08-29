From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 08/13] transport-helper: export should disconnect too
Date: Sun, 29 Aug 2010 15:28:13 -0500
Message-ID: <AANLkTi=EkmEeMUx=sSFjnvkVzhUyxtGv4-TL6SsKuBsA@mail.gmail.com>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
 <1283053540-27042-9-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.1008291529510.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Aug 29 22:28:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpoUZ-00024d-6o
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 22:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292Ab0H2U2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 16:28:34 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39453 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177Ab0H2U2d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 16:28:33 -0400
Received: by yxp4 with SMTP id 4so61711yxp.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 13:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=MGkAtL/ogRKODUsmaCZOv5eVo/+ERgmtoWwOJoaZskY=;
        b=VqLBAVOAwm5vGTaJBc29snWyZBx8LQyQKsv2RrFo7LQ302YA42r5L4KJsTT+nCFFqo
         Uhys9+UEMWDIuMNdh8+xH4EpZlrCCxAwWpdGAHz/b7L6XWfBSTkUCVZ74Dr1PT7S2Xzn
         wGMa/o7oNQsedrS94CQzZD+w9ByIrsDUd7UW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=mPIAOj7miyU7M4rU9SII50Gqi/5XpsiEwg35gXyqo2hrQwx98WbP4iPRd50Ms93lof
         wkZFbtpESyKBa1CNhXLKJtzQKpxxyXWcdRDSI0LqWe3jUrCK3hHnEMoVy7/O7nDlj5Q0
         f7TrYAUq1TaQiWhjHjorUvvQqMAkMK+r0s3XA=
Received: by 10.151.145.16 with SMTP id x16mr4394720ybn.342.1283113713227;
 Sun, 29 Aug 2010 13:28:33 -0700 (PDT)
Received: by 10.151.49.17 with HTTP; Sun, 29 Aug 2010 13:28:13 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1008291529510.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154713>

Heya,

On Sun, Aug 29, 2010 at 14:32, Daniel Barkalow <barkalow@iabervon.org> wrote:
> Yup; this is a big improvement, and I'dhave done it this way in the first
> place, had I realized how easy it would be to get fast-import to have a
> "done" command. Your subject is backwards, I think, though; export won't
> require a disconnect.

Depends on how you look at it, the line this patch removes tells the
remote helper infrastructure not to issue a newline when disconnecting
(which was needed because the helper was already disconnected by that
time). On the other side though, you are right in that now the export
command no longer requires the helper to disconnect as part of the
export command.

-- 
Cheers,

Sverre Rabbelier
