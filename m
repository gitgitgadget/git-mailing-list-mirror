From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] clone: support atomic operation with --separate-git-dir
Date: Sun, 6 Jan 2013 15:49:14 +0700
Message-ID: <CACsJy8Dbe1+e4-XjB+S=kvXyi_Hdt4CQ6K1Z1V-4sqaYekKPWw@mail.gmail.com>
References: <50E74145.4020701@gmail.com> <7vzk0osjli.fsf@alter.siamese.dyndns.org>
 <50E83224.2070701@web.de> <50E83DAE.1080500@web.de> <50E88A40.9010904@web.de> <7vfw2eq0a0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org,
	Manlio Perillo <manlio.perillo@gmail.com>,
	"W. Trevor King" <wking@drexel.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 09:50:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trlvh-0002i4-UK
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 09:50:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658Ab3AFItq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 03:49:46 -0500
Received: from mail-oa0-f48.google.com ([209.85.219.48]:46539 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab3AFItp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 03:49:45 -0500
Received: by mail-oa0-f48.google.com with SMTP id h2so16457182oag.21
        for <git@vger.kernel.org>; Sun, 06 Jan 2013 00:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=N/oxWKvUFkaK4t1aYipix00xdYHOIcIWX0DmaAVD0GY=;
        b=M5lp+jqea/sA6DFYpKG1sb2Y2wlrXBQBmEe3wTexKJLcShl5Tn3itFo4vZGCZTjeUY
         T53z4MGuNvfHAzf6bOv0D8V23DX5aVpzEahdLr37/KoOcISWRthk43h30AzFGAZEOgcX
         20DMrEL1m2nkQbOPwJnQMbYhB/mQhJ1yBzZZID97o9HmLyiAX0C5CERRqy7yHtwTOjg0
         7Rs34kQ/9xIwwUCLRnY3KsSTXm3EPOpxFaZvpdlLeqyvN/Mp5kXLTz4/k2dhObIp1gzL
         mvzh27XAyY5Q7/si9CzkU0aWx+UISDZeKzElXspoxdDnNOk58qIQ9Uw4EzJPm5gq8Li1
         cCGg==
Received: by 10.60.32.44 with SMTP id f12mr33140604oei.61.1357462184777; Sun,
 06 Jan 2013 00:49:44 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Sun, 6 Jan 2013 00:49:14 -0800 (PST)
In-Reply-To: <7vfw2eq0a0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212785>

On Sun, Jan 6, 2013 at 1:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> How is the file that points at the real git dir removed with this
> fix, by the way?

It's part of the worktree cleanup, pointed by junk_work_tree. And
because junk_work_tree is not set up for --bare, I guess we still need
to fix "--bare --separate-git-dir" case, or forbid it because i'm not
sure if that case makes sense at all.
-- 
Duy
