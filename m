From: Karsten Weiss <knweiss@gmx.de>
Subject: https, client certificate, pem pass phrase
Date: Thu, 11 Jun 2009 10:36:14 +0200 (CEST)
Message-ID: <alpine.OSX.2.00.0906110956370.945@xor.localnet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 10:37:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEfmS-0001bp-Na
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 10:37:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758968AbZFKIgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 04:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758852AbZFKIgy
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 04:36:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:35867 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758478AbZFKIgx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 04:36:53 -0400
Received: (qmail invoked by alias); 11 Jun 2009 08:36:54 -0000
Received: from port-92-200-99-90.dynamic.qsc.de (EHLO mail.localnet) [92.200.99.90]
  by mail.gmx.net (mp038) with SMTP; 11 Jun 2009 10:36:54 +0200
X-Authenticated: #3612999
X-Provags-ID: V01U2FsdGVkX1+fyuoUvVSftqXlNEgOwJUusV5C2tRV/4Z4/hvOKB
	MRBh36OY7gonBP
Received: by mail.localnet (Postfix, from userid 502)
	id D8865B71413; Thu, 11 Jun 2009 10:36:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.localnet (Postfix) with ESMTP id CF3E8B71407
	for <git@vger.kernel.org>; Thu, 11 Jun 2009 10:36:14 +0200 (CEST)
User-Agent: Alpine 2.00 (OSX 1167 2008-08-23)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121331>

Hi,

I'm using git-1.6.3.2 (with curl-7.19.5) and would like to configure a 
private git server to be used over https with client-side certificate and 
BasicAuth authentication because I want to restrict access to selective 
and authenticated clients from the Internet which connect to the server 
through a firewall and web proxy.

So far my test setup works fine. Using SSL FakeBasicAuth I can even access 
the git server without storing the BasicAuth password unencrypted in 
~/.netrc (and there are also no git password prompts).

However, it only works as long as I do *not* protect the client's private 
key (PEM) with a pass phrase which is not secure (especially when using 
FakeBasicAuth!). When I do protect the private key with a pass phrase 
*each* git fetch/pull/push prompts the user *several* times with "Enter 
PEM pass phrase:". Thus, it's not usable (even though it works).

Is there any way I can prevent this? Ideally, I want to be prompted for 
the PEM pass phrase once and only once for each git command which uses a 
secure network connection.

Searching the git mailing list archive I found this thread from February 
09 which seems to indicate

git with https and client cert asks for password repeatedly
http://marc.info/?l=git&m=123553151323420&w=2

that this really does not work with git's current http code. Can anyone 
confirm that this is still the case? I'm willing to test patches if 
somebody is working on this problem.

-- 
Karsten Weiss
