From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC PATCH 0/4] pathspec labels [WAS: submodule groups]
Date: Mon, 16 May 2016 07:03:50 +0700
Message-ID: <CACsJy8BU-zym6Nkmbs-jk66af1LwHaasybHBvBUJscU=eBOkQA@mail.gmail.com>
References: <20160513001936.7623-1-sbeller@google.com> <CACsJy8BK-u2VV3kkq3ANHCanYqMwphqgxZmooQfewA_J7e8MPw@mail.gmail.com>
 <xmqq60uf6v5d.fsf@gitster.mtv.corp.google.com> <xmqqfutj5d73.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 16 02:04:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b261N-0007LE-Ba
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 02:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbcEPAEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 20:04:22 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:32808 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbcEPAEV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 20:04:21 -0400
Received: by mail-yw0-f194.google.com with SMTP id y6so17454376ywe.0
        for <git@vger.kernel.org>; Sun, 15 May 2016 17:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8QxXRRcvNq7qvIhz1nMM5FiLWv5dv6dXzyv7uwPVNk0=;
        b=eoxZbngcGldZTCM9B1jeoNNdk5p2juYkIzEC3/UfDfWKt5WsxVad06W1FC88Utvfmm
         fj+uwNqbXppi0BWxxQ/yWg+wGnIdBdfLuTvoJkzWPb5Ah9FJblRt8Cl+5CCVBEBk/dJ2
         wFgiRw2uLwAl7PCxZ/hvH7lAUFgsDonxVEQpRjJktNnejF44yJgJq9k+A2C1tX+FwzQ1
         HU0cjKoplLomAwkbJ2J/tq3uN0j5BXwNjMWlRq7rrqF14qhgW7iLO7fn+H5Og5j3b3S/
         UXeMu1WgH/DSD/6cglrP6W3FRl043zHH5OzCftMVMb9kgnFRHhVkz5/JhXDE5nJAQ1jS
         hIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8QxXRRcvNq7qvIhz1nMM5FiLWv5dv6dXzyv7uwPVNk0=;
        b=AnRN84WLU3pEjpZfHjk6I9w/05GVyeHIQVSrl6MToI+ISWrOjNEal25bN72Jrlugsh
         3qfAwdDic/wBbOYqBkOmMbH1A1+aK4LVKPPzlXxDBDb5Fb62K1EKCKDlV0Y6pg5NAg9f
         Qkx88qmMiuWWqKyhxdXYM45xEzr5y+TGG0/fhGiKXIHbJIjVCqtprAbT2mIIy3ksw6IG
         PBki8klTa6wx5diU0KMferq3HhBxQk33aNI9B8rFzLWMIgMRCbEhOeZtvj/Whaw18jHZ
         kbmPyCiiNm3xWWs0v3DI8moeINhayDfSXIpt2IexgZckkR/gwJyTnB8YrPbmdVR1x8l+
         NwuQ==
X-Gm-Message-State: AOPr4FWYpTWjTZociYh6JzEk56XreouWiRxeREd9JEazd5p3bOcOxZ9PitQbtIfcTaNIpJHHW5nyqaLBJCDXtQ==
X-Received: by 10.37.72.195 with SMTP id v186mr12823037yba.101.1463357060009;
 Sun, 15 May 2016 17:04:20 -0700 (PDT)
Received: by 10.83.11.131 with HTTP; Sun, 15 May 2016 17:03:50 -0700 (PDT)
In-Reply-To: <xmqqfutj5d73.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294696>

On Mon, May 16, 2016 at 2:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> Instead of putting everything in under the same attribute name
>>> "label", make one attribute per label? Would this work?
>>>
>>> *.[ch] c-group code-group
>>
>> The attribute subsystem expects that there will not be unbounded
>> large number of attributes, so this is not a good direction to go.
>
> Having said that, I do not mind too much if it turns out that it is
> necessary to use an unbounded set of random attributes to solve a
> specific problem, if the use case is good.

I only have a vague idea so far, it seems to me a good idea to be able
to specify "binary-marked paths" or "filter attached paths" from
pathspec. We can already do this with scripts, but we need to be very
careful about quoting. And if it's pathspec it can be combined with
other magic (most likely negation)

> But even then, in order to avoid confusion and name clashes, I'd
> prefer to see more like
>
>         *.[ch] group-c group-code
>
> that is matched by
>
>         git cmd ':(group:c code)
>
> i.e. reserve a single prefix that is not and will not be used for
> other purposes.

For my above use case, i can still define macro group-binary that is
an alias of binary to get around this. So it's ok.
-- 
Duy
