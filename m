From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Git::SVN: handle missing ref_id case correctly
Date: Sat, 10 Jan 2015 10:12:23 -0500
Message-ID: <CALkWK0=jEh06hZSmHim54BaP_KiC8hg-455STQphu17PSoQTqw@mail.gmail.com>
References: <1420900510-78522-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Wong <normalperson@yhbt.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 10 16:13:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9xiw-0003uH-Jt
	for gcvg-git-2@plane.gmane.org; Sat, 10 Jan 2015 16:13:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550AbbAJPNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2015 10:13:05 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:46110 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255AbbAJPNE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2015 10:13:04 -0500
Received: by mail-ig0-f170.google.com with SMTP id r2so5934056igi.1
        for <git@vger.kernel.org>; Sat, 10 Jan 2015 07:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=A2yJ8uIvN9J1VZBmT2pMZW/bsaduaLbs2ZdRBx6ss6g=;
        b=TRbGXSpweYZAcIILv2jev0c4D956ys+SFTRjK/YECL+Nbm+ewzn566/NmQuqioRUYU
         WN/clXrLr2tSEw9RkXXJ+KZHF+2OpgC7HOpVSeFTJKKP4PVq3zkS+UilSFO0ZLrS2Kbh
         WEca/jitWJjgrA2vwKtZi3VPe+UWMf4VjsMtMcAxL+d4CfGmryzJZklkX0W9DkJRVYHL
         EmChw+YWE3PlJ6kXJr7a6IonBrr0Gr962i/Bi0OtbMdzvTWUdOURUZ5Q0cEeGONER44E
         2MK4KOoEWFeg6qZy9zA650LWaGLTy5jENJCw2nre5r/bnql3xK0ABlsTedRMXo4L3YPM
         FbWg==
X-Received: by 10.50.17.99 with SMTP id n3mr7602172igd.21.1420902783276; Sat,
 10 Jan 2015 07:13:03 -0800 (PST)
Received: by 10.107.3.75 with HTTP; Sat, 10 Jan 2015 07:12:23 -0800 (PST)
In-Reply-To: <1420900510-78522-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262264>

Ramkumar Ramachandra wrote:
> -our $default_ref_id  = $ENV{GIT_SVN_ID} || 'git-svn';
> +our $default_ref_id  = defined $ENV{GIT_SVN_ID} ? $ENV{GIT_SVN_ID} : 'git-svn';

This is probably not a functional change; please look at the second hunk.
