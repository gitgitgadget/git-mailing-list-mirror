From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] shallow clone
Date: Tue, 31 Jan 2006 15:20:36 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601311518120.9824@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7voe1uchet.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0601301220420.6424@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xsxa70o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 15:21:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3wNq-0008D1-CZ
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 15:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWAaOUi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 09:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWAaOUh
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 09:20:37 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:60857 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750884AbWAaOUh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 09:20:37 -0500
Received: from virusscan.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4B8E2146714; Tue, 31 Jan 2006 15:20:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 3DB66A36;
	Tue, 31 Jan 2006 15:20:36 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0BE03146714; Tue, 31 Jan 2006 15:20:36 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xsxa70o.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15316>

Hi,

On Mon, 30 Jan 2006, Junio C Hamano wrote:

> We need to realize that `upload-pack` that hears
> "have A, want B" is allowed to omit objects that appear in
> `ls-tree B` output but not in `ls-tree A`.  "have A" means not
> just "I have A", but "I have A and all of its ancestors", so
> just sending "have start_shallow" (or start_shallow^ for that
> matter) is not quite enough.

So how about adding a "have-single A" which would be translated to 
"git-rev-list ~A", which in turn would only mark the tree and its 
children, but not the parents?

Ciao,
Dscho
