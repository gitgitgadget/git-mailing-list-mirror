From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv2 6/9] hash-object: Replace stdin parsing OPT_BOOLEAN by OPT_COUNTUP
Date: Wed, 31 Jul 2013 13:12:56 -0400
Message-ID: <CAPig+cSHmZcov5NRxkvRhdqB0XB72LW+K04f4ayfMq2VZrb8CA@mail.gmail.com>
References: <1375288117-1576-1-git-send-email-stefanbeller@googlemail.com>
	<1375288117-1576-7-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jul 31 19:13:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4ZxO-0002d4-Ut
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 19:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757136Ab3GaRM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 13:12:59 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:48509 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757004Ab3GaRM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 13:12:58 -0400
Received: by mail-lb0-f169.google.com with SMTP id u10so650375lbi.14
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 10:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Tv5af4z5/Mboyjp4XBufUjCQj4dhVEH6UqfkbnVOnwY=;
        b=Rc/iuxQ/c/euCIPDFiYKSg8Cuz+VPy4AHwrzcksWc6O++9wCFKW9kbcN/lp1Wbt1ML
         6hF2uqXvuPL8kFvZZgGDlmXirDagWtu67s/T4Q5z7Q8/zorp/42dzL2U3NjcQi7upFXF
         xqUfksO+9vcD8zuyBJ032lrvQuiWHUnYy5b1qAIhNYvGNPhlR/UoCOuIv2QZbrGi1Iug
         Y5Do+g9MzFVKImJlfEsbvk1AVAC0eQddfWUyM5HvePSpEE7OAAyyvWuAcr9+SUyC7Msl
         Q77jTRmwVvz0KPDfGkOEEHeovoPrf+Ki42srVBQCPtWK11fX5g+YZnfb+hU9fn9bAmFJ
         Pm6g==
X-Received: by 10.112.19.162 with SMTP id g2mr30544232lbe.9.1375290776873;
 Wed, 31 Jul 2013 10:12:56 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Wed, 31 Jul 2013 10:12:56 -0700 (PDT)
In-Reply-To: <1375288117-1576-7-git-send-email-stefanbeller@googlemail.com>
X-Google-Sender-Auth: sNAPTPenPRkiNHusNYOh3d_1oyg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231436>

On Wed, Jul 31, 2013 at 12:28 PM, Stefan Beller
<stefanbeller@googlemail.com> wrote:
> This task emerged from b04ba2bb (parse-options: deprecate OPT_BOOLEAN,
> 2011-09-27). hash-object is a plumbing layer command, so better
> not change the input/output behavior for now.
>
> Unfortunately we have these lines relying on the count up mechanism of
> OPT_BOOLEAN:
>
>         if (hashstdin > 1)
>                 errstr = "Multiple --stdin arguments are not supported";
>
> Maybe later, when the plumbing is refined (git 2.0?) we can drop that
> errormessage and replace the OPT_COUNTUP by OPT_BOOL.

s/errormessage/error message/

> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
