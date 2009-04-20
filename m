From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] Fix uninitialized memory in get_local_heads()
Date: Mon, 20 Apr 2009 09:51:18 -0400
Message-ID: <76718490904200651t6cee0d73n8cbdea8099487654@mail.gmail.com>
References: <1240220930-24679-1-git-send-email-Matthieu.Moy@imag.fr>
	 <alpine.DEB.1.00.0904201219240.6955@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 20 15:53:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvtva-0000OS-7l
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 15:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755265AbZDTNvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 09:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755164AbZDTNvU
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 09:51:20 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:21484 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754793AbZDTNvT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 09:51:19 -0400
Received: by yx-out-2324.google.com with SMTP id 3so774134yxj.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 06:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PzX8wWuWu7agHnA3MFur22G2RN3Iq7b2jx6m/2RhC7s=;
        b=Kc0pf0YrGiFTIm/dy4skoML9+YyTv7W43XLu128o4m61/V9i1I6k7IOsGO4P97nPO8
         D5EvyQ4nC+9Fm4MJ9WlhcjDB4Da0+OrNqZ8/3XLMoS2KNEM2+SwQtoc/2u2AIT+uB0AY
         C66T9n9EWj0XYCHY6qB8JlHw4mvvJ+4gvac4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ndqpCtvJsXuRvwqwDO5p9tDKdMptxar0hzeiHXPoak1hdfyxUacHe0W6N9LTn+kgDu
         0J2+BU6umvhFQa+QyGNRpCIrtJgNzU+U0nGfczg8zKsZBO/wqiW96lYh0g6HhxFAr3Ew
         eW4cnSB8xhberCz3Nz9zAFWpEJqTx/TVWaeD8=
Received: by 10.151.44.15 with SMTP id w15mr6403097ybj.147.1240235478869; Mon, 
	20 Apr 2009 06:51:18 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904201219240.6955@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116984>

On Mon, Apr 20, 2009 at 6:20 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> In 454e202(move duplicated get_local_heads() to remote.c), a static
> local variable was moved into a function, but not initialized.
>
> This resulted in a crash when trying to push from an empty repository.
>
> Noticed by Matthieu Moy.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Doh. Thank you for the fix.

j.
