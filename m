From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Failure to extra stable@vger.kernel.org addresses
Date: Tue, 20 Nov 2012 00:12:02 +0100
Message-ID: <CAMP44s0f0zYa1FVf9RhNuwYJbkQ7zPwgJ6=ty3c5knjo5a2TNw@mail.gmail.com>
References: <20121119095747.GA13552@arwen.pp.htv.fi>
	<20121119151845.GA29678@shrek.podlesie.net>
	<7vk3thxuj2.fsf@alter.siamese.dyndns.org>
	<20121119225838.GA23412@shrek.podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Felipe Balbi <balbi@ti.com>,
	git@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Krzysztof Mazur <krzysiek@podlesie.net>
X-From: git-owner@vger.kernel.org Tue Nov 20 00:12:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaaVp-0000aA-2s
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 00:12:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325Ab2KSXME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2012 18:12:04 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:40300 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502Ab2KSXMD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2012 18:12:03 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so5383561oag.19
        for <git@vger.kernel.org>; Mon, 19 Nov 2012 15:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EJYhREUt+NviTlTC2MaUHMt6jlOrRl5M4E7FkZYUUZo=;
        b=QguLAqQU27ylLPwEVtU9MHtVY6I8q1XGXqrXD/l2zbT30HW0O8Mx+sexdE4UXRUkc5
         jxHh/3z9INadZrxCK6RPTzNmoPb0qbgaAVtSJ5nwvqeMPGcjpFNPFjEROFXdxWblSv+p
         xDC0SZKZzjci7UGgqzL18s9YVyNWNAnO83bQKKnRROzb2/XwK8bBbXtDIf5d50M9Z67w
         O6EPxbKNpMHjNF1S5EdPNWeSq/tCnpjLC+nBB/IszebbjpBFlZ80B/bXkqXKqi8UCxVc
         5BqLASsqui9Iboka6R4Vlq4oaxjd9MIGV3VUXJDmpdoGeV3rGunAGPEpfFhd9gsZTmhf
         hG2A==
Received: by 10.182.194.70 with SMTP id hu6mr11932581obc.4.1353366722406; Mon,
 19 Nov 2012 15:12:02 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Mon, 19 Nov 2012 15:12:02 -0800 (PST)
In-Reply-To: <20121119225838.GA23412@shrek.podlesie.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210064>

On Mon, Nov 19, 2012 at 11:58 PM, Krzysztof Mazur <krzysiek@podlesie.net> wrote:

> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -924,6 +924,10 @@ sub quote_subject {
>  # use the simplest quoting being able to handle the recipient
>  sub sanitize_address {
>         my ($recipient) = @_;
> +
> +       # remove garbage after email address
> +       $recipient =~ s/(.*>).*$/$1/;
> +

Looks fine, but I would do s/(.*?>)(.*)$/$1/, so that 'test
<foo@bar.com> <#comment>' gets the second comment removed.

Cheers.

-- 
Felipe Contreras
