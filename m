From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Request: timeout option for remote operations, esp. "git fetch"
Date: Tue, 12 Nov 2013 09:00:47 -0800
Message-ID: <52825EBF.3050603@zytor.com>
References: <527BC8DC.7010108@zytor.com> <20131110201751.GA18513@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Nov 12 18:01:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgHL5-0001E9-EK
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 18:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754458Ab3KLRBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 12:01:14 -0500
Received: from terminus.zytor.com ([198.137.202.10]:35926 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932116Ab3KLRAz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 12:00:55 -0500
Received: from tazenda.hos.anvin.org ([IPv6:2601:9:3340:50:a42d:7aff:febf:9551])
	(authenticated bits=0)
	by mail.zytor.com (8.14.7/8.14.5) with ESMTP id rACH0qL9013462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Tue, 12 Nov 2013 09:00:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <20131110201751.GA18513@dcvr.yhbt.net>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237718>

On 11/10/2013 12:17 PM, Eric Wong wrote:
> "H. Peter Anvin" <hpa@zytor.com> wrote:
>> When a remote server is unavailable or very slow, some git commands can
>> stall out indefinitely.  It would be a very good thing if remote
>> commands -- but especially git fetch -- could be given a timeout.
> 
> We've had SO_KEEPALIVE on git and ssh transports since e47a8583 (2011-12-06)
> SO_KEEPALIVE for http was added recently (a15d069a) and will be in git 1.8.5
> 
> Do you want a shorter timeout for slow (but still alive) servers?
> 

Yes; note that SO_KEEPALIVE only guarantees that the server is alive at
the TCP socket level.  If the server is overloaded but technically alive
it may still make no meaningful forward progress.

	-hpa
