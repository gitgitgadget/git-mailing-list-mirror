From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 01/14] Add proper 'stage' command
Date: Mon, 14 Oct 2013 19:06:37 -0400
Message-ID: <CAPig+cTu8k7c2JtxdYLqn+9s-rZ4C_Th3GNDBXABQVtz0hviaQ@mail.gmail.com>
References: <1381789769-9893-1-git-send-email-felipe.contreras@gmail.com>
	<1381789769-9893-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Miles Bader <miles@gnu.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 15 01:06:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVrDn-0000Rd-Tz
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 01:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757525Ab3JNXGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 19:06:40 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:45322 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757390Ab3JNXGj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 19:06:39 -0400
Received: by mail-lb0-f169.google.com with SMTP id z5so6354662lbh.0
        for <git@vger.kernel.org>; Mon, 14 Oct 2013 16:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=9J0vRXhvYINKjUXszuL2MiyoxQ7LLHbjRfs5TVwl8b0=;
        b=kStnQXtzUsEv06wdxu+C3WJOpWCEvW17It19zxtS8O7IePhcBGBKS+UjktA0s0BH+F
         FXkZ6/kjZ53+U4w9ArEXMB8VdZSt3Qe8Mhza6vPzrdI5YdRZCFXGhWrThOp9dTJeoaKz
         hSgB4Mn0p632N5Pa1oD8mlGPGrQewz9zhKD/sNw+htTorTdZ2uCB3c1HCj9KYKUr94ww
         x5XwWoL6Gw6+LwILf1X8RFy3uCEAcmndvqEYCY58VCwtuVQdbE8l0IUTeGP8xzp9mAUA
         2gNLGwEMsFTV2kPNpEmeRoOFKdNOskJVhMV96mIkc91Uw7E//0vvVLJppZk5PyjzYa3A
         TqJg==
X-Received: by 10.152.22.97 with SMTP id c1mr4183715laf.31.1381791997937; Mon,
 14 Oct 2013 16:06:37 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Mon, 14 Oct 2013 16:06:37 -0700 (PDT)
In-Reply-To: <1381789769-9893-6-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: WXVaTV6VFkv1wR8OiMV8fwjydSI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236146>

On Mon, Oct 14, 2013 at 6:29 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> diff --git a/builtin/stage.c b/builtin/stage.c
> new file mode 100644
> index 0000000..3023d17
> --- /dev/null
> +++ b/builtin/stage.c
> @@ -0,0 +1,52 @@
> +/*
> + * 'git stage' builtin command
> + *
> + * Copyright (C) 2013 Felipe Contreras
> + */
> +
> +#include "builtin.h"
> +#include "parse-options.h"
> +
> +static const char *const stage_usage[] = {
> +       N_("git stage [options] [--] <paths>..."),
> +       N_("git stage add [options] [--] <paths>..."),
> +       N_("git stage reset [-q|--patch] [--] <paths>..."),
> +       N_("git stage diff [options] [<commit]> [--] <paths>..."),
> +       N_("git stage rm [options] [--] <paths>..."),
> +       NULL
> +};

Sent the wrong set of patches? The interdiff in the cover letter
showed usage for "git stage apply", but it's not here in the actual
patch.
