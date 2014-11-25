From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: How safe are signed git tags? Only as safe as SHA-1 or somehow safer?
Date: Tue, 25 Nov 2014 08:16:15 +0700
Message-ID: <CACsJy8BMNXUinfK=YcJPkx98tYv_e40N0_mqqnzMLxDN6hkruA@mail.gmail.com>
References: <5468C33E.2080108@whonix.org> <20141117212657.GC15880@peff.net> <CAK3OfOgko5Fb5FMGCKw3+12fAzMVEHuUriaiBNGi8nb28bNTQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git discussion list <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Nico Williams <nico@cryptonector.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 02:16:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt4kN-00061Y-SV
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 02:16:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbaKYBQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 20:16:48 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:58602 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbaKYBQq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 20:16:46 -0500
Received: by mail-ig0-f174.google.com with SMTP id hn15so4207368igb.1
        for <git@vger.kernel.org>; Mon, 24 Nov 2014 17:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MZ3DdV14SLWiOffZk5jpDNJEvjQDuMOhJGGykeEejog=;
        b=z4rBbuaSrexFjiB2U0yn6j7MeCkObsjnx/yuq/Z6NyMmPp/UMpUnkWWM505rm10sT0
         8xzhwoglb5Iqj36nDFaHftext/y3vGuEONoChI3H8prblKlDKvWhE6a4PlNngGe0/d9Z
         qD5JaZDLc6TSQQ0nMokkPq6BkJh3rhewokBBZHVzrOBTeedNFFOGuyaCzeS5MuFXoBVQ
         VJB1W8EzJ8xoMG9DNvUerOnly2vMeh54wq/FUTG0R7AMP3WKBa94BZpeLqrmeCHrDzVm
         A6FNqKMerUmi1fh63DMf+TmbE+0JPfEC1juw2AgnwyV8NvNvh0jr1aaaAfmr5au9lHxV
         VbBg==
X-Received: by 10.42.167.1 with SMTP id q1mr26977666icy.48.1416878205990; Mon,
 24 Nov 2014 17:16:45 -0800 (PST)
Received: by 10.107.176.8 with HTTP; Mon, 24 Nov 2014 17:16:15 -0800 (PST)
In-Reply-To: <CAK3OfOgko5Fb5FMGCKw3+12fAzMVEHuUriaiBNGi8nb28bNTQA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260179>

On Tue, Nov 25, 2014 at 1:14 AM, Nico Williams <nico@cryptonector.com> wrote:
> Is there a plan for upgrading to a better hash function in the future?
>  (E.g., should it become an urgent need.)
>
> What are the roadblocks to adoption of a replacement hash function?
> Just documenting this would go a long way towards making it possible
> to upgrade some day.

The biggest obstacle is the assumption of SHA-1 everywhere in the
source code (e.g. assume the object name always takes 20 bytes). Brian
started on cleaning that up [1] but I think it's stalled. Then we need
to deal with upgrade path for SHA-1 repos.

[1] http://thread.gmane.org/gmane.comp.version-control.git/248054
-- 
Duy
