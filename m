From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] remote-hg: activate graplog extension for hg_log()
Date: Sat, 6 Apr 2013 21:25:15 -0400
Message-ID: <CAPig+cShUBxRWhb+DOQjACm1wfRT+MBR712shkKveo1Rx9beDg@mail.gmail.com>
References: <CAMP44s1RhMR4vkUqbOOqQ+VAHVQgO8SCrBSSGNjCD-buGnb10g@mail.gmail.com>
	<1365267052-2604-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git List <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 03:25:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOeMG-0005sb-03
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 03:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161250Ab3DGBZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 21:25:18 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:47165 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759275Ab3DGBZR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 21:25:17 -0400
Received: by mail-lb0-f175.google.com with SMTP id o10so4777170lbi.34
        for <git@vger.kernel.org>; Sat, 06 Apr 2013 18:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=A2DYI9JMpQMw03qOv1/6AJA23O03DfWeqixlr+i6SwA=;
        b=nqO+4svocgaGfCGPRP9Rjt7QbnHZr0/woL5/3VHcrI43SHXHzbHdVCIneS/eHcEgMa
         pEbYnW4o4m4bgs6oYoCJZzxkGL6PfSIxXDTGhd4lNSqm1UeZUGzIhtXn/O3KAv1opXc2
         mjSWxp3y3e1T8L5gAvngG/zSqJfnOk0jmSWiQKqLOjqiVs4QXa4SaQC0v1oJRHUbRmFz
         1bDP9JyeW+PIitv5yfn86pyNQqPbDQVlvlqfMjiEZExeyRzF8VEj7vQvg1H2pbVAlXLF
         GNg1S/oeV7P7dr87aYtUcBZv3UQlEflWJ0qZxmJm8Usn3w+ch9XBDP9L7Hse+SLVHSdu
         79nw==
X-Received: by 10.152.47.242 with SMTP id g18mr9107472lan.42.1365297915609;
 Sat, 06 Apr 2013 18:25:15 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Sat, 6 Apr 2013 18:25:15 -0700 (PDT)
In-Reply-To: <1365267052-2604-1-git-send-email-apelisse@gmail.com>
X-Google-Sender-Auth: bRPz3TGSg1rWr7pjBoHn4XzegUM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220272>

On Sat, Apr 6, 2013 at 12:50 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
> remote-hg: activate graplog extension for hg_log()

s/graplog/graphlog/

> The hg_log() test helper uses the "--graph" parameter that is
> implemented by the GraphLog extension. If the extension is not activated
> by the user, the parameter is not available. Activate the extension in
> setup().
>
> Also changes the way we grep the output in hg_log(). The pipe operator
> can hide the return code of hg command. As a matter of fact, if log
> fails because it doesn't know about "--graph", it doesn't report any
> failure and let's you think everything worked.
>
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
