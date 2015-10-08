From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] notes: allow merging from arbitrary references
Date: Wed, 7 Oct 2015 17:28:24 -0700
Message-ID: <CA+P7+xpu1rMHfM-Jk8X8H8Bw4bE+LhWJaG1v0KqZapbdCjH35g@mail.gmail.com>
References: <1443739165-17526-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Mike Hommey <mh@glandium.org>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 02:28:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zjz4l-0008GK-O1
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 02:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbbJHA2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 20:28:44 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:36012 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbbJHA2o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2015 20:28:44 -0400
Received: by ioii196 with SMTP id i196so40949049ioi.3
        for <git@vger.kernel.org>; Wed, 07 Oct 2015 17:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+C1bTpAuyTjRb+kBiFJsIBzRIGveDE8yLxWs3eSy/3s=;
        b=zc7D295cUytT4ioTiS1o0h54gjd4mB1jUbzcIULSC8pLvGeGRQEsjRqTq25T2r4Wg2
         u255wxU9Ig+yQhKwjHw+qPax7OlZzAmpP57sJazVtZnCzfkt4CoKys6KDSb7KmkM7qkW
         w5jx4Z0SlyWxGNDy34bOR2uLFM7C5ckVPconDNgHIYyJSafPmMrPnIoor9bum6gZX8Zd
         xHKv7NUi+8902gdjUU4fT6iUlrU0DE/X3rZKKIqh9Ds2n1NQ1MdOiTCZO5NlczwHxW5c
         /lUEx9fruQ9zdF/S/4yGeaG+Vb5wKJ7eB9OTzo12woS4R3NY36IxIxMm+jBPsuKU1zva
         ZaIg==
X-Received: by 10.107.166.201 with SMTP id p192mr6233376ioe.0.1444264123448;
 Wed, 07 Oct 2015 17:28:43 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Wed, 7 Oct 2015 17:28:24 -0700 (PDT)
In-Reply-To: <1443739165-17526-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279211>

On Thu, Oct 1, 2015 at 3:39 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> Create a new expansion function, expand_loose_notes_ref which will
> expand any ref using get_sha1, but falls back to expand_notes_ref if
> this fails. The contents of the strbuf will be either the hex string of
> the sha1, or the expanded notes ref. It is expected to be re-expanded
> using get_sha1 inside the notes merge machinery, and there is no real
> error checking provided at this layer.
>
> Since we now support merging from non-notes refs, remove the test case
> associated with that behavior. Add a test case for merging from a
> non-notes ref.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---


Anyone have any comments on this one? It's basically Junio's
suggestion of just using get_sha1 directly for the remote side of the
notes merge...

Regards,
Jake
