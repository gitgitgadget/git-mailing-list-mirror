From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 13:05:52 +0530
Message-ID: <CALkWK0naGx6Vrb3_iZbXefQqmwOhaTSRXxBT6K-cheiUwr3Ptw@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com> <517F6E40.1040606@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 30 09:36:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX57G-000452-1I
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 09:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757879Ab3D3Hgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 03:36:36 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:48609 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239Ab3D3Hgd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 03:36:33 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so246741iec.36
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 00:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=/UkV9pysueVVO3bfa/9+BYhPKEkIYqkDI3gQLzk0OX0=;
        b=mUtrJgdTxbe/R1qyV0ccXmsxfrt7x4gDMlLNnm3I3tz2F/fUXUMsFdsaiH6rEqt5qI
         /CmZtIDxX6BeKzC1OFBxOqwEywggfLKSvOzVUWgctxeWi7IicdMs8LatX+gdJEWd5u0j
         Wmz0IO0fJIz9onUqI3TIa+cfsthHOmTzz5iFYjvgvaGeptT/CXJYFMhMPNa27Hm7Ib9w
         EDHdpqWj2lM3W3ze50VItFyMzD02nolpcrLygIXSQQYw3vWF+vMtA8KQ0IPzsycs5zkZ
         BcXxwhbGz7JOZ5JwkE0F1FCv3NCl+H+sEQQmsW8rlw3UBgtW1iDqwegc3Wl/qO9PipDk
         RY+w==
X-Received: by 10.50.73.65 with SMTP id j1mr3213437igv.49.1367307392758; Tue,
 30 Apr 2013 00:36:32 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 30 Apr 2013 00:35:52 -0700 (PDT)
In-Reply-To: <517F6E40.1040606@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222916>

Michael Haggerty wrote:
>     git symbolic-ref -m "Create @ alias for HEAD" @ HEAD

I find this very interesting.  I already have a symbolic ref H
pointing to HEAD, but it has some quirks: H@{u} complains that H is an
invalid branch for example.  When I create the symbolic-ref @, I'm not
_exactly_ creating a synonym for HEAD: @{u} works, not @@{u}.

Many people are confused by this patch (reflog? HEAD@ versus master@?
incomplete due to { omission?), and I'm not sure HEAD@ or master@ are
even useful.  This confusion can be avoided completely if the patch
has the exact same effect as symbolic-ref'ing @ to HEAD.
