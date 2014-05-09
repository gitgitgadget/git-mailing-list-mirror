From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Conforming to pep8
Date: Thu, 08 May 2014 23:36:29 -0500
Message-ID: <536c5b4d9e2c9_377dfcb2f02b@nysa.notmuch>
References: <20140509015429.GA550@wst420>
 <536c3911ea173_741a161d310f2@nysa.notmuch>
 <20140509035759.GA9051@wst420>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: William Giokas <1007380@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 06:47:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiciT-0001yO-79
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 06:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbaEIErV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 00:47:21 -0400
Received: from mail-yh0-f54.google.com ([209.85.213.54]:46937 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbaEIErV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 00:47:21 -0400
Received: by mail-yh0-f54.google.com with SMTP id i57so3327937yha.27
        for <git@vger.kernel.org>; Thu, 08 May 2014 21:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=iwBsPAmIy46IMvUueWnoHJMVaweHgO+bJ5JsYiscXkw=;
        b=C8bVoZldInotpQBlmCwiYdna1pLlMyF7fh2YBW0jCZ4HD//Gzw0AgdeR1fywcXRdxr
         9h4rrzPLsiGcBwwJoN7sCtne5cdOrOOX2MZ9EPmz1qfm0iRlrNnCgIQlQ1rWk+ffPS0Q
         PsFiqhgpMuokfVMJQk7s9ghnhbtrrW0hwnuu0VGaLX6W/YR4/RXvWZ7bpTjTugnMhUdK
         XakVK66z6aBozbsyVN+WKkR6xbI2midPY2BBxvCvyQr5tKt97pN68EP/xyS1tFtJEIAd
         xcLk1/q7+7gvAvzRa+CGSMa7LfiggAX4Nm7y1eHiN5jhGPPW9xzIxsg2jc8mol2qGoFw
         dswQ==
X-Received: by 10.236.90.12 with SMTP id d12mr11570243yhf.120.1399610840693;
        Thu, 08 May 2014 21:47:20 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id q67sm4616805yhb.17.2014.05.08.21.47.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 21:47:17 -0700 (PDT)
In-Reply-To: <20140509035759.GA9051@wst420>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248513>

William Giokas wrote:
> On Thu, May 08, 2014 at 09:10:25PM -0500, Felipe Contreras wrote:
> > William Giokas wrote:
> > > Which is a whole bunch of errors and warnings thrown by pep8. Is pep8
> > > just getting put by the wayside? I would much rather have these
> > > scripts conform to that and have an actual coding style rather than
> > > just be a hodge-podge of different styles.
> > 
> > Personally I try to follow pep8 in git-remote-{hg,bzr}, but only to some
> > extent.
> > 
> > I do this:
> > 
> >   [pep8]
> >   ignore = E401,E302,E201,E202,E203,E126,E128
> 
> (So I haven't looked at git-remote-bzr, but I can comment on
> git-remote-hg)
> 
> Is there a reason for these?
> 
> E401: Multi-line imports seems like something that would just be
> changing one line

Yes, and make the code very annoying.

> E302: Blank lines don't seem to be that hard to do either. That can even
> be automated quite reliably. It shouldn't detract from the readability,
> juts makes the file a bit longer.

The problem is not that it's hard to do, the problem is that it makes
the code uglier.

> E20{1,2,3}: Extra whitespace is something that just makes things more
> consistent and readable.

I don't see how this:

  {'100755': 'x', '120000': 'l'}

Is more readable than this:

  { '100755': 'x', '120000': 'l' }

No strong opinion on this one though.

> E12{6,8}: continuation line indenting is another thing that helps
> consistency.

I don't see how.

> >   max-line-length = 160
> 
> The standard states that this should, at most, be increased to a value
> between 80 and 100.

And why's that?

This has been discussed many times in the LKML, and the end result is
that we don't live in the 60's, our terminals are not constrained to 60
characters. Going beyond 100 is fine.
 
> Note that I'm not trying to yell, but these are just things that are set
> forth in pep8 but don't seem to be set at all in git-remote-hg. I really
> think that git's python 'bits' should be able to pass a default pep8
> without issue.

And I disagree.

I'm willing to follow pep8 as much as possible as long as it makes
sense, but some thing do make the code uglier in my opinion.

> > That said there's a couple of issues present that I didn't notice.
> > Thanks for checking.
> 
> Hope to see some improvements! git-remote-hg is really quite useful for
> me, and I hope it can be as good as possible!

Well, too bad Junio has essentially blocked all possible progress on his
tree.

I've pushed the fix on mine[1].

Cheers.

[1] https://github.com/felipec/git/commit/12374c0e09a84945a202bb5ba7981a223d233d0b

-- 
Felipe Contreras
