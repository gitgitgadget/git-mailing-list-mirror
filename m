From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Geolocation support
Date: Mon, 9 Feb 2015 14:57:02 +0100
Message-ID: <CACBZZX5rgah7Ucek8dicaDeqvjdkR5ybBC5O7PUxE8+KBwrpgA@mail.gmail.com>
References: <87mwrncfkh.fsf@ethzero.com> <CALkWK0kHEDn4Wt3Y+XUE59_9ZDf504yopMp9QtBUk49Sd+EXbg@mail.gmail.com>
 <CALWbr2w3=DTAMkFtJoLF1_X46fefpEq2WtTb7HGiTiOExFHG3w@mail.gmail.com>
 <7vhahtfuzm.fsf@alter.siamese.dyndns.org> <87h9uwvtm2.fsf@ethzero.com> <CAPc5daW5jYAj5z6UMJAQLoWS4L6OH-NSvbGBMd3LO0qCV40a4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alessandro Di Marco <dmr@ethzero.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 14:57:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKoq8-0003GU-U6
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 14:57:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760497AbbBIN5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 08:57:24 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]:53555 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759943AbbBIN5X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 08:57:23 -0500
Received: by mail-ob0-f177.google.com with SMTP id wp18so24567451obc.8
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 05:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lh14hGXNJVeYlIjR4ajbhdkLtoAsMgAp7wHJa0MD/gE=;
        b=a0Vymt3Na0XzU+g8BnEckZinoAKS5i2VLFBChFU6o6jlk3lTAtSMCVqlNPWZqQQlP9
         0y81Dmm53CsKkrVzVjoCbVpJowfek0JT2ucN8VAfTUiT+rRjUyyhEoA1NoV0EHlbfdNU
         RAAxz6pHGeQCOf412S/DpZ5SYLyLAqkEBmTNHpbxvA0y+cE9HeNhIuKvkCdbsUVKw3w2
         GvxCVK5V9GqX2wATH4lcQt5gRWYYgNAju4R0BZ/dRUAXDKWW0kMq1ecARYFWsAJ0MxlM
         1kPkNrpRwy5AvSXjaxDkyOjyGLkzhPMJKfu7g2tzIJqsIt3pwvs90aHEyOGUDSnFiHYZ
         mxeA==
X-Received: by 10.182.119.232 with SMTP id kx8mr11612954obb.37.1423490242843;
 Mon, 09 Feb 2015 05:57:22 -0800 (PST)
Received: by 10.76.50.70 with HTTP; Mon, 9 Feb 2015 05:57:02 -0800 (PST)
In-Reply-To: <CAPc5daW5jYAj5z6UMJAQLoWS4L6OH-NSvbGBMd3LO0qCV40a4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263567>

On Mon, Feb 9, 2015 at 2:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> In case I was not clear, I do not think it is likely for us to accept
> a patch that mucks with object header fields with this information.
> Have them in the log text and let UI interpret them.

We've already told clients for a long time to ignore fields they don't
know about, why would we not store what's intended to be
machine-readable key-value pair data in the commit object itself, as
opposed to sticking it in the log message where parsing it is always
going to be a bit more tricky & distracting, since users will have to
look at this arbitrary metadata when they do "git log" or "git show".
