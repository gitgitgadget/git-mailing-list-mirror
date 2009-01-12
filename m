From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [RFC PATCH 1/3] Add "vcs" config option in remotes
Date: Mon, 12 Jan 2009 10:52:04 +0100
Message-ID: <36ca99e90901120152t7756e6d4n19521cbb7336c5fb@mail.gmail.com>
References: <alpine.LNX.1.00.0901110332580.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jan 12 10:53:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMJUD-0003Y4-5f
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 10:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225AbZALJwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 04:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbZALJwI
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 04:52:08 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:33265 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbZALJwH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 04:52:07 -0500
Received: by fg-out-1718.google.com with SMTP id 19so3865510fgg.17
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 01:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=45ecHMclkxIpKtCAkRMnkJol6qGt+wZSAIiADjfgkmI=;
        b=QMmTPnv+WSHCng/onVvkaAVuXqgTZqhYK5DCbV2VYONIEnCTNpWSIjQmWBY+AuSmjX
         4fdCaY07yUxAVHX058HX44G08jBeq51CFYqUVsBbig32Iz8W4iQXMbiXBRd3BG1Pk9Mp
         nNvgUsmQyQ7fb5gix/kpARErmz2SEefqVF+s0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=H3VjYZxBbFYUptFrySfyBlO/aMUhDaWP5CWtqlla/bTe7Ny7v92XKYAVje2lh8I+5T
         tiXWOCpp2AgCuP0EgTFJ/6TLzyqTHM9EeC3sMB9tEg+UKPnO6jsI1m/yyP/U80Iqnnjv
         HuDFg2AbhO4G8CLvsMiP46FYfGVweSYw2LkI0=
Received: by 10.86.91.3 with SMTP id o3mr15138854fgb.35.1231753924534;
        Mon, 12 Jan 2009 01:52:04 -0800 (PST)
Received: by 10.86.3.2 with HTTP; Mon, 12 Jan 2009 01:52:04 -0800 (PST)
In-Reply-To: <alpine.LNX.1.00.0901110332580.19665@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105317>

On Sun, Jan 11, 2009 at 21:12, Daniel Barkalow <barkalow@iabervon.org> wrote:
> diff --git a/builtin-push.c b/builtin-push.c
> index 122fdcf..3fdedba 100644
> --- a/builtin-push.c
> +++ b/builtin-push.c
> @@ -53,6 +53,9 @@ static int do_push(const char *repo, int flags)
>        int i, errs;
>        struct remote *remote = remote_get(repo);
>
> +       if (remote->foreign_vcs)
> +               die("Pushing with foreign VCSes not supported.");
> +
>        if (!remote)
>                die("bad repository '%s'", repo);
>
Use of remote before NULL check.

Bert
