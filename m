From: Daurnimator <quae@daurnimator.com>
Subject: Re: [PATCH] git-stash: Don't GPG sign when stashing changes
Date: Tue, 12 Apr 2016 12:46:40 +1000
Message-ID: <CAEnbY+eaReDYOH8azpSG7n7MOrvqORkC0ar80pd1m8wR4vv20A@mail.gmail.com>
References: <00000150dddb0eeb-b77240fb-1b63-4676-ac4b-1220b8d011ca-000000@eu-west-1.amazonses.com>
	<loom.20160407T042319-468@post.gmane.org>
	<alpine.DEB.2.20.1604071017510.2967@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	me@cameroncurrie.net
X-From: git-owner@vger.kernel.org Tue Apr 12 04:46:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apoLu-0006eU-B0
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 04:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561AbcDLCqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2016 22:46:50 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33640 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbcDLCqt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 22:46:49 -0400
Received: by mail-lf0-f67.google.com with SMTP id p64so575671lfg.0
        for <git@vger.kernel.org>; Mon, 11 Apr 2016 19:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daurnimator.com; s=daurnimator;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=p5EipouWrQz2l6jO0qB86oZbsvyFtSNGZA2KIAC7VRw=;
        b=d4mkPnzGOz5AVQgTffWEFbgRl8LBEDxcXM6d/TfPvcx0/lajD/mXcmNh10jCjuSgBC
         F5rxo0vdKIjM07c78JDXLLWNUWQHXrOY0s+SorfViALR85puS5y+ZAVO2qefLmBO5t+Y
         bWyqEQdaKIuP3ACLYBSvH7JKNdILFJPcx+KTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=p5EipouWrQz2l6jO0qB86oZbsvyFtSNGZA2KIAC7VRw=;
        b=KataqFYcXPyi6nQ3y0GZ2+slfWdVPq1rbJoDsmZY1CAY2g8ors85zE9glaH4tIsucc
         q4sW1U88p7lmorOlAfQWCvX9AFbfyhFePuXSNrW9JM/o4S94HnTVd+ceTLX9H+c44Ohi
         oiNCm57fUD+q0FwQIQbP2QUuw3G0mzm+u2WqB8cEdsBDxR0yAcCcUqEIAH2kUc7xsbO9
         QFQc9XT7U14nBf6oabHBXiCoPKXRVqMtsfE1V76XyViBjD3ZIWaWeaVNUwFfvlyKXCNc
         hh8/X0XLoSF8u7PUxtdLQFftc/M+LancdfcoskMwdoh3NV3hA7LzcVHudtvZ9hwx4om1
         IKrw==
X-Gm-Message-State: AOPr4FVveCIK++iphQKMpqDOLOwylZOMf4wkjppIvrTavRdxMTd2D2JFqdPJjIanUi60zA==
X-Received: by 10.25.23.195 with SMTP id 64mr266752lfx.82.1460429207885;
        Mon, 11 Apr 2016 19:46:47 -0700 (PDT)
Received: from mail-lf0-f45.google.com (mail-lf0-f45.google.com. [209.85.215.45])
        by smtp.gmail.com with ESMTPSA id rp10sm4916975lbb.13.2016.04.11.19.46.41
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Apr 2016 19:46:45 -0700 (PDT)
Received: by mail-lf0-f45.google.com with SMTP id g184so6140097lfb.3
        for <git@vger.kernel.org>; Mon, 11 Apr 2016 19:46:41 -0700 (PDT)
X-Received: by 10.25.218.1 with SMTP id r1mr338598lfg.130.1460429200673; Mon,
 11 Apr 2016 19:46:40 -0700 (PDT)
Received: by 10.25.146.16 with HTTP; Mon, 11 Apr 2016 19:46:40 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1604071017510.2967@virtualbox>
X-Gmail-Original-Message-ID: <CAEnbY+eaReDYOH8azpSG7n7MOrvqORkC0ar80pd1m8wR4vv20A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291241>

On 7 April 2016 at 18:19, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> you dropped the Cc: list. So most likely Cameron won't get your mail nor
> any response to your mail.

I originally replied via the gmane web interface, apparently it
doesn't CC the original sender.
CCd now.

> On Thu, 7 Apr 2016, daurnimator wrote:
>
>> Cameron Currie <me <at> cameroncurrie.net> writes:
>> > This is helpful for folks with commit.gpgsign = true in their .gitconfig.
>>
>> > https://github.com/git/git/pull/186
>>
>> I too would like this.
>> Bumping due to lack of attention.
>
> It lacks a Sign-off, our convention is to continue in lower-case after the
> colon in the commit's subject, and I think that it would be good to write
> so much as one paragraph in the commit message.
>
> Ciao,
> Johannes

Cameron, able you able to complete this?
