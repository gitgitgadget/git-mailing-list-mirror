From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH v3] checkout: add --progress option
Date: Sun, 1 Nov 2015 11:43:42 -0600
Message-ID: <CAOc6etZ7Vcd-Gq6bV6VuzJQY2om7k0gWfGYsSmQ8xYtGvOWBxQ@mail.gmail.com>
References: <1446398545-8245-1-git-send-email-eantoranz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Edmundo Carmona Antoranz <eantoranz@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 01 18:43:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZswfT-0000pT-2U
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 18:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbbKARnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 12:43:43 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35805 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448AbbKARnm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 12:43:42 -0500
Received: by pasz6 with SMTP id z6so123333105pas.2
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 09:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DAtCl7yWhjkx7/QTOqkor2nc/jkDdx2zJdVlpg28fW4=;
        b=I+g539wYDfITWS0kjzi/+7VVbSSkp/j7q2XEWKtw5tE324xo9f9qnDxlSyrrGwvetc
         pmxXz59l/kKLCW0PA+nLzdu/yZ622K3yA8oP109umX02M3ZwSGZcYecrLgLNiCexyCAF
         VflSL6VJjm+Z8j4yW06adjuyVEczS3FjxD2KKrlSuAn18s6nwNG/Uto2MV4cK0eFtLh7
         EVIhgp2boQfbt7e3cK8gtX3cpZsrebZ9/6JvjuDxahncDcR3xLw6/M4Or6NbG2P8RcwA
         DYoohqbnCaTkEu8KOHwDD/YUaYGeM9xbmM7/QtOMLeGJ9ifhumo9KhRp7If3u5Ipocz7
         NrXg==
X-Received: by 10.68.201.5 with SMTP id jw5mr8596790pbc.28.1446399822431; Sun,
 01 Nov 2015 09:43:42 -0800 (PST)
Received: by 10.66.97.70 with HTTP; Sun, 1 Nov 2015 09:43:42 -0800 (PST)
In-Reply-To: <1446398545-8245-1-git-send-email-eantoranz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280637>

On Sun, Nov 1, 2015 at 11:22 AM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> +       /*
> +        * Final processing of show_progress
> +        * - User selected --progress: show progress
> +        * - user selected --no-progress: skip progress
> +        * - User didn't specify:
> +        *     (check rules in order till finding the first matching one)
> +        *     - user selected --quiet: skip progress
> +        *     - stderr is connected to a terminal: show progress
> +        *     - fallback: skip progress
> +        */
> +       if (opts.show_progress < 0) {
> +               /* user selected --progress or didn't specify */
> +               if (opts.quiet) {
> +                       opts.show_progress = 0;
> +               } else {
> +                       opts.show_progress = isatty(2);
> +               }
> +       }
> +


/* user selected --progress or didn't specify */
This comment is not correct. Disregard this patch.
