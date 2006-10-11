From: Pazu <pazu@pazu.com.br>
Subject: Re: Gitweb indentation wrong in Internet Explorer
Date: Wed, 11 Oct 2006 17:53:51 -0300
Message-ID: <egjllu$6k8$1@sea.gmane.org>
References: <20061011172553.GA1147@linux-mips.org> <egjang$nmh$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Oct 11 23:03:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXlCX-00040a-Rv
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 23:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161373AbWJKVBL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 17:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161374AbWJKVBL
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 17:01:11 -0400
Received: from main.gmane.org ([80.91.229.2]:9613 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161373AbWJKVBJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 17:01:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GXl8n-0002nk-CS
	for git@vger.kernel.org; Wed, 11 Oct 2006 22:57:25 +0200
Received: from 201.37.98.50 ([201.37.98.50])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 22:57:25 +0200
Received: from pazu by 201.37.98.50 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 22:57:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 201.37.98.50
User-Agent: Thunderbird 1.5.0.7 (Macintosh/20060909)
In-Reply-To: <egjang$nmh$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28748>

Jakub Narebski wrote:

> Which version of gitweb? We have removed s/ /&nbsp;/g; in esc_html
> subroutine in favor of using "white-space: pre;" in CSS some time ago,
> and we have added escaping FORM FEED and ESCAPE characters.

The problem here is that "white-space: pre" is only supported by IE6 in 
standards compliance mode[1], but the DTD declaration for this page:

<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

surprisingly triggers IE6 quirks mode[2]. A quick fix to this problem 
would be changing the doctype declaration to use XHTML 1.0 Transitional 
instead of Strict, as that would trigger IE6 standards-compliance mode.

[1] 
http://msdn.microsoft.com/workshop/author/dhtml/reference/properties/whitespace.asp

[2] http://hsivonen.iki.fi/doctype/

-- Marcus
