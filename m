From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: [PATCH] Fix export_marks() error handling.
Date: Mon, 13 Jul 2009 10:01:57 +0200
Message-ID: <op.uwzxxj2m1e62zd@merlin.emma.line.org>
References: <alpine.DEB.1.00.0907091500420.4339@intel-tinevez-2-302>
 <1247146081-4692-1-git-send-email-matthias.andree@gmx.de>
 <20090711094546.GA12399@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Mon Jul 13 10:02:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQGUX-0004cb-0V
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 10:02:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425AbZGMICE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 04:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbZGMICE
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 04:02:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:44481 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750830AbZGMICD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 04:02:03 -0400
Received: (qmail invoked by alias); 13 Jul 2009 08:02:00 -0000
Received: from g230242235.adsl.alicedsl.de (EHLO mandree.no-ip.org) [92.230.242.235]
  by mail.gmx.net (mp035) with SMTP; 13 Jul 2009 10:02:00 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX181V/scN7Q1O88ddPO+pd2NZ11vwDv7edad4IqVLi
	tr5FW2jNjJAlDR
Received: from merlin.emma.line.org (localhost [127.0.0.1])
	by merlin.emma.line.org (Postfix) with ESMTP id 67B28194006;
	Mon, 13 Jul 2009 10:01:58 +0200 (CEST)
In-Reply-To: <20090711094546.GA12399@cuci.nl>
User-Agent: Opera Mail/9.64 (Linux)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123173>

Am 11.07.2009, 11:45 Uhr, schrieb Stephen R. van den Berg <srb@cuci.nl>:

> Matthias Andree wrote:
>> +	/* do not optimize the next two lines - they must both be executed in
>> +	 * this order. || might short-circuit the fclose(), and combining them
>> +	 * into one statement might reverse the order of execution.
>> +	 * Also, fflush() may not be sufficient - on some file systems, the
>> +	 * error is still delayed until the final [f]close().  */
>> +	e  = ferror(f);
>> +	e |= fclose(f);
>> +	if (e)
>
> The commentary above should be common knowledge for anyone familiar with
> ANSI C.  So I'd suggest moving the comments into the description section  
> of
> the commit and removing them from the actual code.

Feel free to do it and submit a patch, I'm not going to invest more time  
into a piece of code that runs seldomly.

-- 
Matthias Andree
