From: Martin Fick <mfick@codeaurora.org>
Subject: Re: inotify to minimize stat() calls
Date: Sun, 10 Feb 2013 12:26:12 -0700
Organization: CAF
Message-ID: <201302101226.12646.mfick@codeaurora.org>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com> <7vliaxwa9p.fsf@alter.siamese.dyndns.org> <CAKXa9=qQwJqxZLxhAS35QeF1+dwH+ukod0NfFggVCuUZHz-USg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Robert Zeh <robert.allan.zeh@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 20:26:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4cY0-0007sV-QI
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 20:26:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759384Ab3BJT0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 14:26:16 -0500
Received: from wolverine01.qualcomm.com ([199.106.114.254]:53351 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756517Ab3BJT0P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 14:26:15 -0500
X-IronPort-AV: E=Sophos;i="4.84,639,1355126400"; 
   d="scan'208";a="24797324"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine01.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Feb 2013 11:26:14 -0800
Received: from mfick-lnx.localnet (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 6706010004B6;
	Sun, 10 Feb 2013 11:26:14 -0800 (PST)
User-Agent: KMail/1.13.5 (Linux/2.6.32.49+drm33.21-mfick7; KDE/4.4.5; x86_64; ; )
In-Reply-To: <CAKXa9=qQwJqxZLxhAS35QeF1+dwH+ukod0NfFggVCuUZHz-USg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215927>

On Sunday, February 10, 2013 12:03:00 pm Robert Zeh wrote:
> On Sat, Feb 9, 2013 at 1:35 PM, Junio C Hamano 
<gitster@pobox.com> wrote:
> > Ramkumar Ramachandra <artagnon@gmail.com> writes:
> >> This is much better than Junio's suggestion to study
> >> possible implementations on all platforms and
> >> designing a generic daemon/ communication channel. 
> >> That's no weekend project.
> > 
> > It appears that you misunderstood what I wrote.  That
> > was not "here is a design; I want it in my system.  Go
> > implemment it".
> > 
> > It was "If somebody wants to discuss it but does not
> > know where to begin, doing a small experiment like
> > this and reporting how well it worked here may be one
> > way to do so.", nothing more.
> 
> What if instead of communicating over a socket, the
> daemon dumped a file containing all of the lstat
> information after git wrote a file? By definition the
> daemon should know about file writes.

But git doesn't, how will it know when the file is written?
Will it use inotify, or poll (kind of defeats the point)?

-Martin
