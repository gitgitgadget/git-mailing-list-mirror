From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor 
	with no changes written
Date: Tue, 2 Feb 2010 16:18:06 -0500
Message-ID: <32541b131002021318q4e25967dp8ed001b0fb92b2ae@mail.gmail.com>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com> 
	<8c9a061002021214j673afbc8vfa5d941fba518648@mail.gmail.com> 
	<32541b131002021227o1ec9f369w6096e85382857b8a@mail.gmail.com> 
	<76c5b8581002021247j6df8f609ld9e5d87a060a5423@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 22:18:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcQ8m-0001YB-1y
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 22:18:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756325Ab0BBVS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 16:18:27 -0500
Received: from mail-yw0-f198.google.com ([209.85.211.198]:59665 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756045Ab0BBVS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 16:18:27 -0500
Received: by ywh36 with SMTP id 36so580075ywh.15
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 13:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=mCZEnr59nzkhMrZafL9s18DLGQh/izjJBcE6d007iCE=;
        b=pWg31F+peaaNY2gsvYIEH/FbWJ1IkQMKJybXFVBrX4v+x08tS2Uy/mGkxdBzwe62yo
         K8Dj82QE09Hno8LkKjxpazrDkVuzZ4JYTWl3UOOV9or7KmFWer//74hoSa14YIE7FxJ9
         e07BUgmQ7RUSNdHkB8D85IaBTR2rxDc2NuaLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=fPKdRzEkLCNs3ijp40G1/yMRcbTs4xIV52EAnItEVNjac+su+0shzxGtx1H1Qxj+ms
         tEiPOTvbKSNWn48JDHG4l9JNc49CtmJ1lE9incIJzKw8SJIZCM47p1IQGGwg3LkBuele
         DlgWOOpaPzJgtiIW+/5yPfAgwtzUDzx3vt2hE=
Received: by 10.150.213.18 with SMTP id l18mr6530739ybg.157.1265145506163; 
	Tue, 02 Feb 2010 13:18:26 -0800 (PST)
In-Reply-To: <76c5b8581002021247j6df8f609ld9e5d87a060a5423@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138757>

On Tue, Feb 2, 2010 at 3:47 PM, Eugene Sajine <euguess@gmail.com> wrote:
> If you're just exiting the vi using :q without writing changes it will
> perform rebase! I'm 100% sure it is not OK.
>
> So, it seems that it will do that every time it has some
> *prepopulated* message in the editor, so it doesn't understand when
> changes are written and when they are not.
>
> I believe all those actions should be treated exactly the same way as
> the commit itself. If I'm writing/saving changes - it is good to go.
> If not - abort.

It might be sort of neat to check the mtime of the commit message file
before and after launching the editor; then if you want, you could
force-save the file even without any changes, and git would know that
you want it changed.

Not sure I would like that behaviour better than the current way,
actually, but it's an idea.

Avery
