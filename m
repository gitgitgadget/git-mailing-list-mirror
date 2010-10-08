From: David Michael Barr <david.barr@cordelta.com>
Subject: Re: [PATCH] fast-import: Allow filemodify to set the root
Date: Fri, 8 Oct 2010 19:58:44 +1100
Message-ID: <74AF320B-5D82-4622-A7BF-61C847D4059A@cordelta.com>
References: <1286448906-1424-1-git-send-email-david.barr@cordelta.com> <20101008081509.GA2845@kytes> <4CAED762.7040708@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Gabriel Filion <lelutin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 08 10:58:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P48n3-0003VY-IG
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 10:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756303Ab0JHI6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 04:58:52 -0400
Received: from ironport1-mx.cbr1.mail-filtering.com.au ([203.88.115.241]:65508
	"EHLO ironport1-mx.cbr1.mail-filtering.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753031Ab0JHI6v convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Oct 2010 04:58:51 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAG96rkzLWHsF/2dsb2JhbACiNghxsWGIToVHBIUJ
X-IronPort-AV: E=Sophos;i="4.57,302,1283695200"; 
   d="scan'208";a="254963713"
Received: from node2.alpha.aussiehq.net.au ([203.88.123.5])
  by ironport1-mta.cbr1.mail-filtering.com.au with ESMTP; 08 Oct 2010 19:58:48 +1100
Received: (qmail 27093 invoked from network); 8 Oct 2010 19:58:48 +1100
Received: from d110-33-95-167.mit3.act.optusnet.com.au (HELO ?192.168.1.1?) (110.33.95.167)
  by 203.88.123.185 with SMTP; 8 Oct 2010 19:58:47 +1100
In-Reply-To: <4CAED762.7040708@gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158495>

Hi,

>> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
>> index 966ba4f..90a4666 100644
>> --- a/Documentation/git-fast-import.txt
>> +++ b/Documentation/git-fast-import.txt
>> @@ -524,6 +524,9 @@ start with double quote (`"`).
>> If an `LF` or double quote must be encoded into `<path>` shell-style
>> quoting should be used, e.g. `"path/with\n and \" in it"`.
>> 
>> +Additionally, in `040000` mode, `<path>` may also be an empty string
>> +(`""`) to specify the root of the tree.
>> +
>> The value of `<path>` must be in canonical form. That is it must not:
>> 
>> * contain an empty directory component (e.g. `foo//bar` is invalid),
> 
> Thanks for keeping documentation up to date :)
> 
> Although, I think the documentation should be a bit more precise about
> what "specifying the root of the tree" means for a 'filemodify' command
> and its implication on performance (i.e. why there's actually this
> special case in the syntax)

The way I perceive it, the patch simply removes the special treatment of
the root, allowing it to be modified just as any other path.
The only property that distinguishes the root from other paths is that the
endpoint must be a tree.
