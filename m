From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Bug: [hostname:port]:repo.git notation no longer works (for ssh)
Date: Fri, 27 Sep 2013 15:38:36 +0700
Message-ID: <CACsJy8ALCXo0ZN-_HRCvN-xDNiZt9FmonXF5=2YE6L8nJBQoOw@mail.gmail.com>
References: <87vc1mg01t.fsf@aeneas.oslo.osa>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Morten Stenshorne <mstensho@opera.com>
X-From: git-owner@vger.kernel.org Fri Sep 27 10:39:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPTZw-0006S7-VU
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 10:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804Ab3I0IjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 04:39:09 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57467 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab3I0IjH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 04:39:07 -0400
Received: by mail-ob0-f174.google.com with SMTP id uz6so2978987obc.33
        for <git@vger.kernel.org>; Fri, 27 Sep 2013 01:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rYuSQjyzHJfePSnucidfegMMlIgNNeGsBxpPZoJ1YRk=;
        b=NG4XglcD+08RTnpi9QGgN8SPSmHVKJ0Z+0JIudjEQAlKxlRmpQEv2mHl6WGdqWlP4m
         Wks0Xdr8X8ETldZ7pxd+bH0dxHDIWcTsOPN39XEfYNuMR0X2x7yxOOARhEp2DyM12GWh
         YNViTZw1LcWcJdFLEVjm+TyLtM5856xlZ26z3q/kg5dwZSwjmtHWgDLoleQ4DrGtk65b
         2VGbKrdro5qmE2xkpprX5frp9ZZAGqDRSEBkTtADvUKWk/Tc/CLGELsx/0hiG1efyqqz
         3xNwv0vlVxqB3zdaWLBbD/uOInrE9C6525nXMGfTQxmPa6xpmdYWwkW88Bv5ydfOi9UF
         BHUg==
X-Received: by 10.60.51.196 with SMTP id m4mr4792596oeo.1.1380271146772; Fri,
 27 Sep 2013 01:39:06 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Fri, 27 Sep 2013 01:38:36 -0700 (PDT)
In-Reply-To: <87vc1mg01t.fsf@aeneas.oslo.osa>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235447>

On Fri, Sep 27, 2013 at 3:07 PM, Morten Stenshorne <mstensho@opera.com> wrote:
> I've just upgraded to Debian testing (jessie), and with that I got a
> brand new (for me) git version:
>
>     $ git --version
>     git version 1.8.4.rc3
>
> Some of my repos I use an ssh tunnel to reach, so when I want to reach a
> repo forwarded to local port 2223, using the ssh protocol, the following
> used to work (.git/config) in older git versions:
>
>     [remote "exp"]
>             url = [localhost:2223]:blink.git
>             fetch = +refs/heads/*:refs/remotes/exp/*
>
> However, now I get this message:
>
>     $ git fetch exp
>     fatal: ':blink.git' does not appear to be a git repository
>     fatal: Could not read from remote repository.

Ugh.. bisect pointed to my commit 6000334 (clone: allow cloning local
paths with colons in them - 2013-05-04). Will have a closer look
tonight.
-- 
Duy
