From: Stephan Peijnik <stephan@peijnik.at>
Subject: Re: git smart protocol via WebSockets - feedback wanted
Date: Tue, 05 Jun 2012 20:41:56 +0200
Message-ID: <jqljtk$h6d$1@dough.gmane.org>
References: <jqlim2$6vt$1@dough.gmane.org> <7vpq9dobjo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 20:42:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbyht-00023Q-0C
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 20:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755944Ab2FESmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 14:42:12 -0400
Received: from plane.gmane.org ([80.91.229.3]:51441 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754861Ab2FESmL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 14:42:11 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Sbyhi-0001bI-RM
	for git@vger.kernel.org; Tue, 05 Jun 2012 20:42:06 +0200
Received: from 178-190-4-245.adsl.highway.telekom.at ([178.190.4.245])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Jun 2012 20:42:06 +0200
Received: from stephan by 178-190-4-245.adsl.highway.telekom.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Jun 2012 20:42:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 178-190-4-245.adsl.highway.telekom.at
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <7vpq9dobjo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199279>

On 06/05/2012 08:31 PM, Junio C Hamano wrote:
> How does this compare with the smart-http support that tunnels the
> git protocol over http (with some butchering)?

To be honest, I didn't know smart-http support yet. Is that the approach 
introduced with git 1.6.6?

If so, that approach uses multiple POST requests, meaning multiple TCP 
and HTTP connections need to be established, multiple requests 
processed, etc.

The WebSocket approach uses a single HTTP connection which gets upgraded 
to a WebSocket. This WebSocket then allows the same communication to 
happen as with the ssh implementation.

So in comparison there is possibly a lot less overhead and, in theory, 
the performance should be comparable to running the smart protocol over 
ssh. Personally I'd say the WebSocket approach is cleaner than the 
HTTP-POST approach.

-- Stephan
