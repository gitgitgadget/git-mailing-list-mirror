From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: How to change merge message ("weenie commits")
Date: Thu, 25 Jan 2007 08:12:26 -0800
Message-ID: <m2veiv9jbp.fsf@ziti.local>
References: <17848.54065.631799.755255@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 25 17:12:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA7DM-0003kn-2S
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 17:12:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbXAYQMh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 11:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbXAYQMg
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 11:12:36 -0500
Received: from nz-out-0506.google.com ([64.233.162.231]:40290 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030252AbXAYQMf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 11:12:35 -0500
Received: by nz-out-0506.google.com with SMTP id s1so453292nze
        for <git@vger.kernel.org>; Thu, 25 Jan 2007 08:12:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=NiKOrdYaSFB/1M/V4cbFbuczw/rmLw+lGeZSaFiQ8Vz0Zo+ScPRybcx0zLaJjqxBP1j+pm3PDxOlzNijUqtYkg+VrWUJzlrtwAslwc14y1EVpDSd/9ZLSkuYb3A9fxUjt8mmuRuqUtgTJ4RA837sWIJ2eVZc05tSFYvxh/28CZo=
Received: by 10.64.199.2 with SMTP id w2mr3225000qbf.1169741555155;
        Thu, 25 Jan 2007 08:12:35 -0800 (PST)
Received: from ziti.local ( [67.171.24.140])
        by mx.google.com with ESMTP id q17sm2792689qbq.2007.01.25.08.12.34;
        Thu, 25 Jan 2007 08:12:34 -0800 (PST)
In-Reply-To: <17848.54065.631799.755255@lisa.zopyra.com> (Bill Lear's message of "Thu, 25 Jan 2007 09:56:33 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37733>

Bill Lear <rael@zopyra.com> writes:
> So, when I merge my topic branch onto master, for example, I'd like
> the commit message to be something more thoughtful than the
> "checkpoint 1", "checkpoint 2", "fix typo", "redo sort algorithm",
> etc., etc., and be more like a short set of release notes, a summary
> of what all has been accomplished.
>
> Do others run into this and perhaps have a good solution?

Suppose you do your daily work on branch weenie, then one way would
be:

  git format-patch -k master..weenie
  git checkout master
  git apply 00*.patch
  ## review, then git add and git commit where you would write a long
  ## commit message.

One nice thing about this workflow is that you can easily decide if
you want one single commit or a few commits to group logical groups of
the patch files.

+ seth
