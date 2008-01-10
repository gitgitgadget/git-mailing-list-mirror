From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] bundle, fast-import: detect write failure
Date: Thu, 10 Jan 2008 19:05:56 +0100
Message-ID: <87lk6xftdn.fsf@rho.meyering.net>
References: <874pdmhxha.fsf@rho.meyering.net>
	<alpine.LSU.1.00.0801101204120.31053@racer.site>
	<87myrdhnn5.fsf@rho.meyering.net>
	<alpine.LSU.1.00.0801101234580.31053@racer.site>
	<87hchlhm3k.fsf@rho.meyering.net>
	<20080110162526.GB27808@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git list <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@artemis.madism.org>
X-From: git-owner@vger.kernel.org Thu Jan 10 19:07:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD1o2-0006RM-Lw
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 19:07:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755075AbYAJSGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 13:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754747AbYAJSGJ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 13:06:09 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:32802 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752325AbYAJSGI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 13:06:08 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id A33EF17B65A
	for <git@vger.kernel.org>; Thu, 10 Jan 2008 19:06:04 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id B2A7E17B630
	for <git@vger.kernel.org>; Thu, 10 Jan 2008 19:05:57 +0100 (CET)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id DC846589FD;
	Thu, 10 Jan 2008 19:05:56 +0100 (CET)
In-Reply-To: <20080110162526.GB27808@artemis.madism.org> (Pierre Habouzit's
	message of "Thu, 10 Jan 2008 17:25:26 +0100")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70077>

Pierre Habouzit <madcoder@artemis.madism.org> wrote:
...
>> On the other hand, if that write failure is truly ignorable,
>> a mindless minimalist :-) might argue that it's best just to
>> omit the syscall.
>
>   And leak a file descriptor :)

Not that mindless.
The *write* syscall, not the close.
I would never suggest eliminating the close.
