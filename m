From: Noam Postavsky <npostavs@users.sourceforge.net>
Subject: Re: [BUG] A part of an edge from an octopus merge gets colored, even
 with --color=never
Date: Fri, 20 May 2016 18:12:59 -0400
Message-ID: <CAM-tV-9gAGBLsEh3=aa-bHT2DmJb=dfahq+kUW+0GLoc7eFq0w@mail.gmail.com>
References: <CAM-tV-_Easz+HA0GX0YkY4FZ2LithQy0+omq64D-OoHKkRe55A@mail.gmail.com>
	<573B6BF5.1090004@kdbg.org>
	<20160517194533.GA11289@sigill.intra.peff.net>
	<20160517195136.GB11289@sigill.intra.peff.net>
	<20160517195541.GC11289@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>,
	Hemmo Nieminen <hemmo.nieminen@iki.fi>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 21 00:13:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3sfJ-0000ID-N3
	for gcvg-git-2@plane.gmane.org; Sat, 21 May 2016 00:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbcETWNB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 18:13:01 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:34072 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbcETWNA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 18:13:00 -0400
Received: by mail-oi0-f41.google.com with SMTP id b65so55981744oia.1
        for <git@vger.kernel.org>; Fri, 20 May 2016 15:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=PztwdRUG83vUZEJyWAjABx5peJXIR4+c5XLjiLtXKnc=;
        b=cqF8v9TuUt94U6GzY662UlgtFnjB/dm6ggwtXyZAKIZVhihuHa0UafxPn8tZHLkwOi
         JCRBD75cmPWK0Ufe/gREBPfb5hf7oTp9NwquvqY1JFDtokFC0p0+0F98LtucHLPsivZd
         qB94sqDv6FjkiMkB/C5mFEhEH4oyYzL2eVfYCgJ78tQ39FxjgFZivpfq8HfuOVCIJW/D
         uCsrdg3Z3wkDhZ5oEiob2WlVFDEgtHqWfj68TEjLoGW0fJvS3I4leSPbOPvpK7OMVq9q
         V7/kfwLyuP8Si8iPd0ibTHasKfJo40ilJ+oAqz2Ndyi7nEvfpfGnG808EUDybbTkZ6vM
         ZxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=PztwdRUG83vUZEJyWAjABx5peJXIR4+c5XLjiLtXKnc=;
        b=jnoypKvyayJdusBqJv1c1LVDzmKphIgNo+2kUZjcxUUZZqPXwTFQCr8GEKVO4hTnYd
         Qjo637urDVguC1LctH6VtUtZEyujHiI8lguSNcpJH8Qn0X/LvLiAO99EuFKo3t+us0Sd
         qBF7zidc/DRMLa100AHpzqdzxXeVDu6gK0OOlZZC55MaErT4k83oJPiP4vQIPe64yiJj
         3IfreaiNC5jCizT0V70hND2eJSGLRr+0MlM3mYdpfZaqB2ooquzLDu381buqI931JoTv
         lnohKRDpQgi1DD75F3+vmjuuwFaueZL+s2CWUQoR77Mzt5QOY/BA93ORVDA20XBZSa8D
         3rXA==
X-Gm-Message-State: AOPr4FUgIgMIqWWt9r24IBeG18jpBKvnPmdKIo2+SKe7hqvxfmd8EayDk8rUzOHmYa7URfh+kLv8o2co/8hQ+A==
X-Received: by 10.202.245.16 with SMTP id t16mr2954215oih.178.1463782379474;
 Fri, 20 May 2016 15:12:59 -0700 (PDT)
Received: by 10.157.45.138 with HTTP; Fri, 20 May 2016 15:12:59 -0700 (PDT)
In-Reply-To: <20160517195541.GC11289@sigill.intra.peff.net>
X-Google-Sender-Auth: 4VBqxTWIToKLVIz9bq1I-fsTZOg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295213>

On Tue, May 17, 2016 at 3:55 PM, Jeff King <peff@peff.net> wrote:
>> (It's actually the first one which triggers). I'm not familiar enough
>> with the code to know whether the col_num computation is bogus, or
>> whether we needed to earlier increase the size of the "new_columns"
>> field.
>
> And unsurprisingly, reverting 339c17bc7690b5436ac61c996cede3d52c85b50d
> seems to fix this (author cc'd). It's the extra "commit_index" addition
> that causes the problem. But I'm still not sure what the correct
> solution is.

Looking at the coloured output, for some octopus merges where the
first parent edge immediately merges into the next column to the left,
col_num should be decremented by 1 (otherwise the colour of the "-."
doesn't match the rest of that edge).

| | *-.
| | |\ \
| |/ / /

For the other case where the first parent edge stays straight, the
current col_num computation is correct.

| *-.
| |\ \
| | | *

I'm not sure how to distinguish these cases in the code though. Is it
enough to just compare against graph->num_new_columns?
