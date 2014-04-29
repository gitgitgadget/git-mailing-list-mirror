From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: git-svn Rewrites Some Commits, but not All
Date: Wed, 30 Apr 2014 00:04:37 +0200
Message-ID: <CAA01CsoWw2OxuO7e09u18b9-g8c2aavDNWPDE_TvG33-79nwMQ@mail.gmail.com>
References: <CADu-kvcXWXAd2iBt+oQOVt5znxLmU0fmJ-tgOaogyfGjS5R0vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Eric Wong <normalperson@yhbt.net>
To: Aaron Laws <dartme18@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 00:04:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfG8p-0002y0-OW
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933934AbaD2WEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:04:40 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:52805 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933881AbaD2WEj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:04:39 -0400
Received: by mail-wi0-f174.google.com with SMTP id d1so8202501wiv.7
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HKW0mnXI6cuWuHFslojmn1qcltf/GIS0Pn/phl0DFig=;
        b=oJ5rNFKO2yirsClzngxLhJ6adbeXTEpkULK7/+xD5ajao9zQyPq+6nHjKV/Sa/7tav
         MoNLr0bjdyjWNvH65X5jWpNyvNKuxlgCwdsHKngURFYdM4gLrZW1SUeJGRDgnDo9ozoE
         jy4lBEBUyl2uBiWE6D+WiG9+csEnQgefz3KODBtiT45oNklxyEd1JqmSigvC8y8Bbz6u
         EpYGUzyP4L9R0fqawi8jUYCgOzefcQ80jnyigCAyx0HqSqI2fVIRX5gv3q+mPANZm6nW
         5L0nU7zEpzdSEVeQA7+QAYOELzJSGlejwob2lTTa2SSzW7o2Y0adAeHsj6jrkQKXFNtY
         A8KA==
X-Received: by 10.180.12.206 with SMTP id a14mr365663wic.48.1398809077950;
 Tue, 29 Apr 2014 15:04:37 -0700 (PDT)
Received: by 10.180.24.133 with HTTP; Tue, 29 Apr 2014 15:04:37 -0700 (PDT)
In-Reply-To: <CADu-kvcXWXAd2iBt+oQOVt5znxLmU0fmJ-tgOaogyfGjS5R0vA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247622>

On Mon, Apr 28, 2014 at 9:26 PM, Aaron Laws <dartme18@gmail.com> wrote:
> The way I understand it, when `git svn dcommit` is run, new commits
> are created (A' is created from A adding SVN information), then the
> current branch is moved to point to A'. Why don't we move any other
> refs that were pointing to A over to A' ? What would be the point of
> continuing to point to A? I'm interested in looking into coding this
> change to git-svn, but I would like to hear some feedback first.

Hi,

I think A' might not always be simply (A + SVN info). I think you can
dcommit when you're not up to date.  So A' will have a different
parent than A (will be automatically rebased on top of current branch
tip). Other refs pointing to A might be used as bookmarks, and moving
them from A to A' would be a significant change.

-- 
Piotr Krukowiecki
