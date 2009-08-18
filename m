From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] block-sha1: Windows declares ntohl() in winsock2.h
Date: Tue, 18 Aug 2009 18:59:18 +0200
Message-ID: <bdca99240908180959h69f37671k4d526fbf4814e8d1@mail.gmail.com>
References: <4A8A552D.6020407@viscovery.net> <4A8A8661.5060908@gmail.com>
	 <4A8AA511.1060205@gmail.com>
	 <bdca99240908180617n75dfd0b5nfe069aba6e74b722@mail.gmail.com>
	 <7v4os5gs0p.fsf@alter.siamese.dyndns.org>
	 <alpine.LFD.2.00.0908181147510.6044@xanadu.home>
	 <alpine.LFD.2.00.0908181240400.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Artur Skawina <art.08.09@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	msysGit <msysgit@googlegroups.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Aug 18 18:59:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdS2F-00058S-0o
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 18:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759069AbZHRQ7T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Aug 2009 12:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754287AbZHRQ7T
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 12:59:19 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:36438 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbZHRQ7S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Aug 2009 12:59:18 -0400
Received: by bwz22 with SMTP id 22so3150779bwz.18
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 09:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EnUdQSReA+XUPZm5q2LI3U1jQazsGLbwzjMiaC2163k=;
        b=h57bGvGhpHAUgPtGcjPhIP3LftxKx9V7OLrk2KWVF6XM9e1lEkhJwKudpKUUzWlqRL
         QCzftSgsKQFW9jOQeIPHZwHMBprwu4Z1cE8mhTRxts9yubv6t7UsCgp2Ysaelb2Ulgu/
         PuznoFda2qmbFrU16B/vvpQGuV4XbGmNbtTUk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YVZlG+BqELzM9gAqrCTu5rBHW2PMmbtsXFNs+pSL4zz9FM24bpZZ5vz4tpnZ3gXMmU
         gK/LDLUSqRLYVtQyp7hhEsAtez2aMxqfCk/yy0H5YJKngBNoLmXQvXOYlTSjmeXNL3ro
         VIMC8qe11jri0eoVrFqGyUXHHk/vJ99RRkw1E=
Received: by 10.204.7.156 with SMTP id d28mr3955884bkd.140.1250614758646; Tue, 
	18 Aug 2009 09:59:18 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0908181240400.6044@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126420>

On Tue, Aug 18, 2009 at 18:43, Nicolas Pitre<nico@cam.org> wrote:

>> Well... =C2=A0Given that git already uses ntohl/htonl quite extensiv=
ely in
>> its core already, I'd suggest making this more globally available
>> instead.
>
> What about something like this?

I like the idea of making bswap available more globally, but I'm not
sure if it's worth to introduce a new file for only that purpose.
Isn't there already a central header for such things?

Moreover, including compat/bswap.h would only give you ntohl()/htonl()
on one platform. For consistency, I'd expect to get those for any
platform if I include compat/bswap.h, but maybe I'm not aware of some
Git source code rules.

=46inally, there's a typo in your comment saying "sinple" instead of "s=
imple".

--=20
Sebastian Schuberth
