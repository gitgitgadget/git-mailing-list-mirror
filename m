X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 2 Dec 2006 10:04:20 +0000
Message-ID: <200612021004.22236.andyparkins@gmail.com>
References: <20061130170625.GH18810@admingilde.org> <200612012154.33834.andyparkins@gmail.com> <20061201220821.GL18810@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 2 Dec 2006 10:07:25 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=D9fK/Uk6FkKYtKR4G3WTRtQnjYO8XFAOZFyuo89mBuIVy8dN+2u/YnLyH/4lu3u0wIvQG6HqsBMhl+y2OUq832DEB0JhvXcbTKhAUPi45G4AJCu4ri5uWuRCucDpt0kDnVRlhlZzCejiSUO7YQ9N0aIvx3ySobKuznRJ7yLcB9Y=
User-Agent: KMail/1.9.5
In-Reply-To: <20061201220821.GL18810@admingilde.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33016>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqRmE-0007hb-4d for gcvg-git@gmane.org; Sat, 02 Dec
 2006 11:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757669AbWLBKHK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 05:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759419AbWLBKHK
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 05:07:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:12876 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1757669AbWLBKHH
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 05:07:07 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2618568uga for
 <git@vger.kernel.org>; Sat, 02 Dec 2006 02:07:06 -0800 (PST)
Received: by 10.78.201.2 with SMTP id y2mr5710702huf.1165054025904; Sat, 02
 Dec 2006 02:07:05 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id 36sm14662753huc.2006.12.02.02.07.05; Sat, 02 Dec
 2006 02:07:05 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 2006, December 01 22:08, Martin Waitz wrote:

> > echo $SUBMODULE_HASH >
> > submodule/.git/refs/supermodules/commit$SUPERMODULE_HASH
>
> I guess you are aware that you have to scan _all_ trees inside _all_
> supermodule commits for possible references.

No you don't; you do it as part of the appropriate normal operations.

 * supermodule commit - scan the current tree for "link" objects in the
   tree.  If you find one write the reference in the submodule.
 * adding a new submodule - if this is a new submodule there can't be any
   references in the supermodule already.
 * cloning a supermodule, every new commit that gets written in the 
   supermodule gets checked from "link" objects.

> So what do you do with deleted submodules?
> You wouldn't want them to still sit around in your working directory,
> but you still have to preserve them.

Now that is a tricky one.  Mind you, I think that problem exists for any 
implementation.  I haven't got a good answer for that.


Andy

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
