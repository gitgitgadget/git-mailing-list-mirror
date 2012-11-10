From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Help requested - trying to build a tool doing whole-tree commits
Date: Sat, 10 Nov 2012 20:24:33 +0100
Message-ID: <CAMP44s2NzPw+GYKk5s7UUo8uRWob=K9nedcB+xP85rcyM5WPrQ@mail.gmail.com>
References: <20121109182024.81074BC66D4@golux>
	<m2txsyqwdi.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Eric S. Raymond" <esr@golux.thyrsus.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Nov 10 20:24:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXGfg-0003pG-0O
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 20:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547Ab2KJTYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 14:24:35 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:40751 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265Ab2KJTYe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 14:24:34 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so5109519oag.19
        for <git@vger.kernel.org>; Sat, 10 Nov 2012 11:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=y7LDwqS9L6+phpHtDfHMs3hbV9cN+ZHLCds9e90TxJQ=;
        b=ux1FQSynR3Xi8/ynsbjve07lDFAXnDJ7FzKLWKTEroq1buxaeR1S1nm9nRS12SLtBa
         OEQFEETPZF5rY5HrVRqJ9QhPd0r/Mp+CBKsQht1+H7ArUOmDzp3uRe04ah7hbZ7LKDZO
         /pVUUyVCIo91CyRgBZrSQGyd6fogRgS0XDJmmtdUKNAh5rAtyw4Co4fz09oHre0tvO59
         b0I/RKoFyoO+eqQjo6Pg6VLNLIfmElbkNm7jj51eL5FCbCbjS2pG5lS28dxdtqoPDcrd
         8Mg6FGgRi5A1Oo2PKKlEBly6KiPuE215x3OKSfG/IlPbqqDNxy2Tb4U5eAxGrCb/Iy32
         eElA==
Received: by 10.182.245.20 with SMTP id xk20mr11660274obc.89.1352575473992;
 Sat, 10 Nov 2012 11:24:33 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sat, 10 Nov 2012 11:24:33 -0800 (PST)
In-Reply-To: <m2txsyqwdi.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209299>

On Fri, Nov 9, 2012 at 10:50 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Unknown <unknown@unknown.invalid> writes:

Unknown Invalid? Please don't change the original email, makes it
harder for other people to reply.

>> I need a command or command sequence that will commit an entire file
>> tree to a repository...
>>
>> (a) Allowing me to specify committer and author metadata, and
>>
>> (b) deleting paths not present in the previous commit on the current
>> branch, and
>>
>> (c) allowing me to specify merge links from other previous commits.
>>
>> git commit -a passes (a) and (b) but not (c).
>
> git commit -a won't add new files, so you probably want to use git add
> -A && git commit.  I'm not quite sure what you mean with "merge links",
> but if you want to create merge commits the you'll need to resort to
> plumbing: git add -A && git write-tree && git commit-tree && git
> update-ref.

I've done something similar, except that I used git hash-object
instead of git commit-tree so that I can specify every single detail
about the commit object.

Cheers.

-- 
Felipe Contreras
