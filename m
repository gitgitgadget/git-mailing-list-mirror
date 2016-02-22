From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC/PATCH 1/1] format-patch: add an option to record base tree info
Date: Sun, 21 Feb 2016 23:30:37 -0800
Message-ID: <CA+P7+xqotNdbKHB4jbzEKZ7brPtz4vrg9HGBmia-aV2Z-kC=aQ@mail.gmail.com>
References: <1456109938-8568-1-git-send-email-xiaolong.ye@intel.com>
 <1456109938-8568-2-git-send-email-xiaolong.ye@intel.com> <xmqqmvqt8jgz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Xiaolong Ye <xiaolong.ye@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 08:31:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXkxo-0005sw-Ja
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 08:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506AbcBVHa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 02:30:58 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:37577 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478AbcBVHa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 02:30:57 -0500
Received: by mail-ig0-f180.google.com with SMTP id 5so76090456igt.0
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 23:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JdU+A80AmSyeiYCfTWwO9fn/QL8gl2+ZChfGWNRbdDk=;
        b=R3qE3+Af/EDKxV2L21fauNSJUqO3eBqDij6nPvbBqQhffApLVlt+QvT0ldDeTemHHc
         N6+6Pf0SjIR6plZUtHaDw/9qdtahLxFQ6QEg+QW3HvhUzARpXH0OOQIgE+uTf+uBRIAd
         olmTJSa+tgi777fpEBpR3EAxBGQu7omo0bVJH2jgqWhFZgilXJMtce/V1lXFr/YnsI51
         cGv+TNMg2U0OH7wKnSjaTq6UjOjz81pU3pyTX9/PeNUkso3a6uwCtNibllG8cMrEvM1U
         EOuqzee4Q23htClxWgEOk6lIfUb16S/7yGEpmJ8ZRxkzwH6PeiNR5ksuQ+EmIJxgTWCh
         iGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=JdU+A80AmSyeiYCfTWwO9fn/QL8gl2+ZChfGWNRbdDk=;
        b=BX/+4wMKvgeUCTzjrgjCp7SDLmIMr2flXTlv1gcjw7KnhltePu9qMhJan0qUi7ytGy
         zrcFQUN5k/yG+ttm0lrnMjLOn2gtZ7bmmK7mV9wfqE6BcxFvFqqF6uPCG3C97YeL+Btw
         VUqsHoSX/sR9M71T0EVOabABqIZ1oTyWqkPwXGH7uUn1LgGN8qZ3/8Sri7t+PQ6PzSUh
         O1KOvI+u3ewqERuyCqE+40wn/zBcG+wckK/KcYzpHovfUlgvsgn8H7iJ4DqH5zwB7jHL
         Xt6Qn1s+S/Ojwu+BrMkCHfmH+qwGiMr0vONNUw7mPEKMZIlZV7O5VbD3Kokzky4IUU+N
         YX8w==
X-Gm-Message-State: AG10YOSdTMvhLMJz7e8PvCkMlCpS8pvugUo6E9eCi7j05sQwnbxjDj9M1M4AjhqCPJwrEetae6/cpTdkQ6iHIA==
X-Received: by 10.50.137.35 with SMTP id qf3mr10045477igb.92.1456126256804;
 Sun, 21 Feb 2016 23:30:56 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Sun, 21 Feb 2016 23:30:37 -0800 (PST)
In-Reply-To: <xmqqmvqt8jgz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286888>

On Sun, Feb 21, 2016 at 8:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> If you are OK with accepting a patch application to a tree with the
> same blobs the diff was taken from, then the format-patch output
> already has all the necessary information.  For each "diff --git"
> part, there is the "index $old..$new" line that records preimage and
> postimage blob object ID, so you should be able to find a tree that
> has the matching blobs in the paths mentioned in the patch, and it
> is guaranteed that the patch would apply cleanly to such a tree.
>
> Of course, that requires the recipient of the patch to have the all
> the blobs mentioned as the preimage in the patch, but it would be a
> reasonable assumption, as your patch assumes that the recipient has
> the commit, and if he has a commit by definition he would have all
> the blobs recorded by that commit.
>

Sorry for a sort of tangent here, but what method would you recommend
for asking git to locate a commit which matches all those blobs? Is
there any already existing plumbing to do such a thing?

Regards,
Jake
