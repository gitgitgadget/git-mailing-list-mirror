From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/6] worktree: stop supporting moving worktrees manually
Date: Mon, 18 Jan 2016 13:24:40 -0500
Message-ID: <CAPig+cThX3vj8KOLf9CB6bqp-stDrwWs_mddW68YkAVrjzhA+Q@mail.gmail.com>
References: <1453116094-4987-1-git-send-email-pclouds@gmail.com>
	<1453116094-4987-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 19:24:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLETu-0004Hj-Vn
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 19:24:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756179AbcARSYn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jan 2016 13:24:43 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36662 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755161AbcARSYl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jan 2016 13:24:41 -0500
Received: by mail-vk0-f66.google.com with SMTP id e64so9564232vkg.3
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 10:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=oiedCjSl3XviebJ1ws15hKjBhCjql2uXOYy7y+QK1Tk=;
        b=VCff61D8lsJ2iTbsmt5m/R1O1ujX49cFf1foVvrddaQcciLrBIbAv/sq2HFcPjFV4H
         m8Td++gG0iz1PDL/pB2Vjf9P1j1N6vWv4vagUNR6gwBAK3Hmnr5hil6F8M3+ocOVB2wp
         BDGUnDSKbC7qnDEjzMWlSHPhBrYR4gWnaHydcYpzbRctegp6hJU2K8eFyQqjxcaQ6Hpq
         dpVdaEgADk8KBV+v7718zEhQTU1xfOhd1XzXbWrIDzjwD/5FtWLtla8RKqqRI/OyL7bK
         kDvDH8Q30ji/5NXNeIFrV2t7x29Eaf4jfWxRPR+sXhMNZ+v3oXu9e5EOay3q6dd3UKZQ
         CCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oiedCjSl3XviebJ1ws15hKjBhCjql2uXOYy7y+QK1Tk=;
        b=PHfazEvlnXWUFp1IWFJTesybqAkuIi+bcsmoiXHD7LIIQSDq6v1D6HL8HRJv973G+1
         hYLphzgtX7yGAeEj3PQ0lYNPkbQH1XR1olM5EPDDH+4A88Xu7M+Kg0hzVoi4+k4iPkJF
         BCPCgmGjpBxzOBJI11jqdvubliOunsv3mfJbPyejE6jLsHiUeGTn8rodsI1hkpQYonze
         TE36AKZau+J4y48n8iGegvSAJConBW8KiZgvNUiDatSNYwOiAc7ZwZGbLb9RKH40FG2L
         K+H6phnSmUtTmY1G+ydGBQunA3oWDssFtnOs+RAhVfJ/a848APm1En/I+CapyzNI3IeA
         kB/w==
X-Gm-Message-State: ALoCoQmEie/1fCVMjI0lYAJo/PZY/pDkc0Q90yg/flR/B79s11cLgYkKtQ8BINbugpwzRxZW79WSJ+YAgwvJi476Y/A2J1tMzg==
X-Received: by 10.31.141.2 with SMTP id p2mr17848145vkd.37.1453141480840; Mon,
 18 Jan 2016 10:24:40 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 18 Jan 2016 10:24:40 -0800 (PST)
In-Reply-To: <1453116094-4987-3-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 3914eRmswFOKgkk48__K2HyfP3g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284302>

On Mon, Jan 18, 2016 at 6:21 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> The current update_linked_gitdir() has a bug that can create "gitdir"
> file in non-multi-worktree setup. Worse, sometimes it can write relat=
ive
> path to "gitdir" file, which will not work (e.g. "git worktree list"
> will display the worktree's location incorrectly)
>
> Instead of fixing this, we step back a bit. The original design was
> probably not well thought out. For now, if the user manually moves a
> worktree, they have to fix up "gitdir" file manually or the worktree
> will get pruned.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-workt=
ree.txt
> @@ -33,10 +33,8 @@ The working tree's administrative files in the rep=
ository (see
>  If you move a linked working tree to another file system, or
> -within a file system that does not support hard links, you need to r=
un
> -at least one git command inside the linked working tree
> -(e.g. `git status`) in order to update its administrative files in t=
he
> -repository so that they do not get automatically pruned.
> +within a file system that does not support hard links, you need to u=
pdate
> +$GIT_DIR/worktrees/<id>/gitdir so that they do not get automatically=
 pruned.

It seems kind of sad to change this text in this patch and then
immediately change it again in the next patch. You could instead
combine the two patches (and add a "Helped-by: Eric" if you want to
credit me).
