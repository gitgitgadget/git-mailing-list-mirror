From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/5] worktree.c: add find_worktree_by_path()
Date: Sun, 22 May 2016 21:41:11 -0400
Message-ID: <CAPig+cQTWK_yR4hCdMDj35Rwx6tAUXdfzrOkALJU3j6qCBxoew@mail.gmail.com>
References: <20160510141416.GA22672@lanh>
	<20160522104341.656-1-pclouds@gmail.com>
	<20160522104341.656-2-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 03:41:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4ert-00033R-74
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 03:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760AbcEWBlN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2016 21:41:13 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:34683 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbcEWBlM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 May 2016 21:41:12 -0400
Received: by mail-io0-f176.google.com with SMTP id 190so184398949iow.1
        for <git@vger.kernel.org>; Sun, 22 May 2016 18:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=6dKRoOlqMLqpM9rdjVh0+8PmLbDv1Sj3DN7oesUfZEU=;
        b=xubDPj2DF8A3CElebgMtTiajAQeKAv8Fv/z0LpGlJpMUgqV9jt/kWmEmnyQWVy4Pwk
         NMIyaA4hlZc54T1QzSp+eQ6XnlHQLfkJF0BOM7umbSxH2DJercqOsx3dZldgoMo0Ru+U
         9FCQvkmAlPZg5SqrmOZRS0Lg9laQRUQQK6H/cOsi2cqIlTMhpfzOFuBBeL50skpVmSak
         OWk35lT6lXIl+tLM1VFPSsH7jF0jkG34XvUDlVUyZYcobYUAI4JPHKrdKP4+vlw2Aef5
         OJtzg6J+O8/eQ4cObqjF8th+v66rZZdUJThrgtdHy1dfc/72iUZ9AQ0oXp2a/L28L9t4
         e79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=6dKRoOlqMLqpM9rdjVh0+8PmLbDv1Sj3DN7oesUfZEU=;
        b=KnGoC2MnFZw8NcEvBf3/HqosX9Cy8s4OE1kJNr5r30r5Z+qLH0lfoXYzs+CZ7QoSCV
         p1HJYruTibDrOJGb4+iQwYSktLGF2u+SQB23iKZq5HMNyfAHvgRlIAUEcDJe4AVPInU8
         G8eD97JvwF+U9Ayfu0AI8+Ao8nsCGFW55YsEczltpibkebixJymLoVXfU679TvLTYgba
         m03gHN2ERGWP4oGbADtW8NNDQpP/FTw6LGr0YbPjINjtqXXyjiHfhQHza0kK8Cr/1LnG
         hgN2Sd0SdJr1chdEx3I/yXl1CivUDby0YnYRQeLqX2VpSg5vzMTcXfJrsm+/fFkPJ5eP
         fc0Q==
X-Gm-Message-State: ALyK8tIQ7W6j1cNFIyeDkP1OyOVHvvfnac10LgFnDzTAEqkeZUqxtNb8m0CGb+fuwgYCorterlKaplW+NZNRxQ==
X-Received: by 10.36.31.3 with SMTP id d3mr1984640itd.84.1463967671805; Sun,
 22 May 2016 18:41:11 -0700 (PDT)
Received: by 10.79.110.21 with HTTP; Sun, 22 May 2016 18:41:11 -0700 (PDT)
In-Reply-To: <20160522104341.656-2-pclouds@gmail.com>
X-Google-Sender-Auth: RKxCKTRqyD8XZ7GsMj-mSNGe_wA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295300>

On Sun, May 22, 2016 at 6:43 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> So far we haven't needed to identify an existing worktree from comman=
d
> line. Future commands such as lock or move will need it. There are of
> course other options for identifying a worktree, for example by branc=
h
> or even by internal id. They may be added later if proved useful.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/worktree.h b/worktree.h
> @@ -29,6 +29,12 @@ extern struct worktree **get_worktrees(void);
> +/*
> + * Search a worktree by its path. Paths are normalized internally.
> + */
> +extern struct worktree *find_worktree_by_path(struct worktree **list=
,
> +                                             const char *path_);
> +

Sorry for not noticing last time, but I'd probably have named this
argument 'path' rather than 'path_' here in the header.

Not worth a re-roll, of course.
