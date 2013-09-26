From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Problem switching branches in submodule
Date: Thu, 26 Sep 2013 11:08:52 -0700
Message-ID: <20130926180852.GF9464@google.com>
References: <BLU0-SMTP17403D5452DA1619FEFCCBAB8280@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Manish Gill <mgill25@outlook.com>
X-From: git-owner@vger.kernel.org Thu Sep 26 20:09:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPG0A-00026T-JV
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 20:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324Ab3IZSJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 14:09:01 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:42238 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565Ab3IZSJA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 14:09:00 -0400
Received: by mail-pa0-f48.google.com with SMTP id bj1so1651900pad.21
        for <git@vger.kernel.org>; Thu, 26 Sep 2013 11:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=JJnujpWU07jngmLAfVsHM4iyLx5nl0BQ5ZO0cd2Oekw=;
        b=LAhXj6UqrWClk76RWnjRYMZnPjPU3ANWfqiNxzMm7hIkchbDb6fp/B+slHbKYyGO6R
         qPmkpPurv4wDVuNVxROhxDUmjLYcNn7YRMgyyV3xZVDnSGJG0oPtpVS+NZc4K+O2A+mg
         cNvfQ2uuXJDCoypMuQTop8SGsCHY3aCojrei0lRp+18KYyv2lOMLjpjeeghSmCJimtu4
         SkPEmr7Bie+QfXqiXqL/y+DLo0pOvEFqnMnSMHdCA8Df4fJ2GiwCc04GCAQmyaDtnqsC
         DhgNVaEqBignFG718BaxODPm69tERCsXTXsgICRbxcTu6ZEyi1yJtz5iqqFjl9BzuVpz
         vlKA==
X-Received: by 10.66.154.197 with SMTP id vq5mr6733740pab.155.1380218939549;
        Thu, 26 Sep 2013 11:08:59 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id aq1sm3679992pbc.9.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 26 Sep 2013 11:08:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BLU0-SMTP17403D5452DA1619FEFCCBAB8280@phx.gbl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235423>

(cc-ing Duy, who knows the setup code well)
Manish Gill wrote:

> I have a git repository with lots of submodules. In one particular
> submodule, I'm having the following problem:
>
> If I try to switch branches at the top-level of that submodule, I succeed.
>
> But, if I try to switch branches in any subsequen levels, I get the
> following error:
>
>     fatal: internal error: work tree has already been set
>     Current worktree: ../path/Mailman3/rest_project
>     New worktree: ../path/Mailman3/rest_project/website/public_rest
>
> Here, Mailman3 is the primary repository and "rest_project" is a
> submodule. I can do "git checkout" just fine
> inside rest_project, but not after cd-ing into any other repos.
>
> My git version is 1.8.4
>
> Other commands, like git status, push/pull are working fine.

Interesting.  Yeah, this shouldn't happen.

What is the exact command you use to get the above output?  Is your
repository public (which would let us reproduce it) or can you
reproduce it by creating a small artificial test repository?

For comparison, did some previous version of git work ok in the same
scenario, or is this the first time you've tried it?

Thanks,
Jonathan
