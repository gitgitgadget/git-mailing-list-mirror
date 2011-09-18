From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] fast-import: rename object_count to pack_object_count
Date: Sun, 18 Sep 2011 14:32:05 -0500
Message-ID: <20110918193205.GF2308@elie>
References: <1316372508-7173-1-git-send-email-divanorama@gmail.com>
 <1316372508-7173-4-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 18 21:32:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5N66-0002t8-Vr
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 21:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756629Ab1IRTcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 15:32:10 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52960 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756184Ab1IRTcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 15:32:09 -0400
Received: by iaqq3 with SMTP id q3so4494130iaq.19
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 12:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GWkg1pKbEHKGxyMhbMWjAq3bvXdi1cCs8IJGA12lpeU=;
        b=VPZ7lPwRbh8FjaQnPJL/zeYwsJPUxJKh6tkPPUTMoQpFoytVYiM8lrLwlCoKYXktd8
         mvfhk4TNIJS21ypm3IaCjHNeavbwxrq3mzYyRKGQdhhe5KIih4FBoGNoloq0uaxqkkYI
         eJFrHyuelxfD8nwkAEDFRGznSAHk+SWsfrJcE=
Received: by 10.42.178.194 with SMTP id bn2mr3186828icb.30.1316374328542;
        Sun, 18 Sep 2011 12:32:08 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id 37sm21916470iba.5.2011.09.18.12.32.07
        (version=SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 12:32:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1316372508-7173-4-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181629>

Dmitry Ivankov wrote:

> object_count is used to count objects that'll go to the current pack.
> While object_count_by_* are used to count total amount of objects and
> are not used to determine if current packfile is empty.
>
> Rename (and move declaration) object_count to pack_object_count to
> avoid possible confusion.

No strong opinion on this one.  I guess the important thing is that
you are moving the declaration to the group of declarations labelled as

	/* The .pack file being generated */

.  Is it important to rename the variable while at it (which will
disrupt other patches in flight using that variable if they exist)?
