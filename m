From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 6/9] gitweb: Change appereance of marker of refs pointing to given object
Date: Mon, 14 Aug 2006 11:30:03 +0200
Message-ID: <200608141130.04148.jnareb@gmail.com>
References: <200608140202.46160.jnareb@gmail.com> <200608140214.20450.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 14 12:17:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCZVD-0001tP-Ki
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 12:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWHNKQs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 06:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWHNKQr
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 06:16:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:50060 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751988AbWHNKQo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 06:16:44 -0400
Received: by nf-out-0910.google.com with SMTP id k26so20482nfc
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 03:16:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=BePp4qlgHbt5BhVbDOnf6u2R7LLW5dThlBYE2cn9ruW5kA4svjwmBD7JGX7reN7RWbrT//cNmDGkaN6w1aYhw+cIuxMKZKfkd2uYiP7eD9eAx78FrNxz6ElZTCACsx992X6O8oqOMmJki9q+dlPjKkvl+2fS0Jx1tGAm63gm8f0=
Received: by 10.49.29.2 with SMTP id g2mr1045183nfj;
        Mon, 14 Aug 2006 03:16:43 -0700 (PDT)
Received: from host-81-190-23-158.torun.mm.pl ( [81.190.23.158])
        by mx.gmail.com with ESMTP id m16sm9637471nfc.2006.08.14.03.16.43;
        Mon, 14 Aug 2006 03:16:43 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608140214.20450.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25343>

Jakub Narebski wrote:
> Change git_get_references to include type of ref in the %refs value, which
> means putting everything after 'refs/' as a ref name, not only last
> part of the name.  Instead of separating refs pointing to the same
> object by " / " separator, use anonymous array reference to store all
> refs pointing to given object.

Earlier version of the patch used ':' (instead of ' / ') to concatenate
multiple refs pointing to the same object, then split on ':'. Character
':' was used because it cannot be part of valid ref name (as of
git-check-ref-name).

Note that usually there is at most one ref pointing to given object;
multiple refs are quite rare (usually when starting new branch, or just
tagged a branch).

-- 
Jakub Narebski
Poland
