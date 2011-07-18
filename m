From: SASAKI Suguru <sss.sonik@gmail.com>
Subject: Re: SP in committer line in fast-import stream
Date: Tue, 19 Jul 2011 01:18:35 +0900
Message-ID: <CAE3X6mxbMBwd5O+md0J3M6DUu38Q1uzDHNhAU7iGbqYVm2TyRw@mail.gmail.com>
References: <CAE3X6mwJquoHj06FVGTsg0qtzyTwbd6gNqy7J4yWiVF-+p-23Q@mail.gmail.com>
	<loom.20110718T172927-173@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 18:18:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiqWn-0001vQ-8p
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 18:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180Ab1GRQSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 12:18:36 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51515 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731Ab1GRQSg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 12:18:36 -0400
Received: by iyb12 with SMTP id 12so3231990iyb.19
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 09:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=7P5mAkzyU0h8r0DNI/MxcCYl1Aa9NZ4bLVBBNr/1H6E=;
        b=Ldy+jD+T4HcA52gZtGp+8Xip1bSWW8dvbMmHlnHIaM2iM9sPSFzmBl9aQqxn04jlSb
         JykJVKc+BFYBRebhMNy5VuzzPSU2dbkm8T0xMZSqUVU7eVE+5UryhViBvudkq99/FY9D
         I+tT3YmsjCFmYVgTmepV06YbTOS+FVrQjybEQ=
Received: by 10.231.125.212 with SMTP id z20mr6094622ibr.154.1311005915198;
 Mon, 18 Jul 2011 09:18:35 -0700 (PDT)
Received: by 10.231.43.9 with HTTP; Mon, 18 Jul 2011 09:18:35 -0700 (PDT)
In-Reply-To: <loom.20110718T172927-173@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177381>

Hi,


2011-07-19 Dmitry Ivankov <divanorama@gmail.com>:
> The problem is with git-fast-import that it doesn't verify the format strictly
> here.
> For example following (no LT) will pass:
> <name> SP <email> GT
> The second problem is that it generates "bad" committer, in fact name-email is
> used as-is, so at least it should convert absent name to a empty name. Or maybe
> just fix the format to make string obligatory.
> There even is a third minor problem, fsck will report confusing "missing space"
> for the no-LT example.
>
> Third one is a clear.
> Your one is the second one, while internally it pulls the first one too.
>
> The shortest fix is to read documentation as
> 'committer' SP <name> SP LT <email> GT SP <when> LF

Thanks.  I understand what happens.
For now, I'll write some wrapper around git-fast-import as a workaound for this.

But, if git-fast-import successfully import and git-fsck will confuse,
aren't some fixes necessary?
It might be too done if git-fast-import will check as if git-fsck does,
but I think some simple checks will help us.

Any comments?


Regards,

-- 
SASAKI Suguru
  mailto:sss.sonik@gmail.com
