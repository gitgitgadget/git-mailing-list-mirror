From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: MIME headers in introductory message (git send-email --compose)
Date: Tue, 25 Mar 2008 15:17:10 -0400
Message-ID: <76718490803251217q27ae4381h298ec6de8a4d965a@mail.gmail.com>
References: <1205426419-4594-1-git-send-email-sam@rfc1149.net>
	 <7vhcfaxxxk.fsf@gitster.siamese.dyndns.org>
	 <200803252031.17017.tlikonen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
	"Samuel Tardieu" <sam@rfc1149.net>
To: "Teemu Likonen" <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Tue Mar 25 20:18:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeEei-0007nV-JQ
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 20:17:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757438AbYCYTRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 15:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757358AbYCYTRN
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 15:17:13 -0400
Received: from rv-out-0910.google.com ([209.85.198.186]:31009 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756906AbYCYTRM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 15:17:12 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1848756rvb.1
        for <git@vger.kernel.org>; Tue, 25 Mar 2008 12:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=VxQbrXpIHQinXGM/I4QnCmQxDWIFGmkaGol+IAQ66xY=;
        b=sKcldRyKv/L4MIAUJRhCyzGAzuELNuU7MVcq9IWeXgp8W1UTq/oNmlSUe03sh/5IgJfEzujOgAVkGugtTlL/HZhssK0KSqWA8aRBcZEFyPNuux2PpQZ/8/UTOB3Xw9rTSL7Fj1Mq6Q6t3861BXw0gw7Gn0UG8MwUToZpUg68rEo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jCTTQKTvx47YCh7xE03NBG3PDV7P9pQdTAKCk/kIi8wpUlPLF5himLWmD+zLxFIunZCxoTH7yncdEGKDxhUqh043CT/ITsL7YIJ0o8CK/d9mrzdLhHd8AL3a0uXYXY1nnmCrD7Qr6EyubTPzUpyiowWqV9Bpx0XZBjPt4qyV41Y=
Received: by 10.141.129.14 with SMTP id g14mr3669815rvn.209.1206472631012;
        Tue, 25 Mar 2008 12:17:11 -0700 (PDT)
Received: by 10.141.33.18 with HTTP; Tue, 25 Mar 2008 12:17:10 -0700 (PDT)
In-Reply-To: <200803252031.17017.tlikonen@iki.fi>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78208>

On Tue, Mar 25, 2008 at 2:31 PM, Teemu Likonen <tlikonen@iki.fi> wrote:
> Junio C Hamano kirjoitti:
>
>  > Samuel Tardieu <sam@rfc1149.net> writes:
>  > > Add MIME-Version/Content-Type/Content-Transfer-Encoding headers in
>  > > messages generated with git-format-patch. Without it, messages
>  > > generated without using --attach or --inline didn't have any
>  > > content type information.
>  >
>  > Isn't that job for send-email (or user's MUA)?  I really do not think
>  > we want to clutter format-patch output any more than necessary.
>
>  By the way, 'git send-email --compose' does not add MIME headers to
>  introductory message. All non-Ascii chars will output something
>  undefined in receivers' end.
>
>  I guess the right way would be to detect user's charset (locale) and add
>  appropriate MIME headers. Also, the Subject field should be encoded if
>  it contains non-Ascii characters.

I stuck this in my config and it works-for-me:

[format]
	headers = \
"MIME-Version: 1.0\n\
Content-Type: text/plain; charset=UTF-8\n\
Content-Transfer-Encoding: 8bit\n"

Shrug. (Never tried putting non-ascii in the subject tho.)

j.
