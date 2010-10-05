From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH v4 0/4] Detection of directory renames
Date: Mon, 4 Oct 2010 20:42:08 -0500
Message-ID: <20101005014208.GE9994@burratino>
References: <1286138529-6780-1-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Brian Ewins <brian.ewins@gmail.com>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Tue Oct 05 03:45:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2wb0-0003Dy-S3
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 03:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973Ab0JEBp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 21:45:27 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:57932 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324Ab0JEBp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 21:45:26 -0400
Received: by qyk29 with SMTP id 29so1110495qyk.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 18:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=s9utnRRLCVOvw7XGbMksVLzLLklv1T/h8FhVOmAtp1k=;
        b=NEeafOu+39xrwAHs/AZqG3rYEfcA2pTleKQdYpPuDjpJ/PV0olx2ldcYk8x8orU+Bn
         h1ivxTDc8/kxT6j1NnqT1GC6doYvKlbFgw8Z9/1DNnU9MlOTZy5t5wcPbPDp5OdEE95P
         CrQGXUTmTAFSKYmS8ky6dcwtW2C5Z/mvYsaq4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tqEQy01Wr/PJ0VqXdxlTiDQQ82PmTkodnG6F6bR0Fjuk/PNRToUb/nkH0lgkZtkQdl
         PeR0LiJqWt8fV4bsmxHhnDtm/7dcPV6mnfI+Qcw75MVhSrKetnP7Hjc+lLtYaHcbwchY
         0GvzxOU/t/ckIGY1gL1dRSNlWkyfvGn5luD2Y=
Received: by 10.224.88.69 with SMTP id z5mr7298252qal.359.1286243125583;
        Mon, 04 Oct 2010 18:45:25 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id n9sm2415260vch.19.2010.10.04.18.45.24
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 18:45:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286138529-6780-1-git-send-email-ydirson@altern.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158156>

Yann Dirson wrote:

>                                       The most prominent change is a
> split of the old --factorize-renames flag into --detect-dir-renames
> and --hide-dir-rename-details - hopefully following Junio's comments
> dated nearly 2 years ago.

I suspect that makes the patches more readable, too.

> I hope we can turn the simple detection feature to something
> acceptable for inclusion - that is, once unified diff output shows the
> detected renames as annotations, and once the known major holes are
> plugged (both from FIXME and testcases).

>From my point of view, I think it would be best to start with
the smallest usable piece, which is the raw format.  It probably
makes the most sense to error out when -u and --detect-dir-renames are
used together.  Then unified diff could be reenabled in a separate
patch series on top of this one.

Another nice feature might be to let the directory-move
detection feed back into file-move detection to make it more
accurate.  Have you thought about this?  Would it be feasible,
and if so, would it be useful?
