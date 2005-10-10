From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: First cut at git port to Cygwin
Date: Mon, 10 Oct 2005 11:43:47 -0700
Message-ID: <434AB663.8050205@zytor.com>
References: <20051005155457.GA30303@trixie.casa.cgf.cx>	<20051005191741.GA25493@steel.home>	<20051005202947.GA6184@trixie.casa.cgf.cx>	<81b0412b0510060205v4cd510c9wb4b06a3ed9242c8@mail.gmail.com>	<81b0412b0510060307q431b64edt4196553bce28346c@mail.gmail.com>	<81b0412b0510070544v3e7cf0b4n521db8ff7e4e335a@mail.gmail.com>	<Pine.LNX.4.64.0510070828270.31407@g5.osdl.org>	<20051007205450.GA14827@steel.home> <20051007212250.GA1423@steel.home>	<4346E8AC.5030503@citi.umich.edu> <20051007213952.GA8821@steel.home>	<Pine.LNX.4.64.0510080900510.31407@g5.osdl.org>	<Pine.LNX.4.63.0510082023130.25971@wbgn013.biozentrum.uni-wuerzburg.de> <7vr7avrgr2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Oct 10 20:46:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP2de-00063I-2t
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 20:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbVJJSoi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 14:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbVJJSoi
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 14:44:38 -0400
Received: from terminus.zytor.com ([192.83.249.54]:11407 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751173AbVJJSoh
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 14:44:37 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9AIhprm001742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Oct 2005 11:43:52 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7avrgr2.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9909>

Junio C Hamano wrote:
> 
> PROT_WRITE is true, but we do MAP_PRIVATE, and if I recall
> correctly we do not write file via mmap -- at least we do not
> intend to.
> 

Then PROT_READ probably makes more sense?

> 
> Yes.  It might have been overkill that you supported writing
> changes back, though.

Not just overkill; if we do MAP_PRIVATE it's actively WRONG.

	-hpa
