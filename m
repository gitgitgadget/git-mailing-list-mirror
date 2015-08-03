From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFC 0/2] bisect per-worktree
Date: Tue, 4 Aug 2015 06:09:17 +0700
Message-ID: <CACsJy8Aab0-JQitEnxYwiepPBvkgHzZudALpQSi2VS54_x4d7Q@mail.gmail.com>
References: <1438387012-29229-1-git-send-email-dturner@twopensource.com>
 <55BC4438.8060709@alum.mit.edu> <CAPc5daVnfit8pkjc2HCSn0erW-q++We8gx8tPsb_ptd5H+CpJg@mail.gmail.com>
 <55BC6C5C.1070707@alum.mit.edu> <1438631396.7348.33.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 01:09:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMOrg-0006AC-7f
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 01:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755539AbbHCXJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 19:09:48 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:38420 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbbHCXJr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 19:09:47 -0400
Received: by iggf3 with SMTP id f3so303279igg.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 16:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=n4i7xf/G0+Rb5pPC3ubDDniVYldJAo4HqUBkB7yWujk=;
        b=VfVvu9EhAwvf2Esh31Afa2LyfmKijkWAS+wxWkW1t+ddF/HXlM2n05iWrT+8YSt2RS
         2cdlOL1wKiPqN6L/zxjcn85Jx4t9n32P9MGDDFKBoxs4bHeh7dJ9XYo5U6bGMwoAwO4F
         HXpb/2iTIziojYZahzBkXMlgBBK0eF9HMZLizodoUf+0wlqoKf4PLWuxgZlzdLkwKWRi
         VCHtpF62SEItdfUz5cPULHjqFbllFyAoT55lQQu1p2crh/bEq8n5FU0wxS14HmYqsxJO
         n9WbNA9M1KKuDe2fN8GIs1qakc6RfjYvF8o19e0xIS4WYiJT0imDo4sORnXFMQkkXDkA
         zr1A==
X-Received: by 10.50.72.6 with SMTP id z6mr615397igu.65.1438643386935; Mon, 03
 Aug 2015 16:09:46 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Mon, 3 Aug 2015 16:09:17 -0700 (PDT)
In-Reply-To: <1438631396.7348.33.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275227>

On Tue, Aug 4, 2015 at 2:49 AM, David Turner <dturner@twopensource.com> wrote:
> Simply treating refs/worktree as per-worktree, while the rest of refs/
> is not, would be a few dozen lines of code.  The full remapping approach
> is likely to be a lot more. I've already got the lmdb backend working
> with something like this approach.  If we decide on a complicated
> approach, I am likely to run out of time to work on pluggable backends.

I think you still have another option: decide that lmdb backend does
not (yet) support multiple worktrees (which means make "git worktree
add" reject when lmdb backend is used). That would simplify some for
you and we can continue on at a later time.
-- 
Duy
