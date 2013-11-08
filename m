From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v4 02/14] add a hashtable implementation that supports O(1) removal
Date: Fri, 8 Nov 2013 16:45:46 -0000
Organization: OPDS
Message-ID: <2BEA8A50DFB9411BA89CAB9236687F5B@PhilipOakley>
References: <527BA483.6040803@gmail.com> <527BA4F3.3040806@gmail.com> <xmqq4n7nriuj.fsf@gitster.dls.corp.google.com> <527CBC8E.6050507@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>, "Thomas Rast" <tr@thomasrast.ch>,
	"Jens Lehmann" <Jens.Lehmann@web.de>
To: "Karsten Blees" <karsten.blees@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 08 17:45:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VepBp-0007MX-25
	for gcvg-git-2@plane.gmane.org; Fri, 08 Nov 2013 17:45:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757096Ab3KHQpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Nov 2013 11:45:41 -0500
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:35161 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756856Ab3KHQpk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Nov 2013 11:45:40 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnAGAGUUfVJZ8Y58/2dsb2JhbABagweJPbZhgS8XdIIgBQEBBAEIAQEdER4BASEFBgIDBQIBAxUMJRQBBAgSBgcXBgESCAIBAgMBh14DCQqzFw2Ja4x1gnKDJ4EQA4kKhhKHCI4+hTiBOoFsPA
X-IPAS-Result: AnAGAGUUfVJZ8Y58/2dsb2JhbABagweJPbZhgS8XdIIgBQEBBAEIAQEdER4BASEFBgIDBQIBAxUMJRQBBAgSBgcXBgESCAIBAgMBh14DCQqzFw2Ja4x1gnKDJ4EQA4kKhhKHCI4+hTiBOoFsPA
X-IronPort-AV: E=Sophos;i="4.93,661,1378854000"; 
   d="scan'208";a="593512449"
Received: from host-89-241-142-124.as13285.net (HELO PhilipOakley) ([89.241.142.124])
  by out1.ip06ir2.opaltelecom.net with SMTP; 08 Nov 2013 16:45:38 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237455>

From: "Karsten Blees" <karsten.blees@gmail.com>

> However, defining the constants inversely is a bit unintuitive (i.e. 
> 1.25 instead of 0.8, 6 instead of 0.166). Perhaps the thresholds 
> should also be calculated once on resize, not on every add / remove.
>
> What about this:
>
> #define HASHMAP_GROW_AT 80
> #define HASHMAP_SHRINK_AT 16

mico-bikeshed adding a code comment...

 #define HASHMAP_GROW_AT 80    /* percent */
 #define HASHMAP_SHRINK_AT 16    /* percent */

>
> ...in rehash:
>
> map->grow_at = (unsigned int)((uint64_t) map->tablesize * 
> HASHMAP_GROW_AT / 100);
> map->shrink_at = (unsigned int)((uint64_t) map->tablesize * 
> HASHMAP_SHRINK_AT / 100);
>

[No need to add to cc...]

regards

Philip 
