From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 01/11] replace: forbid replacing an object with one
 of a different type
Date: Sun, 01 Sep 2013 13:53:21 +0200 (CEST)
Message-ID: <20130901.135321.1182162250658468787.chriscool@tuxfamily.org>
References: <20130831190528.26699.33964.chriscool@tuxfamily.org>
	<20130831191215.26699.18957.chriscool@tuxfamily.org>
	<7D7C5D53BA544AAD92B05DF9635926C8@PhilipOakley>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, trast@inf.ethz.ch,
	j6t@kdbg.org
To: philipoakley@iee.org
X-From: git-owner@vger.kernel.org Sun Sep 01 13:53:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VG6E4-000305-25
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 13:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757234Ab3IALxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Sep 2013 07:53:48 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:47655 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757182Ab3IALxs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Sep 2013 07:53:48 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 97B8B5D;
	Sun,  1 Sep 2013 13:53:24 +0200 (CEST)
In-Reply-To: <7D7C5D53BA544AAD92B05DF9635926C8@PhilipOakley>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233586>

From: "Philip Oakley" <philipoakley@iee.org>
>
> Sorry for not replying earlier in the series.
> 
> From: "Christian Couder" <chriscool@tuxfamily.org>
>> Users replacing an object with one of a different type were not
>> prevented to do so, even if it was obvious, and stated in the doc,
>> that bad things would result from doing that.
>>
>> To avoid mistakes, it is better to just forbid that though.
>>
>> If one object is replaced with one of a different type, the only way
>> to keep the history valid is to also replace all the other objects
>> that point to the replaced object.
> 
> Isn't this a recursion problem? Taken in that order one unravels the
> whole DAG.
> 
> However if considered in the reverse direction, one can replace an
> existing object within the DAG with a carefully crafted alternative of
> the same type, but which then wrongly references other dangling
> objects which are then replaced by objects which have the right type
> (this last replacement requires -f force).

I am not sure I understand what you are saying.

Anyway in a previous version of this patch I tried to be more explicit
about this, but Junio basically said that he found no value in
discussing this more explicitely...

Thanks,
Christian.
