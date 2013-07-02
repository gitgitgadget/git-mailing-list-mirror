From: Johan Herland <johan@herland.net>
Subject: Re: Feature request: "author branch" in commit object
Date: Tue, 2 Jul 2013 22:31:03 +0200
Message-ID: <CALKQrgf_Gv=+zUwcdDUPENj59kx1CbEwELnYZjArBZ1S8ueVcg@mail.gmail.com>
References: <CADL+T9YGtvFrzStxJW64OJEV6H0BroMbkVCJdsDwWDaUWd91zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ed Hutchins <eh@demeterr.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 22:31:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu7EK-0003x2-3Q
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 22:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755429Ab3GBUbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 16:31:10 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:62276 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754487Ab3GBUbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 16:31:09 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Uu7EB-000NqG-45
	for git@vger.kernel.org; Tue, 02 Jul 2013 22:31:07 +0200
Received: from mail-oa0-f41.google.com ([209.85.219.41])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Uu5yc-000DS1-PI
	for git@vger.kernel.org; Tue, 02 Jul 2013 21:10:58 +0200
Received: by mail-oa0-f41.google.com with SMTP id n10so7048344oag.0
        for <git@vger.kernel.org>; Tue, 02 Jul 2013 13:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=p+e+71YprGlpJX0XeM098Uvh+OEfVEXsbxgqVAM85Eo=;
        b=nNQP+CmAbbr/4AFIFdTEw4MYvtbjBYMWYzKKsWrJbfaGa+l6ZZiXlaEtiTjfz2KBeo
         p4peBt92NOoPsYL0BceJ2H3mFlnsed4mEAC40uyjvKuild6wN3gOC/+HnlxftZ1PO3ru
         IXy5uiHnlmLR9WR8IEGUkjE/3cTPNTudwLls6Z0B29rHOcOQ5LeRlnhU4RKzVsmln6Q8
         oVNYuN6cp7v7ZClNAa0EO3cSPnpxn3JRPB+oSxN69e6vLmD/WYWUEgHxTLx0mGWofTap
         QBUulUQHsVKxAwfb2Hnm3YtSgnJXVzWOds2bnRpMGynFE5tIfx8YfNK0+C7VMez241JM
         s9hg==
X-Received: by 10.60.97.1 with SMTP id dw1mr12751739oeb.1.1372797063392; Tue,
 02 Jul 2013 13:31:03 -0700 (PDT)
Received: by 10.182.102.5 with HTTP; Tue, 2 Jul 2013 13:31:03 -0700 (PDT)
In-Reply-To: <CADL+T9YGtvFrzStxJW64OJEV6H0BroMbkVCJdsDwWDaUWd91zQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229426>

On Tue, Jul 2, 2013 at 9:37 PM, Ed Hutchins <eh@demeterr.com> wrote:
> I realize that branch names are ephemeral repo-specific things, but it
> would be really useful to be able to determine what branch a commit
> was authored from (as a hint to ancestry graph layout tools, for
> example). Is there any way to do this currently, is it planned, or
> would it be deemed useful enough to be worth adding to each commit
> object?

As Junio stated elsewhere in the thread: No.

However, you could do this with "git notes", which allows you to
attach information to a commit object without changing the commit
object itself. Of course, for this to work, you would have to write a
post-commit hook to record the branch information in a commit note,
and then convince all contributors in your project to install the same
hook. Then you'd need to teach the relevant graph layout tools to pay
attention to your notes.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
