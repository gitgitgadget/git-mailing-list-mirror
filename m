From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Fsck configurations and cloning.
Date: Sat, 5 Mar 2016 21:18:42 -0800
Message-ID: <CA+P7+xozN8Ah9b1QxBFXEiO3=SsUq9J1r+XM5387AodfvXwRQA@mail.gmail.com>
References: <CAGbFckZNpy=2P8kpSsEpCeTFmgzE5MEK7fnS8xJzDSPJs3iJdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Ryne Everett <ryneeverett@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 06 06:19:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acR68-00051g-3i
	for gcvg-git-2@plane.gmane.org; Sun, 06 Mar 2016 06:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbcCFFTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 00:19:05 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37452 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbcCFFTD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 00:19:03 -0500
Received: by mail-ig0-f179.google.com with SMTP id z8so20277101ige.0
        for <git@vger.kernel.org>; Sat, 05 Mar 2016 21:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BUCP1biVN4yiDFHue8f3pwaH2BGLqbwvDGbof4OaOWM=;
        b=fpn447rdRQBV/BvWmssawijw/XnaaMSx8ibLE0kTwPmmH8QZ+ULuCaYJSrxRo31FmG
         sRq1Kv5sKSo7Keey/m8bxLiFv9FKBbgxXyFBGWrQYy+wnwo3/1c9B87ZPiUIxl1ZDHMR
         26KhGr3iIdaG6EUneMd3OV/vjkGxweQG+ONLy/AicowWq80oFbwJLnFDD4Qz7eQcbOfi
         dhmcy7x8BDi19tUtBJmRxZ+UCSbOwwy35Z7VdzyEvbzHUv3xeTrw4bsSmZPQz98Xex88
         UAH8SZ2DbBWEp4165giTEDnbd1XrETXGmCF9wwPkWIMq2Lbn13ep7YVhUcoKe7chDpkP
         8kgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BUCP1biVN4yiDFHue8f3pwaH2BGLqbwvDGbof4OaOWM=;
        b=AZYjfjFj5kJlNzyxuhcfZCFpzboBfy66bvJ/U0AU6/LLxrYkkuAwcctHtIWzitF7eg
         COB7w+jM5ABROdhlYborcc6UjspAGfmys8kdM5/192AAYExAFzWUoRPDhfHR7rImFGGD
         zbU8QELwDWFCcAp11uZLJWZbbmx+4qt4qWnG2kzcvpEiVRJe2vIQaatcl0EW7aDguKTG
         qF8va4KPvqX1apyTzLEhaH2XeRlYs5qTWKqUFCC6Z2ad8Utg5kid+7JLgsWYMl7EzpEd
         6MI3aLzxoPmUICbt+sEJpYoaRjGl4ihXFVGMNM8QjjVfJJb3j9rbN+pNti8x+/kiyWLW
         0Prw==
X-Gm-Message-State: AD7BkJLrluLensxjNL7m8HOB4XcVMHxJrh0hiENJaUyP9b5S03X+L3IlwVhVMDSDys9e5nOAHsjK6HDgbTfekg==
X-Received: by 10.50.137.35 with SMTP id qf3mr6412402igb.92.1457241542212;
 Sat, 05 Mar 2016 21:19:02 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Sat, 5 Mar 2016 21:18:42 -0800 (PST)
In-Reply-To: <CAGbFckZNpy=2P8kpSsEpCeTFmgzE5MEK7fnS8xJzDSPJs3iJdQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288337>

On Sat, Mar 5, 2016 at 5:44 PM, Ryne Everett <ryneeverett@gmail.com> wrote:
> I'm assuming fsck configurations are supposed to apply to clones but
> I'm having no luck:
>
>     $ git --version
>     git version 2.7.2
>     $ git config --get transfer.fsckobjects
>     true
>     $ git config --get fsck.badTimezone
>     ignore
>     $ cat $(git config --get fsck.skiplist)
>     5e6ecdad9f69b1ff789a17733b8edc6fd7091bd8
>     $ git clone https://github.com/kennethreitz/requests.git
>     Cloning into 'requests'...
>     remote: Counting objects: 16904, done.
>     error: object 5e6ecdad9f69b1ff789a17733b8edc6fd7091bd8:
> badTimezone: invalid author/committer line - bad time zone
>     fatal: Error in object
>     fatal: index-pack failed
>
> Am I doing something obviously wrong here?

You have to make sure the fields are set within a global git
configuration. Did you set this within a previous clone using "git
config"? If so you need to make sure you use "--global" option to
write it to your user configuration file so that it is persistent
across multiple repositories.

Not sure if that is what your problem was or not, it is unclear from
the information provided.

Thanks,
Jake
