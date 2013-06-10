From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/15] Towards a more awesome git branch
Date: Mon, 10 Jun 2013 08:25:25 +0700
Message-ID: <CACsJy8D8FoiVFT5cNbXyxeAngAUJ1X3AdQOGK41FVWyZyEaSKw@mail.gmail.com>
References: <1370800474-8940-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 03:26:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulqrw-0001ae-JO
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 03:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151Ab3FJBZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 21:25:57 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:52865 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008Ab3FJBZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 21:25:56 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo10so9342491obc.3
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 18:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IXND6PZedAjvYnDtN68dHTGq/pYzcS4PyJ3fuTtuhvo=;
        b=rCnTcWEb1sYT6yXkrZPK1rf9AcMtAZx/VknIg1NEspvRBZfVRvEUVKZkYqr9BV5BOA
         aVbFTDYKQcG+e71H9a9ZjhpETZ4WXcwbStnhV7syef97oOCPjA21pd+4G7DV7aiLG8Da
         h3nLYjsZ+WIJY8wpdpmRpSecK7zgyLI1H75csMx+AV1ziJ6955aKTvnbyq0tmpg3nLMw
         TK2LJu9355f0J4A/MZ16/KTHtfY2iQWVeeZm//4vgG0v/HEB8TIWCbUWi8EX91qNONQZ
         Pz1f0PmxTBdHon1UutR9q2Ke29hJD0SZVttxxGZCNS7xpSjKB3v1wAqzFZkouLzLC6Jf
         LJGw==
X-Received: by 10.60.131.143 with SMTP id om15mr6163352oeb.19.1370827555906;
 Sun, 09 Jun 2013 18:25:55 -0700 (PDT)
Received: by 10.76.76.69 with HTTP; Sun, 9 Jun 2013 18:25:25 -0700 (PDT)
In-Reply-To: <1370800474-8940-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227223>

On Mon, Jun 10, 2013 at 12:54 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Hi,
>
> This iteration contains some minor fixups (courtesy reviews by Eric
> Sunshine and Junio), and some tests from Duy squashed in.

I'm starting to think this is a half-baked solution. It hides
problems, for example commit placeholders should produce empty string,
not the literal placeholders. Doing that from a callback is really
ugly. There's also the problem with sorting and quoting (both only
work with for-each-ref atoms only). A better solution may be improving
pretty.c to the point where it can more or less replace f-e-r's
--format. Even more, I think pretty engine should be easily added to
cat-file (especially --batch), as a generic way to extract
information. But for the reason I will send shortly, I will not work
not work on this series or any others.
--
Duy
