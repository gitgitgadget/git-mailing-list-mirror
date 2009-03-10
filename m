From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH/RFC] recv_sideband: Band #2 always goes to stderr
Date: Tue, 10 Mar 2009 12:17:14 +0100
Message-ID: <49B64C3A.50909@viscovery.net>
References: <cover.1236639280u.git.johannes.schindelin@gmx.de> <e2b19f6c7c50e5b0a652c40b0d8e4947134ed669.1236639280u.git.johannes.schindelin@gmx.de> <49B61377.90103@viscovery.net> <49B61703.8030602@viscovery.net> <alpine.DEB.1.00.0903101153250.14295@intel-tinevez-2-302> <49B64ADC.2090406@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Peter Harris <git@peter.is-a-geek.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Nicolas Pitre <nico@cam.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 10 12:18:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgzyz-0000ih-Oh
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 12:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253AbZCJLRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 07:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753000AbZCJLRU
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 07:17:20 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:19586 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbZCJLRT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 07:17:19 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LgzxT-0007bj-7h; Tue, 10 Mar 2009 12:17:15 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id EC27C4FB; Tue, 10 Mar 2009 12:17:14 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <49B64ADC.2090406@viscovery.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112805>

Johannes Sixt schrieb:
> All data producers and data consumers *in git* use band #2 to transport
> error messages and progress report. GitTorrent cannot not talk to
> upload-pack or upload-archive and expect to get arbitrary binary data over
> band #2.
> 
> For use-cases that you have in mind in GitTorrent, the *protocol* may be a
> good choice, but the current implementation is definitely a special case.

And it really is: Did you notice that stuff that recv_sideband sends over
the channel named 'err' (before my patch) has "remote: " prepended on
every line? That's certainly not an implementation that you want if you
send binary data over that band!

-- Hannes
