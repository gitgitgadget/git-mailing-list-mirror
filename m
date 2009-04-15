From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] Fix buffer overflow in config parser
Date: Wed, 15 Apr 2009 09:11:09 +0200
Message-ID: <49E5888D.2090607@viscovery.net>
References: <49E50003.2040907@intra2net.com> <alpine.DEB.1.00.0904142340350.10279@pacific.mpi-cbg.de> <7v3aca3lpl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Jarosch <thomas.jarosch@intra2net.com>,
	git@vger.kernel.org, markus.heidelberg@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 09:13:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtzIt-00080r-95
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 09:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328AbZDOHL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 03:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752039AbZDOHL3
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 03:11:29 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:6869 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894AbZDOHL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 03:11:28 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LtzH3-00008O-QW; Wed, 15 Apr 2009 09:11:17 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 70690795; Wed, 15 Apr 2009 09:11:09 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <7v3aca3lpl.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116591>

Junio C Hamano schrieb:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> Hi,
>>
>> On Tue, 14 Apr 2009, Thomas Jarosch wrote:
>>
>>>  t/t1303-wacky-config.sh |    9 ++++++++-
>> I like the name!
>>
>>> +LONG_VALUE=`perl -e 'print "x" x 1023," a"'`
>> But should it not be guarded against NO_PERL?
> 
> The right question to ask is a rhetorical "do we need perl to do this?"

LONG_VALUE=$(printf "x%0.1021dx a", 7)

-- Hannes
