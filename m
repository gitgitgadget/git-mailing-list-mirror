From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v10 0/2] introduce --[no-]autostash command line flag
Date: Fri, 25 Mar 2016 03:23:51 -0400
Message-ID: <CAPig+cTqnev_YpamaSi1tkvWydZHRadBzo_zLnF1Pd6FyWKiTQ@mail.gmail.com>
References: <1458584283-23816-1-git-send-email-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Paul Tan <pyokagan@gmail.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 08:23:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajM6A-0005xd-Ht
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 08:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134AbcCYHXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 03:23:53 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:32989 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbcCYHXw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 03:23:52 -0400
Received: by mail-vk0-f67.google.com with SMTP id a62so6724773vkh.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 00:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=U0ymJ2Ql9TlL2FUIa33PTXASonMnqvAma1OilBryq8o=;
        b=oOKtD9p8uSzxw2bozmNDN0cWnLQdIIU/fbuoT5eBHXWAdcEZsOOOhrYOWW4ufqHxdz
         UhzxDACP37v8BIyJ3KgQVMKUSKgD12eNQeIeIBYfaLP+4W5yS1044EjF+14ub25z400/
         9EmSFJUmobjehvd1peYq3tEU+T6BOsuU3UmRwKOJ2rIpE7umUkF7JKX3xRsf2gd56GEM
         P6mEL50WX0qnNu0+z5yUD9LjOzhz+OKpUuvvw1lzjnsJMlakxNTDbYhbTH58EaZybdGk
         3VSJRbQXqdPOktj+gH60eRW1Y2fNXw4l0lI4zyyk/rNI/Ab/T2FWEPK9HB/yO+5NJOL2
         l5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=U0ymJ2Ql9TlL2FUIa33PTXASonMnqvAma1OilBryq8o=;
        b=SyRJ2InHveutn6m1ZML7C2c1173fPAdgA/0UgtULz3G88gBTmPX69sSSKXjRhrrscF
         x12vZXHt9EqQlHGqWMXmkcBmuT/KRLeg86A0WKO6HIkWsD6fCycJd9qa0s4JXvlpvYP9
         IRhn3RHSG08Ze5LxO/1tySShdLDkLvD5BU9u9DMgDC1zXhABa+Ck/RoLmS3BiNwo1U1h
         juFEKbXgk5rFXBQSwNukGEVQmEe8TKzrMO22rhcAH7t0nFzKybLudqfAFRzxaHzU3kdJ
         /Jf0UmkzKicczFNqAZ/ECLbkrP/R1DptaoinSCdHtPN2SI9s9pj09LYnQcqevwD+Dr9Q
         sk/Q==
X-Gm-Message-State: AD7BkJLtAxU90RCjgQP7cHPse592ZPrA8xKm+434I1CEk7ichL/lsOATMJ+IAU1l1bKVPBfUeDwf5f5PucThmQ==
X-Received: by 10.31.130.74 with SMTP id e71mr6473635vkd.117.1458890631622;
 Fri, 25 Mar 2016 00:23:51 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Fri, 25 Mar 2016 00:23:51 -0700 (PDT)
In-Reply-To: <1458584283-23816-1-git-send-email-mehul.jain2029@gmail.com>
X-Google-Sender-Auth: VQ0OLiy2MVy-IbcnA5Xo_5bRCP4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289859>

On Mon, Mar 21, 2016 at 2:18 PM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> Changes introduced w.r.t. previous patch:
> [...]
> * Two more tests are added to checkout for error when "git pull
>   --[no-]autostash" is called. Here I'm forced to use "test_i18ncmp"
>   instead of "test_i18ngrep" to compare the expected error message with
>   the actual because grep was, unfortunately, reading "--[no-]autostash"
>   as an option and thus leading to test failure.

Pass -e to grep to treat the next argument as an expression (even if
it happens to look like an option):

    test_i18ngrep -e "--[no-]-autostash ..."

You may also need to escape the [ and ] with backslash (\) to force
grep to treat them as literal characters rather than as the character
set "[no-]". Alternately, rather than escaping, also pass the -F flag
to make it treat all characters as literals.
