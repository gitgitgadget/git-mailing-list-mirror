From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 4/4] gc --aggressive: three phase repacking
Date: Tue, 18 Mar 2014 12:16:04 +0700
Message-ID: <CACsJy8DZsH_2CpaUUpc5xyunHD42CN24m6Mb+9vsKyaRqJ6q3w@mail.gmail.com>
References: <1394976904-15395-1-git-send-email-pclouds@gmail.com>
 <1394976904-15395-6-git-send-email-pclouds@gmail.com> <20140318045050.GB8240@sigill.intra.peff.net>
 <20140318050727.GA14769@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 18 06:17:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPmOa-0005ev-7I
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 06:17:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbaCRFQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 01:16:36 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:48452 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbaCRFQf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 01:16:35 -0400
Received: by mail-qg0-f45.google.com with SMTP id j5so19743147qga.4
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 22:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=M14y6uTm6zHNP1eO+5WOX08WQS7Fi5Y5f6xBSbPETds=;
        b=ViAYDgwdSn2Gplfk/Qw7j5rqV08xlnjKUrckXAlbeTENNHq4lKSu1r+zSMd/u1Jqoo
         S3tBJqGOFobCpBnhpdENpI1Jh0MjmBHcrqyKXtUCl44pIONmoxG7EadhQYc++bXfkAsy
         bTVwG5OF4jSOSaIFFGjGO7lSmRLP07I4Ov5tdoNuugLCYPuC2TsWZ1LqzDqH2hvfeJQx
         8UT2ZlZoeHFvOajdqTIvRrlyyQ1TRDjP+1FeirXkl/De2UBQCo/BeeSOe6L3j6qE5WhK
         KKI8xXiHK0TBO+BRP284qbKeTl8KCipqMefAdZGr+/XfLM5qoDSKbiUue1+khONmgiUc
         vXBQ==
X-Received: by 10.140.91.228 with SMTP id z91mr31362407qgd.32.1395119795056;
 Mon, 17 Mar 2014 22:16:35 -0700 (PDT)
Received: by 10.96.146.102 with HTTP; Mon, 17 Mar 2014 22:16:04 -0700 (PDT)
In-Reply-To: <20140318050727.GA14769@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244332>

On Tue, Mar 18, 2014 at 12:07 PM, Jeff King <peff@peff.net> wrote:
>   [before]
>   real    0m28.824s
>   user    0m28.620s
>   sys     0m0.232s
>
>   [after]
>   real    0m21.694s
>   user    0m21.544s
>   sys     0m0.172s
>
> The numbers below are completely pulled out of a hat, so we can perhaps
> do even better. But I think it shows that there is room for improvement
> in the delta base cache.

There is definitely room for improvement in delta base cache:
increasing cache size, better eviction strategies.. But I think it's
orthogonal to gc --aggressive improvement. From what Linus described
---aggressive is more for archival purposes but I think people have
been using it for upstream repos as well. Better packed repos could
speed up current clients immediately (although this argument is
somewhat flawed, server updates are usually at slower pace than
clients..).
-- 
Duy
