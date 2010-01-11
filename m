From: Leo Razoumov <slonik.az@gmail.com>
Subject: Re: How to check new commit availability without full fetch?
Date: Mon, 11 Jan 2010 12:35:35 -0500
Message-ID: <ee2a733e1001110935h101e7ec9l1b4fcf2bf210f53f@mail.gmail.com>
References: <ee2a733e1001100312j786108fct1b4c8abd0acc5afc@mail.gmail.com>
	 <alpine.LFD.2.00.1001101501520.10143@xanadu.home>
	 <7v8wc5itlc.fsf@alter.siamese.dyndns.org>
	 <alpine.LFD.2.00.1001101556490.10143@xanadu.home>
	 <ee2a733e1001101736p2f395de6ka05044fe7cca624d@mail.gmail.com>
	 <alpine.LFD.2.00.1001102055070.10143@xanadu.home>
	 <ee2a733e1001110822t1b04c1ccg9b6eb5489b69783d@mail.gmail.com>
	 <alpine.LFD.2.00.1001111149150.10143@xanadu.home>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 18:35:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUOB5-0006h9-17
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 18:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140Ab0AKRfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 12:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753079Ab0AKRfj
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 12:35:39 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:7968 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037Ab0AKRfi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 12:35:38 -0500
Received: by ey-out-2122.google.com with SMTP id 22so1897864eye.19
        for <git@vger.kernel.org>; Mon, 11 Jan 2010 09:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=84aO/TFgmZvD6O09a47qkA5o8ZRpWtQigvDCHymVXKw=;
        b=eLEUQU4Bk72qUqlqvfpRVnUVNue1Qx51aX9AdM/+zAW52boIKuNGIU9wa+zhOpNeRK
         7x0OqDC1i7+Sl/3I/RM6WfFWBF17NC8iDKLt5/j8F1AHaOKdFsVvOnlKWiHU7sxDKHut
         YhwdrgDkLVHit7yYWJKwxkhH+TL/qu4aBBmvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        b=ub752k+M/NrEs83LGATMvCMAnIRms2y26q10s5bC5Iy8b1ufhCjTQirZsP/j2A30hr
         0LEe286nlUisrHV9I75gHjxs8NDlalfshnQd7VynZp5jsVb/wAWgK3+UfHqkXveEmJeu
         Ms08yhYvMKfUO1dO+wb3dHPHprrMBTp7cbwvM=
Received: by 10.216.86.83 with SMTP id v61mr7180009wee.80.1263231336655; Mon, 
	11 Jan 2010 09:35:36 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1001111149150.10143@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136646>

On 2010-01-11, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Mon, 11 Jan 2010, Leo Razoumov wrote:
>
>  > On 2010-01-10, Nicolas Pitre <nico@fluxnic.net> wrote:
>  > >
>  > > You still don't answer my question though.  Again, _why_ do you need to
>  > >  know about remote commit availability without fetching them?
>  > >
>  >
>  > I use git to track almost all my data (code and otherwise) and spread
>  > it between several computers. I end up with several local repos having
>  > the same local branches. It happens once in a while that I fetch into
>  > a given remote/foo from several local foo branches from different
>  > machines and the operation fails. It happens because the commits have
>  > not been yet consistently distributed among the repos. To do the
>  > forensics and figure out who should update whom first I need a quick
>  > and non-destructive way to fetch dry-run.
>
>
> There is probably something awkward about your setup then.
>
>  Normally you should have a remote description for any of the remote
>  repositories you fetch from.  So if you have, say, remote machine_a with
>  repo foo, machine_b with repo bar, and machine_c with repo baz, then
>  fetching any of those will _only_ mirror locally the state of those
>  remote repositories.  There is no ordering required as there can't be
>  any conflicts in the mere fact of mirroring what the other guys have.
>  That's what remote tracking branches are for: they follow the state of a
>  remote repository and are never altered by local changes.  And you can
>  have as many of those as you wish and they will never conflict with each
>  other as each remote description is independent. And this is true
>  whether or not the remote repository lives on the same machine (that
>  would be a remote directory in that case).
>

Setup might be, indeed, awkward but it handles very diverse tasks.
As I said in my earlier emails different repos fetch into the *same* remote/foo.
So there could be conflicts and using fetch -f could cause loss of data.

Before switching to git I used mercurial for the same purpose and it
has command that are equivalent to fetch --dry-run.

--Leo--
