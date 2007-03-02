From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: Re: [PATCH, 4th version] git-branch: register where to merge from,
   when branching off a remote branch
Date: Fri, 02 Mar 2007 17:33:54 +0100
Message-ID: <45E851F2.6010405@lu.unisi.ch>
References: <es450f$d58$1@sea.gmane.org> <Pine.LNX.4.63.0703010221000.22628@wbgn013.biozentrum.uni-wuerzburg.de> <81b0412b0702282355i176ad7e5t7b9e417b27e524fb@mail.gmail.com> <45E68897.8000607@lu.unisi.ch> <81b0412b0703010010o24513f60x937b5af52362e0c8@mail.gmail.com> <45E68EDE.2090405@lu.unisi.ch> <81b0412b0703010033w2e1079a3l6ac6e38c59bdefd5@mail.gmail.com> <45E69297.8070001@lu.unisi.ch> <81b0412b0703010059w52a33b54n4d3c25ada6b96369@mail.gmail.com> <45E69EEE.8070905@lu.unisi.ch> <81b0412b0703010212w5367c8cek51f22e9098f8e22f@mail.gmail.com> <7vvehls1h9.fsf@assigned-by-dhcp.cox.net> <45E70041.1030705@lu.unisi.ch> <Pine.LNX.4.63.0703012240210.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45E7DC04.5010701@lu.unisi.ch> <45E7E53E.5020704@gnu.org> <7vtzx4ezvm.fsf@assigned-by-dhcp.cox.net> <45E8072A.2020303@lu.unisi.ch> <Pine.LNX.4.63.0703021647560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <paolo.bonzini@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 02 17:34:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNAhw-0005Ad-BS
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 17:34:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992593AbXCBQd5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 11:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992598AbXCBQd5
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 11:33:57 -0500
Received: from server.usilu.net ([195.176.178.200]:16225 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S2992593AbXCBQd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 11:33:56 -0500
Received: from [192.168.76.141] ([192.168.76.141] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 2 Mar 2007 17:33:54 +0100
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
In-Reply-To: <Pine.LNX.4.63.0703021647560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-OriginalArrivalTime: 02 Mar 2007 16:33:54.0984 (UTC) FILETIME=[91B16A80:01C75CE8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41227>


>>>> +	else if (dwim_ref(start_name, strlen(start_name), sha1, &real_ref))
>>>> +		remote = !prefixcmp(real_ref, "refs/remotes/");
>>>  - (pure question) What happens if dwim_ref() returns more than one?
>> Then, real_ref is the one matching sha1.
> 
> Which one ;-)

Matching "the variable named" sha1. :-)

> What Junio tried to get at: if you have "refs/heads/my" and 
> "refs/remotes/origin/my", dwim_ref("my", ...) returns 2 (or even more, if 
> you have other refs ending in "/my").

But the sha1 and the real_ref are always consistent.  If I get refs/heads/my (and a non-remote will always override the remote), the sha1 is non remote.  If I get refs/remotes/origin/my (which triggers the magic), the sha1 is remote.

Still, let's put this patch on hold, I have to understand more about git before proposing something that is clearly beyond my knowledge (as the criticism shows).

Paolo
