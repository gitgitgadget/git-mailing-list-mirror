From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 01/14] Add proper 'stage' command
Date: Mon, 14 Oct 2013 18:15:26 -0500
Message-ID: <CAMP44s0qXui4DM6ejdwNYTR__q0zsish2+-JsphrmNT15zoeAg@mail.gmail.com>
References: <1381789769-9893-1-git-send-email-felipe.contreras@gmail.com>
	<1381789769-9893-6-git-send-email-felipe.contreras@gmail.com>
	<CAPig+cTu8k7c2JtxdYLqn+9s-rZ4C_Th3GNDBXABQVtz0hviaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Oct 15 01:15:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVrML-0005bG-Hl
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 01:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757474Ab3JNXP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 19:15:29 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:34231 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756918Ab3JNXP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 19:15:28 -0400
Received: by mail-la0-f54.google.com with SMTP id ea20so6158193lab.41
        for <git@vger.kernel.org>; Mon, 14 Oct 2013 16:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CsBIaSI7J6OcpbL7oOuyXah7+bvn1/QzjzGv8SV0ih0=;
        b=G5yIXpSA3IJ6EZcCd7Jc9Z2TMT6la3aXC4dHOIFH8tnZg1siszDA0pqKdDdNpEGkXq
         4pUGOBL2LdsTTDwZqt4HaffY+1Pedq3vQPG/pN9XymRHaR4JDMKYgci1n/vi4rKXliap
         JXi/c8sdepmfB7nQ88j0BMX8e7IT/9biU10aLRyuXfvfZPMHZu9G36eZeqU47C97tUzf
         eBnenxIq9bjTzCZLxouiifCcdwkkllq2Nv93/BDHmXFqv7UHKtzJoUOtQtlRMRaXsUiF
         zBAkb+r8zu4jCVJctl7tgDpUzHSyEj7Z92DDQHvFMFoC9FDx3wG2MRZNoqip6Tx8Nwn6
         lDbQ==
X-Received: by 10.152.180.139 with SMTP id do11mr22949850lac.23.1381792526983;
 Mon, 14 Oct 2013 16:15:26 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Mon, 14 Oct 2013 16:15:26 -0700 (PDT)
In-Reply-To: <CAPig+cTu8k7c2JtxdYLqn+9s-rZ4C_Th3GNDBXABQVtz0hviaQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236147>

On Mon, Oct 14, 2013 at 6:06 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Oct 14, 2013 at 6:29 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> diff --git a/builtin/stage.c b/builtin/stage.c
>> new file mode 100644
>> index 0000000..3023d17
>> --- /dev/null
>> +++ b/builtin/stage.c
>> @@ -0,0 +1,52 @@
>> +/*
>> + * 'git stage' builtin command
>> + *
>> + * Copyright (C) 2013 Felipe Contreras
>> + */
>> +
>> +#include "builtin.h"
>> +#include "parse-options.h"
>> +
>> +static const char *const stage_usage[] = {
>> +       N_("git stage [options] [--] <paths>..."),
>> +       N_("git stage add [options] [--] <paths>..."),
>> +       N_("git stage reset [-q|--patch] [--] <paths>..."),
>> +       N_("git stage diff [options] [<commit]> [--] <paths>..."),
>> +       N_("git stage rm [options] [--] <paths>..."),
>> +       NULL
>> +};
>
> Sent the wrong set of patches? The interdiff in the cover letter
> showed usage for "git stage apply", but it's not here in the actual
> patch.

No, it's the right series, but apparently I added the change to the
wrong commit: stage: add edit command. I've fixed that and will send
it on the next reroll (if there's any).

-- 
Felipe Contreras
