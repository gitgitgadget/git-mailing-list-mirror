From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] status: hint the user about -uno if read_directory takes
 too long
Date: Fri, 15 Mar 2013 21:27:50 +0530
Message-ID: <CALkWK0kaAVE=sH+iMgm8cVid5wLCpvkN7GJMfKh3O60OBaFOiw@mail.gmail.com>
References: <CACsJy8DZm153Tu_3GTOnxF8bFrYPh7_DP6Rn6rr3n6tfuVuv2Q@mail.gmail.com>
 <1363179556-4144-1-git-send-email-pclouds@gmail.com> <7vehfj46mu.fsf@alter.siamese.dyndns.org>
 <CACsJy8BixM-9bPB3G_WO+W3cTHBFxLQ=YCU2NDEzHmCYW73ZPQ@mail.gmail.com>
 <7vmwu6yqbd.fsf@alter.siamese.dyndns.org> <CACsJy8BruzR=EGnwA5nc_aCJ5pO4FHyQKxd-9_36U48Ci_FFew@mail.gmail.com>
 <514343BA.3030405@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, robert.allan.zeh@gmail.com, finnag@pvv.org
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 15 16:58:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGX1j-0001Ob-B4
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 16:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754549Ab3COP6M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 11:58:12 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:59637 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754091Ab3COP6L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Mar 2013 11:58:11 -0400
Received: by mail-ie0-f177.google.com with SMTP id 16so4414625iea.8
        for <git@vger.kernel.org>; Fri, 15 Mar 2013 08:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=ZfRnKgSc6BoU5yrVETzN/H2pK8yLF9rOUKt2cc1z1Is=;
        b=PT0saoD4Uj2edFfWnAsjK9m7udxGY1yW8MEBKMVs4MsVKr5YWhXDFm3N0zpj80543Y
         eqKkQlxYL2/+qfbSzo44dccydlasHiEcxW1Ceur7g6tmSAtlbTEkgEIv4K3IUm7sn9yH
         9MOWfvHikDGwV/STyTe6mo5VCWf4njewR7sjcLWY3Uz+Zl3jRwESw0C7ZzkpMmvT5P45
         SzEqxxj+GdtwB08B4ikRsb0eUW9VFNkDv5H2S5UGtxfQPnrrWstwwT75AbVc9AuhGR1B
         dHC+00nUjx0LPnOyXc6mf037LwEx+25O9qgXuolzxawliSWwv/8enrIQsFZkEbfCPHku
         YZ/Q==
X-Received: by 10.50.41.200 with SMTP id h8mr1526793igl.14.1363363090749; Fri,
 15 Mar 2013 08:58:10 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Fri, 15 Mar 2013 08:57:50 -0700 (PDT)
In-Reply-To: <514343BA.3030405@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218247>

Torsten B=C3=B6gershausen wrote:
> [PATCH] git status: Document that git status -uno is faster

Yes.  I like this patch.

> In some repostories users expere that "git status" command takes long=
 time.
> The command spends some time searching the file system for untracked =
files.
> Document that searching for untracked file may take some time, and do=
cuemnt
> the option -uno better.

Please correct the typos in the commit message.

> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  Documentation/git-status.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/git-status.txt b/Documentation/git-status.=
txt
> index 0412c40..fd36bbd 100644
> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -58,6 +58,13 @@ The possible options are:
>  The default can be changed using the status.showUntrackedFiles
>  configuration variable documented in linkgit:git-config[1].
>
> ++
> +Note: Searching the file system for untracked files may take some ti=
me.
> +git status -uno is faster than git status -uall.
> +There is a trade-off around the use of -uno between safety and perfo=
rmance.
> +The default is not to use -uno so that you will not forget to add a =
file
> you newly created (i.e safety).
> +You would pay for the safety with the cost to find such untracked fi=
les
> (i.e. performance).

Good writeup.  What -uno does is already documented, so you've
explained the trade-off.
Why didn't you just wrap the paragraph to 80 columns though?
