From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] t3700 (add): add failing test for add with submodules
Date: Mon, 8 Apr 2013 21:04:13 +1000
Message-ID: <CACsJy8CCepx5njpMo40608vHf5mQ_VfeZA_e5KDaH98V8_o0-w@mail.gmail.com>
References: <CACsJy8BAQUms9sgNh5_VFOx0_9LkobytjDk33VB+U_J-S44o_A@mail.gmail.com>
 <1365416809-4396-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 18:28:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPEvV-0003oz-Rw
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 18:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762507Ab3DHLEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 07:04:45 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:57151 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057Ab3DHLEo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 07:04:44 -0400
Received: by mail-ob0-f177.google.com with SMTP id uz6so5516520obc.22
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 04:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=hRpiyrJhdZsBAeI7flYrBy4tXG0E1DfvLEo/BLmwtzw=;
        b=fecu0GlTqnMF02rVZ1ILMR2frEAs6Tm1aHhDe0J0cYyBDy8M3noVGUdb65zpLZvPax
         CxeKdap6GgvltTkOHdRps8rBIASkM87smPRVdjWYEJcFoNQfeXZqGI8ES14cQG0M8bK7
         iPuZDDNJNDpzb0t8n7buAOSlvtyCAwHax+qaZFpC9zDY+L4++xzYtYRAqnGsR+zMfJJR
         fllox5eGigti65mQc9hs6H3+KwV8QHo1r0sauvYSVuwmJV2GGO7irbqJqj2/y10rJL7V
         ISldV87qBU+Hl3G1veT4am07s1TSKRT7ahKbuJC0u1Y+GkIaqWSJWPM4Uwo7O2P9+OOu
         YS+g==
X-Received: by 10.60.103.165 with SMTP id fx5mr15248710oeb.4.1365419083951;
 Mon, 08 Apr 2013 04:04:43 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Mon, 8 Apr 2013 04:04:13 -0700 (PDT)
In-Reply-To: <1365416809-4396-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220418>

On Mon, Apr 8, 2013 at 8:26 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> +test_expect_failure 'git add should not go past submodule boundaries' '
> +       mkdir submodule_dir &&
> +       (
> +               cd submodule_dir &&
> +               git init &&
> +               cat >foo <<-\EOF &&
> +               Some content
> +               EOF
> +               git add foo &&
> +               git commit -a -m "Add foo"
> +       ) &&
> +       git add submodule_dir/foo

Thanks. I yhink the last line above should be "test_must_fail git add
...". I'm half way of fixing it (I think treat_leading_directory is a
bit loose). Will continue tomorrow (or this weekend, depending on
$DAYJOB)
--
Duy
