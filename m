From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Q: description of file name encoding approach used by git
Date: Wed, 11 Feb 2009 11:08:48 -0500
Message-ID: <76718490902110808g47b3ce0bm24419c89b5cb4aaa@mail.gmail.com>
References: <85647ef50902110356l19870259t9de22fd8827ac144@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 17:11:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXHfk-0007eE-NT
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 17:10:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757660AbZBKQIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 11:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757646AbZBKQIu
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 11:08:50 -0500
Received: from rv-out-0506.google.com ([209.85.198.225]:9813 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757631AbZBKQIt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 11:08:49 -0500
Received: by rv-out-0506.google.com with SMTP id g37so7606rvb.1
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 08:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TcycQTnlb8hOJrHLc5GqS6fOJsDVb79K84GpfOOs9ew=;
        b=Nk1ZKnSqYpfmejfLruQ3rHqxjgTnP3bAHO3OeTSEsG4KPAReT/aQbod4Vl61nIK5Za
         ETqmsNn+JZpZe6sP5k1onHX6w+lxd6DSF470YWaC5kr7JO7sxkAaVy/SmZhZSA4wMy5v
         rHkWfZ280FlOlvOe+VfgagnBcOwkuhPRCEiE8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Q3WCRN+PyCxg03P7cZ/6OC+br0JBZsffqutMYkopiy7kq7YFoBzAQzfJArRFeCYUDX
         P+5oEuNjJiJvgiYYw5c2vlUySMxxrkx5tZXhzpSChNsAzQHCUqsVbCr/Z1qbgTbKFvm4
         fkuDG//N9AplNE0CPin58Gf27/FnEKKfOjirU=
Received: by 10.141.71.21 with SMTP id y21mr5657716rvk.0.1234368528291; Wed, 
	11 Feb 2009 08:08:48 -0800 (PST)
In-Reply-To: <85647ef50902110356l19870259t9de22fd8827ac144@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109433>

On Wed, Feb 11, 2009 at 6:56 AM, Constantine Plotnikov
<constantine.plotnikov@gmail.com> wrote:
> 3. As I understand, there is an unresolved problem with Mac OSX HFS+
> case insensitive file system due to file name normalization.

HFS+ can be configured to be case-sensitive, though it is not by
default. However, this is only a problem if the repo contains > 1
filenames that collide in a case-insensitive filesystem, since HFS+ is
case-preserving.

The larger HFS+ problem is that it performs Unicode NFD normalization,
which is unfortunately lossy. There are some good links about the
topic here: https://bugs.launchpad.net/bzr/+bug/172383

j.
