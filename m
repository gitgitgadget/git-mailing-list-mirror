From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH v6] blame: add support for --[no-]progress option
Date: Sat, 12 Dec 2015 18:01:05 -0600
Message-ID: <CAOc6etYBaiAhEjZTn2knCe+HywjqFN5qhQtHFBwRAC2r_iBsJQ@mail.gmail.com>
References: <1449964625-27737-1-git-send-email-eantoranz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Edmundo Carmona Antoranz <eantoranz@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 13 01:01:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7u6C-0006ia-C3
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 01:01:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbbLMABI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2015 19:01:08 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33866 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbbLMABG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2015 19:01:06 -0500
Received: by pfbo64 with SMTP id o64so7101904pfb.1
        for <git@vger.kernel.org>; Sat, 12 Dec 2015 16:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8XbQhhJvjhz7e+MG0pEA3V6RCdL2eEfh6TA2cWEQMPc=;
        b=RWRgxIB+2MSr3L9J2cwphlzPW5K0Mrjvi6zoJwlKJamLO+oDVIbSPkNNhfb+lhADT3
         fLfiMnZuBJFzfbz8IlH94Lr6ztgL8kWVix/HsKRZxu477MeHi5LVy21xsHHfKVpjmLg3
         g6QeunBur3dinV44pcEWQRRG67DV2go/5CIz14xilAI9cTtJhvYGNMG9u/rmeVN+jAQ3
         bxHSYw6qx9GJOqyMAvLAnDHJwrkVDZcB5Pt5YKg5u4cpDUO4bT/pLhyyk8Obh9lfbQS2
         ZPHfOe4F6HoSUEU10dRPLS8cRVoLGgMrHaCTYquafTO73R3Z90L0rC6E2qUUIFFYE85y
         SOCA==
X-Received: by 10.98.1.140 with SMTP id 134mr24917021pfb.134.1449964865696;
 Sat, 12 Dec 2015 16:01:05 -0800 (PST)
Received: by 10.66.89.42 with HTTP; Sat, 12 Dec 2015 16:01:05 -0800 (PST)
In-Reply-To: <1449964625-27737-1-git-send-email-eantoranz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282306>

On Sat, Dec 12, 2015 at 5:57 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> +       if (incremental || (output_option & OUTPUT_PORCELAIN)) {
> +               if (show_progress > 0)
> +                       die("--progress can't be used with --incremental or porcelain formats");
> +               show_progress = 0;
> +       } else if (show_progress < 0)
> +               show_progress = isatty(2);
> +

I think I took care of all the comments from Eric gracefully. Hope
that block is ok for detection of mutually exclusivity related to
--progress.

Cheers!
