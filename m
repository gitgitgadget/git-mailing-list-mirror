From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] receive-pack, fetch-pack: reject bogus pack that records
 objects twice
Date: Thu, 17 Nov 2011 12:51:43 -0800
Message-ID: <CAJo=hJtYYZqSowCLrBH02MrQyiuQFmTTxY2dHP9mOQQRqA5Z-Q@mail.gmail.com>
References: <7v7h2znv36.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 17 21:52:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RR8wN-0004mH-Cs
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 21:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831Ab1KQUwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 15:52:06 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55738 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab1KQUwE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 15:52:04 -0500
Received: by ggnb2 with SMTP id b2so1620120ggn.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 12:52:04 -0800 (PST)
Received: by 10.236.128.226 with SMTP id f62mr241996yhi.104.1321563124053;
 Thu, 17 Nov 2011 12:52:04 -0800 (PST)
Received: by 10.147.167.10 with HTTP; Thu, 17 Nov 2011 12:51:43 -0800 (PST)
In-Reply-To: <7v7h2znv36.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185609>

On Wed, Nov 16, 2011 at 22:04, Junio C Hamano <gitster@pobox.com> wrote:
> When receive-pack & fetch-pack are run and store the pack obtained over
> the wire to a local repository, they internally run the index-pack command
> with the --strict option. Make sure that we reject incoming packfile that
> records objects twice to avoid spreading such a damage.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Looks sane to me. I thought this would be more difficult to catch and
report to the user. :-)
