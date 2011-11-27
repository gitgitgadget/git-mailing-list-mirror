From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Add test that checkout does not overwrite entries in .git/info/exclude
Date: Sun, 27 Nov 2011 17:13:13 +0700
Message-ID: <CACsJy8AXLBNSPmeEJjD1QX2zF1ic+S9kb_+4=EBO9xd07xhAYQ@mail.gmail.com>
References: <CAPRVejcpAZrLWCeHTZJr9Uk6_z6hTPQLLd6pCOKteYnRGMQ5ig@mail.gmail.com>
 <7vehx2ijf8.fsf@alter.siamese.dyndns.org> <20111120221930.GF14902@foodlogiq3-xp-d620.thebe.ath.cx>
 <7vzkfqgn91.fsf@alter.siamese.dyndns.org> <4EC9FC81.3080306@viscovery.net>
 <20111121081701.GA7985@do> <7vk46th5bz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Taylor Hedberg <tmhedberg@gmail.com>,
	Bertrand BENOIT <projettwk@users.sourceforge.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 27 11:13:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUbk7-000532-F7
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 11:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298Ab1K0KNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Nov 2011 05:13:46 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58745 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196Ab1K0KNp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2011 05:13:45 -0500
Received: by bke11 with SMTP id 11so6759690bke.19
        for <git@vger.kernel.org>; Sun, 27 Nov 2011 02:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PZmDQHnB05soyN/VuI0GKZWwMnpe0j2Dya+03KPimPw=;
        b=KPTixIAGLMO+zekFqJPB3QFWTkhSst5gI0a6du87vSeEXaVezFBfL9RJYYEozlAj6A
         +XVe1xM0mXhT9KCxGZPD0VNsM+Sa9DAfQBNatHnQTWYF3zHcgxdfU6JChpqfX0UbxJ89
         OaFNVupgodRkCILyUIy/aa3Z/9mgRBiZWVPYc=
Received: by 10.204.130.85 with SMTP id r21mr39802547bks.38.1322388824121;
 Sun, 27 Nov 2011 02:13:44 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Sun, 27 Nov 2011 02:13:13 -0800 (PST)
In-Reply-To: <7vk46th5bz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185980>

On Mon, Nov 21, 2011 at 10:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> In the medium term, I think one reasonable way forward solving the "TODO
> that used to be tracked but now untracked and ignored" issue is to
> introduce "info/exclude-override" that comes between command line and
> in-tree patterns. The info/exclude file is designed as the fallback
> definition to be used when all other sources are too lax, and comes near
> the precedence stack; the "TODO" situation however calls for an override
> that is stronger than the in-tree patterns.

Short term, should we allow an option to disregard ignored status
(i.e. all files are precious)? Something like [2/2]

[1/2] checkout,merge: loosen overwriting untracked file check based on
info/exclude
[2/2] checkout,merge: disallow overwriting ignored files with
--no-overwrite-ignore
-- 
Duy
