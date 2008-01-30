From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC] Authenticate push via PGP signature, not SSH
Date: Wed, 30 Jan 2008 09:00:40 +0100
Message-ID: <47A02EA8.50507@viscovery.net>
References: <479D5611.4010205@vilain.net> <20080128081258.GE24004@spearce.org> <479E5021.7010404@vilain.net> <20080129041000.GK24004@spearce.org> <20080129190845.GC30093@artemis.madism.org> <20080130042201.GO24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>, Sam Vilain <sam@vilain.net>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 30 09:01:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK7su-0006EV-Dw
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 09:01:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528AbYA3IAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 03:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753151AbYA3IAq
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 03:00:46 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:19739 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425AbYA3IAp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 03:00:45 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JK7rt-0003Vj-V0; Wed, 30 Jan 2008 09:00:26 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 980FB69F; Wed, 30 Jan 2008 09:00:40 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080130042201.GO24004@spearce.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72048>

Shawn O. Pearce schrieb:
> I'm currently finishing a side-band-64k protocol extension to the
> send-pack/receive-pack pair.  My next task after I flush those
> RFC patches out to the list tonight will be to prototype at least
> some of the auth1 extension I described.

I propose to make the syntax of the extension

server capability:  auth=<list of hash methods>:<challenge>
client response:    auth=<chosen hash method>

where <challenge> is a random sequence of non-blank ASCII text, not
necessarily of a fixed length, but perhaps of a minimum length.

Then we can extend the list of hash algorithms (that are used for
authentication purposes) if people think that SHA1 is not secure enough:

    auth=SHA1,SHA256:random-stuff-goes-here

I'm not a security expert, so take this with a grain of salt.

-- Hannes
