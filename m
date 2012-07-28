From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/7] Change canonicalize_url() to use the SVN 1.7 API
 when available.
Date: Sat, 28 Jul 2012 14:57:33 -0500
Message-ID: <20120728195733.GC3107@burratino>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
 <1343468312-72024-3-git-send-email-schwern@pobox.com>
 <20120728135018.GB9715@burratino>
 <50143700.80900@pobox.com>
 <20120728193029.GB3107@burratino>
 <501442D5.6080207@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 21:58:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvD9G-0004Xb-Sr
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 21:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080Ab2G1T56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 15:57:58 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:49372 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054Ab2G1T55 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 15:57:57 -0400
Received: by obbuo13 with SMTP id uo13so6293512obb.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 12:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9xFElf/uQM/hSLmbAZc7ZbF/PIZPISJQ9V5InZ+CaIc=;
        b=mSrii4nuJyL/Drfs809aJnLhXe7r+nppKGeV5044/sM1Iflj+/VRZj5PyBJ4AZcDV6
         aZcks8jQkVtc7XmuFBIgoTiqnWTR2ZicRq9hxsRQuoZ/X33KZfKwVSALVHKDcfDgE79J
         3IETJzt1Oup3goTNuuSOVrMcJ2Qn8K9Zwxp4orllI0XSyqraQ1pnjBlBUTg7+3iUZfrr
         m+7a+qLL64PjnCrl2+OIGhVumMAHg2t+TE1Bf1M2cwXDcVCgBgUk9KcRflCcPPd3Mxqa
         L5+SohSLGM5kJLOQu1tnEZJVaM2XgC/+y32khgAvlOn+kzAlhKWc8D4I9EWh6jkbymJd
         /dVQ==
Received: by 10.50.135.97 with SMTP id pr1mr4913175igb.49.1343505476646;
        Sat, 28 Jul 2012 12:57:56 -0700 (PDT)
Received: from burratino ([66.99.3.171])
        by mx.google.com with ESMTPS id k5sm2368726igq.12.2012.07.28.12.57.49
        (version=SSLv3 cipher=OTHER);
        Sat, 28 Jul 2012 12:57:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <501442D5.6080207@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202461>

Michael G Schwern wrote:
> On 2012.7.28 12:30 PM, Jonathan Nieder wrote:

>> Since this part of the series is not tested with SVN 1.7, this is
>> basically adding dead code, right?  That could be avoided by
>> reordering the changes to keep "canonicalize_url" as-is until later in
>> the series when the switchover is safe.
>
> I would suggest that worrying whether a few lines of code are introduced now
> or 10 patches later in the same branch which is all going to be merged in one
> go (and retesting the patches after it) is not the most important thing.  The
> code needs humans looking over it and deciding if canonicalizations were
> missed or applied inappropriately.  Or hey, work on that path and url object
> idea that makes a lot of real code mess go away.

In that case they should be one patch, I'd think.

The advantage of introducing changes gradually is that (1) the changes
can be examined and tested one at a time, and (2) if later a change
proves to be problematic, it can be isolated, understood, and fixed
more easily.  The strategy you are suggesting would have neither of
those advantages.

Jonathan
