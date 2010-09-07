From: "Kevin P. Fleming" <kpfleming@digium.com>
Subject: Re: [PATCH] post-receive-email: ensure sent messages are not empty
Date: Tue, 07 Sep 2010 14:04:31 -0500
Organization: Digium, Inc.
Message-ID: <4C868CBF.6040903@digium.com>
References: <1283886126-4005-1-git-send-email-kpfleming@digium.com>
Reply-To: "Kevin P. Fleming" <kpfleming@digium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Kevin P. Fleming" <kpfleming@digium.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 21:04:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot3TD-0001bT-NK
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 21:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758089Ab0IGTEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 15:04:35 -0400
Received: from mail.digium.com ([216.207.245.2]:47854 "EHLO mail.digium.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757218Ab0IGTEd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 15:04:33 -0400
Received: from zimbra.digium.internal ([10.24.55.203] helo=zimbra.hsv.digium.com)
	by mail.digium.com with esmtp (Exim 4.69)
	(envelope-from <kpfleming@digium.com>)
	id 1Ot3T6-0005ZZ-FG; Tue, 07 Sep 2010 14:04:32 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.hsv.digium.com (Postfix) with ESMTP id 7B342D8194;
	Tue,  7 Sep 2010 14:04:32 -0500 (CDT)
Received: from zimbra.hsv.digium.com ([127.0.0.1])
	by localhost (zimbra.hsv.digium.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tVrGIvi3TdEV; Tue,  7 Sep 2010 14:04:32 -0500 (CDT)
Received: from [10.24.250.46] (unknown [10.24.250.46])
	by zimbra.hsv.digium.com (Postfix) with ESMTPSA id 13AEAD8192;
	Tue,  7 Sep 2010 14:04:32 -0500 (CDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100713 Thunderbird/3.0.6
In-Reply-To: <1283886126-4005-1-git-send-email-kpfleming@digium.com>
X-Enigmail-Version: 1.0.1
OpenPGP: id=05FB8DB2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155730>

On 09/07/2010 02:02 PM, Kevin P. Fleming wrote:
> Changes the logic in the script to determine whether an email message
> will be sent before invoking the send_mail() function; otherwise, if
> the logic determines that a message will not be sent, send_mail() will
> cause an empty email to be sent. In addition, ensures that if multiple
> refs are updated and a message cannot be sent for one of them,
> the others are still processed normally.
> 
> Signed-off-by: Kevin P. Fleming <kpfleming@digium.com>

Just bringing this one back to the list again, since Junio's preparing
for a freeze for 1.7.3. Allowing post-receive-email to generate an empty
email message can be quite problematic, depending on the MTA in use on
the system where the script is run... in our case, it caused the MTA to
generate bounce messages which were then delivered to the admin of our
corporate MTA, who had no clue what was causing them since they had no
content.

-- 
Kevin P. Fleming
Digium, Inc. | Director of Software Technologies
445 Jan Davis Drive NW - Huntsville, AL 35806 - USA
skype: kpfleming | jabber: kfleming@digium.com
Check us out at www.digium.com & www.asterisk.org
