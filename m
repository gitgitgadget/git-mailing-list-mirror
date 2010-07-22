From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: Re: [PATCH] Fix rebase with file move when diff.renames = copies
Date: Wed, 21 Jul 2010 17:22:08 -0700 (PDT)
Message-ID: <76360.2655.qm@web30004.mail.mud.yahoo.com>
References: <7vwsfb2k3u.fsf@gitster.siamese.dyndns.org> <1279742303-29817-1-git-send-email-ddkilzer@kilzer.net> <7vpqygijqt.fsf@alter.siamese.dyndns.org>
Reply-To: "David D. Kilzer" <ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 02:29:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Objeo-00027q-89
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 02:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186Ab0GVA2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jul 2010 20:28:51 -0400
Received: from web30004.mail.mud.yahoo.com ([209.191.69.21]:31570 "HELO
	web30004.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752657Ab0GVA2u (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jul 2010 20:28:50 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Jul 2010 20:28:50 EDT
Received: (qmail 3118 invoked by uid 60001); 22 Jul 2010 00:22:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1279758128; bh=lqstu1HvSBNmLqsXSVepTegH7KceUymDv1ZIMn1m1Ls=; h=Message-ID:X-YMail-OSG:Received:X-RocketYMMF:X-Mailer:References:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type; b=trvc1LcbqWMsvUYLx6jv42V3Pxhu9Ka3QJ/UhVM35Cd0cVTlh/9lTmB3jl84seeOPBc1BVfrdXnIBSl2UsacXUlQ+V7lk++0pI5lwhIZ9hzz4Et3rvbQckR57Lz00ZCZmObQTFRHtrlGn8MbN+mi4/QHmkNCnNocJtja4PMFUJw=
X-YMail-OSG: RD5JmD4VM1nUEv_APHxar8bK8.VVYIorlMLAxkd0h.218J1
 J1e2TP755nUy5vSGfbGv8_9DhaITNVLR9txoNZJxdA6b7L9BU7GSFBhfMG8I
 8e3Zp8yjSMIdeeinuuY4GchE3azLP.up1ffSk12Ft8gEgk6UxQeb.Y7eQlZ6
 VoRF4oXq8zhLU2r5xn8_3YrDWdEkj2Hp0p1u0Y9lKnGoxbVnfOmCv7zbd.lx
 C4eDyNzXUn.Q3WNhkUS40UcVsAPzJ1J1SfENy7PtVh1kxeBKCnQCFMqgY3C5
 skqNAfzJNPiVGejGBTuCgHmTp5SvOHMZiHDMlgYiMKy_ewwLOSyDtAYIOHzP
 8EISacKYcr_qd0c_1dpjWVndVQHM-
Received: from [17.202.32.26] by web30004.mail.mud.yahoo.com via HTTP; Wed, 21 Jul 2010 17:22:08 PDT
X-RocketYMMF: ddkilzer
X-Mailer: YahooMailRC/420.4 YahooMailWebService/0.8.105.277674
In-Reply-To: <7vpqygijqt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151437>

On Wed, July 21, 2010 at 2:54:18 PM, Junio C Hamano wrote:

> "David D. Kilzer" <ddkilzer@kilzer.net>  writes:
> 
> > The bug is that git rebase does not disable diff.renames  when it runs
> > format-patch internally to feed into "am -3".  The fix  is simply to
> > include a --no-renames argument to format-patch to override  any local
> > diff.renames setting.
> >
> > Fix by Junio C  Hamano.  Test case by David D. Kilzer.
> >
> > Signed-off-by: David  D. Kilzer <ddkilzer@kilzer.net>
> 
> Hmm, I  actully do not recall doing this patch, even though I think what it
> does  probably makes sense.


Yeah, it was a while ago (Nov 11, 2008):

<http://marc.info/?l=git&m=122636263923046&w=2>

Sorry for the delay, but the issue still affects me.  :)

Dave
