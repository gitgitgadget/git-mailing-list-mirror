From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 1/2] git-multimail: an improved replacement for
 post-receive-email
Date: Sun, 14 Jul 2013 22:47:34 -0700
Message-ID: <20130715054734.GC2962@elie.Belkin>
References: <1373789343-3189-1-git-send-email-mhagger@alum.mit.edu>
 <1373789343-3189-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Chris Hiestand <chrishiestand@gmail.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michiel Holtkamp <git@elfstone.nl>,
	Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 15 07:47:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UybdP-0003TD-Qg
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 07:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353Ab3GOFrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 01:47:39 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:65166 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853Ab3GOFrj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 01:47:39 -0400
Received: by mail-pb0-f51.google.com with SMTP id um15so10947249pbc.10
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 22:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9w66pOjbtq3URon2QoyiEuLBZ1po1idsI2QPH+Vx/xs=;
        b=Tw4eu961Hzfe+nxvOa9uLzsys5lekn0ySjkwiNJsQ3MRzd3M3Q1R0NdDNco8HIDC+F
         Aj1oyJttVtD7W0T0YXl+O+ou1LvcLFMH/m+9NCVM/dwAMDPaOFBMw6L630ibnkjFtIL2
         oJ575WArOVfFKz6w2UcgktxNWcRJDEGefuQQsdqR3xJ6REgWLOJp6KP3CH49Pe6DTzlY
         bJ/knuCzWwS20G1/mPh4ma8/ugvNV0Oz3+Ef17+Ohy83zxtNjnPVPzVdkSVFkX9n8Nlt
         yRaIZC2uuOsRC4LhRPwDaVW1Cz4H5OKvVunlkIadFoRQs2K8kLjnChfzoVGva65Kj+qy
         HG4A==
X-Received: by 10.68.143.199 with SMTP id sg7mr1525896pbb.13.1373867258683;
        Sun, 14 Jul 2013 22:47:38 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id py6sm58835054pbb.33.2013.07.14.22.47.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 22:47:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1373789343-3189-2-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230420>

Michael Haggerty wrote:

> Add git-multimail, a tool for generating notification emails for
> pushes to a Git repository.  It is largely plug-in compatible with
> post-receive-email, and is proposed to eventually replace that script.
> The advantages of git-multimail relative to post-receive-email are
> described in README.migrate-from-post-receive-email.

Yay!

>  contrib/hooks/multimail/README                     |  486 ++++
>  contrib/hooks/multimail/README.Git                 |   15 +
>  .../README.migrate-from-post-receive-email         |  146 ++
>  contrib/hooks/multimail/git_multimail.py           | 2394 ++++++++++++++++++++
>  contrib/hooks/multimail/migrate-mailhook-config    |  270 +++
>  contrib/hooks/multimail/post-receive               |   90 +
>  6 files changed, 3401 insertions(+)
>  create mode 100644 contrib/hooks/multimail/README
>  create mode 100644 contrib/hooks/multimail/README.Git
>  create mode 100644 contrib/hooks/multimail/README.migrate-from-post-receive-email
>  create mode 100755 contrib/hooks/multimail/git_multimail.py
>  create mode 100755 contrib/hooks/multimail/migrate-mailhook-config
>  create mode 100755 contrib/hooks/multimail/post-receive

I wouldn't be surprised if it is possible to improve this in some
way or other, but where as usual "Reviewed-by" means "If I were
maintainer I would commit and push it out and as a non maintainer
I vouch for its suitability",

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

The patch integrates it into the git tree sanely and further
refinements can safely come on top.  Thanks for your hard work.
