From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: git fetch documentation problem or bug
Date: Sun, 21 Oct 2012 08:15:41 -0400
Message-ID: <CAM9Z-nnKTq0C9wPA=JKZ3qzTmL3NVisfy=rbjjq1yKEVrN53FQ@mail.gmail.com>
References: <CAB9Jk9Ac06sfFMGizRq6Ztqd2tKS7BBqGOC891=z4615J3f4hA@mail.gmail.com>
	<7vfw5olqp9.fsf@alter.siamese.dyndns.org>
	<7vbogclqm6.fsf@alter.siamese.dyndns.org>
	<7vpq4silou.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 21 14:15:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPuRe-0007mv-U5
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 14:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055Ab2JUMPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 08:15:44 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:34213 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713Ab2JUMPn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 08:15:43 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so690177bkc.19
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 05:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MC1yFSZbB0HDILElna8SEexxGRjbzAlXNLDo6lj+aks=;
        b=CRIy7G/eRPvBDBd8cPZLYsM4XC16qxV28y0xEwCXRbx9Vc1Loz5VX2l5tQCS5tW9tA
         vuoylHa5HGKhewRgm9lSGJYdtnhvNZzN44yUebRDzdo4jxgdSe/eySeO6T3dpsT4TQCO
         ajvTuLpTkPviUTfOHV7+Ey02kQSmI6Lj6Xkf/KckS4V1zWSbZ5qM/odsZWuOk4jsORqP
         caqFYHtWnrYjPya8Pu/+2q7NvMv5h2he0R1zo7mgsNr2EdQuCDfq2B+Laez3OjYKrvsE
         Beg5otq+BVYO/L/yRvcd3ZUAH7jtIXbp53WvYtEi+UShIplhwX9i1e6W62Hegvjrv7OK
         kazg==
Received: by 10.204.5.151 with SMTP id 23mr1894448bkv.3.1350821741955; Sun, 21
 Oct 2012 05:15:41 -0700 (PDT)
Received: by 10.205.122.144 with HTTP; Sun, 21 Oct 2012 05:15:41 -0700 (PDT)
In-Reply-To: <7vpq4silou.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208122>

On Mon, Oct 8, 2012 at 7:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> In other words, you can do this from the command line if you want
>> to do the update.
>>
>>   $ git fetch origin master:refs/remotes/origin/master
>
> Now having said all that, we should probably revisit this and
> possibly other issues and for the ones we can reach concensus, start
> coding after 1.8.0 final.

>  * "git fetch $from $branch..." to update tracking branches
>
>    This is the topic in this thread.
>
> I personally do not think the downside of breaking backward
> compatibility is too bad.  If we do this only when we already are
> configured to keep remote tracking branch for branch $branch from
> remote $from (it has to be given as a nickname, not URL that happens
> to have an entry in the configuration), then a promiscuous fetch
> that grabs from a URL (or a nickname that is configured not to keep
> tracking branches) will not change any behaviour, and when you want
> to keep your remote tracking branch intact while doing one-shot
> fetch for whatever reason, you can say "git fetch $from $branch:" to
> explicitly decline copying.

How are we supposed to remember those are different?

"git fetch $from $branch..."
VS
"git fetch $from $branch:"

I strongly prefer EXPLICITLY setting tracking than expecting some
extreme syntactic nuance to quietly do it for me now and confuse the
heck out of me later.

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
