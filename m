From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [RFC 0/5] Date Mode: Add --time-zone; deprecate --date=local
Date: Wed, 20 Apr 2011 14:23:37 +0000
Message-ID: <d74e95d4-ef16-42fb-ae8f-b1d7a8b9d91e-mfwitten@gmail.com>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
            <20110420064318.GF28597@sigill.intra.peff.net>
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 20 16:28:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCYO5-0002cq-9H
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 16:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774Ab1DTO2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 10:28:08 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56482 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223Ab1DTO2G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 10:28:06 -0400
Received: by pzk9 with SMTP id 9so404890pzk.19
        for <git@vger.kernel.org>; Wed, 20 Apr 2011 07:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:from:to:cc:message-id:in-reply-to
         :references;
        bh=a9Svs5+C4zeRbWKK9dVTM9Vzp5SCZl0Sn4QBitHy1Dc=;
        b=UxD29ltIiNhm8sAL4GckgUtys0qZUncSq0tvKu/ekxIKKmbfp4UxPyI9xvG5kw7TEk
         imCKr6BWgSAmT8NP9eZBB9DIqsSGhiAJrD57mrW8TkKVDA2uZqf5StOnkymwRwayDZDj
         ET9QFdauW3zdaJTIWElU09Aoj16uBv/1jiXm4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        b=B3QfxbQArDi84usfR4e+k/RKBdijOZeSdIkxoU3tIsWsWDRQRCXErEFk5Ju0CNx8SK
         aM6Kw6mvzjcSjBQJEPMRnsPOomMrZoN2r/Jsm2PXXRU93NAY9lUnji7NMLR/Q707e5k8
         YzUfoUBKash0FukxELEOfXzWFnyV0tw93/Lds=
Received: by 10.68.25.166 with SMTP id d6mr10511960pbg.136.1303309685853;
        Wed, 20 Apr 2011 07:28:05 -0700 (PDT)
Received: from gmail.com (tor11.anonymizer.ccc.de [62.113.219.4])
        by mx.google.com with ESMTPS id t9sm663067pbq.31.2011.04.20.07.27.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Apr 2011 07:28:04 -0700 (PDT)
In-Reply-To: <20110420064318.GF28597@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171866>

On Wed, 20 Apr 2011 02:43:18 -0400, Jeff King wrote:

>> There are some whitespace warnings (a la `git diff --check'), but I
>> have reviewed them and personally approve of them; if you think that
>> appraisal is incorrect, then you don't know what you're talking about :-P
>
> All of the warnings I saw are related to indentation with spaces, and it
> looks like your intent in each case is to line up the opening paren of a
> function call with a line of arguments below, like:
>
>   foo(bar, baz
>       bleep, moof);
>
> That's fine, style-wise, but the run of spaces should be collapsed into
> tabs followed by spaces, with each tab representing 8 spaces.

I understand this, as I've read:

  Documentation/CodingGuidelines

and I'm also responsible for this massive git flamewar of yore on the same
subject:

  http://article.gmane.org/gmane.comp.version-control.git/61095
  Message-ID: 634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu

However - and this is the key point - if you are going to be mixing
tabs and spaces ANYWAY, then you might as well do it in a way that
maintains alignment within a tab level regardless of the current
setting for the tabwidth:

> (some would argue that it should be "one tab for each level of
> structural indentation, plus spaces to line up the arguments",
> but I don't find that we tend to follow such a rule in git).

That approach is the most logical and the most robust, and if
somebody messes it up, then the whitespace simply reduces
(or degenerates) back to just the very approach you espouse
anyway.
