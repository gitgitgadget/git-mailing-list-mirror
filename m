From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC 2/2] Add Git-aware CGI for Git-aware smart HTTP transport
Date: Mon, 04 Aug 2008 19:02:13 -0700
Message-ID: <4897B4A5.4030700@zytor.com>
References: <20080803025602.GB27465@spearce.org> <1217748317-70096-1-git-send-email-spearce@spearce.org> <1217748317-70096-2-git-send-email-spearce@spearce.org> <7vwsix7nhw.fsf@gitster.siamese.dyndns.org> <20080804035921.GB2963@spearce.org> <4896D19C.6040704@dawes.za.net> <20080804144824.GB27666@spearce.org> <4897A6E4.3070508@zytor.com> <20080805012459.GC32543@spearce.org> <4897AE53.4030107@zytor.com> <20080805015717.GB383@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Rogan Dawes <lists@dawes.za.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 05 04:03:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQBtc-0005uF-JL
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 04:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757745AbYHECCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 22:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756002AbYHECCa
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 22:02:30 -0400
Received: from terminus.zytor.com ([198.137.202.10]:51820 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730AbYHECCa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 22:02:30 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m7522Eik012468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Aug 2008 19:02:14 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m7522ERi013355;
	Mon, 4 Aug 2008 19:02:14 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m7522DlX009029;
	Mon, 4 Aug 2008 19:02:14 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080805015717.GB383@spearce.org>
X-Virus-Scanned: ClamAV 0.93.3/7941/Mon Aug  4 15:44:27 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91406>

Shawn O. Pearce wrote:
> 
> I guess we need to ask client implementations to honor a redirect
> on the first request and reuse that new base URL for all subsequent
> requests that are part of the same "operation".  Then server farms
> can issue a redirect to a server-specific hostname if a client
> comes in with a round-robin DNS hostname, thus ensuring that for
> this current operation there isn't skew.
> 

Either that, or you can pass a "chase URL" in the payload of the 
request... it's more or less the same concept.

	-hpa
