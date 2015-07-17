From: David Turner <dturner@twopensource.com>
Subject: RFC/Pull request v2: Refs db backend
Date: Fri, 17 Jul 2015 17:22:00 -0400
Organization: Twitter
Message-ID: <1437168120.30911.9.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: mhagger@alum.mit.edu
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 17 23:22:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGD56-00023U-33
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 23:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754509AbbGQVWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 17:22:03 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36433 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463AbbGQVWB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 17:22:01 -0400
Received: by qkdv3 with SMTP id v3so77635317qkd.3
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 14:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=r/wRCZf2s5CGnLGwoD3pc332EQq1UPm3JJmu6inuTPw=;
        b=XvhmhqgrJ++u7+7bDoTUm5/91JcNtmBA+vtiB9jv9KRhaSGM+2KK87RQMvOMfq6I60
         LlIcFMlOJS5vA3QBIhGg2tpt8tmdDPycUX92zjuzGCJbvEQBzYGR629o+X/2W2ubrw6/
         cpNAuGxex3bnvjnkwHfx5pb56lMwCtfENH8+ipfS/Lw5YqtfN0vzszK+gZ9+SZe9yNVv
         Y5kzu1SRx9wVWO1CAnWn11L0iJscOLb3ZVjhBKt48aLVW2m42cgMgLudxChYT9wVYVUR
         mhY1F4svG9c+OmwhjydSVuRNN01N1msU6utfymxAhEFHcDCbVkAtaFSjuA8+g3vYnuhh
         MRjw==
X-Gm-Message-State: ALoCoQk3KDndaUe0aHDu2scu2jCXrmpVUSplguvEWt/UoFaSMzmjL16qu9BS4YtnV0akmN+FTHK9
X-Received: by 10.55.48.18 with SMTP id w18mr28965941qkw.34.1437168120968;
        Fri, 17 Jul 2015 14:22:00 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e10sm6502138qka.40.2015.07.17.14.21.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2015 14:22:00 -0700 (PDT)
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274105>

I've prepared another version of my pluggable backends series.

This version has the following changes:
1. Addressed all cosmetic review comments from previous version
2. Significant cleanup of LMDB code: formatting and variable names,
functions extracted, etc.
3. Explicit handling of per-worktree refs and pseudorefs; several new
patches in the series now address this.
4. refdb init function added to backend
5. rename of refs-be to refs-lmdb
6. Replace void * with struct ref_transaction
7. removed a memory leak
8. More documentation
9. Rebased on top of more-recent upstream (and on top of my preamble
patch series).

There are probably a few further changes that I've forgotten.  Because
the patch series is 49 patches, I've made it available for pull:

https://github.com/dturner-tw/git.git on the 
dturner/pluggable-backends branch

Let me know if you think it's ready for per-patch review, and I'll send
all 49 patches to the list.

Thanks.
