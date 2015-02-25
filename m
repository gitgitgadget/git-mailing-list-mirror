From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Wed, 25 Feb 2015 19:44:41 +0700
Message-ID: <CACsJy8BN2imGCW0cueh-jGKfN_nRg3=J-GTX2P5h2z0Tu=id6A@mail.gmail.com>
References: <1424747562-5446-1-git-send-email-sbeller@google.com>
 <CACsJy8BSf2h_xD-Q1tudAg_xCzffRQM+7xzUgprONxD7vM5RYw@mail.gmail.com>
 <CAPc5daVbrUaU6LFM65evru0+1tBT916+0AOyids=f7DZThTPGw@mail.gmail.com> <CAGZ79kbZHtZuPrb6rEP41vbdnZqJmsMwq+8pNer-_D4U5B1xZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 13:45:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQbL6-0006XZ-JY
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 13:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbbBYMpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 07:45:13 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:50569 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbbBYMpM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 07:45:12 -0500
Received: by mail-ig0-f181.google.com with SMTP id hn18so5360333igb.2
        for <git@vger.kernel.org>; Wed, 25 Feb 2015 04:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bDLk7EtYyEU4Q7/5H4ufgxPhmxVemAheRrS+OVBnTpE=;
        b=ocGDneMXMxRnKMvtNZPVwWju8KAd8V23i+I1lchbFTAZwxsS9XEAM/4VqY0qDNHnxp
         6SH3KGIzdokNbRz4vGsc+qHN0A98bN7VRnORsmDWYgwUsLZLJlBp56RKdnpOF0wZVFkb
         ALI8xOKkGtYqVVtwpeTX84Tb2qUSCBB8oJU9efSTvtdpLjWmnyX+06eN00bB73kM9ryK
         t/pDRE0pgigfIFbdwDCCllp303WQmrfKq0A8hp2Hx/18DylSzjesygI6xDHs7j0vt6d9
         AezvXk1uPC0KpH09wkmRWoY2W6+ciXoP+Gm8SPuKNpJlp37PoxSkhZ7X3gvy4aOJwh2d
         HOEA==
X-Received: by 10.42.44.199 with SMTP id c7mr3715065icf.0.1424868311855; Wed,
 25 Feb 2015 04:45:11 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Wed, 25 Feb 2015 04:44:41 -0800 (PST)
In-Reply-To: <CAGZ79kbZHtZuPrb6rEP41vbdnZqJmsMwq+8pNer-_D4U5B1xZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264390>

On Wed, Feb 25, 2015 at 6:37 AM, Stefan Beller <sbeller@google.com> wrote:
> I can understand, that we maybe want to just provide one generic
> "version 2" of the protocol which is an allrounder not doing bad in
> all of these aspects, but I can see usecases of having the desire to
> replace the wire protocol by your own implementation. To do so
> we could try to offer an API which makes implementing a new
> protocol somewhat easy. The current state of affairs is not providing
> this flexibility.

I think we are quite flexible after initial ref advertisement. After
that point the client tells the server its capabilities and the server
does the same for the client. Only shared features can be used. So if
you want to add a new micro protocol for mobile, just add "mobile"
capability to both client and server. A new implementation can support
no capabililities and it should work fine with C Git (less efficient
though, of course). And we have freedom to mix capabilities any way we
want (it's harder to do when you have to follow v2, v2.1, v2.2...)
-- 
Duy
