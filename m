From: Kevin Ballard <kevin@sb.org>
Subject: Re: Useful tip about !aliases
Date: Tue, 15 Jul 2008 17:58:25 -0700
Message-ID: <EC8F3D14-CAD6-4337-B8AA-FD741E6313CE@sb.org>
References: <3BD7F543-7CB4-48B6-8D2C-DEA2ADC6EF5F@sb.org> <alpine.DEB.1.00.0807160250120.2841@eeepc-johanness>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 16 02:59:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIvMi-0001u2-Oe
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 02:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753034AbYGPA61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 20:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753085AbYGPA61
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 20:58:27 -0400
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:59938 "EHLO
	randymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751921AbYGPA61 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jul 2008 20:58:27 -0400
Received: from [10.100.18.129] (dsl092-049-214.sfo4.dsl.speakeasy.net [66.92.49.214])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a1.g.dreamhost.com (Postfix) with ESMTP id 2D7DF18DBB4;
	Tue, 15 Jul 2008 17:58:26 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807160250120.2841@eeepc-johanness>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88619>

On Jul 15, 2008, at 5:50 PM, Johannes Schindelin wrote:

> Hi,
>
> On Tue, 15 Jul 2008, Kevin Ballard wrote:
>
>> Here's something I discovered recently about !aliases that other  
>> folks might
>> find useful. The canonical form for a shell alias is something like
>>
>> git config alias.foo '!echo bar'
>>
>> where any args given to foo, as in `git foo blah` are passed along  
>> to the
>> shell, so in this case `echo bar blah` would be invoked.
>>
>> Something that I find very useful is the ability to interpolate  
>> arguments into
>> the middle of a command. This doesn't seem possible at first  
>> glance, not
>> without a helper script. But it certainly is possible, with the  
>> help of shell
>> functions:
>>
>> git config alias.reverse '!foo () { args=''; while [[ -n "$*" ]];  
>> do args="$1
>> $args"; shift; done; echo $args; }; foo'
>
> On the gitwiki, you will find a more elegant solution using "sh -c".

I'd forgotten you can do that, but I disagree that it's more elegant.  
It's a bit shorter, certainly, but it also invokes another process.  
Using a shell function doesn't.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
