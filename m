From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [BUG] --bare is ignored before command word
Date: Wed, 18 Nov 2015 12:08:37 -0800
Message-ID: <CA+P7+xoD2-eDZQt29KBqZF2g4i+K7XhJG0mhUgqf5iDURBPntg@mail.gmail.com>
References: <loom.20151118T181639-5@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Ronny Borchert <mister_rs@web.de>
X-From: git-owner@vger.kernel.org Wed Nov 18 21:09:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zz92M-00012B-G3
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 21:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756851AbbKRUI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2015 15:08:58 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:34715 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755713AbbKRUI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2015 15:08:57 -0500
Received: by ioir85 with SMTP id r85so66155043ioi.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2015 12:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nBy6Yd1zp3npInXB5DJrRXenb0ScSa3VBpcWT2pWXro=;
        b=FxpuaX9EswpnlSS7nqV7ywJVtPJcI+UGBBe1/wxQ/VTR4CoiNCgMWYQdbNDOESAEae
         PqQF9mqfYuEOSXmPjkQ7eOsSfRX9mYpyslq+offZb/BxSyqLFVK1wi002tdlsOyDtYFV
         TiFIU2SHJ1fpqTBKqPJDOfhLw5p2TnlCMciugXJPpVjIUorBKZyNMLMUV9YaUCnANcGU
         AsInThuEqxIqZciLC/1NfWF1Tq5nOvvHZUBlgKilU1Iq25HtG8RfYjTdEsOu9EERWmue
         DpoX+DODiEhtQatIxiZL7LbKZ0Li8kWvtnJ6R4JFRclCRFKyXstq1cyPrpG86wRz+fnE
         kBxw==
X-Received: by 10.107.150.208 with SMTP id y199mr4852420iod.146.1447877336324;
 Wed, 18 Nov 2015 12:08:56 -0800 (PST)
Received: by 10.107.19.227 with HTTP; Wed, 18 Nov 2015 12:08:37 -0800 (PST)
In-Reply-To: <loom.20151118T181639-5@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281456>

On Wed, Nov 18, 2015 at 9:20 AM, Ronny Borchert <mister_rs@web.de> wrote:
> I was trying to clone a bare repository. Not sure why I did, maybe
> description on website was wrong.
> My try:
>
> git --bare clone https://github.....
>
> This was leading in creating a none bare repository! No error or warning
> message here!
> I guess this behavior is also for other --xxx commands.
>

This is how the git options work. Options before a command word are
always ignored. It may be better to warn about these options though,
so that they don't cause errors? The reasoning this is done is because
options between git and its command word are used to modify general
git behavior, while options after the command word modify each
specific command in their own way.

Regards,
Jake
