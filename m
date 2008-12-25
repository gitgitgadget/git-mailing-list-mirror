From: skillzero@gmail.com
Subject: Re: git rev-list with --name-status?
Date: Thu, 25 Dec 2008 12:13:21 -0800
Message-ID: <2729632a0812251213h1de24995v9ad0a0df4e6967f8@mail.gmail.com>
References: <2729632a0812241453x4ae50362g4bcd3317e5be0429@mail.gmail.com>
	 <7vr63w84iy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 25 21:14:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFwbU-0002vH-UP
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 21:14:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbYLYUNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Dec 2008 15:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990AbYLYUNY
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Dec 2008 15:13:24 -0500
Received: from rn-out-0910.google.com ([64.233.170.184]:63500 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598AbYLYUNX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Dec 2008 15:13:23 -0500
Received: by rn-out-0910.google.com with SMTP id k40so2436361rnd.17
        for <git@vger.kernel.org>; Thu, 25 Dec 2008 12:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=d67LMY6KYymGfpGOyLS6qSp3VNV66dM5Bnun1omjfng=;
        b=V4tQT4lX2QWEa2/hIBt67/CJFSPyh7UlonPZSGQNQyAbWQCpPRZfqZmEhaOiRRzZao
         BLiYtmDSJ2NHCtztlcQaDjCaDw5E8vivS9KMv5yzNzdCDsBYBi1sGgiADTvWq2VJ1jho
         iwgeRi4JA6Zbj99x7OiTeMloeGOXHO+1T6FpY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=FNOAqTSPXTlnMCJo57+GO4CuQJOvfFBAqxTNv3hbK7RADib5SLmNzDABuQRm4HPNW4
         e5MWHa6hQBGhWFvxw02l2eIkX12lmEa5fFt6XP6F25fSuk4eLDoQAJSwKt2dWXKefzFr
         0xX2nLRl3wR9SjFjgLClnoxWOirhTzw0qLMe0=
Received: by 10.65.153.10 with SMTP id f10mr7855155qbo.70.1230236001144;
        Thu, 25 Dec 2008 12:13:21 -0800 (PST)
Received: by 10.65.192.6 with HTTP; Thu, 25 Dec 2008 12:13:21 -0800 (PST)
In-Reply-To: <7vr63w84iy.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103910>

On Thu, Dec 25, 2008 at 10:59 AM, Junio C Hamano <gitster@pobox.com> wrote:

> You seem to be referring to contrib/hooks/post-receive-email as "The
> script that comes with git".  It does have customization possibility
> already implemented and documented:
>
>    hooks.showrev
>       The shell command used to format each revision in the email, with
>       "%s" replaced with the commit id.  Defaults to "git rev-list -1
>       --pretty %s", displaying the commit id, author, date and log
>       message.  To list full patches separated by a blank line, you
>       could set this to "git show -C %s; echo".
>
> ...
>
> I think you can use "git show --name-status %s; echo" instead, if you like
> the --name-status output.

Thanks, that's perfect. I was using an older version of
contrib/hooks/post-receive-email that didn't have hooks.showrev so I
didn't realize it already had support for what I wanted.
