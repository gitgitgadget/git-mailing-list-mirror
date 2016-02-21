From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] t8005: avoid grep on non-ASCII data
Date: Sun, 21 Feb 2016 18:50:15 -0500
Message-ID: <CAPig+cQvuc+Gn1jsnYr0_wMe+fggtHyJPXx4dV=h5sMGWpGRuQ@mail.gmail.com>
References: <20160219193310.GA1299@sigill.intra.peff.net>
	<cover.1456075680.git.john@keeping.me.uk>
	<81ec83acd004ef050a4c8df62fb158b41f0a0a80.1456075680.git.john@keeping.me.uk>
	<CAPig+cQ9n4Eg73Uyeg_g_4wzebuwn8=0R-LMb8F9QLFxanwVVg@mail.gmail.com>
	<20160221231913.GA4094@sigill.intra.peff.net>
	<20160221234135.GA14382@river.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Feb 22 00:50:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXdlf-0004zc-2v
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 00:50:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbcBUXuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 18:50:17 -0500
Received: from mail-vk0-f53.google.com ([209.85.213.53]:36154 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbcBUXuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 18:50:16 -0500
Received: by mail-vk0-f53.google.com with SMTP id c3so115745387vkb.3
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 15:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=8cAhwvBmGfjjWUwBInsMX8jz9nzxWKRmxvaSN+YHwxg=;
        b=I4dJwy5QqQPH7sHWG/z6E4KuhoTtv8dcXwAexj01KaY1I2FDh7ly4h8I+7G+pFGE4r
         El3G/4de5REXNoBi83TpoTyMYv2GRw2UEl0XC717Syelq3TZIoL9WJ32m3ThbM28hJI6
         KGLuRiqeOAUccYbgFV4rX4ADI0g7C1cA72B5OPjSErcJzilDWlJK83CmbtqZqAwJG17U
         xkH1gifdlZA8RNXG5sQmNN5aYRKChrMwr8L2smw831xulwxUlT/ZkdKqbBEh/nXndMP7
         WwpC9PNxLBB+JAPtoQBuk55nRUYoqRZ21USNdnnuA7D1H51i6kIiLhsx3xpN4PUNbnRh
         pISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=8cAhwvBmGfjjWUwBInsMX8jz9nzxWKRmxvaSN+YHwxg=;
        b=SOmJsNgQUnoJxW179W5UMwJx4JoQuLb4bxCbDTImXhTXYIF9h/Alp9jByUNk0oUDRS
         BKHW6CpuATg2DIv3qxXZmJbmj9lytPDS5VcMAIBt359QyZFwkqVGP/H9Bxy+Zbi1UKMD
         vHJp3ncpOSODnrH8DGmuOmyYnZzMbs9ElCNFDzOp0Q/5gFoHJH3akk/av+kamyF/LBZe
         9ehGrhWrCdW5NHwcHBdauGWDgFU9p2+PU0zz+Q4fNNuXHd0gVhxQUdj/fzhJ0eENORre
         +bi0FS8khYP/G/AlvGRFmyOPgRpaKrJ3yQM55WI6wiYAL3EpFoDH81OQLqBacrhD/+Cz
         M6yQ==
X-Gm-Message-State: AG10YOR5eYJuz7d+wzCRN20RuAP+VOINUw1pynPmk9MZpF/YXxw6p7nDW70tPvKjI7p+Qz5t04ZI00Z5NeaeEQ==
X-Received: by 10.31.168.76 with SMTP id r73mr20821010vke.117.1456098615370;
 Sun, 21 Feb 2016 15:50:15 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 21 Feb 2016 15:50:15 -0800 (PST)
In-Reply-To: <20160221234135.GA14382@river.lan>
X-Google-Sender-Auth: 85-P4Uwm-qxK_UIy_sKWHCOdwEM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286852>

On Sun, Feb 21, 2016 at 6:41 PM, John Keeping <john@keeping.me.uk> wrote:
> On Sun, Feb 21, 2016 at 06:19:14PM -0500, Jeff King wrote:
>> On Sun, Feb 21, 2016 at 04:01:27PM -0500, Eric Sunshine wrote:
>> > These tests all crash and burn with BSD sed (including Mac OS X) since
>> > you're not restricting yourself to BRE (basic regular expressions).
>> > You _could_ request extended regular expressions, which do work on
>> > those platforms, as well as with GNU sed:
>> >
>> >     sed -nEe "/^(author|summary) /p" ...
>>
>> At that point, I think we may as well use grep, because obscure
>> platforms are probably broken either way.
>
> Also GNU sed doesn't understand "-E", it uses "-r" for --regexp-extended.

It actually does recognize -E in all the versions I've tested,
however, apparently it's undocumented (thus probably should be
avoided).

> My original sed version was:
>
>         sed -ne "/^author /p" -e "/^summary /p"
>
> which I think will work on all platforms (we already use it in
> t0000-basic.sh) but then I decided to be too clever :-(

The unclever version seems fine.
