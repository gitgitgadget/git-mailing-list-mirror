From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] sha1_name: reorganize get_sha1_basic()
Date: Thu, 2 May 2013 15:10:48 +0530
Message-ID: <CALkWK0=qknGMuHN-zJzLXDNRLFdaBssccnkXbXbM8SZ+ORKiZA@mail.gmail.com>
References: <1367455791-30091-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 11:41:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXq18-0001vZ-97
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 11:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755038Ab3EBJl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 05:41:29 -0400
Received: from mail-ia0-f169.google.com ([209.85.210.169]:57043 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956Ab3EBJl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 05:41:28 -0400
Received: by mail-ia0-f169.google.com with SMTP id l29so320617iag.28
        for <git@vger.kernel.org>; Thu, 02 May 2013 02:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=y5Gw9h2LbjxrloZa2P1hgB0i1666A65bw3RaT8HYwgo=;
        b=CmDkHmrWmomBGF4N3TpJQbsBJvFn6omwHOt6exeLPYw0+gBAWWi5XSWlFs7yLC18yK
         /OgVz+SgH8igOA0DPW0ogTGv0uUWHn5jvbKqLZnWTix+f/Le0Cw2+V3iHXJzrIivkCTd
         xUGCnyAzWo3X8Se1iUb8OESz+EPdtFgayEXxrDHDsggkFr4PH7crgfwNlEkebf2wSiDM
         AJzX7Gfqs0y3HvOSWdtG1Aq44Df9ZMAWYeK1JtgLpDrB3nLdxuVJoK/uIA6rX9h3PTWb
         tognMkcaWPsv8W66uq+KNsHHdJ1MUemQS57ZvmXp4HmNuxmReot4pxDn98WsQw4ACOuE
         WpBA==
X-Received: by 10.50.73.65 with SMTP id j1mr3617956igv.49.1367487688383; Thu,
 02 May 2013 02:41:28 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 2 May 2013 02:40:48 -0700 (PDT)
In-Reply-To: <1367455791-30091-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223184>

Felipe Contreras wrote:
> @@ -447,6 +449,9 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>         if (len && str[len-1] == '}') {
>                 for (at = len-2; at >= 0; at--) {
>                         if (str[at] == '@' && str[at+1] == '{') {
> +                               if (at == 0 && str[2] == '-')
> +                                       /* @{-N} syntax */
> +                                       continue;

Nicely done.  Thanks.
