From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: intended use of "git --exec-path"?
Date: Wed, 24 Oct 2007 15:54:52 +1000
Message-ID: <ee77f5c20710232254j32afa044t841b4a4f6fcdfd7d@mail.gmail.com>
References: <20071024043224.GR16291@srparish.net>
	 <20071024043819.GI14735@spearce.org>
	 <20071024054749.GT16291@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Scott Parish" <sRp@srparish.net>
X-From: git-owner@vger.kernel.org Wed Oct 24 07:55:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkZCv-0004Y5-JN
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 07:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755011AbXJXFyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 01:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754839AbXJXFyy
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 01:54:54 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:37590 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366AbXJXFyx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 01:54:53 -0400
Received: by rv-out-0910.google.com with SMTP id k20so82610rvb
        for <git@vger.kernel.org>; Tue, 23 Oct 2007 22:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=bVPkSuBayGkH/ooBASkeMg59pctPsTA27d5KcJxmmnk=;
        b=qI5egiOPH3Vm0dRffGjUXvU3EOACsZr7gXxQH1SK4htuejalvbXDnlSNK3jiVkb0ccxcXDtHF5nC3BNADkbB/jrMTAGrGhLI6VM0Ik/GvsXU+W80Eca/fUZycuYa+YhD2NeGEUxd0mTFi8GkOx3RlZHXHAo8yXtUOYB2o4Kul/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pc2DhBy4A+vNS3yZicAr+hRNCIF9I4b6NVaa7nwFGtw8M/pGGJMHSm3dsPP6d/Dx5JZTE2vE0h+lbRceTiknb6eWuSLAB/uOTt692ZqjwTVKbFNS5kvxvdTZkWwQ1Fw+LLqyYCvWWbva/da6cgmLMgop4Q0QdGoZzOJzjgF/XTo=
Received: by 10.141.19.16 with SMTP id w16mr86045rvi.1193205292829;
        Tue, 23 Oct 2007 22:54:52 -0700 (PDT)
Received: by 10.141.115.4 with HTTP; Tue, 23 Oct 2007 22:54:52 -0700 (PDT)
In-Reply-To: <20071024054749.GT16291@srparish.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62194>

On 10/24/07, Scott Parish <sRp@srparish.net> wrote:
> On Wed, Oct 24, 2007 at 12:38:19AM -0400, Shawn O. Pearce wrote:
>
> > Scott Parish <sRp@srparish.net> wrote:
> > > "git --exec-path" presently prints out the highest priority path
> > > to find executable in. That's a what; i'm curious why and when it
> > > should be used. Basically i'm wondering if its still useful, and
> > > what, if anything, it should be printing.
> >
> > git-gui uses it.  git-gui runs git-* by prefixing it with the
> > exec path.  It also scans the first line of the file if we are on
> > Windows and the "executable" doesn't end in ".exe" so it can figure
> > out what process to run it through.
> >
> > So it really can't go away.
>
> So it sounds like it might be more helpful for git to return its
> PATH, so other programs can set their PATH or search for executables
> accordingly.

You don't necessarily want to be monkeying around with $PATH if you're
trying to use a particular git installation (say, a build of next)
instead of your "proper" install, which is in your $PATH; if you call
/some/random/path/git-whatever, it should use the git tools in
/some/random/path/, not in $PATH.


Dave.
