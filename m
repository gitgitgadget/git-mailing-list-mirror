From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: bug?: stgit creates (unneccessary?) conflicts when pulling
Date: Tue, 28 Feb 2006 18:53:07 +0000
Message-ID: <b0943d9e0602281053r675cee49i@mail.gmail.com>
References: <20060227204252.GA31836@diana.vm.bytemark.co.uk>
	 <44037A5C.6080409@gmail.com>
	 <b0943d9e0602280700p132c6da2v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 28 19:53:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FE9yC-0007cY-VU
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 19:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWB1SxJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 13:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWB1SxJ
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 13:53:09 -0500
Received: from xproxy.gmail.com ([66.249.82.207]:42898 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932405AbWB1SxI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2006 13:53:08 -0500
Received: by xproxy.gmail.com with SMTP id s19so778311wxc
        for <git@vger.kernel.org>; Tue, 28 Feb 2006 10:53:07 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qs6YsjmSoPcUR3reDY0F+rbr3LiOSnH4WRhvW8y+l13mkvyrsZqXMr4xtnzMIRjsKASKpgPfT1b1Djt1gbK8idnOfMcyX4isOxVBHZKuIXprLrQvgozylvKFpJQghhrSUzzd/WCm5BA8adsxEc++OkuADSB689c9FBwQonLPZpg=
Received: by 10.70.116.13 with SMTP id o13mr924754wxc;
        Tue, 28 Feb 2006 10:53:07 -0800 (PST)
Received: by 10.70.31.16 with HTTP; Tue, 28 Feb 2006 10:53:07 -0800 (PST)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
In-Reply-To: <b0943d9e0602280700p132c6da2v@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16945>

On 28/02/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On 27/02/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > An idea (untested, I don't even know whether it's feasible) would be to
> > check which patches were merged by reverse-applying them starting with
> > the last. In this situation, all the merged patches should just revert
> > their changes. You only need to do a git-diff between the bottom and the
> > top of the patch and git-apply the output (maybe without even modifying
> > the tree). If this operation succeeds, the patch was integrated and you
> > don't even need to push it.
>
> I tried some simple tests with the idea above. I attached a patch if
> you'd like to try (I won't push it to the main StGIT repository yet.
> For safety reasons, it only skips the merged patches when pushing
> them. A future version could simply delete the merged patches.

Don't bother trying this patch. I just found a bug with git.reset()
and the caching of the git.__head variable. I'll post another patch in
a few hours.

--
Catalin
