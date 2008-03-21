From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: How to find where a branch was taken from.
Date: Fri, 21 Mar 2008 23:03:18 +0300
Message-ID: <37fcd2780803211303r1a247739na79e78c609565010@mail.gmail.com>
References: <47E37A63.9070209@glidos.net>
	 <7v4pb0qw28.fsf@gitster.siamese.dyndns.org>
	 <32541b130803211039h1f5b8da5k8fb353d46e57b05e@mail.gmail.com>
	 <20080321183225.GA13583@hashpling.org>
	 <32541b130803211148r651d03eev98a478b13e69f710@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Charles Bailey" <charles@hashpling.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Paul Gardiner" <osronline@glidos.net>, git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 21:05:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcnTw-000835-O0
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 21:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325AbYCUUDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 16:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754882AbYCUUDU
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 16:03:20 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:26576 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990AbYCUUDT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 16:03:19 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1687717wff.4
        for <git@vger.kernel.org>; Fri, 21 Mar 2008 13:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=HucktFo9sdKBR4zaE1RXcVmOc6T4bZzImr19BwwibvE=;
        b=HyNQjI4Ky5S3XV6lBlKLbmCjDAOXE6dz/n7ztkRPSOV44+VhcPWPV/U4xuD8I4VeS5k1rKmdftBZ7Lx2SUNviczmxGXXrBPdF81mALg16bcQOWgVH0fXbabtsfSbVvxEyL/KVq6L2G2W777YTMG2CA0kG/x6DPA+J6JOksRszhg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VSM+EnwNqVOZ3KkZ1Uz2FnS/TV03958Ite8CefQB0NAfynoduQ88WYWjsgWpBRDMy47Hsc7k8jhu18prOx8q940gLYE5SyzVLMJK2xTY2fWXVbpfEadK8AhWW4/65w05zNACo+1+BbjCZMf16lkPw27EeLCFy99HYpOTh5jabgo=
Received: by 10.142.245.10 with SMTP id s10mr2646592wfh.200.1206129798530;
        Fri, 21 Mar 2008 13:03:18 -0700 (PDT)
Received: by 10.142.81.18 with HTTP; Fri, 21 Mar 2008 13:03:18 -0700 (PDT)
In-Reply-To: <32541b130803211148r651d03eev98a478b13e69f710@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77764>

On Fri, Mar 21, 2008 at 9:48 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
>
>  "git show-branch" has logic very close to what we need here: if you
>  give it the names of your current branch and its parent, it'll show
>  you just the changes on both branches since the branchpoint.  But I
>  don't really want to know about additional changes on the parent, only
>  on the branch I'm working with, and I often prefer the output to be in
>  git-log's (very flexible) format instead of git-show-branch.

I believe that

   git log parent-branch..local-branch

should give you exactly what you want, i.e. all changes on your local
branch since it was copied from the parent branch.

Dmitry
