From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v4 13/32] write_packed_entry_fn(): convert cb_data into a
 (const int *)
Date: Thu, 11 Sep 2014 12:55:15 -0700
Message-ID: <CAL=YDWnHKUTiKnW5tVfdppw0g6HpXHPbL-b_EViRZHheQO3Uqg@mail.gmail.com>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
	<1409989846-22401-14-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Sep 11 21:55:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSASn-0005U3-0i
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 21:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168AbaIKTzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 15:55:21 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:38109 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075AbaIKTzS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 15:55:18 -0400
Received: by mail-vc0-f174.google.com with SMTP id hy10so6318747vcb.5
        for <git@vger.kernel.org>; Thu, 11 Sep 2014 12:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5PP9JtYGONEuPv38TV4Pg4z6mZwFl/eoQI8n+kyegjk=;
        b=ZiDpDu7NcchHSCazrX28R9njt9VdJpcyoiUxYDmecjH84WKj2AM20tlF1S5jyli1LB
         Ek53DVt/hRmAVAwFsYI9D8L74xZCeKeDYW0u/YfNcZinZ85NfPRQWPzsfiHopIEjkuSE
         Z9bzS30NmmoWSwYnMbEqwa9Do7PZa1KzAEujEIphhd5qjdKSpYXFqNfRqxvrmsk92IEl
         /yf4KKT550AgKkF8+2ETlpKxxiJfjDWBPFpWrCszusMVQef0+354OkWALpDRoAkIP3VW
         ey8gMYIbZCTGrAf/MzHpR9NlHuwtvI6yfo7sPKjEtNZnsJ7Ct3dcZsI4pQ3UPTVqFfzJ
         W/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=5PP9JtYGONEuPv38TV4Pg4z6mZwFl/eoQI8n+kyegjk=;
        b=Vf8/5yEgbptivl0cNBEil9yPixtlylb0X15ajmatl+fpzyh6JiqZGdh8m09kI+doFm
         oAgXu98MEI1JrllEfXRKarxbFSaMzyu8b8rCIgvExcNOhT+fD3giSJEXVsp1DDV6R9KI
         PPw5MQrWcaeXejYIiLaSfld/PjljqmMXjV5R6FSH6ttPD85945Xzm+LiLLO3kSWfzFSt
         U0hi5H8JLSRPKqR71VLNmJD5lJyh90COwEg93FMvkM3SrOimJ3kt3N6aJdS+6qab4BK2
         X1Awql0Wc7o4CW0S/qwisHZzM/0AaimQvTNX01P1o16vK0r5CGiHezEsNgIHTX2y+MZY
         6ksQ==
X-Gm-Message-State: ALoCoQmnHiSmQPFBxzkB9mA8MCb77tqfTyI2/xtCWfrkzszBVpjBZg6DBTJbL17NoWgAV8Gb2scA
X-Received: by 10.52.245.101 with SMTP id xn5mr2280176vdc.32.1410465315541;
 Thu, 11 Sep 2014 12:55:15 -0700 (PDT)
Received: by 10.52.231.232 with HTTP; Thu, 11 Sep 2014 12:55:15 -0700 (PDT)
In-Reply-To: <1409989846-22401-14-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256871>

Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>

On Sat, Sep 6, 2014 at 12:50 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> This makes it obvious that we have no plans to change the integer
> pointed to, which is actually the fd field from a struct lock_file.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/refs.c b/refs.c
> index 8a63073..21b0da3 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2218,7 +2218,7 @@ static void write_packed_entry(int fd, char *refname, unsigned char *sha1,
>   */
>  static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
>  {
> -       int *fd = cb_data;
> +       const int *fd = cb_data;
>         enum peel_status peel_status = peel_entry(entry, 0);
>
>         if (peel_status != PEEL_PEELED && peel_status != PEEL_NON_TAG)
> --
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
