From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 4/4] config: allow including config from repository blobs
Date: Fri, 27 Jan 2012 11:01:00 +0700
Message-ID: <CACsJy8DPcgJtw_xxqZ2pOtpV-w=PAVQ7uHs+CJ+ynECYdL50og@mail.gmail.com>
References: <20120126073547.GA28689@sigill.intra.peff.net> <20120126074208.GD30474@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 27 05:01:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rqd0c-0005Ri-RH
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 05:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045Ab2A0EBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 23:01:36 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52484 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab2A0EBb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 23:01:31 -0500
Received: by bkas6 with SMTP id s6so1041206bka.19
        for <git@vger.kernel.org>; Thu, 26 Jan 2012 20:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fdD8biDlSZj4lcxscq9TnpvdtprkWT2CmtkM9V5Z2+c=;
        b=P5h5gSbniFKXhqRzAX7HfB2jHXtGbT5BGswzzdpRdzjpe0QDe9oaYXcmjGVPsCqI1Q
         3V+lfve1aByBzy+lkskP3mVHWsSltzOqQyhWjZTQ+HMtfi/l3+MLONtK8XBSCOHX4eQr
         IR6nGePBtX0iH1jixFzIB4Z7p8FBVU0Brw62I=
Received: by 10.205.42.130 with SMTP id ty2mr2238540bkb.55.1327636890204; Thu,
 26 Jan 2012 20:01:30 -0800 (PST)
Received: by 10.204.33.70 with HTTP; Thu, 26 Jan 2012 20:01:00 -0800 (PST)
In-Reply-To: <20120126074208.GD30474@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189186>

On Thu, Jan 26, 2012 at 2:42 PM, Jeff King <peff@peff.net> wrote:
> +Security Considerations
> +~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Because git configuration may cause git to execute arbitrary shell
> +commands, it is important to verify any configuration you receive over
> +the network. In particular, it is not a good idea to point `include.ref`
> +directly at a remote tracking branch like `origin/master:shared-config`.
> +After a fetch, you have no way of inspecting the shared-config you have
> +just received without running git (and thus respecting the downloaded
> +config). Instead, you can create a local tag representing the last
> +verified version of the config, and only update the tag after inspecting
> +any new content.

It may be a good idea to tell users the ref include.ref points to has
been updated at the end of git-fetch. Showing a diff is even better.
-- 
Duy
