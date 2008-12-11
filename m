From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2008, #06; Wed, 26)
Date: Thu, 11 Dec 2008 20:04:32 +0700
Message-ID: <fcaeb9bf0812110504u1acfb612he3edae1df3774045@mail.gmail.com>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org>
	 <fcaeb9bf0811290502j5db4056fo9b125aaa8b564314@mail.gmail.com>
	 <fcaeb9bf0811300229v4e7bfbb7g9a0ac72dcddb4326@mail.gmail.com>
	 <alpine.LNX.1.00.0811301509070.19665@iabervon.org>
	 <fcaeb9bf0812060926r2ee443bfl3adb3f2d1129e5b8@mail.gmail.com>
	 <alpine.LNX.1.00.0812061238260.19665@iabervon.org>
	 <fcaeb9bf0812070427s64438216s41bf1294aa6398a3@mail.gmail.com>
	 <alpine.LNX.1.00.0812071455020.19665@iabervon.org>
	 <fcaeb9bf0812080451k6e213d0fo8d1da9bbac872649@mail.gmail.com>
	 <alpine.LNX.1.00.0812081223140.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Dec 11 14:06:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAlEn-0001NB-7B
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 14:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755177AbYLKNEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 08:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754765AbYLKNEf
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 08:04:35 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:31166 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979AbYLKNEe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 08:04:34 -0500
Received: by fg-out-1718.google.com with SMTP id 19so450407fgg.17
        for <git@vger.kernel.org>; Thu, 11 Dec 2008 05:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=5p0avvTb7d/y9HVLw3h1usf+SAX8HfE0FVVPf+SUb6A=;
        b=GhTh2Ardbi1DwSzqrAujqY+IXkOl/YZGHwoxdNJD0qVGk44F7VmZh3NIuy9rc727bj
         zozhkcCJ6DHMk0ggtwF2qOeJUrk1NRE7H4/rbKgseuDNZ+BPBBR2r0JOeyDhzf7wLshn
         TEchKydZPc6FuDXH2u3XxuaryT8c10IFK0Zq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=bCjFMKe2VUWDYU/HWwEWpGoBegM4flfsQtQDurbeo6hbwYz/s98Kmy957wYgn8xyq9
         x5rDOJtFjgTjTjxoScZ3hZGMw/+z2XJVI/8reyGiCJ9ct6Zg73D13LtngvvcPDUL1xbH
         Cj0fQXP1ruvPPYSAQLV8pJYPuMJAoVKOHon3Y=
Received: by 10.86.4.14 with SMTP id 14mr1244527fgd.27.1229000672669;
        Thu, 11 Dec 2008 05:04:32 -0800 (PST)
Received: by 10.86.87.14 with HTTP; Thu, 11 Dec 2008 05:04:32 -0800 (PST)
In-Reply-To: <alpine.LNX.1.00.0812081223140.19665@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102796>

On 12/9/08, Daniel Barkalow <barkalow@iabervon.org> wrote:
>  >  - for "git grep", we ignore path with CE_NO_CHECKOUT (while using
>  > cache version for CE_VALID)
>
>
> Is this sufficient? I'd expect "git grep" to ignore paths that are outside
>  the checked-out region, even when searching an arbitrary tree, and even
>  when those files aren't in the index at all (i.e., the current commit
>  doesn't have them). That is, I'd expect core.defaultsparse or the
>  equivalent to limit the paths, normally giving this effect.

That's the point. CE_VALID does not define checkout area while
CE_NO_CHECKOUT does.  If an entry is CE_VALID, it is still in checkout
area. But if it is CE_NO_CHECKOUT, "git grep" should ignore that path.
core.defaultsparse has nothing to do here.

>  > >  The question, then, is what happens when the index and core.defaultsparse
>  > >  disagree, either because the porcelain supports causing it or because the
>  > >  user has simply editting the config file or used plumbing to modify the
>  > >  index. That is, (1) we have index entries that say that the worktree is
>  > >  ignored, and the rules don't say they're outside the sparse checkout; do
>  > >  we care whether we expect the worktree to be empty or match the index?
>  > >  And, (2) we have index entries that say we do care about them, but the
>  > >  rules say they're outside the sparse checkout; what happens with these?
>  >
>  > The rule is CE_NO_CHECKOUT is king. core.defaultsparse only helps
>  > setting CE_NO_CHECKOUT on new entries when they enter the index.
>
>
> This seems like a really bad idea to me. If you ask for a file that's
>  outside your default area to be checked out, and then you switch branches
>  and switch back, the file may or may not disappear (depending on whether
>  the branch you switched to temporarily had it or not). Likewise, if you
>  remove files, and then switch branches and back, the files may or may not
>  reappear.

Well, if you set core.defaultsparse properly, those files should
appear/disappear as you wish (and as of now if you define your
checkout area with "git checkout --{include-,exclude-,}sparse" then
core.defaultsparse should be updated accordingly). I don't say
core.defaultsparse is perfect.

Anyway how do you suppose the tool to do in your case (checkout,
switch away then switch back)?
-- 
Duy
