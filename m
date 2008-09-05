From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git Gui does not want to work on chunk level
Date: Thu, 4 Sep 2008 22:20:26 -0700
Message-ID: <20080905052026.GB31166@spearce.org>
References: <c6c947f60808270216k2feb8f9ar765cdee1fc3910ee@mail.gmail.com> <c6c947f60809031223i575ca3fdya357588610bb72e8@mail.gmail.com> <20080903230814.GJ28315@spearce.org> <c6c947f60809040220t589e65bfkbd693fd335792069@mail.gmail.com> <20080904143723.GB23708@spearce.org> <c6c947f60809040754g34e60633lcd5f872ac5e80158@mail.gmail.com> <20080905045327.GA31166@spearce.org> <7v63pbyxu9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alexander Gladysh <agladysh@gmail.com>, git-users@googlegroups.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 07:21:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbTlF-0002iy-SO
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 07:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbYIEFU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 01:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbYIEFU1
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 01:20:27 -0400
Received: from george.spearce.org ([209.20.77.23]:50093 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbYIEFU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 01:20:26 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 3B44338353; Fri,  5 Sep 2008 05:20:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v63pbyxu9.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94991>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > git-gui was incorrectly parsing "--- foo" as the old file name
> > in the file header, causing it to generate a bad patch file when
> > the user tried to stage or unstage a hunk or the selected line.
> > We need to keep track of where we are in the parsing so that we do
> > not misread a deletion or addition record as part of the header.
> 
> While keeping track of state is obviously a good change, it also might be
> worth noticing "@@ -k,l +m,n @@" header and actively using the
> information.

Yea.  But that was a lot more work.

Noticing a hunk header, getting the line counts from it, then
keeping a running counter to know how many lines before either EOF
or the next header are all part of that hunk is just a lot of code
I didn't feel like writing this evening.  ;-)

-- 
Shawn.
