X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Print progress message to stderr, not stdout
Date: Mon, 4 Dec 2006 09:17:16 +0000
Message-ID: <b0943d9e0612040117y6554b891yaf6eb59d0d52ebf0@mail.gmail.com>
References: <20061111121625.8988.45195.stgit@localhost>
	 <e5bfff550612020520w3ad48a09xfdde63b9050a75cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 4 Dec 2006 09:17:22 +0000 (UTC)
Cc: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lDLOqSK+JeoamilPoVPjctPnlXac5LBhEzDf7Np6N/3K3QJVWMJRza2dKQqjDdo+6NT3mWOkj5Q3sqP7+Y3ExKrFsFSTLBEPELURCSr7xxifIxWBXUlFk6W9S3XtE7HF7NNXErLmSO47T3cn+w2iVWdQKzhbfG6TrZ/qUhT8zyE=
In-Reply-To: <e5bfff550612020520w3ad48a09xfdde63b9050a75cf@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33176>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gr9wu-00007g-E7 for gcvg-git@gmane.org; Mon, 04 Dec
 2006 10:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759859AbWLDJRS convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006 04:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759863AbWLDJRS
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 04:17:18 -0500
Received: from nz-out-0506.google.com ([64.233.162.235]:7644 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S1759859AbWLDJRR
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 04:17:17 -0500
Received: by nz-out-0102.google.com with SMTP id s1so1819223nze for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 01:17:16 -0800 (PST)
Received: by 10.65.43.5 with SMTP id v5mr11737891qbj.1165223836365; Mon, 04
 Dec 2006 01:17:16 -0800 (PST)
Received: by 10.65.133.7 with HTTP; Mon, 4 Dec 2006 01:17:16 -0800 (PST)
To: "Marco Costalba" <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org

On 02/12/06, Marco Costalba <mcostalba@gmail.com> wrote:
> On 11/11/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> > Printing progress messages to stdout causes them to get mixed up wi=
th
> > the actual output of the program. Using stderr is much better, sinc=
e
> > the user can then redirect the two components separately.
>
> This patch breaks qgit.
>
> GUI interface to stgit pop and push commands is broken because a
> command that prints to stderr is considered a failing one by qgit.
>
> I would kindly ask you to:
>
> 1 - Revert the patch. That would be the best. You can use a prefix to
> printed message instead, see git pull, something like 'stg: bla bla
> bla' . In any case, IMHO, using stderr for normal activity logging
> does not sound like a great idea in general.
>
> 2 - At least add a '-v' '--verbose' option that defaults to quiet so
> to not break back compatibility.

Since there are other tools relying on a clean stderr, I think I would
revert it and add a verbose flag and/or config option. Karl, any
thoughts on this (since you sent the patch)?

--=20
