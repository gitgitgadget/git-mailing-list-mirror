From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] grep: stop looking at random places for .gitattributes
Date: Wed, 10 Oct 2012 19:51:15 +0700
Message-ID: <CACsJy8A4Ef3P+qjR6eJD1bH7XUNGBKCiwiMc6hhQYskxBwz8Ag@mail.gmail.com>
References: <7vk3uzfp3p.fsf@alter.siamese.dyndns.org> <1349868894-3579-1-git-send-email-pclouds@gmail.com>
 <1349868894-3579-4-git-send-email-pclouds@gmail.com> <5075615B.8020702@viscovery.net>
 <CACsJy8BG0HJNePG-j27SrfEenEkZ5a5nCdMEuDGn=qXxq=VzhA@mail.gmail.com>
 <50756646.5060505@viscovery.net> <CACsJy8CznUShZVdmvGz1bfHHpZ1ZEX3PRUPb0+NNq2ZnvZEzZg@mail.gmail.com>
 <50756D62.5030008@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 10 14:52:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLvlV-0007EK-EA
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 14:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755757Ab2JJMvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 08:51:47 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:50181 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748Ab2JJMvq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 08:51:46 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so735819iea.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 05:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1nQGHMH2wDvCL3RJlBmiqmmRzG166CeWU6TcbD/tENg=;
        b=nK4vn50OeB0QXmQa8F5bt+CvUjcqdpcKVwpSUUdJlWL6tTSwXbDrn5lEGxeDhTjhzW
         zqqbnxwDca9qEMWGw0TbJ8xzJuXriaZzrisg0p1CZPHIJPHXdKAxGN1LATSdCJ5JiuCm
         gwygx+cCjuWaIRtpgXV7RCiqXBN+J/y8JcNIYKylnEE6c7/TBpA/9S3bZ+oLJxkkLL7n
         DOjzeSLop2FlqBNDAGJYwlYvdLJCehvkdZAkUTPF3A1nWkCVXepDKRz/YkHP2BiYAJAj
         ZXSATLHLjcB8D4EU95OXAtJaszES8oN+zlYPabgn3t5+8fGAFg1ygkLpxm3CXz0za2yh
         QyXw==
Received: by 10.50.53.199 with SMTP id d7mr5143278igp.47.1349873506025; Wed,
 10 Oct 2012 05:51:46 -0700 (PDT)
Received: by 10.64.143.168 with HTTP; Wed, 10 Oct 2012 05:51:15 -0700 (PDT)
In-Reply-To: <50756D62.5030008@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207409>

On Wed, Oct 10, 2012 at 7:43 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 10/10/2012 14:32, schrieb Nguyen Thai Ngoc Duy:
>> git-archive has --worktree-attributes to specify where attributes come
>> from. Sparse checkout can choose to read index version first then
>> worktree's or the other way around. All normal operations read
>> worktree version, if not found index version.
>
> So, even if I run 'git diff master~2000 master~1999', it uses the
> attributes from the worktree, and if not found from the index? (I would
> not mind, BTW.)

Yes. Tested and verified.
-- 
Duy
