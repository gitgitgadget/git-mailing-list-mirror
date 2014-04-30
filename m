From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH 10/12] MINGW: compat/poll/poll.c: undef NOGDI
Date: Wed, 30 Apr 2014 13:41:25 +0200
Organization: <)><
Message-ID: <20140430114125.GA23046@camelia.ucw.cz>
References: <1398762726-22825-1-git-send-email-marat@slonopotamus.org> <1398762726-22825-11-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Wed Apr 30 13:41:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfStI-0007ra-8L
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 13:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758733AbaD3Ll2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 07:41:28 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:38267 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758371AbaD3Ll1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 07:41:27 -0400
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 8BF9A1C00F5;
	Wed, 30 Apr 2014 13:41:26 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s3UBfQYl023073;
	Wed, 30 Apr 2014 13:41:26 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s3UBfP1D023072;
	Wed, 30 Apr 2014 13:41:25 +0200
Content-Disposition: inline
In-Reply-To: <1398762726-22825-11-git-send-email-marat@slonopotamus.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247706>

Hello,

On Tue, Apr 29, 2014 at 01:12:04PM +0400, Marat Radchenko wrote:
> On MinGW-W64, MsgWaitForMultipleObjects is guarded with #ifndef NOGDI.
> 
> Removal -DNOGDI=1 from config.mak.uname has an undesirable effect of
> bringing in wingdi.h with weird #define ERROR 0 that conflicts with
> internal Git enums. So, just #undef NOGDI in compat/poll/poll.c.

compat/poll/poll.c comes from Gnulib, so it would be better to submit
the patch there and then backport so that the divergence of the two
versions does not get worse.

Stepan
