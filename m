From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] streaming: allow to call close_istream(NULL);
Date: Fri, 18 May 2012 14:02:38 -0700
Message-ID: <xmqqobpl2oep.fsf@junio.mtv.corp.google.com>
References: <1336818375-16895-1-git-send-email-pclouds@gmail.com>
	<1337169731-23416-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 18 23:02:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVUJw-0006ZF-Uc
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 23:02:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967500Ab2ERVCk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 May 2012 17:02:40 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:60971 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967372Ab2ERVCj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2012 17:02:39 -0400
Received: by qcsp5 with SMTP id p5so419911qcs.1
        for <git@vger.kernel.org>; Fri, 18 May 2012 14:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=pQX7Fs0rVRxYqpN0Sy1s6wHg3CwyKOHbH5DCyESwKE4=;
        b=ajAijsUU5LK8AwSuQU0qVjRXkSHFxwvQQdLLYEAejk20xrJ3hHcAdPh1xaLdPQ99rR
         7udNvY/m6cCsK0lps6ejO3u/jlXU8EUpMeh7f7Rc0xbF2eBJRp8cH2c9063oF40kXNuA
         lTs6lxeird9v5RY76G7IBChCGk8S7NtPjYY6PCfEAGlNo/ohPdNw8kjtjFAYdVBiPsSD
         HaZCocN8ZDP018kCqOQOqP7kcX1lZ4zQBsfJcSWFRvFre4I6dmOTWlJa+MSSaFLcedRX
         THb4MzZikMNjlTNmmYbhti3EBLCH9qilSdfE01910/kD3lc13qexWDtngFkxkdLvJLWT
         qhvA==
Received: by 10.101.39.7 with SMTP id r7mr5841591anj.9.1337374958744;
        Fri, 18 May 2012 14:02:38 -0700 (PDT)
Received: by 10.101.39.7 with SMTP id r7mr5841581anj.9.1337374958680;
        Fri, 18 May 2012 14:02:38 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id y36si8820894yhg.2.2012.05.18.14.02.38
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 18 May 2012 14:02:38 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 916A510004D;
	Fri, 18 May 2012 14:02:38 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 3B73FE1772; Fri, 18 May 2012 14:02:38 -0700 (PDT)
In-Reply-To: <1337169731-23416-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 16
 May 2012 19:02:08 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmHS8dRLFfUwkrGXy3CstBGYXPpKBbdeJ5euqAn4viVyRfkJgldMSnNtAn4mpKx4sVt4n8O3wtwpN0b+3wsD6PoKhD1OtBt3gmiYX2QzLmmE+5jAUA+Yv4u/MaDCWd2kLmscvExLLtvJEqSY7uDvcLyGufvLA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197971>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This makes it more convenient in cleanup code, like free(NULL).

If the justification were "like fclose(NULL)", it have made more sense,
but fclose(NULL) does not silently turn itself into a successful no-op.
You are expected to check the returned value from the matching function
(i.e. fopen()) and do not call it.  So taking this patch alone, I smell
a bad design taste.

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  streaming.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/streaming.c b/streaming.c
> index 3a3cd12..38b39cd 100644
> --- a/streaming.c
> +++ b/streaming.c
> @@ -94,7 +94,7 @@ struct git_istream {
> =20
>  int close_istream(struct git_istream *st)
>  {
> -	int r =3D st->vtbl->close(st);
> +	int r =3D st ? st->vtbl->close(st) : 0;
>  	free(st);
>  	return r;
>  }
