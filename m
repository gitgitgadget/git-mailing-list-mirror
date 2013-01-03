From: =?ISO-8859-1?Q?Gr=E9gory_Pakosz?= <gpakosz@visionobjects.com>
Subject: Re: git filter-branch doesn't dereference annotated tags
Date: Thu, 3 Jan 2013 10:50:27 +0100
Message-ID: <CAC_01E2HXSnXBgDm=Cbwgi5PbiuHp_qPpoaqT_=pdDWDMnC5jA@mail.gmail.com>
References: <CAC_01E174m_6tDwPKZ5P0BUxnLNWUf9p+VkECFosPTzip0sYsA@mail.gmail.com>
 <7vsj6mdqeo.fsf@alter.siamese.dyndns.org> <CAC_01E3twtNq8YXQ8=SU5oXxmnAQS43L-46NF=7RyT4tFQvU5g@mail.gmail.com>
 <7vfw2kbs4h.fsf@alter.siamese.dyndns.org> <CAC_01E3VWtsFd8ww+7W8DMhRAs4WgHf=bm+xoh9wszCkb-DfUA@mail.gmail.com>
 <7vk3rwaa3r.fsf@alter.siamese.dyndns.org> <CAC_01E2iHgNvh5PnBh3TcNKr2pLazZwRojVK9ksaE3x0a1QHmQ@mail.gmail.com>
 <7v623f18ci.fsf@alter.siamese.dyndns.org> <50E55198.5080202@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Jan 03 10:51:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqhSP-0006Ku-JP
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 10:51:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753202Ab3ACJvC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 04:51:02 -0500
Received: from mail.elysmail.net ([188.165.34.231]:51329 "EHLO elysmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753169Ab3ACJvA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 04:51:00 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=visionobjects.com; s=vo2010objects;
        h=received:received:received:mime-version:received:in-reply-to
          :references:from:date:message-id:subject:to:cc:content-type
          :x-declude-sender:x-declude-spoolname:x-declude-refid
          :x-declude-note:x-declude-scan:x-declude-tests:x-country-chain
          :x-declude-code:x-helo:x-identity;
        b=Ul3m6kqWhHc7/vkYXjImyvbNi0DF5QSYgqBW8IfGGwUVK19rYB3N2Yz58V0m73zsu
          qO0ES8ho2hhg6SW1CZ+f4+pn9ppo9iIonhHu1AgFN8pFrWvCsz0NhIAFR1IgoXbM3
          ZXH/1ZAmfl9t6w3FqEcJ4AqXcbtUcati0Ols7GQD4=
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com [209.85.212.51]) by elysmail.net with SMTP;
   Thu, 3 Jan 2013 10:50:47 +0100
Received: by mail-vb0-f51.google.com with SMTP id fq11so14936107vbb.38
        for <git@vger.kernel.org>; Thu, 03 Jan 2013 01:50:47 -0800 (PST)
Received: by 10.58.248.41 with SMTP id yj9mr75197848vec.29.1357206647565; Thu,
 03 Jan 2013 01:50:47 -0800 (PST)
Received: by 10.52.65.233 with HTTP; Thu, 3 Jan 2013 01:50:27 -0800 (PST)
In-Reply-To: <50E55198.5080202@kdbg.org>
X-Declude-Sender: gpakosz@visionobjects.com [209.85.212.51]
X-Declude-Spoolname: 21173851.eml
X-Declude-RefID: 
X-Declude-Note: Scanned by Declude 4.10.59 "http://www.declude.com/x-note.htm"
X-Declude-Scan: Outgoing Score [0] at 10:50:48 on 03 Jan 2013
X-Declude-Tests: Whitelisted
X-Country-Chain: 
X-Declude-Code: 0
X-HELO: mail-vb0-f51.google.com
X-Identity: 209.85.212.51 |  | vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212577>

>
> IOW, if the command was something like
>
>   git filter-branch ...filter options... -- v1.0 master ...
>
> and v1.0 is an annotated tag, then it is reasonable to expect v1.0 to be
> deleted if the commit it points to goes away. But if the commit did not
> go away, but was rewritten, then it is equally reasonable to expect that
> the tag is also rewritten. But I don't think that we currently do the
> latter.
>
When the commit doesn't go away, the tag is currently being rewritten properly.

> Therefore, IMO, a change that implements the former behavior should also
> implement the latter behavior.
>
The patch in my latest email does both. (yet lacks unit tests for now)

Gregory
