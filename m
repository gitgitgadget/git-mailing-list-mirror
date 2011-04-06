From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [RFC] upload-pack deadlock
Date: Wed, 6 Apr 2011 21:15:31 +0200
Message-ID: <BANLkTi=5WgfLoBU1ZXqyEkoBf_pQu2QKOA@mail.gmail.com>
References: <20110404053626.GA26529@sigill.intra.peff.net> <7v8vvnjnyg.fsf@alter.siamese.dyndns.org>
 <20110406175413.GA8205@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Aman Gupta <aman@github.com>, Ryan Tomayko <ryan@github.com>
To: Jeff King <peff@github.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 21:16:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7YCs-0000eZ-49
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 21:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756634Ab1DFTPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 15:15:53 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54974 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879Ab1DFTPw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 15:15:52 -0400
Received: by bwz15 with SMTP id 15so1421351bwz.19
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 12:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=l6E/+/7KpZGSrPcP2Sws2pjzENmM67HigrJM6ceC4Dw=;
        b=Y5Gg9sKSPt33J7zuIpcRkw0+jSX0/XL+sfTA9ghbwfNNBEjP4TaRHDaAG/57MLB3RP
         1dwIV2eXOqbYjEJ27sz5InOHoLYt2unRedsZHRmkJI0QL1tfJy/OFSNMiq+MzwLY4rA2
         9Os/y4sM82h7pQHl3U/gpCAst+DExyh/v+Plk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=FZtRxhMRO612EV/eTIjjV1aoEUhSmASiBvqxfcB5SuVrOItu39WGzDPj/841Od65qb
         RgexY6NDd6coTzmaQtXAmzjDO7bmzQt2vMpusqjfSLzIuAR1yP36ByPWY11yQbLJrEs/
         R2Smwf8AwnYp1XDXX79sH1tHwAaFVpF3j87JM=
Received: by 10.204.20.79 with SMTP id e15mr1236849bkb.147.1302117351131; Wed,
 06 Apr 2011 12:15:51 -0700 (PDT)
Received: by 10.204.172.130 with HTTP; Wed, 6 Apr 2011 12:15:31 -0700 (PDT)
In-Reply-To: <20110406175413.GA8205@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171006>

On Wed, Apr 6, 2011 at 7:54 PM, Jeff King <peff@github.com> wrote:
> I do still wonder about the win32 deadlock that Erik mentioned. Does my
> patch help at all, or is there another bug hiding somewhere?

Nope :(

If you're interested, you can read some more information here on the
msysGit mailing list:
http://groups.google.com/group/msysgit/browse_thread/thread/865318a3e89d9e64/9d475b8ff3cef3c3

It only happens when pushing over the git-protocol. But it happens consistently.
