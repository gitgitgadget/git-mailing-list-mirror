X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Print progress message to stderr, not stdout
Date: Sat, 2 Dec 2006 14:20:07 +0100
Message-ID: <e5bfff550612020520w3ad48a09xfdde63b9050a75cf@mail.gmail.com>
References: <20061111121625.8988.45195.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 2 Dec 2006 13:20:18 +0000 (UTC)
Cc: "Catalin Marinas" <catalin.marinas@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cIi0CopIEHzPLJlPgRf925ZvQFU2bZz58+ZAQ+jbjoKOKybCgrEYJ7bSJfWzzhpOm1D7sOWchZt6+QzEAx3yNzsasMTnLrzvo2MJ2g68Y++z4nkCd+0i78U8uA2e9WJfZ1dDg1E6eFbFKvo+vJ1RCcM+z4M/zSXls5WhEWS+lms=
In-Reply-To: <20061111121625.8988.45195.stgit@localhost>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33023>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqUmr-0001Nl-WE for gcvg-git@gmane.org; Sat, 02 Dec
 2006 14:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423857AbWLBNUK convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006 08:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423859AbWLBNUK
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 08:20:10 -0500
Received: from nz-out-0506.google.com ([64.233.162.226]:9863 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S1423857AbWLBNUI
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006
 08:20:08 -0500
Received: by nz-out-0102.google.com with SMTP id s1so1674776nze for
 <git@vger.kernel.org>; Sat, 02 Dec 2006 05:20:07 -0800 (PST)
Received: by 10.35.41.14 with SMTP id t14mr10739530pyj.1165065607676; Sat, 02
 Dec 2006 05:20:07 -0800 (PST)
Received: by 10.35.42.4 with HTTP; Sat, 2 Dec 2006 05:20:07 -0800 (PST)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
Sender: git-owner@vger.kernel.org

On 11/11/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> Printing progress messages to stdout causes them to get mixed up with
> the actual output of the program. Using stderr is much better, since
> the user can then redirect the two components separately.
>

This patch breaks qgit.

GUI interface to stgit pop and push commands is broken because a
command that prints to stderr is considered a failing one by qgit.

I would kindly ask you to:

1 - Revert the patch. That would be the best. You can use a prefix to
printed message instead, see git pull, something like 'stg: bla bla
bla' . In any case, IMHO, using stderr for normal activity logging
does not sound like a great idea in general.

2 - At least add a '-v' '--verbose' option that defaults to quiet so
to not break back compatibility.


Thanks
Marco

P.S: I cannot change the stderr =3D=3D 'something has gone wrong'
behaviour because the interface to git commands works with this, and,
BTW, _all_ the git commands respect the behaviour stderr =3D=3D empty -=
>
