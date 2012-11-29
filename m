From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Millisecond precision in timestamps?
Date: Thu, 29 Nov 2012 14:14:40 -0500
Message-ID: <CABURp0pnGYykud1xDn5T+eszQGTrzKLTp6J_O7ZrWwVd-zKpkg@mail.gmail.com>
References: <20121127204828.577264065F@snark.thyrsus.com> <CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com>
 <7vzk22lmz9.fsf@alter.siamese.dyndns.org> <20121127230419.GA26080@thyrsus.com>
 <CAJo=hJtOqRHcjWH1F71Qc5zvPkUAe+u1RrcC2pt_xQwLSUY0yg@mail.gmail.com>
 <20121128001231.GA27971@thyrsus.com> <CAMP44s3hpuxbo7mfKAD2trOkezPrV3nKYpNAzXOs3sQym102LQ@mail.gmail.com>
 <CAJo=hJuskvYaNTtCcTSqvU8YwEU=HwRpb_sqW-BSxfSr7xE57A@mail.gmail.com>
 <20121128011750.GA23498@sigill.intra.peff.net> <7v7gp6i3rx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Eric Raymond <esr@thyrsus.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 20:15:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te9Zw-0002X0-4N
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 20:15:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200Ab2K2TPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 14:15:03 -0500
Received: from mail-ea0-f174.google.com ([209.85.215.174]:32994 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042Ab2K2TPB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 14:15:01 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so5837611eaa.19
        for <git@vger.kernel.org>; Thu, 29 Nov 2012 11:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aoSgOZBCFwGcHTlzxLnt+isGK6dy2BI+tG6KelV8474=;
        b=WVnhYlMAy90awF1dIecuv1BXTPn9YxQxcXKmHiMViyUlZdA7m0Y8YGOVJA843nr4we
         aQ9uHWFmBQNdnmLQKnbNl8ncuY1vBHuoCy3YVkSW0W8k5KJVKS0ZOvC3rzfxJxUC5DP7
         bzjDl9rmBiYVOrt7FXJE1mLzvD4xPFIp2PmcCxRHkmG+uykhFd3D2TDeSyC9w7HWFCRA
         1ZcamyNrITXzg41o8cdjp0AIfgITbERhNskPtQg+l5wjaOG1WWLECDydgssc0afpHQA4
         Qt+i1X/Iq67KiMdjN0MbOBGmrg/bTIwPDZ/N1EHCdpxNma+VrCA5VsLl/bLmMNtgrYlk
         J3Uw==
Received: by 10.14.175.198 with SMTP id z46mr85068116eel.26.1354216500672;
 Thu, 29 Nov 2012 11:15:00 -0800 (PST)
Received: by 10.223.68.210 with HTTP; Thu, 29 Nov 2012 11:14:40 -0800 (PST)
In-Reply-To: <7v7gp6i3rx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210868>

On Wed, Nov 28, 2012 at 2:29 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> There is room for new headers, and older versions of git will ignore
>> them. You could add a new "committer-timestamp" field that elaborates on
>> the timestamp included on the committer line. Newer versions of git
>> would respect it, and older versions would fall back to using the
>> committer timestamp.
>>
>> But I really wonder if anybody actually cares about adding sub-second
>> timestamp support, or if it is merely "because SVN has it".
>
> Roundtrip conversions may benefit from sub-second timestamps, but
> personally I think negative timestamps are more interesting and of
> practical use.  Prehistoric projects need them even if they intend
> to switch to Git, never to go back to their original tarballs and
> collection of RCS ,v files.
>
> And if we were to add "committer-timestamp" and friends to support
> negative timestamps anyway (because older tools will not support
> them), supporting sub-second part might be something we want to
> think about at the same time.

Posix-time is signed, but I suppose the git tools do not expect/allow
a '-' character in the stream.  Has git considered the year-2038
problem?

No hurry...

Phil
