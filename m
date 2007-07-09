From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Fix "git log --parent -m" from emitting duplicated parent info
Date: Mon, 9 Jul 2007 07:46:10 +0200
Message-ID: <e5bfff550707082246k39286517o58fe89d80e05e08@mail.gmail.com>
References: <e5bfff550707080737j56c161bdrf0c079b61877085b@mail.gmail.com>
	 <7vd4z2za2g.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0707090220281.4248@racer.site>
	 <7vps32xsof.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 07:46:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7m4m-0001ji-S6
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 07:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbXGIFqM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 01:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbXGIFqM
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 01:46:12 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:40651 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbXGIFqL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 01:46:11 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1258220wah
        for <git@vger.kernel.org>; Sun, 08 Jul 2007 22:46:10 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r067TN0F+zi7KnJQE8OMv5eL+G3hJFpo9e96552kxVmDrhsPrCOjja4Qm+/mgSzUBiOkn9PnHHQzUutLaNaw7hWkGVvIUuOWKSaWG3GZVVna8+uzQc3/ndKJXNC5S7WGc8CBHXTacFmQv4F6UcbO6jCExxdS+psy7Nkg1potw3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZUmPEjhBMHbtANmjqBVS/JD7DpP59LTXXVr4TpBidr3VGx6h4ymoutsKFlhTjhSa/GRah420ffYAajFkTQUIqFVwN1Y38nRKm+pePDz7CTYlZSNFT45ykVHz4GlK702gactA2uaPRwjML906lAKFeVDX39Z4b7BwiZl8A9vVZeI=
Received: by 10.114.78.1 with SMTP id a1mr2789150wab.1183959970732;
        Sun, 08 Jul 2007 22:46:10 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Sun, 8 Jul 2007 22:46:10 -0700 (PDT)
In-Reply-To: <7vps32xsof.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51961>

On 7/9/07, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> Second try, this time not doing the simplification when --full-history
> is given.
>

Probably I'm wrong but I would think the first original version with
post-filtering is more
correct.

Indeed we can use and _do_ use --full-history not only for printing
all revisions but to _walk_ the tree in a certain way, different from
default.

IMHO --parents + --full-history is absolutely legal because the first
flag indicate how to walk the tree and the second flag indicate what
to show to the user.

I agree the original patch is much uglier then your last version but I
would say is more correct.

Thanks
Marco
