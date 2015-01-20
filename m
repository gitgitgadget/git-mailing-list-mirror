From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: =?UTF-8?Q?Re=3A_Git_messes_up_=27=C3=B8=27_character?=
Date: Tue, 20 Jan 2015 22:27:05 +0100
Message-ID: <CACBZZX68b-+UsYpen+-GmNiPzNAwJAZRgxNVPo_vU9m_sPrkBg@mail.gmail.com>
References: <54BEB08D.9090905@tronnes.org> <54BEB585.2030902@web.de>
 <54BEB7ED.2050103@tronnes.org> <CACBZZX58Di=m2YEKRuAsuU=bqUXjQhN21tvjRL8Z1Vbuyk2fKQ@mail.gmail.com>
 <20150120212049.GA22103@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <notro@tronnes.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 20 22:27:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDgKg-0003dY-B2
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 22:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846AbbATV10 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2015 16:27:26 -0500
Received: from mail-oi0-f47.google.com ([209.85.218.47]:34181 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbbATV1Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jan 2015 16:27:25 -0500
Received: by mail-oi0-f47.google.com with SMTP id a141so8664374oig.6
        for <git@vger.kernel.org>; Tue, 20 Jan 2015 13:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Vd7ii00/XiKG4AgIteJtUdPUciQ2mfVFMIUf++7OjiY=;
        b=wbH5iDH98I62leWPQiHMqZWkWG9AikwYCqsMrn6MFid18ZVTts0LKgNlExldjt4z/9
         lKbcq4TV1bar8hfyTHUwo/WChOY6b8wPQeIF389viZTB8FLBnypsrIz5NI2xCjYhrdld
         qniSfSVLQi67FmnE7nxOjBfXGQ8z0podpoHoaBuzO9Z7O2hLNxJRdI0GuNBMmooxVC5O
         +G/dZjn9A0zFd8s916Qivo5ggmd00zdYsLH3PzfjS5gnqpuhmb301XRePJWGbrGQJhRh
         uLIDisBngAuhO1l3fIXpuA3Lcgrwsy72wbpvEfNBrmpGC2aO7u6GbZ7hI5x1mpYCWflc
         l8hg==
X-Received: by 10.182.231.230 with SMTP id tj6mr23259900obc.58.1421789245305;
 Tue, 20 Jan 2015 13:27:25 -0800 (PST)
Received: by 10.76.50.70 with HTTP; Tue, 20 Jan 2015 13:27:05 -0800 (PST)
In-Reply-To: <20150120212049.GA22103@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262694>

On Tue, Jan 20, 2015 at 10:20 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jan 20, 2015 at 09:45:46PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>
>> What's happened here is that:
>>
>>  1. You've authored your commit in ISO-8859-1
>>  2. Git itself has no place for the encoding of the author name in t=
he
>> commit object format
>
> Is (2) right? The "encoding" header in a commit object should apply n=
ot
> just to the commit message, but also to the author (and committer) na=
me.
>
> I think the real problem is simply that it defaults to UTF-8, but he =
is
> giving it iso-8859-1 characters. Setting i18n.commitEncoding should f=
ix
> it.

True, I forgot about that setting.

> -Peff
>
> PS If you try experimenting with this, you may fall afoul of 08a94a1
>    (commit/commit-tree: correct latin1 to utf-8, 2012-06-28), which w=
ill
>    silently "correct" Latin1 characters into UTF-8 (when the commit
>    message is expected to be in UTF-8, of course). So it actually
>    _should_ just work under modern gits, but only for Latin1.
