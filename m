From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 0/5] git help: group common commands by theme
Date: Fri, 15 May 2015 16:41:04 -0400
Message-ID: <CAPig+cTAMrQEfK81WWn3honj5yL5RjYvt13P63kZoZ+pQ1f98g@mail.gmail.com>
References: <1431714904-16599-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 15 22:41:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtMQC-0008Ts-QJ
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 22:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934813AbbEOUlG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2015 16:41:06 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:36820 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934627AbbEOUlF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 May 2015 16:41:05 -0400
Received: by iepk2 with SMTP id k2so129769852iep.3
        for <git@vger.kernel.org>; Fri, 15 May 2015 13:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=F4GWfrtn4A0DPYHnEhjhmNhYwdj/89ZRzQOvHTlRv6k=;
        b=pGnuAyUvVBy4smcY1URy1IKghOETh44kX2BIbPawKCAdtg4rwEtBgSRrSGjIKLKOgX
         jXoYceaFkE1ZxO8acQLTTVZKUlB+zuyu7OGwLEXawqIUUDRajycsVLO33IfoaHNnyIpN
         sbSDSpzXPJxi63i7uneV37nwszkQPWmwGJdJlZq3VbNmVYdt9HP8kNNOvxT9CG3Y77Ne
         JNRaBAk5W+yopXQTGQ+1g2k9ypLbIwkvaPjS6mwTCapasPciCu+pwFG7qmbSSrCnlJ35
         RlMkba96w7QbL2ZTvYu9Zmp0DIu5PGWzk5UEtY1is6vAi1QphPvVmAWHyuK+zrrXJp73
         B2rQ==
X-Received: by 10.107.151.75 with SMTP id z72mr11697275iod.46.1431722465027;
 Fri, 15 May 2015 13:41:05 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 15 May 2015 13:41:04 -0700 (PDT)
In-Reply-To: <1431714904-16599-1-git-send-email-sebastien.guimmara@gmail.com>
X-Google-Sender-Auth: PAIiEhS7M4ZXHhUOKhZlYKeQkYQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269180>

On Fri, May 15, 2015 at 2:34 PM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> This v7 is very similar in content to the v5 [1], except minor format=
ting
> adjustments in 'git help' output and recommendations from Eric.
>
> rebased on 'next' (a2776d4)

Something to keep in mind for the future: It's usually easier to
manage preparatory cleanup patches by incorporating them into the
series which needs/wants them rather than posting them as separate
topics. That way, your patch series isn't held hostage by those
separate topics. For instance, if your "whitespace fix" cleanup patch,
bf990a2 (command-list.txt: fix whitespace inconsistency, 2015-05-08),
which is already in 'next', had been an early patch in the current
series (say patch 1/6), then you wouldn't have had to base this series
on 'next'.

> The major change is in the patch series itself. Commits have been
> reordered and adjusted so that each 'apply' doesn't break the build, =
and
> preserve bisectability.

Thanks, the patch organization of this version (v7) looks much better
than that of v5.

> Summary: make 'git help' outputs a more usable and friendlier
> list of commands, grouped by theme according to the typical Git workf=
low:
>
> The typical Git workflow includes:
>
> start a working area (see also: git help tutorial):
>    clone      Clone a repository into a new directory
>    init       Create an empty Git repository or reinitialize an exist=
ing one
>
> work on the current change (see also: git help everyday):
>    add        Add file contents to the index
>    mv         Move or rename a file, a directory, or a symlink
>    reset      Reset current HEAD to the specified state
>    rm         Remove files from the working tree and from the index

Nice. This looks better with the extra indentation dropped[1], and it
once again fits my 80-column terminal window.

One minor bike-shedding observation: The colon ":" at the end of the
group headings seems unnecessary and a bit redundant with the colon at
the end of "The typical Git workflow includes:". I think the group
headings would read just as well (or a bit better) without the
trailing colon, but I don't care strongly.

[1]: http://article.gmane.org/gmane.comp.version-control.git/268759
