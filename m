From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: call external editor from git-gui?
Date: Thu, 16 Aug 2007 08:59:41 +0100
Message-ID: <e2b179460708160059x90b0187g30f50784fbe6ac87@mail.gmail.com>
References: <20070810153008.GA31759@diana.vm.bytemark.co.uk>
	 <20070814045511.GF27913@spearce.org>
	 <20070814070000.GA12052@diana.vm.bytemark.co.uk>
	 <20070815182228.GA3419@efreet.light.src>
	 <86ir7g4p92.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 16 09:59:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILaGg-0004Am-Tb
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 09:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757621AbXHPH7o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 03:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757124AbXHPH7o
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 03:59:44 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:39940 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754685AbXHPH7n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 03:59:43 -0400
Received: by wr-out-0506.google.com with SMTP id 36so128470wra
        for <git@vger.kernel.org>; Thu, 16 Aug 2007 00:59:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lu5kpNVmGx6cIWyb1LRs6nGO0pHkWxH3KJhiVWI5WaTaNCR15Hv/VCVJOz6l1hW7sh4JL68pTmyN/aNEbexxxNMQ0fSKhYltyV3lQ4CB9sJU0/yfSFVCgBlj4MzQjZtx69ermYc+dZPfFddKZNX2bzvPK2AwbxYeC3Liqb/4F80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nfY8ls7DQAP3Mo3U0w9cja/tdgWG7fqd/D+njC6QKufTEVfVLQ+QxtrhamVzc01aa0cFMt7XM7lYqM1OqZtmmnoUPMDDynu/QmNwDWdmmWqlXZF2KV4rGut62x5Qbi4YvXjb5sJZIdvL3rzOAaGguO61oNFZocz48HfN+cvUSxc=
Received: by 10.90.80.8 with SMTP id d8mr1956407agb.1187251181726;
        Thu, 16 Aug 2007 00:59:41 -0700 (PDT)
Received: by 10.90.51.10 with HTTP; Thu, 16 Aug 2007 00:59:41 -0700 (PDT)
In-Reply-To: <86ir7g4p92.fsf@lola.quinscape.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55983>

It seems quite common to have a trio of environment variables:
$EDITOR, $VISUAL and $XEDITOR, for line, tty-aware and graphical
editors respectively.

[http://xdvi.sourceforge.net/inverse-search-emacs-noauctex.html]
[http://lists.osuosl.org/pipermail/darcs-users/2006-December/010783.html]

Whether git needs to have a trio of overrides for them is a different
matter, or could just recommend that git be aliased or wrapped if the
editors needed for git are different to normal.

Cheers, Mike

On 8/15/07, David Kastrup <dak@gnu.org> wrote:
> The usual convention (though _very_ hard to find anywhere explicitly,
> so it might more often than not be ignored) is that $VISUAL points to
> an editor that requires a tty to work on, while $EDITOR might get
> along without one.
>
> So one uses VISUAL in preference of EDITOR on ttys/proper terminals,
> but only EDITOR when without one.  A call from git-gui would probably
> fall in the second category.  A call from tig, in contrast, in the
> first category.
>
> The GIT_EDITOR variable has no way of expressing this difference,
> though.  And I doubt that many people remember this.  I googled around
> but failed to come up with a useful reference (of course, both
> variable names being common words does not exactly help).
