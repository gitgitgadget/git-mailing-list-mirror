From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] setup_revisions(): do not access outside argv
Date: Thu, 21 May 2009 11:38:25 +0900
Message-ID: <buoljor6uzi.fsf@dhlpc061.dev.necel.com>
References: <1242806900-3499-1-git-send-email-pclouds@gmail.com>
	<4A13BC3C.5070000@viscovery.net>
	<fcaeb9bf0905200123r3649a7e5vc40ece402379e701@mail.gmail.com>
	<7v7i0btdwu.fsf@alter.siamese.dyndns.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 21 04:38:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6yB9-0008Fj-De
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 04:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380AbZEUCif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 22:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754277AbZEUCie
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 22:38:34 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:61149 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753596AbZEUCid (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 22:38:33 -0400
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n4L2c8xT015967;
	Thu, 21 May 2009 11:38:25 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay11.aps.necel.com with ESMTP; Thu, 21 May 2009 11:38:25 +0900
Received: from dhlpc061 ([10.114.113.45] [10.114.113.45]) by relay11.aps.necel.com with ESMTP; Thu, 21 May 2009 11:38:25 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 70EBF52E21E; Thu, 21 May 2009 11:38:25 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <7v7i0btdwu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 20 May 2009 18:58:41 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119647>

Junio C Hamano <gitster@pobox.com> writes:
> If a function takes (int ac, char **av), then people should be able to
> depend on the usual convention of
>
>  (1) for any i < ac, av[i] is not NULL; and
>  (2) av[ac] is NULL.

Hmm, isn't potentially useful to be able to pass a sub-range (of a
longer argv vector) to an ac/av function?  In such a case, av[ac] may
not be NULL.

-Miles

-- 
97% of everything is grunge
