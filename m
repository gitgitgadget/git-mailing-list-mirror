From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: Re: git-remote and remotes with '.' in their names
Date: Wed, 28 Feb 2007 16:14:15 +0100
Message-ID: <45E59C47.9000001@lu.unisi.ch>
References: <87k5y5tlol.fsf@briny.internal.ondioline.org> <45E597CF.9000009@lu.unisi.ch> <Pine.LNX.4.63.0702281607220.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paul Collins <paul@briny.ondioline.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 28 16:15:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMQW9-0002CG-JQ
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 16:14:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933067AbXB1POS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 10:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933052AbXB1POS
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 10:14:18 -0500
Received: from server.usilu.net ([195.176.178.200]:46819 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933067AbXB1POR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 10:14:17 -0500
Received: from [192.168.76.141] ([192.168.76.141] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 28 Feb 2007 16:14:15 +0100
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
In-Reply-To: <Pine.LNX.4.63.0702281607220.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-OriginalArrivalTime: 28 Feb 2007 15:14:15.0302 (UTC) FILETIME=[1BF45260:01C75B4B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40934>

Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 28 Feb 2007, Paolo Bonzini wrote:
> 
>> Hello,
>>
>>>  	for (@remotes) {
>>> -		if (/^remote\.([^.]*)\.(\S*)\s+(.*)$/) {
>>> +		if (/^remote\.(.*)\.(\S*)\s+(.*)$/) {
>> You probably want either
>>
>> +		if (/^remote\.(\S*)\.(\S*)\s+(.*)$/) {
>>
>> or
>>
>> +		if (/^remote\.(\S*)\.([^.]*)\s+(.*)$/) {
> 
> Did you mean to prevent the remote starting with a dot? IMHO that would be 
> a good change, but AFAIS both your proposals don't do that.

No, I meant to avoid the ".*" in Paul's proposal.  They should be in 
practice equivalent but, with the second one, I made the regex more 
readable: it is clearer that the $3 variable is not meant to include dots.

Your proposal makes sense to me -- that would be

+		if (/^remote\.([^.]\S*)\.([^.]*)\s+(.*)$/) {

Paolo
