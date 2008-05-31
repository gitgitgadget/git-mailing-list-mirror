From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: gitweb forgets to send utf8 header for raw blob views
Date: Sat, 31 May 2008 17:04:53 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0805311703420.4055@fbirervta.pbzchgretzou.qr>
References: <alpine.LNX.1.10.0805282002510.19264@fbirervta.pbzchgretzou.qr> <m3tzgg1a06.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 31 17:05:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2SeR-0005dx-7r
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 17:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837AbYEaPEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 11:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752801AbYEaPEz
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 11:04:55 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:40812 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbYEaPEz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 11:04:55 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 4476D1803D07D; Sat, 31 May 2008 17:04:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 393C21CD6B140;
	Sat, 31 May 2008 17:04:53 +0200 (CEST)
In-Reply-To: <m3tzgg1a06.fsf@localhost.localdomain>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83392>


On Friday 2008-05-30 10:18, Jakub Narebski wrote:
>Jan Engelhardt <jengelh@medozas.de> writes:
>
>> I have configured gitweb to use utf8, and that works for text blob views 
>> like on
>> http://dev.medozas.de/gitweb.cgi?p=hxtools;a=blob;f=bin/git-forest;hb=HEAD
>> but it does not for raw blob views like
>> http://dev.medozas.de/gitweb.cgi?p=hxtools;a=blob_plain;f=bin/git-forest;hb=HEAD
>
>This can depend on configuration, both on gitweb configuration (you
>can for example define $default_blob_plain_mimetype to 'text/plain;
>charset=utf-8', and define $default_text_plain_charset to 'utf-8'),
>and on your /etc/mime.types; gitweb does not add charset info if
>mimetype is acquired from mime.types, which I guess is a mistake.

Thanks for the hint. Setting 
	our $default_text_plain_charset  = "utf-8";
was all that was needed. I only had $fallback_encoding set to utf-8
for whatever reason...
