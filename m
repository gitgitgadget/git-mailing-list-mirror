From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: GSoC proposal for svn remote helper
Date: Fri, 8 Apr 2011 09:42:07 +0600
Message-ID: <BANLkTinHE-E5_mK8aKYv2f7yExVvfOFVRw@mail.gmail.com>
References: <BANLkTinYyxxkZpmEF2PYXMb_BjCVcbTkYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: jrnieder@gmail.com, artagnon@gmail.com, david.barr@cordelta.com,
	srabbelier@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 05:42:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q82aN-0005no-Qd
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 05:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757426Ab1DHDmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 23:42:10 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:33905 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757397Ab1DHDmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 23:42:09 -0400
Received: by ewy4 with SMTP id 4so981765ewy.19
        for <git@vger.kernel.org>; Thu, 07 Apr 2011 20:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=k9Z1lpnp+v35k36qr3grQIlNMdnJGaIuZaJLcqenILw=;
        b=jHFXSalAlq3QFObAYgK+AaddGrLdMLxr3Te4Fsmw+WnILvGL6NSrev/Oxawbksu562
         qmOdC3IaKso4P+fYWIjRaSd6o0ACDMm3Yg57gQ2Z1n0pCHQlrSJg5Gc5Cb6aXFvL7bPt
         wZAffQOglhFaNxdUhKUWrc6LiCdb5l4yIVUyM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ddZjqeUCi9A1T4vZ0Nk4Nbf81AG9QD+VvGQoNA1JbBzZ1Z2bt34Qy9jTnSUW0T75JH
         PAdhsexOHLUps+TGthN8z2IqOrBjQvs3ivto/tgei1Ydhpq01cQSYtNOtzDRzwnXLE3G
         bx8gAJ43N8zS5x6YKJF5R41dlx3vq9hZ/LQCo=
Received: by 10.14.124.68 with SMTP id w44mr758081eeh.77.1302234127643; Thu,
 07 Apr 2011 20:42:07 -0700 (PDT)
Received: by 10.14.37.10 with HTTP; Thu, 7 Apr 2011 20:42:07 -0700 (PDT)
In-Reply-To: <BANLkTinYyxxkZpmEF2PYXMb_BjCVcbTkYw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171102>

resending in plain-text to make vger.kernel.org happy.

Hi.

This is the second iteration of my GSoC proposal, the first one was on
melange and
got nice responses from Jonathan Nieder, David Barr and Sverre Rabbelier.
However the conclusion was that it looks too ambitious, and that I should roll
out it to the list. So here it is in a diff-style.

I would like to work on "Remote helper for Subversion and git-svn".
My major motivation is to make git-svn repository easy to clone, and to make
git-svn (fetch) faster on huge repositories.

Project Goals:
+ * Design and create fully functional prototype of new git-svn which is
cloneable and quite fast. By fully functional I mean that it'll be
able to fetch, push, etc. but probably won't have automatic tags and
branches discovery and like, but will allow it to be implemented on
top. Oh, it just hit me that given a path (read trunk) to track and a
svndump it looks trivial to discover all it's branches - just seek for
copies.
+ * Get all the needed core git changes merged. Some of these exist already and
only need help with polishing, reviewing and merging.
- * Complete git-remote-svn and get it merged.
- * Implement new git-svn and get it merged too.
+ * Make the prototype as close to being merged as possible.

Milestones for prototype functionality:
 * Be able to track whole / as the only remote branch.
 - * Be able to dumb track some path as the only remote branch. Could be done
 either via pruning in git-remote-svn or via maintaining custom branch,
 probably with the help of git-filter-branch.
 - * Finally, be able to work with multiple svn branches. There are many ways to
 achieve this and several kinds of what features the ability to work includes,
 so there even should be a milestone for choosing the ones to implement.
 + * Be able to track several "paths" as branches so that they have expected
 history (whole path copying is branching), and so that these branches are
 cloneable (will be the same in different git-svn repositories tracking the
 same svn repo, under reasonable assumptions like svn:author not being
 propedited :) ).
 * Anything else that'll appear to be interesting and related.

 Sorry for the late submission to this list, I was really puzzled on how to
 make my proposal more realistic and still as useful for git-svn as possible.
