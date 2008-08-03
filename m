From: "Lee Marlow" <lee.marlow@gmail.com>
Subject: Re: [PATCH] bash completion: Add completion for 'git grep'
Date: Sun, 3 Aug 2008 01:31:13 -0600
Message-ID: <7968d7490808030031v39726af6r9f88feb28df02de7@mail.gmail.com>
References: <1217638593-57321-1-git-send-email-lee.marlow@gmail.com>
	 <20080802210525.GD24723@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Aug 03 09:32:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPY4e-00086N-7X
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 09:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbYHCHbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 03:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752493AbYHCHbP
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 03:31:15 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:25269 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407AbYHCHbO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 03:31:14 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1674906rvb.1
        for <git@vger.kernel.org>; Sun, 03 Aug 2008 00:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=XFueezNf0qd0FpgAHnhRs6wfWAQQ703j1WcDJsOjVxQ=;
        b=dOaloFsgIg8O95nTib7B6wZig4lJRgdc/0pbRpJu1JuAnQY0C/35JQhvm3azGojwcR
         Tnto7FKA5q7Lgjg4QdOqfZNDeFQGWHweigDFRgMiTu7DzFzSGIkLYH2JfL1FNebzuDER
         15wws2v98nGHx15GqP6Mrbj+XTrdVy4NeJVhM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=V1sGZWzdxxUddNrP4PE43DigOGRBGRiEqu/p3f/1xjwtPnBApJJsnaFSP2egkGpJLo
         mOPsV4qo45skN7WNDXHQF/3UCKccpKr3pSrS7QSGpYDHjYymHbRigc3aa2cIm15Y/PDH
         PsLX4KfwhUHEGexgKrT+IfNg81IJArxYpkmhs=
Received: by 10.141.161.6 with SMTP id n6mr6903875rvo.41.1217748673990;
        Sun, 03 Aug 2008 00:31:13 -0700 (PDT)
Received: by 10.141.69.4 with HTTP; Sun, 3 Aug 2008 00:31:13 -0700 (PDT)
In-Reply-To: <20080802210525.GD24723@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91213>

On Sat, Aug 2, 2008 at 3:05 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
>
> Hmm.  The has_doubledash test seems redundant since we don't do
> anything with args that aren't --foo.  Even though git-grep will
> accept a tree-ish and thus completion of __git_refs here may
> make sense.
>
> But that is very much a user question.  Do users mostly search a
> file in the current working directory, or do they mostly search
> a tree-ish?

I haven't found myself using grep to search anything but the current
working directory.  I wonder whether __git_complete_file would be
better than __git_refs.  My issue with __git_complete_file in this
case and also doing completion for 'git mv' is that it falls back to
just __git_refs.  Would it be better if it fell back to __git_refs and
ls-tree for HEAD?  That way when using completion to get to
Documentation/git-grep.txt,  it doesn't also show completions for
Documentation/git-grep.{1,html,xml}.

-Lee
