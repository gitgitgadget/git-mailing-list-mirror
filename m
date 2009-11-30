From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] reset: add --quiet option
Date: Sun, 29 Nov 2009 17:18:59 -0800
Message-ID: <1259543939.5679.5.camel@swboyd-laptop>
References: <1259492290-21771-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 02:19:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEuuy-0002FT-OY
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 02:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187AbZK3BS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 20:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752829AbZK3BS4
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 20:18:56 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:55712 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbZK3BS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 20:18:56 -0500
Received: by yxe26 with SMTP id 26so2639851yxe.4
        for <git@vger.kernel.org>; Sun, 29 Nov 2009 17:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=RDDPbf1g6rLNYlXnMrAc1Q8wK4o6YfUE2SzGh1Yq7OI=;
        b=DnvIHWozHE6LJt4oZPS1yBlCrGZHmEnoyMi5lwKfiJ1auRN1I1e8oxFEznYFHCjNbq
         QZjHsaV3uWLM3LjgLkvFvfK9jPBK87F3XbEk/R1O7kBqCzaAQZ6BLRqWoiYtlpR3JkkY
         81dMmsW3ZqS1k5RTlTPWVSZzFqSXojmrxjTp0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=OSOjxrFVgIF3AQsp71UDqV0zwH2OjSCiket5RIlmx2TbQgxzIRb6nht0q1klvMqW2D
         8Bke/wIJS4kCWl0CNP1Ic3imclvAvsCC2XTeAwhn8zbEIm5kepXRII5oQ16szPhX1qps
         QFgzBRfHUFOjGM8RTrueRun05MHHx7XDX6fNI=
Received: by 10.91.178.19 with SMTP id f19mr5843219agp.33.1259543942598;
        Sun, 29 Nov 2009 17:19:02 -0800 (PST)
Received: from ?192.168.0.6? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 4sm1800456yxd.52.2009.11.29.17.19.00
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 29 Nov 2009 17:19:01 -0800 (PST)
In-Reply-To: <1259492290-21771-1-git-send-email-felipe.contreras@gmail.com>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134042>

On Sun, 2009-11-29 at 12:58 +0200, Felipe Contreras wrote:
> diff --git a/builtin-reset.c b/builtin-reset.c
> index 73e6022..c0127c4 100644
> --- a/builtin-reset.c
> +++ b/builtin-reset.c
> @@ -209,7 +209,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  				"reset HEAD, index and working tree", HARD),
>  		OPT_SET_INT(0, "merge", &reset_type,
>  				"reset HEAD, index and working tree", MERGE),
> -		OPT_BOOLEAN('q', NULL, &quiet,
> +		OPT_BOOLEAN('q', "quiet", &quiet,
>  				"disable showing new HEAD in hard reset and progress message"),
>  		OPT_BOOLEAN('p', "patch", &patch_mode, "select hunks interactively"),
>  		OPT_END()

Why not just OPT__QUIET? We lose the specific help string but it's
possible that what quiet is silencing will change in the future.

Maybe you could move the help string to the documentation if you want to
save it.
