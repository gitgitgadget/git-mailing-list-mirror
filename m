From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] Make sure to use Araxis' "compare" and not e.g. ImageMagick's
Date: Tue, 24 Jul 2012 00:39:09 +0200
Message-ID: <CAHGBnuOXNb5NKB-aiSmciU7OQaGm_T-cn4JUSj5yS3bVVFiBUw@mail.gmail.com>
References: <500CF8CE.90906@gmail.com>
	<500CF9D2.30102@gmail.com>
	<500CFB19.6010905@gmail.com>
	<7vmx2qmnfw.fsf@alter.siamese.dyndns.org>
	<500DA7F3.3000403@gmail.com>
	<7v4noykxvm.fsf@alter.siamese.dyndns.org>
	<CAHGBnuOz94YR9wx_goL5YaWzPt5Z9c3gBB9CtyfcE40F5amrXw@mail.gmail.com>
	<7v629ejexo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 00:39:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StRHs-00036f-3Q
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 00:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754875Ab2GWWjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 18:39:11 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:64125 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754856Ab2GWWjK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 18:39:10 -0400
Received: by vcbfk26 with SMTP id fk26so5293624vcb.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 15:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Uz8HsQIl3LCHHGoyLGd8oQ0e7n3HeSsvWtL8V2pI4Cw=;
        b=H/0Is89dE3Q5fp8dMy5flApjrIhcf2hWl2jNke+QXqPdFXH8OE80pmOd2gYNaUSipv
         /gCfQIqFv90cBQ/H7Q6jQ36TfhUwkOnyEVK/HJ0ILoksNbsnXCmyy/09LnH9/3CluMJ/
         Wd8OJ+K2I70pTFuPLwDwc9Yg31lGOwgmrCV5eNhNPbgVcpV0NSmh+Jl87f5zayS9jly2
         23QVYD8kUGp2+RKtc28W2D8Y9UvX+uQqsFrdXoTY61j6/lIDdElMZar1RKYen3aMFkC0
         nI+ExCYqsO+BSs5tiPYDw8RuI+e44r3090rthTiQm0rPkn8OZgX3pnFoPz0gBkObYyrn
         KTEQ==
Received: by 10.52.100.165 with SMTP id ez5mr12165562vdb.108.1343083149226;
 Mon, 23 Jul 2012 15:39:09 -0700 (PDT)
Received: by 10.58.35.135 with HTTP; Mon, 23 Jul 2012 15:39:09 -0700 (PDT)
In-Reply-To: <7v629ejexo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201998>

On Tue, Jul 24, 2012 at 12:22 AM, Junio C Hamano <gitster@pobox.com> wrote:

> On the other hand, if the user has bought and installed Araxis, but
> we incorrectly identify it as unusable, the user has wasted good
> money and there is no easy recourse as far as I can see in your
> patch.

Agreed.

> If we limit the problem space by special casing Windows installation
> (e.g. check "uname -s" or something), would it make the problem
> easier to solve?  Perhaps it is much more likely that the path the
> program is installed in can be safely identified with a call to
> "type --path compare" (bash is the only shell shipped in msysgit,
> isn't it?), and its output is likely to contain "/Program Files/Araxis/"
> as a substring, or something?

Yes, I could come up with basically a variant of my first version of
the patch that is limited to Windows only and uses "type --path"
instead of "which", but then again this is too non-generic for my
taste. Moreover, as I'm also using Mac OS X, I'd be interested in a
solution that works there, too.

I don't see a good (read generic and concise) solution to the issue. I
think we should just drop my patch and not waste all of our time on it
any more.

-- 
Sebastian Schuberth
