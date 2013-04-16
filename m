From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] Extend runtime prefix computation
Date: Tue, 16 Apr 2013 17:18:49 +0200
Message-ID: <CABPQNSbd_baEe7pstZPSdNQQCAUMBCgV2FGcszy-8zoeuD+M5w@mail.gmail.com>
References: <20121127163004.GC7499@science-computing.de> <20130305115837.GD21473@science-computing.de>
 <7vd2vdvn7l.fsf@alter.siamese.dyndns.org> <20130306081942.GA11151@science-computing.de>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Weiser <M.Weiser@science-computing.de>
X-From: git-owner@vger.kernel.org Tue Apr 16 17:19:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US7fd-0004nR-1b
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 17:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756132Ab3DPPTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 11:19:32 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:48446 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756557Ab3DPPT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 11:19:29 -0400
Received: by mail-ie0-f181.google.com with SMTP id as1so630331iec.26
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 08:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=GzBYxQ+KiaPGYG2w3vT+aZlzdXqFvdIHbi+/mq5N2xs=;
        b=xVegfobJPJBvrjACuYOPaBUsHj1ZrfdAPvbiSNxrL/NHqLmtapVvFnD7Ojf1mmbd7R
         dq8jpwjkCeOsWdbd9ZQW58//6dmiwqvRJu5cE2vGz1xHLqnFCwPwU61NFFtAfRSP3ydP
         wmlT94Z37Uf5DlMafS4ZOHOJoaT513GAzmdDDlzG+BfK73GDLbR2/OHMjPDfS7zYDaN8
         ZC+vJEEZqWM7Uv5HRzriaadZEC/ZRNTRapdghM5rsPrzF7l1KohmncK4OwxmpP0U1OBZ
         SE8iYUudfo6Rtsth6BEIYW4OLqLip6SsAlvfsgkg7oLAJiULcUvgBlucv0vf4mSo3acV
         2RfA==
X-Received: by 10.50.50.239 with SMTP id f15mr938737igo.30.1366125569372; Tue,
 16 Apr 2013 08:19:29 -0700 (PDT)
Received: by 10.64.44.47 with HTTP; Tue, 16 Apr 2013 08:18:49 -0700 (PDT)
In-Reply-To: <20130306081942.GA11151@science-computing.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221424>

On Wed, Mar 6, 2013 at 9:19 AM, Michael Weiser
<M.Weiser@science-computing.de> wrote:
> Hello Junio,
>
> On Tue, Mar 05, 2013 at 08:13:50AM -0800, Junio C Hamano wrote:
>
>> >> Support determining the binaries' installation path at runtime even if
>> >> called without any path components (i.e. via search path).
>
>> The default for any change is not to include it.  Is there any
>> reason why we want this change?
>
> It makes a binary git installation fully relocatable. Seeing how git
> already has basic support for it I thought other people might be
> interested in this.

I think the motivation for the feature in the first place is Windows,
where the installation path isn't known at build-time. In the
unix-world, this is generally known (/usr/bin or something like that).
What's the reason you want it on other platforms?
