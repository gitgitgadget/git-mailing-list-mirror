From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Determining if two commits are on a separate branch
Date: Fri, 27 Jun 2008 17:17:39 +0200
Message-ID: <8aa486160806270817j1cab369eyc2d74996e9a3286f@mail.gmail.com>
References: <308083c30806270755t4316be67u1f468b51bf475d28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Adr3nal D0S" <adr3nald0s@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 17:18:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCFii-00080L-Oo
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 17:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885AbYF0PRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 11:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754301AbYF0PRo
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 11:17:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:17757 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753685AbYF0PRm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 11:17:42 -0400
Received: by fg-out-1718.google.com with SMTP id 19so260989fgg.17
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 08:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ZmcFLNLsdNuj4QqETXz3JeHyUzhCQP1/haW7JG9KIjU=;
        b=ol6+PdN1bktcK3cVRJ++HRUppa8heZfr/WoprB6dH+khYjSg3V4WzczQJ+gtFuR5A8
         bPYn0K40L7CQs9JjgkgQPpvNLpKpVDMtw3Z7/HDyFxRLffrp90g9nmi2FlOPP4KGHqj4
         l+0bgyHuLMNagpO+9LStHgOP0po6w06mugF9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=T00qVEEfc1m/u6OYpZu5cO/c7zvnu/n8LMc6q/+dpnIULsFXZU5kwtmuamUmHQdoUb
         YSye3Qkc2mAJjoDw5GiRkBytz57VKIJ/JEPAMtC4cqO5CnwhaBlnMid96Nvo/wy0llT5
         uVfIUgWGyburtnpVv66L+4U5+8lq4OIZB2pys=
Received: by 10.86.90.2 with SMTP id n2mr1992721fgb.51.1214579859578;
        Fri, 27 Jun 2008 08:17:39 -0700 (PDT)
Received: by 10.86.27.11 with HTTP; Fri, 27 Jun 2008 08:17:39 -0700 (PDT)
In-Reply-To: <308083c30806270755t4316be67u1f468b51bf475d28@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86572>

On Fri, Jun 27, 2008 at 16:55, Adr3nal D0S <adr3nald0s@gmail.com> wrote:
[...]

> So, is there a "correct" or "best" way to determine if one commit's
> SHA follows directly from another's SHA in the commit history?

You can compute the merge-base of these two commits and if the base is
one of them then it is a fast-forward.

For example, in git.git:

$ git merge-base origin/next origin/master
d54467b8c319571b5dc433b1f7e471c4b0f21caf

$ git rev-parse origin/next origin/master
3e7d305293ce93d00d5e0e6371311f7caa94f497
d54467b8c319571b5dc433b1f7e471c4b0f21caf

The merge-base is origin/master so it is an ancestor of origin/next.

HTH

Santi
