From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC/PATCH 0/3] fix "Funny: git -p submodule summary"
Date: Tue, 27 Jan 2009 13:46:19 +0100
Message-ID: <497F021B.2050306@viscovery.net>
References: <alpine.DEB.1.00.0901081601240.30769@pacific.mpi-cbg.de> <20090127062512.GA10487@coredump.intra.peff.net> <497EDCB0.8080806@kdbg.org> <20090127122315.GA22628@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 27 13:47:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRnM5-00074V-GF
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 13:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbZA0MqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 07:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752519AbZA0MqX
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 07:46:23 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:17007 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847AbZA0MqX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 07:46:23 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LRnKd-0003qL-V8; Tue, 27 Jan 2009 13:46:20 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A342C4FB; Tue, 27 Jan 2009 13:46:19 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <20090127122315.GA22628@sigill.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107339>

Jeff King schrieb:
> However, I'm not sure just negating the exit code is sufficient.
> run_command can return codes in the 10000 range for its own internal
> errors. We don't want to pass those out through exit, which will
> truncate them to 8 bits.

Exit code and start_command/finish_command's return code handling is a
complete mess IMHO and deserves a clean-up series of its own. If the few
codes at 10000 and above are truncated to 8 bits, then we get exit codes
16 and higher; I think that's good enough for this series.

-- Hannes
