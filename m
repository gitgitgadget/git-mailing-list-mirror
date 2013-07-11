From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 1/4] builtin: add git-check-mailmap command
Date: Thu, 11 Jul 2013 09:31:25 +0700
Message-ID: <CACsJy8C6_ycum9RfxgfB0Xa2U7Fk02NyED5VvH6o1pExkcV6vA@mail.gmail.com>
References: <1373483041-27901-1-git-send-email-sunshine@sunshineco.com> <1373483041-27901-2-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Marius Storm-Olsen <marius@trolltech.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 04:32:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ux6fo-0002iu-DR
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 04:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755325Ab3GKCb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 22:31:56 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:52604 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754950Ab3GKCbz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 22:31:55 -0400
Received: by mail-ob0-f169.google.com with SMTP id up14so9461584obb.14
        for <git@vger.kernel.org>; Wed, 10 Jul 2013 19:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=O70qk6Ci0dh3VI7gLQ8vquXgMLn+c1BgYcPdqVG0E8U=;
        b=PA8gU4ZhWeL6msXkjlHFBdAM6vlU1QMiS21ma0Bt+P/hvOCWva/LJ6DB3AOU2ArnZd
         qelLZPETXIE0ZLhV2rHNVIa9Y6QD5B/htAiQ/bHZkj1SDu3Lg4Se6FRartUOiwcaXBts
         kotD0N0h2+HQQp8Vrn3gXhLPJGiTKLFCuVpyaupvmUXA6mq4hexFoG0VmNgP0c3Ywudc
         e+czYIgLWaW5292OwFIpESVWhGYdWIaAmhQNXChxGIzZDp+eNn4LFGVQb1mSq39sXmy0
         6jM96DoMLtErPlb+OuHPXDz3flcuyFeeLhtFHjyeIAKKQSor5HnyFJeuyHOxPViisxkl
         rK8Q==
X-Received: by 10.182.142.104 with SMTP id rv8mr25481639obb.3.1373509915262;
 Wed, 10 Jul 2013 19:31:55 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Wed, 10 Jul 2013 19:31:25 -0700 (PDT)
In-Reply-To: <1373483041-27901-2-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230075>

On Thu, Jul 11, 2013 at 2:03 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> +static const struct option check_mailmap_options[] = {
> +       OPT_BOOLEAN(0, "stdin", &use_stdin,
> +                   N_("also read contacts from stdin")),
> +       OPT_BOOLEAN('z', NULL, &null_out,
> +                   N_("null-terminate output lines")),

I think OPT_BOOLEAN is deprecated in favor of OPT_BOOL (or OPT_COUNTUP
if you really want -z -z -z to mean differently than -z)

> +       maybe_flush_or_die(stdout, "contact to stdout");

On error this function will print

write failure on 'contact to stdout'

maybe maybe_flush_or_die(stdout, "write contact to stdout") or
something? From i18n point of view, maybe_flush_or_die should not
compose a sentence this way. Let the second argument be a complete
sentence so that translators have more freedom. But that's a different
issue.
--
Duy
