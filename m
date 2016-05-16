From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 0/4] pathspec labels [WAS: submodule groups]
Date: Mon, 16 May 2016 10:20:52 -0700
Message-ID: <CAGZ79kacKnBjzVFSShRido4rKa3-Zg465d2320M6w1qXEkOZqw@mail.gmail.com>
References: <20160513001936.7623-1-sbeller@google.com>
	<CACsJy8BK-u2VV3kkq3ANHCanYqMwphqgxZmooQfewA_J7e8MPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 19:21:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2MCP-0006Qi-N6
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 19:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754132AbcEPRUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 13:20:54 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:33732 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbcEPRUx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 13:20:53 -0400
Received: by mail-io0-f177.google.com with SMTP id f89so217732182ioi.0
        for <git@vger.kernel.org>; Mon, 16 May 2016 10:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=egYFcyGt04sVrw6RepGFtinV1j6N+MDORzXvvjBAUeE=;
        b=A3ZLxnvpX9Fg2b8+pLcIX2rSEepT2kng37O5kXdy74VsV37w6WZLFL0p28Q1u5PqkP
         DVmttm9eympJ1N8btclz1m7do64DbKjaONEjfDHfQOSB7zzOU4xCUZJ37fByAM0yw9J+
         2gbPMvSqqZmhcXEGV338xJg6/oMbV5QXffwnrc00s6NF5804oL/Fx/BNAKI9XfAUamKc
         BmW4CuKWG1D8Ii61WhOkFhGwdDOzTnUB3IaqS7yDL65q9EPr9CCJToTkXfr15IjhSsE9
         D2npr8wZ9HDN43X05iRmmqOM3Ud9uVZiRlc2UzAg6hWguFjadeBN3d6KPCb7gTQAUvTP
         YtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=egYFcyGt04sVrw6RepGFtinV1j6N+MDORzXvvjBAUeE=;
        b=VFAZT+s7fz3oTjQ3PNQL3Fy+KcU4Kr5I7a5gxIAK1LjZOSZhBSiW6v+P9TRC+3FZnN
         IuCdTbwd1MrYDU9qWj5Lqp4tRRE4OOXMtToKBAqqlKe3j3Eg5qrEhFOS8HZN/go7lDGs
         KbFm1i8rb6B7Gqr9qFXO5h63zotREUjlDuDMyVTGSsBSZibp55Sucpo6OKxiro9RJuNk
         XT4rklwOlS0qaRBI6RQ5jtgVPprj4WfWFSaze+ddQIYA2ccGDDlRSq/D7K7Xw8AiAois
         zw0x7pqvPvcLAtEb8MSw2vGMaBm2OOhRuo2/MkkL4Hl+VhgqPuue9higvEmqHY8Nxc3z
         m49w==
X-Gm-Message-State: AOPr4FWCwuuXjY5XgTZlAo2cGn9aFQ20t092UYoSI8mMd67AFVKTdsjl1pLUgFrRvyYyK95L3V3+SWGdCXBQxf3O
X-Received: by 10.36.107.129 with SMTP id v123mr9673320itc.52.1463419252156;
 Mon, 16 May 2016 10:20:52 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 16 May 2016 10:20:52 -0700 (PDT)
In-Reply-To: <CACsJy8BK-u2VV3kkq3ANHCanYqMwphqgxZmooQfewA_J7e8MPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294758>

On Sun, May 15, 2016 at 3:06 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> Instead of putting everything in under the same attribute name
> "label", make one attribute per label? Would this work?
>
> *.[ch] c-group code-group
>
> And the pathspec magic name can be simply "attr", any git attribute
> can be used with it, e.g. :(attr:c-group)

So you want to be able to query something like:

    git ls-files ":(crlf=auto)"

as well?
