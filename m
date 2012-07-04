From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/RFC] Replace ce_namelen() with a ce_namelen field
Date: Wed, 4 Jul 2012 17:07:42 +0700
Message-ID: <CACsJy8AHqjgDx3PT39LVMeGp=qc3tEqNi9gjMok9V7RG1Bspew@mail.gmail.com>
References: <1341393528-21037-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com,
	mhagger@alum.mit.edu
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 12:08:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmMVU-0002CI-4S
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 12:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933832Ab2GDKIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jul 2012 06:08:16 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:46821 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933799Ab2GDKIO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2012 06:08:14 -0400
Received: by wibhm11 with SMTP id hm11so5346137wib.1
        for <git@vger.kernel.org>; Wed, 04 Jul 2012 03:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LeJo2ZsQE6PA/e/hpT+AVxaTtBH3XNSfcq3YV5wGHBE=;
        b=Ht7cAKLdTQWxNOCL3jKCBaU73bOH/oI/UDve+jwszPjevw5W0lyeGnHA35PXPA7YhL
         9DX6OjfL9pcSVzBhYlkkM812p8OB7kJK7mdPe3WMg71aAT6z7M7fDkc73BhAgsul6oYC
         JYbXhZYZA58V/e8XL1pA3y0zmfzm1oUMbgMFC3Ex6TfsTk8jFWa8IYowMTHSBSv/3uFM
         B6b6ltE24SneJzFc8ewBHkrHqp2RCSW9Gsfhw6zAw6Q1s0vKE3SMQI0R6jznunRaGyW1
         9AUK5b521k55pnafGzH1r+pYw3cqvTceUktJ+NPyp3w8sJNzdABtYeFaxIda5czMbuJz
         mLmA==
Received: by 10.180.102.136 with SMTP id fo8mr13417327wib.19.1341396492872;
 Wed, 04 Jul 2012 03:08:12 -0700 (PDT)
Received: by 10.223.79.76 with HTTP; Wed, 4 Jul 2012 03:07:42 -0700 (PDT)
In-Reply-To: <1341393528-21037-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201001>

On Wed, Jul 4, 2012 at 4:18 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Replace the ce_namelen() function in cache.h with a ce_namelen
> field in struct cache_entry. This will both give us a tiny bit
> of a performance enhancement when working with long pathnames
> and is part of the refactoring for the index-v5 file format.

In the name of performance maybe you want to replace strlen(ce->name)
with ce_namelen(ce) or ce->ce_namelen. git-grep says there are three
occurrences, but you may want to relax the search a bit because it's
not always "strlen(ce->name)".
-- 
Duy
