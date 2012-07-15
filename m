From: Wincent Colaiuta <win@wincent.com>
Subject: Re: (Ab)using filter-branch from a post-receive hook
Date: Sun, 15 Jul 2012 01:17:13 -0700
Message-ID: <11BD88E2-F82C-4CD9-8EA3-1CF263D7C53A@wincent.com>
References: <8D1AF968-AF34-4590-AB8F-E644C534A928@wincent.com> <7vipdp61fp.fsf@alter.siamese.dyndns.org> <CEAB8F11-05A4-46B4-A0B5-B51B14EAD536@wincent.com> <7va9z15xrc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 10:48:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqKVN-0005if-0p
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jul 2012 10:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727Ab2GOIsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jul 2012 04:48:37 -0400
Received: from outmail148093.authsmtp.net ([62.13.148.93]:40251 "EHLO
	outmail148093.authsmtp.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751685Ab2GOIsf convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2012 04:48:35 -0400
X-Greylist: delayed 1871 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Jul 2012 04:48:34 EDT
Received: from mail-c194.authsmtp.com (mail-c194.authsmtp.com [62.13.128.121])
	by punt12.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id q6F8HJbC048903;
	Sun, 15 Jul 2012 09:17:20 +0100 (BST)
Received: from zenyatta.unixhosts.net (ec2-184-73-234-210.compute-1.amazonaws.com [184.73.234.210])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2) with ESMTP id q6F8HHEv078610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 15 Jul 2012 09:17:18 +0100 (BST)
Received: from [192.168.1.131] (c-69-181-20-120.hsd1.ca.comcast.net [69.181.20.120])
	(authenticated bits=0)
	by zenyatta.unixhosts.net (8.14.2/8.14.2) with ESMTP id q6F8HECZ023161
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 15 Jul 2012 04:17:16 -0400
In-Reply-To: <7va9z15xrc.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1278)
X-Server-Quench: 7e621adc-ce55-11e1-80b9-0022640b883e
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJD0VH axsdDEdXdwdEHAsR A28BWlNeUVU/WGtx dQ1ScwdeZlRMXgV1 Uk1WQxwTEnNgeWR0 QB4ZWh9zd0tAfnp4 K0E3WHJaDRApaBUo R0tJFGxTZHpoaDIW TUBYdQFSdAMYdhdG Px4dAXkdeRRVfz8j Hgk8dz4wOSlSMmFf WAgLJlJaT1wMG3Y1 DwgFBilqB0AOSiQt IlQmLVkfdAAA
X-Authentic-SMTP: 61633436303433.1015:706
X-AuthFastPath: 0 (Was 255)
X-AuthSMTP-Origin: 184.73.234.210/25
X-AuthVirus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201474>

On Jul 14, 2012, at 11:44 PM, Junio C Hamano wrote:

> Wincent Colaiuta <win@wincent.com> writes:
> 
>> On Jul 14, 2012, at 10:25 PM, Junio C Hamano wrote:
>> 
>>> I did not see anything wrong doing what you described in the
>>> post-receive, even though having the hook in the "scratch" felt
>>> strange, as the "copying from authoritative" would also want to be
>>> automated and the natural triggering mechanism to do so would be a
>>> post-receive there.  What issues were you worried about?
>> 
>> The part that I left out, to keep things simple, is that ...
> 
> I said "strange", not "wrong".  If it is undesirable to hook the
> "authoritative" repository, it is perfectly fine to hook on the
> receiving end.
> 
> So what issues were you worried about?

I guess I was just a little worried about using filter-branch in a completely automated context (I have used it previously, but always in a manual fashion to do explicit "surgery" on the history), so I really just wanted a sanity check. Thanks for your input; it's much appreciated.

We have a strict fast-forward-only policy on our master branch, so I think the hook will be quite simple to write and won't require us to handle any crazy edge cases.

Cheers,
Wincent
