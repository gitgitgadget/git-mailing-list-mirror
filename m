From: Christian Couder <christian.couder@gmail.com>
Subject: Re: git bisect replay produces wrong result
Date: Mon, 31 Aug 2015 09:54:47 +0200
Message-ID: <CAP8UFD2sAyQp6uUuBBdmGtU1+9heE14pivJs8n8a84UY22yJsQ@mail.gmail.com>
References: <8737z15r1d.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Neil Brown <neil@brown.name>
X-From: git-owner@vger.kernel.org Mon Aug 31 09:54:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWJvZ-0007tE-A7
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 09:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbbHaHyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 03:54:49 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:34800 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756AbbHaHys (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 03:54:48 -0400
Received: by vkhf67 with SMTP id f67so34329193vkh.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 00:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vwCy0il7N5wgNNTxAxZhZNPBumRqxqAKhC1onRimrm8=;
        b=0TRq30NYlaa9N38iIFtT+DgP7CKfkGO8jPsVp7kOK2pfFZYZj8R6mFpZcTEEmul89g
         IEtGKD616DZoH6peDp/93ughXZmkPYCFol1dfdjUvyFx8M3Mpp3zH6kS1cOLoEuJ5Gm4
         MGdgUTgPNAHNaXwaxY4HIpyoHoNsG9Cv2vXcRypl2x7P5U9cxk8ACXBJbUtlibf10/su
         qNF5gejkDi8smXTYqh6HCLxMGum4670U8fM1wf/VqqBEDKaJwqiZCgrtCFfqK16b7rkk
         SeuFyyMt0nE5DFe5rxJDTiUGE4bP8tHTXzV6Hb4ekHCdncUWuvLiDOcC38xdt4ezRKuU
         CALA==
X-Received: by 10.52.52.133 with SMTP id t5mr20184732vdo.56.1441007687947;
 Mon, 31 Aug 2015 00:54:47 -0700 (PDT)
Received: by 10.31.13.201 with HTTP; Mon, 31 Aug 2015 00:54:47 -0700 (PDT)
In-Reply-To: <8737z15r1d.fsf@notabene.neil.brown.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276853>

Hi,

On Sun, Aug 30, 2015 at 6:38 AM, Neil Brown <neil@brown.name> wrote:
>
> Hi,
>  the following git-bisect log - applied to a recent linux-kernel tree
>  produced different end results when I use "git bisect replay"
>  and when I just run it as a shell script.
>
> $ git bisect replay /tmp/log
> We are not bisecting.
> Bisecting: a merge base must be tested
> [2decb2682f80759f631c8332f9a2a34a02150a03] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
>
>
> $ bash /tmp/log
> ....
> Bisecting: 2 revisions left to test after this (roughly 1 step)
> [57127645d79d2e83e801f141f7d03f64accf28aa] s390/zcrypt: Introduce new SHA-512 based Pseudo Random Generator.
>
> Is "git bisect replay" doing the wrong thing, or am I confused?

I think you are right and "git bisect replay" is buggy.
"git bisect replay" should display the same thing.
I will take a look at fixing this.

Thanks for the report,
Christian.
