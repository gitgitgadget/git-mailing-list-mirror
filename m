From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] Make 'remote show' distinguish between merged and rebased 
	remote branches
Date: Tue, 10 Feb 2009 18:13:52 -0500
Message-ID: <76718490902101513i504e515ocb4a2d789ba520f0@mail.gmail.com>
References: <20090210202046.8EBEC3360AC@rincewind>
	 <7v3aemm1po.fsf@gitster.siamese.dyndns.org>
	 <4991FA18.1040200@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 00:15:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX1p4-0001lC-4g
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 00:15:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756446AbZBJXNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 18:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756379AbZBJXNy
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 18:13:54 -0500
Received: from rv-out-0506.google.com ([209.85.198.224]:2704 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756101AbZBJXNx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 18:13:53 -0500
Received: by rv-out-0506.google.com with SMTP id g9so2076840rvb.5
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 15:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fHyeWwlZ2Qqi3xRDWeBljXojA550y/y8oNQLgGiB09g=;
        b=SHKS29Hy840XR3epfPr4hCqSA+QkbY2iLAV7Z4JQQ9vKmnVPAArsKY5NhPNCYKxUbQ
         43BNwmMPyLlFjzu+8yKres1oF9EV5+U9EOix0yBBaUqUZSzzPRVO8pj/OUugUVFlqJk2
         5S3qFhdIHfh+4xmD7sjL6LSnZiIhKh3mhinrk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IdP6fwJGCnOT/xoh1EBCr611AUBkIoQKvq2GTDP9NKBou5bIua2Gn4zVd59/4xbJOs
         maW/bSwrMeVUPk2QrFrDEYjJr35aeJUGA1STcpNy+BfLK2tukXa0yiI8T5d1HlTe06Qr
         bOgziFCG0nN4duAW2p3LFYwnRAmXrTfRXPqvk=
Received: by 10.141.153.16 with SMTP id f16mr2470906rvo.1.1234307632940; Tue, 
	10 Feb 2009 15:13:52 -0800 (PST)
In-Reply-To: <4991FA18.1040200@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109339>

On Tue, Feb 10, 2009 at 5:05 PM, Marc Branchaud <marcnarc@xiplink.com> wrote:
> I'm happy to use more accurate phrasing -- I was just going for a minimal change.
>
> How about the following, consistent for both cases:
>
> 'git pull' merges branch master with remote branch
>  master
> 'git pull' rebases branch rebaser on top of remote branch
>  side
>
> ?
>
> I like the above because the keywords & branch names are in consistent locations, making it easier to parse the output.

The output of git remote show seems much too verbose for the
information it provides. Something like this, I think, provides the
same information in much less space:

* remote origin
  URL: git://git.kernel.org/pub/scm/git/git.git
  Remote branches:
    html      Not tracked
    maint     Tracked
    man       Tracked
    master    Tracked
    next      Tracked
    pu        Tracked
    todo      Not tracked
    old-next  Stale (would prune)
  Local branches configured to pull from this remote:
    master           upstream is master (merges)
    wip/remote-HEAD  upstream is next   (rebases)

When run with "-n" the status column would be blank or say "Status not
available with -n".

$0.02. :-)

j.
