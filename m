From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v3] Document pack v4 format
Date: Sat, 07 Sep 2013 00:57:03 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309070054320.20709@syhkavp.arg>
References: <1377917393-28460-1-git-send-email-pclouds@gmail.com>
 <1378433643-15638-1-git-send-email-pclouds@gmail.com>
 <alpine.LFD.2.03.1309052319310.20709@syhkavp.arg>
 <CACsJy8AWa0NFViO+3Cnp_0Gqzqidcbx9vPd1wxCuY1jjWhyFaQ@mail.gmail.com>
 <alpine.LFD.2.03.1309060922020.20709@syhkavp.arg>
 <CACsJy8CVaFKZE2bM+1AZPTpq19BS8-=UrYCcvO004Aw_EX-vfg@mail.gmail.com>
 <alpine.LFD.2.03.1309061224350.20709@syhkavp.arg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 07 06:57:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIAaI-0003nu-Gj
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 06:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819Ab3IGE5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 00:57:06 -0400
Received: from relais.videotron.ca ([24.201.245.36]:13601 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab3IGE5E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 00:57:04 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSQ00K1MOF3MV50@VL-VM-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 07 Sep 2013 00:57:03 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 724BF2DA0547; Sat, 07 Sep 2013 00:57:03 -0400 (EDT)
In-reply-to: <alpine.LFD.2.03.1309061224350.20709@syhkavp.arg>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234114>

On Fri, 6 Sep 2013, Nicolas Pitre wrote:

> On Fri, 6 Sep 2013, Duy Nguyen wrote:
> 
> > In your code you reject sha1ref starting with zero too
> > (sha1_file.c::get_base_delta and packv4-parse.c::decode_entries)
> 
> Yeah... because I wrote the minimum code to make it work with the 
> current encoder.  But the decoder could be more lenient than that.  It's 
> just a matter of adding a call to find_pack_entry_one() when the sha1ref 
> index is 0.

FYI I've added the missing code to packv4-parse.c::decode_entries.
The code in sha1_file.c::get_delta_base was already fine.


Nicolas
