From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] git diff/diff-index/diff-files: call setup_work_tree()
Date: Mon, 25 Aug 2008 22:26:07 +0700
Message-ID: <fcaeb9bf0808250826l2f1a0f3l94fff1b702e69c5d@mail.gmail.com>
References: <20080825145044.GE23800@genesis.frugalware.org>
	 <1219677095-21732-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Karl Chen" <quarl@cs.berkeley.edu>, git@vger.kernel.org
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Aug 25 17:30:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXdyO-0001oJ-Fw
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 17:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497AbYHYP0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 11:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753408AbYHYP0K
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 11:26:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:3506 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375AbYHYP0J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 11:26:09 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1001998fgg.17
        for <git@vger.kernel.org>; Mon, 25 Aug 2008 08:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=4C7A8gffvuB4HlMMXHrD0aARsCBUWea1mfhFCdvvoB4=;
        b=tMfacbG0H7BsTxyY46/JUP9Bt3f/jydGDkLspJo91zPRzfIhiU9/Xk2g1oKfnnMFmh
         SioCED6K++FPfuM4bSJwYm3+p1hNvPYyfUTDCWap+LZSDmIbC7gGqzijGPkcSHeyWg08
         qv5KjB3WKdpY0GgxLccUXt96Yv7vImtcpOnAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ZHvjHzjEYAO94D/ds0b88u8HEogvi4IVtAQzp9GFc7rtFAgBuOq7EaeG+hu9i36Uo0
         d5z5RPukQpCNPiYI6xdX9tpAvGO35uz8RL/tCafc54Yegh7f66nN32PewEpOkSoiXSi8
         AKiQKhdrJWPTGPMGg5ahQGlpFK+vec0jP/57c=
Received: by 10.86.27.19 with SMTP id a19mr3437820fga.56.1219677967309;
        Mon, 25 Aug 2008 08:26:07 -0700 (PDT)
Received: by 10.86.93.13 with HTTP; Mon, 25 Aug 2008 08:26:07 -0700 (PDT)
In-Reply-To: <1219677095-21732-1-git-send-email-vmiklos@frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93635>

On 8/25/08, Miklos Vajna <vmiklos@frugalware.org> wrote:
>  diff --git a/builtin-diff.c b/builtin-diff.c
>
> index 7ffea97..57da6ed 100644
>
> --- a/builtin-diff.c
>  +++ b/builtin-diff.c
>
> @@ -279,6 +279,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>         diff_no_index(&rev, argc, argv, nongit, prefix);
>
>         /* Otherwise, we are doing the usual "git" diff */
>  +       setup_work_tree();
>         rev.diffopt.skip_stat_unmatch = !!diff_auto_refresh_index;
>
>         if (nongit)

At least builtin_diff_blobs() and builtin_diff_tree() won't need
worktree, so NACK again. Anyway I'm not familiar with diff*. Junio
should know these better.

-- 
Duy
