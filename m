From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v6 3/4] notes: add notes.mergestrategy option to select
 default strategy
Date: Fri, 14 Aug 2015 14:12:20 -0700
Message-ID: <CA+P7+xpPFO4cJbK=nZMMy8DYAB71xzq=gEaTB5D+_KACZLzaDw@mail.gmail.com>
References: <1439585329-10542-1-git-send-email-jacob.e.keller@intel.com>
 <1439585329-10542-4-git-send-email-jacob.e.keller@intel.com> <CAPig+cTjQu2LRuR5cC+VSihVB00k-bjew3eCqA4Ee_tRuDK_=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 23:12:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQMHR-0004Ro-Dp
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 23:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbbHNVMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 17:12:40 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:34619 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbbHNVMj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 17:12:39 -0400
Received: by iodb91 with SMTP id b91so97337288iod.1
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 14:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0zwJ+ySJqd4VFqK8jQmHEUUfzyBEtWLHH+lAOw4cT6k=;
        b=g8qHDdvG+4S2gXr4tcbPJbbTNO5XuxTJQHnFZML+hhDfumxECn0yGg1XR4sT14uyoo
         1VB3ntTjXdY3Rjh+IxC6DlIefAGDf8Ipp9eBEGMVbNVxxIvInpG/mP0EFdmHMRRbvKdd
         I7oV6iG1h5P/0sQ3Hr1ZMO0klRsKnsk2rNB1o4IzFftIZIhnxf473mXOIILxgyaY6K98
         Qv3LU0JQyUXiMBdrnXNwlCEnZgXwxiJldbIz1xWna/Bw/qBmiOGZBK8gRT7pw5GB4xJS
         Hgy4kZYNkZdlsabPVfPAcR5aVFqPrbZidOwIJoktjL195xH9AtPrEsMVJ2rnMkZaxg/J
         Br4w==
X-Received: by 10.107.154.67 with SMTP id c64mr3340874ioe.0.1439586759333;
 Fri, 14 Aug 2015 14:12:39 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Fri, 14 Aug 2015 14:12:20 -0700 (PDT)
In-Reply-To: <CAPig+cTjQu2LRuR5cC+VSihVB00k-bjew3eCqA4Ee_tRuDK_=w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275955>

On Fri, Aug 14, 2015 at 2:06 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>     const char *value;
>
>     if (!git_config_get_string_const(key, &value)) {
>         if (parse_notes_strategy(value, strategy))
>             git_die_config(key, "unknown notes merge strategy '%s'", value);
>         return 0;
>     }
>     return 1;
>
> Or, the equivalent, but less indented:
>
>     if (git_config_get_string_const(key, &value))
>         return 1;
>     if (parse_notes_strategy(value, strategy))
>         git_die_config(key, "unknown notes merge strategy '%s'", value);
>     return 0;


I like it. Will do.
