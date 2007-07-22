From: "Jason Sewall" <jasonsewall@gmail.com>
Subject: Re: Test #7 in t9200-git-cvsexportcommit fails
Date: Sun, 22 Jul 2007 13:49:19 -0700
Message-ID: <31e9dd080707221349g40ff050bue72733f270822603@mail.gmail.com>
References: <31e9dd080707221241j5c00aaaaqa79c12d3e2a3345b@mail.gmail.com>
	 <20070722202121.GA3288@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 22:49:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICiMm-00072l-00
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 22:49:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763003AbXGVUtV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 16:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762810AbXGVUtU
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 16:49:20 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:3586 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760632AbXGVUtU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 16:49:20 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1310641wxd
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 13:49:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QfNBH7pw6imMcrWTvElGyt+3pRMiVgOwywGdTW/O9Gi/1ZRsfU4sRg99NsyJWHN1zpO4QG4XjkMJgw1umIc+5CAPoTxvz3Y0nG3XdcB9Sg2f7ReFh4rEObYM6saQv6S6nPViBVGUyJwni44vT+voAeG/Fi4xyRpitYlqUp5d/nQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=odY2B9msNisDJMxibNVtAoewJnRVtvHQa6mMYBGwx19ZShbMeNJSo+Ufwkn9eOUkkAqpqYo4CfgNWu/MoBm1jdeirZygNbSXSlpYZOktWv2QZn3bZTpU8zgjQ19z1QSiCmcpSQvjaX2yGCszExn/LYnkbSpxnvSBLjN+7ianbbE=
Received: by 10.90.50.1 with SMTP id x1mr1417761agx.1185137359171;
        Sun, 22 Jul 2007 13:49:19 -0700 (PDT)
Received: by 10.90.54.18 with HTTP; Sun, 22 Jul 2007 13:49:19 -0700 (PDT)
In-Reply-To: <20070722202121.GA3288@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53316>

> It'll never work, cvs does not commit changes made during one second,
> as they have the same timestamp.

Why not add a delay in there, like this:

id=$(git rev-list --max-count=1 HEAD) && sleep 2

It makes the test work for me.

Jason
