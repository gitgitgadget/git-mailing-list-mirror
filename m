From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Feb 2011, #07; Mon, 28)
Date: Wed, 02 Mar 2011 07:49:51 +0100
Message-ID: <4D6DE88F.9030001@viscovery.net>
References: <7vbp1vfy5f.fsf@alter.siamese.dyndns.org> <AANLkTiksROE_dQTUn3Y_1Op6NDpGzEsSJ70JNYyYrufS@mail.gmail.com> <7voc5uenmy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: kusmabite@gmail.com, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 07:50:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pufsq-0001oU-94
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 07:50:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754789Ab1CBGt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 01:49:58 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:44580 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753014Ab1CBGt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 01:49:57 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Pufse-0006h3-GF; Wed, 02 Mar 2011 07:49:52 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 27F961660F;
	Wed,  2 Mar 2011 07:49:52 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <7voc5uenmy.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168295>

Am 3/1/2011 18:50, schrieb Junio C Hamano:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>> There's also the added complication that _open_osfhandle also seems to
>> be limited by this 2048 limit (see the third comment here:
>> http://bugs.mysql.com/bug.php?id=24509). We use this function for
>> pipes and sockets as well. This alone might be a reason to corner-case
>> test the resulting binary on Windows properly.
> 
> As long as the use of osfhandles for non filedescriptors is reasonably
> bounded, it may be enough to make the 25 slop configurable per platform,
> no?

It's not necessary to complicate things. The file descriptors acquired
with _open_osfhandle are (only) used in the implementation of pipe() and
socket() and count towards the limit no more and no less than the file
descriptors acquired with pipe() and socket() on Unix.

-- Hannes
