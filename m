From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 7/8] revert/cherry-pick: add --quiet option
Date: Wed, 29 May 2013 18:03:25 +0530
Message-ID: <CALkWK0=QyznWZt4sJCok9OZxjrdjtMTtpStA8LHdCCbn0Oi6TA@mail.gmail.com>
References: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com> <1369799788-24803-8-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 14:34:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhfa1-0000gJ-Vq
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 14:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966016Ab3E2MeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 08:34:07 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:61900 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965855Ab3E2MeG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 08:34:06 -0400
Received: by mail-ie0-f178.google.com with SMTP id f4so8561741iea.37
        for <git@vger.kernel.org>; Wed, 29 May 2013 05:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vlh2wEOqd8ePg7V1jkD2u5VcXhrFv8rmopRK3HDgL08=;
        b=LzE3X1nfSenBn8XDC/7QzQu0+a9OGx267A26zJVHBElgXeILV6r4gnsTDj/fG188Bx
         nDuoBz84ZmbVBwtv9y8gK1HwmWEOMDr7TdUXDkpMAnex03yiFY65JM/C3WReGOGA32wu
         ZLvtyAN+CCdKmPpC/U1cFIJMrgdkL4wg5JRCALX2UbiJt7//3fLC2RTTT85ve7bGzanp
         cpDh1KJXv3ulZEpivn3EVNjrU7gOUvtaesoqBZSe51Q8PuKOEvPQA1mU2vEgrx29L/VF
         PwITl5QUgHb8DWOkVohvosAqRIzmAPcLKFU1YB6RQGqehAqGYtqNPGakqpiAveRgC5iQ
         UK2Q==
X-Received: by 10.50.141.230 with SMTP id rr6mr9205832igb.89.1369830845203;
 Wed, 29 May 2013 05:34:05 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Wed, 29 May 2013 05:33:25 -0700 (PDT)
In-Reply-To: <1369799788-24803-8-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225802>

Felipe Contreras wrote:
>         if (opts->skip_empty && is_index_unchanged() == 1) {
> -               warning(_("skipping %s... %s"),
> -                       find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
> -                       msg.subject);
> +               if (!opts->quiet)
> +                       warning(_("skipping %s... %s"),
> +                               find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
> +                               msg.subject);
>                 goto leave;
>         }

All this trouble just to suppress the "skipping ..." message.  Do you
see anything else --quiet can be used to suppress?
