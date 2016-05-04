From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3] submodule deinit: require '--all' instead of '.' for
 all submodules
Date: Wed, 4 May 2016 14:34:11 -0700
Message-ID: <CAGZ79kbdnKMxrp_rQp7k-G6mveNYxES4XB-+2jh2e4+_RwPeyQ@mail.gmail.com>
References: <1462321992-15153-1-git-send-email-sbeller@google.com>
	<1462324785-26389-1-git-send-email-sbeller@google.com>
	<xmqqlh3pft91.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 23:34:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay4Qz-0006We-VX
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 23:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289AbcEDVeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 17:34:14 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:32809 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702AbcEDVeN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 17:34:13 -0400
Received: by mail-ig0-f174.google.com with SMTP id c3so157329igl.0
        for <git@vger.kernel.org>; Wed, 04 May 2016 14:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=SIAPT2hqStv7I9cH0Mtdj5j4Zhh+j0I2kCZdOQVDPSA=;
        b=hgtWgk97WPOWfvXstrir+Tf4oQN7eNFZdq+gxOP0RI2fMO8QATC+Sbp2a+pyYxFaC5
         PFE9c7IsHYL2SS8A2MuhcxylIuQk/y1SIBBh9zJOaSR8tLWBcgcx2YKs729GFhpUHPXB
         5Z+Fpu8899tUWhonXQ8G4KNChYECFao9X+IJuJhcEl1bTUvn3JysFgWl9ed1yqMjnGYt
         MEQnewVtv7iSY4mFai7IbSW5g93RMJyORzgpXMNFXGom6QE0Gv5qC/A/cQ98NGPMQUVl
         OuSpbizsipp/WHV2+5Gv89eO2Tbmc+zzYGJHhwt7NJ1lkm73LKQbLEIBk6mKhD9tTrIE
         G1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=SIAPT2hqStv7I9cH0Mtdj5j4Zhh+j0I2kCZdOQVDPSA=;
        b=PeAQAeaVDUTmAJr6B2NBuRu7//oRTw7rFQQtlY1//VapwQo7uQvdvddr7s6W/cka7R
         K6IYCOZq8wbJGTyleVCYXLUAWp9qCqthWtiMOyECgfGpudhKijftzoc+s459oiAr1lIl
         7BD51SlHl7Z1B2zgbVyKqz7NZTd3/8XM3TRLHqGr9bCnsuEYD+8rybXdmNhiRPVghSzn
         3qiaxPcg3MDZTZm/VxVUaTq7giw9sdYT4L1zpQCiN9fBhtAc5eYXBKDk426iP6ichakX
         zuGE2UeXjRm4DUYNBsvkl4sIZrz07DAYHI8CUkMbZMGjzAviYN7OrGWJsv4tGEGwNHQD
         C/jg==
X-Gm-Message-State: AOPr4FWtYZgMgS3t3yiZIBv35xjJP8FLvdmtJwBltEysCgFh7DyX6ixZ4VJmCVgwtHlLAF/KblKnCKWCtIzRdBZt
X-Received: by 10.50.170.68 with SMTP id ak4mr13804193igc.93.1462397652080;
 Wed, 04 May 2016 14:34:12 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 4 May 2016 14:34:11 -0700 (PDT)
In-Reply-To: <xmqqlh3pft91.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293596>

On Wed, May 4, 2016 at 1:44 PM, Junio C Hamano <gitster@pobox.com> wrote:

> I think this sentence talks about "working tree" (as opposed to
> "worktree"), so s/work tree/working tree/.

I'll fix this up in a resend, though it may be a fix on its own.

So the two "official" terms are working tree (files on your disk)
and worktree (the command) and we don't want to have anything in between?
(e.g. work tree for working tree?)

Or as `grep -r "work tree"` puts it, we may want to have an extra cleanup patch
and not do it here for this single occurrence.
