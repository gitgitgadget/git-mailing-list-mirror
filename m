From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] Fix in Git.pm cat_blob crashes on large files (reviewed
 by Jeff King)
Date: Fri, 22 Feb 2013 18:10:07 +0100
Message-ID: <CABPQNSaGSOio1Sn=--jdCfOkw4N+L_khH3Z6AZAQ=aaUg_OGig@mail.gmail.com>
References: <CAMB+bfLjewgKjSN6WNHGkwpRx9OaWipi_-TDa0MnJMDN+6tPZA@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Joshua Clayton <stillcompiling@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 18:11:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8w9Q-0008Nh-Rt
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 18:11:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758196Ab3BVRKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 12:10:48 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:63417 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757720Ab3BVRKr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 12:10:47 -0500
Received: by mail-ie0-f178.google.com with SMTP id c13so959211ieb.23
        for <git@vger.kernel.org>; Fri, 22 Feb 2013 09:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=cdL3KDNrdQQRp7MMVArt7J8onfnYAvRYE4HPUpJy7sk=;
        b=ajASc98+JRSEL/URfxWKn3ez93qAiTXOjx6c8h/uicmVit2wpv8FRaizBU90XJLqrJ
         MsjKcm+Dyg7ADPS2kiR+FNGOp00CP1dEkAlJOC+j0DYVlDk+DooPjdy8yXkQYJ2YSVC8
         qoFZfOirKfYwjnQCB2KaIriuPI9PdVsgG55yiQnMivjhJ9zvnvPr8d5rZNg8OAXJHGVV
         nywzArrpO/lGtw/PegS9Q0D6EJ0JpadvK66wmrTDafX05/RbgPLfDXYqT0zGfsN21RoF
         A7f3gbWRBHS893N2guFEcZzZe42JJ2wPhhH3x9/+k4+tBH7n5vPRvd5FmwWDlYtQS/r9
         os+g==
X-Received: by 10.42.58.67 with SMTP id g3mr1059841ich.56.1361553047217; Fri,
 22 Feb 2013 09:10:47 -0800 (PST)
Received: by 10.64.48.193 with HTTP; Fri, 22 Feb 2013 09:10:07 -0800 (PST)
In-Reply-To: <CAMB+bfLjewgKjSN6WNHGkwpRx9OaWipi_-TDa0MnJMDN+6tPZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216841>

On Fri, Feb 22, 2013 at 6:03 PM, Joshua Clayton
<stillcompiling@gmail.com> wrote:
> Read and write each 1024 byte buffer, rather than trying to buffer
> the entire content of the file.
> Previous code would crash on all files > 2 Gib, when the offset variable
> became negative (perhaps below the level of perl), resulting in a crash.
> On a 32 bit system, or a system with low memory it might crash before
> reaching 2 GiB due to memory exhaustion.
>
> Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>

We usually put "Reviewed-by: Name <email>" right below the SoB-line,
rather than in the subject. And then we CC the people who were
involved in the previous round :)
