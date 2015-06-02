From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFCv2 13/16] fetch-pack: use the configured transport protocol
Date: Tue, 2 Jun 2015 16:55:02 +0700
Message-ID: <CACsJy8CYKi_MTV+FUSFmTSMR3zu-Ks5pe_b4=HVn-msur=D4yA@mail.gmail.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com> <1433203338-27493-14-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 11:55:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yziv4-000676-Lu
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 11:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141AbbFBJzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 05:55:35 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33906 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753594AbbFBJzd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 05:55:33 -0400
Received: by igbhj9 with SMTP id hj9so82249194igb.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 02:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xxfaVAXEA21xIPLsODUsDjkz5RfYJNTrphC4N3k7EZs=;
        b=GoZk34mvvN54/r/5XP91Dco8elhjcNDeobDNIklY8bSUqEU1Po+cApgqj1VGFuWG+1
         re40Qo3YhVJ3rsJkQRvmLlmIUiyXWPqSWKKxczFi1IRfDQhJTltsn/SByBBRfEekHRGB
         r4WIsSHa8Fl4rDXJa+A21eX9KJJ/EzQDfB3rENYmUCXlTa3wMax1Nvw5INXtHMaC2ERK
         skOv1M9yfhudJb1+A9RKwLuBEfC408HigXw1WsYkuoaUwE9skQoGKh9NSSP7cFwSqvRX
         ydhRuaLV0Quc0xou0KdFCOE9vekLGQFzA86nNtxGH3GrUOBbfT5tRPLcNrkw7WL0/r2w
         USWw==
X-Received: by 10.50.79.231 with SMTP id m7mr19063311igx.41.1433238933242;
 Tue, 02 Jun 2015 02:55:33 -0700 (PDT)
Received: by 10.107.6.9 with HTTP; Tue, 2 Jun 2015 02:55:02 -0700 (PDT)
In-Reply-To: <1433203338-27493-14-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270514>

On Tue, Jun 2, 2015 at 7:02 AM, Stefan Beller <sbeller@google.com> wrote:
> @@ -127,6 +128,10 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
>                         args.update_shallow = 1;
>                         continue;
>                 }
> +               if (!skip_prefix(arg, "--transport-version", &arg)) {

I think this line should be "if (skip_prefix(arg,
"--transport-version=", &arg)) {".
-- 
Duy
