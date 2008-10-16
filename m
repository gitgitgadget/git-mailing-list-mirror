From: "Richard Hartmann" <richih.mailinglist@gmail.com>
Subject: Re: commiting while the current version is in conflict
Date: Fri, 17 Oct 2008 01:26:37 +0200
Message-ID: <2d460de70810161626n4f4c4489k489b20f2e6cce186@mail.gmail.com>
References: <2d460de70810161510ha220593g4615a55b2c3e3b25@mail.gmail.com>
	 <20081016224808.GO536@genesis.frugalware.org>
	 <20081016230035.GC9877@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 17 01:28:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqcFz-000802-UZ
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 01:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471AbYJPX0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 19:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753394AbYJPX0j
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 19:26:39 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:43023 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbYJPX0j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 19:26:39 -0400
Received: by an-out-0708.google.com with SMTP id d40so21062and.103
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 16:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=yUjlHFhKTgrJx5QijAG7bqxPX7pSI3ZHBzI3jM1d0+Y=;
        b=uKHsUlUxHmRHnu4dHCap2bnrMlS75ymYE3/kdBxBeh6ZADc8D563hhA+MSFoG4ye6Z
         nGVLe68F2Ve85gBtSIq/3Sz11FJyFyvPV/b2gGDHuBaKaCbiiirkqf8k2PsHi9o9o+d6
         tfNvbR06ZoBvWnbx5BssNL+UZ3x1Hjf9ZKYkg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=KfNoo7TjtQi5685dfMrf0We9MvAL+mPhuf+EvlHK0yzXZYIm2dVDemGptSvh3ITzUO
         YTT42zdd8b/53TFnWsXeeiiJ+Obh4cKx2z4VcITNNCB3hgIiCZu7vgvkFwkYizxfCpWS
         j7fmYfr9dXVLu7Xpi096uojMi5uK0P4s71/Qw=
Received: by 10.100.248.9 with SMTP id v9mr4299933anh.115.1224199597886;
        Thu, 16 Oct 2008 16:26:37 -0700 (PDT)
Received: by 10.100.43.19 with HTTP; Thu, 16 Oct 2008 16:26:37 -0700 (PDT)
In-Reply-To: <20081016230035.GC9877@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98435>

On Fri, Oct 17, 2008 at 01:00, Shawn O. Pearce <spearce@spearce.org> wrote:

> The sample pre-commit hook checks for these.  Its really hande to
> have enabled.

Thanks.


> and merge conflicts are "resolved" by you running "git add $path"
> after you have finished fixing that path.

True, git add is an implicit resolving, I did not think about it this way.
Personally, I think that git should break at this point, but that's
just me.

The obvious fix would be a pre-add hook. Does anyone else think
this would make sense?


Judging from the code in the pre-commit script, git does not
keep conflict information in its metadata cache, but tries to guess
conflicts from the file's contents/ This seems to be a strange
thing to do, imo. What's the reason for this?


Richard
