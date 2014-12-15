From: Klein W <wineklein@gmail.com>
Subject: Re: remote helper example with push/fetch capabilities
Date: Mon, 15 Dec 2014 16:42:56 -0500
Message-ID: <CAPCWLt4=oYTPFXktCj8CgqNncaO2=sbwZcPOVa+a5wgt7HPCUQ@mail.gmail.com>
References: <CAPCWLt6kxoJJSWAcyH_kW071Md0vc4zeo41hCKBQHd-_pvUMXQ@mail.gmail.com>
	<20141215204740.GI29365@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 22:43:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0dPy-0002Nw-Lb
	for gcvg-git-2@plane.gmane.org; Mon, 15 Dec 2014 22:43:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbaLOVm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2014 16:42:58 -0500
Received: from mail-la0-f68.google.com ([209.85.215.68]:63088 "EHLO
	mail-la0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbaLOVm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2014 16:42:58 -0500
Received: by mail-la0-f68.google.com with SMTP id gq15so2121019lab.3
        for <git@vger.kernel.org>; Mon, 15 Dec 2014 13:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=O5zk7kN8JVsbsioQLLLisPr7jcurM/Q2M1iqQ/ckEMU=;
        b=KW8NtCeqztHWMKLWSsxr1JHDDUM67qfbqcRSmmS9Is1ek0NlG7571xE85GRQILJ/lm
         F5jxPtAbnx8OYnzFXlUIe7Rk9TSJChMU+aigaIiPeuT/nflqCTV8g67kNRz9QlnetqDl
         zVQ6PokdbJXcQo+jVnXBsI5aw5Fj1kUMnfO8CUNsIqvzpXq/ajoP00Q0wyigZgwzeglk
         NtzQahKDj2/0km8fGkaHvd+kCY+aGCBDSZcBQoDA8E+7TYoGen/hXD0NZwQJ1UMkS/za
         O5GNut0b0Q8yCz3TVmKcTjB7Yf6t599lSCCy5vwnCbkp7bKkPRTe38XNW/ZHXIi4CHtl
         uPgQ==
X-Received: by 10.152.6.67 with SMTP id y3mr30874364lay.90.1418679776771; Mon,
 15 Dec 2014 13:42:56 -0800 (PST)
Received: by 10.114.216.100 with HTTP; Mon, 15 Dec 2014 13:42:56 -0800 (PST)
In-Reply-To: <20141215204740.GI29365@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261425>

On Mon, Dec 15, 2014 at 3:47 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Sure --- see remote-curl.c.
>
> There's also the "connect" capability.  builtin/remote-ext.c and
> builtin/remote-fd.c are examples using that one.

Thanks.

>> Also, what are the advantages and disadvantages of a remote helper
>> with push/fetch capabilities vs a remote helper with import/export
>> capabilities?
>
> It mainly has to do with what it is convenient for your helper to
> produce.  If the helper would find it more convenient to write native
> git objects (for example because the remote server speaks a
> git-specific protocol, as in the case of remote-curl.c) then the
> "fetch" capability will be more convenient.  If the helper wants to
> make a batch of new objects then a fast-import stream can be a
> convenient way to do this and the "import" capability takes care of
> running fast-import to take care of that.

I'm trying to write a remote helper for hosting git remotes on Amazon
S3.  Do you have any intuition about which capabilities would work
best for this case?

Thanks.
