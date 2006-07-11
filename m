From: sf <sf-gmane@stephan-feder.de>
Subject: Re: [PATCH 2/3] sha1_file: add the ability to parse objects in "pack
 file format"
Date: Wed, 12 Jul 2006 00:25:43 +0200
Message-ID: <44B42567.9010307@stephan-feder.de>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0607101623230.5623@g5.osdl.org> <20060711145527.GA32468@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0607111004360.5623@g5.osdl.org> <Pine.LNX.4.64.0607111010320.5623@g5.osdl.org> <44B4172B.3070503@stephan-feder.de> <Pine.LNX.4.64.0607111449190.5623@g5.osdl.org>
Reply-To: sf-gmane@stephan-feder.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jul 12 00:29:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0QiJ-0007Bd-DC
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 00:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWGKW2P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 18:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWGKW2O
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 18:28:14 -0400
Received: from main.gmane.org ([80.91.229.2]:31884 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932216AbWGKW2N (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 18:28:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G0Qh1-0006yC-R8
	for git@vger.kernel.org; Wed, 12 Jul 2006 00:26:59 +0200
Received: from ip-213157024137.dialin.heagmedianet.de ([213.157.24.137])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Jul 2006 00:26:59 +0200
Received: from sf-gmane by ip-213157024137.dialin.heagmedianet.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Jul 2006 00:26:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ip-213157024137.dialin.heagmedianet.de
User-Agent: Thunderbird 1.5.0.4 (X11/20060606)
In-Reply-To: <Pine.LNX.4.64.0607111449190.5623@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23744>

Linus Torvalds wrote:
...
> The common byte sequence for a compressed stream is
> 
> 	78 9c ...
> 
> where the first byte is the CMF byte (compression info and method).
> 
> But it's not the only possible such sequence according to the zlib format.

No, but 0x78 is the only first byte ever produced by git; the files are
always deflated (second nibble is 8) with window size 32K (first nibble
is 7).
