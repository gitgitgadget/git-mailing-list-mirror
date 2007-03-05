From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: [BUG] git-rev-list: --topo-order --boundary and --max-count
Date: Mon, 5 Mar 2007 11:02:27 +0100
Message-ID: <8aa486160703050202y5ee159d2i42a2859a00b41679@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 05 11:02:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOA1q-0003qy-Rj
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 11:02:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933012AbXCEKCb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 05:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933017AbXCEKCa
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 05:02:30 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:4659 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933012AbXCEKC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 05:02:29 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2034311nfa
        for <git@vger.kernel.org>; Mon, 05 Mar 2007 02:02:27 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AfXTS/EzL8dH1VQg7QMa9LEvMO2Y2UoJ1GTg2CITv6oqNyYJZUllov3f1Kl0UE78GHAxP3y6MLQ+AgbuXtGMEoXHbe0UoRdyrYj23owYVtusjEhBYyfKgAinXalsZ+7tKVXv8Mdkd57AkWdinTwkgmqh294yElNlre2IrVqTMUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aNL+Mar7mdcB+eN/OAmfV+gFSLshBXwy1FfA2bOfZl2A8B+ZRbr4TEIb7RINxAwSsqTnY16cNRUYMaRBw76a4BtX+WmsKIC4h+tbRYBBRk+VCdcQQwGl7HSBBh/ChQGGDbBH3/odoxNb84mFEjh1maPTD0YdDpSQHQVnKMUWnRg=
Received: by 10.78.150.7 with SMTP id x7mr597248hud.1173088947598;
        Mon, 05 Mar 2007 02:02:27 -0800 (PST)
Received: by 10.78.69.4 with HTTP; Mon, 5 Mar 2007 02:02:27 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41432>

Hi *,

  the --topo-order does not play well with --boundary and --max-count.

$ git-rev-list --boundary --max-count=50 5ced0 | wc -l
56
$ git-rev-list --topo-order --boundary --max-count=50 5ced0 | wc -l
8846

(5ced0 is git.git's master). I think it should be 56 for both. It
presents this behaviour since c4025103fa, when was added --boundary
support for git-rev-list --max-count and --max-age.

Santi
