From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC] pack-objects: compression level for non-blobs
Date: Sat, 29 Dec 2012 11:34:09 +0700
Message-ID: <CACsJy8D_E0shqJAvZH7xqij6F4a6qUxkUPNcZL=0yX5w9bLd_g@mail.gmail.com>
References: <1353911154-23495-1-git-send-email-b@rr-dav.id.au> <20121229004104.GA24828@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Michael Barr <b@rr-dav.id.au>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 29 05:35:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Too8R-0007rQ-LV
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 05:34:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472Ab2L2Eel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 23:34:41 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:41355 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab2L2Eek (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 23:34:40 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so10293534obb.33
        for <git@vger.kernel.org>; Fri, 28 Dec 2012 20:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Asj4CBCb+x9fFDeIcL7JNBR0c7ufmcC76RkzbtL5eeg=;
        b=AC/aXZ/Xb57AsczpkFDH9Jn/PcfkNFthYFVAjFlrWcf4FMWMAX3LCWLFZ/33zZwN4R
         nai+LTE2vkysekfecvAQYzT9tPsDFy6qd7w+RFao6jRpUzxgGAR1BnUGntN99MGmXrMV
         YTacLBavdtQqtlkwSiqyznrh2XGjGbPslXzBUenCKKH72FeSqzAKNlOTox7Qj/N9KQ+J
         vI91weJnuHMnol8RJ7TKjhSS9ezz2clsP68SLKYZgTyVVjJU+IHi/Ipivq1VvqljKixn
         U87ZbnovX4RM8h5BbQfne5294nJzwJEkLdTNtaNUXIS6kVk9FcEMUhhX4FU/6hJyTFjh
         HOqw==
Received: by 10.60.30.70 with SMTP id q6mr17197680oeh.107.1356755679942; Fri,
 28 Dec 2012 20:34:39 -0800 (PST)
Received: by 10.182.27.168 with HTTP; Fri, 28 Dec 2012 20:34:09 -0800 (PST)
In-Reply-To: <20121229004104.GA24828@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212287>

On Sat, Dec 29, 2012 at 7:41 AM, Jeff King <peff@peff.net> wrote:
> I wonder if we could do even better, though. For a traversal, we only
> need to look at the commit header. We could potentially do a progressive
> inflate and stop before getting to the commit message (which is the bulk
> of the data, and the part that is most likely to benefit from
> compression).

Commit cache should solve this efficiently as it also eliminates
parsing cost. We discussed this last time as a side topic of the
reachability bitmap feature.
-- 
Duy
