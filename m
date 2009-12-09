From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2 1/3] refactor ref status logic for pushing
Date: Wed, 9 Dec 2009 11:40:40 +0800
Message-ID: <be6fef0d0912081940p63628d5eoab93a1a1f2676baa@mail.gmail.com>
References: <20091208223413.98e99d3e.rctay89@gmail.com>
	 <20091208223543.c7f88afe.rctay89@gmail.com>
	 <alpine.LNX.2.00.0912081158040.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Dec 09 04:40:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIDPz-0001k8-2p
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 04:40:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756502AbZLIDkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 22:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756493AbZLIDke
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 22:40:34 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:51345 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756386AbZLIDke (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 22:40:34 -0500
Received: by iwn1 with SMTP id 1so4276751iwn.33
        for <git@vger.kernel.org>; Tue, 08 Dec 2009 19:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=ZfYcfbosvfT0DZL9MMwovSR8LyaWEDzdSso4sBkxiQQ=;
        b=txQRqbRXEM7mVO+6wPrBO+9tqXkv2Ac9f/8yX/QGLPB9SWHYr8q6QjKnUqQtZV3w8S
         2PO2YCIi56eVdSq0kICm/ytuzzXD8nGr94L2ga/RqaD7dx2b+xkU0KFRlHpC5qSnNKIL
         JSJehQc3tm39E0mGH0bPf88d7Iqv9Mh4S2Ce0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=CKFci7JsV6Puyxjxsbf9XZ/O8rNFTQjCoYGDRpVsAwQIY040TwG0JuRG1Ie1m94Pn7
         bGdiRMye5Uw5BS6Hcgvsr16RPMPmikzkAKoO7xR941HDKsZlXszvCaGfFbvVReBphdX4
         GcHKSJdz3BxO9fLFeMdbTw8WGN5QSJRNM5/V0=
Received: by 10.231.150.149 with SMTP id y21mr714117ibv.56.1260330040734; Tue, 
	08 Dec 2009 19:40:40 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.0912081158040.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134930>

Hi,

On Wed, Dec 9, 2009 at 1:17 AM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Tue, 8 Dec 2009, Tay Ray Chuan wrote:
>
>> Move the logic that detects up-to-date and non-fast-forward refs to a
>> new function in remote.[ch], set_ref_status_for_push().
>
> Is there some reason to not have set_ref_status_for_push() be static in
> transport.c now? (Sorry for not suggesting this before.)

it can't be static, because builtin-send-pack.c::main() needs it too.

> Other than that, it looks good to me.

Thanks.

-- 
Cheers,
Ray Chuan
