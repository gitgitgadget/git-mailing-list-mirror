From: alexandrul <alexandrul.ct@gmail.com>
Subject: Re: Creating something like increasing revision numbers
Date: Sun, 18 Oct 2009 21:16:23 +0300
Message-ID: <4ADB5B77.8040605@gmail.com>
References: <20091018144158.GA9789@gandalf.dynalias.org> <200910181703.20607.johan@herland.net> <20091018152054.GA3956@gamma.logic.tuwien.ac.at> <200910181923.19511.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Norbert Preining <preining@logic.at>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Oct 18 20:16:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzaJA-0000JC-QG
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 20:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811AbZJRSQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 14:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754808AbZJRSQb
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 14:16:31 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:10320 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754494AbZJRSQb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 14:16:31 -0400
Received: by ey-out-2122.google.com with SMTP id 9so779086eyd.19
        for <git@vger.kernel.org>; Sun, 18 Oct 2009 11:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=cuCew4WYFjaVJBi8sQod5DRAcy2pcxr2feMaasGjL10=;
        b=en0s2yNjU4w6mLhmHkBwvkPTkJPYL/sasGYoCuD/1drvUXAGK6p0iAetV26wiQ9c7v
         G0XpLqAfJBi2loXGQQO28I1dSm8gFsY4fVttv+EYYv/gkIDqulEt1R5H8jbeYOEc27mu
         dTlq0qx6ENI6x208O/v53cBhy2GETfSrLYvd8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=NhN0QcHGh2e1K8jp1AY9m4gMNPkqrX4GylaMlTPqkO8zOVdDlxI6CeKtZ4/lCVOStK
         5tzV77jiN3kU6Txgcp4Xa38Xjp5XJ6zvm8piFrQ2MzL8I2blzrxWnDsxIozPR7CA2sBD
         bUQlPacL75FrmtmbEVCQ/2zEc8WzPoIbcyNbI=
Received: by 10.216.89.6 with SMTP id b6mr1426834wef.100.1255889794758;
        Sun, 18 Oct 2009 11:16:34 -0700 (PDT)
Received: from ?192.168.2.8? ([89.136.114.133])
        by mx.google.com with ESMTPS id p10sm10846192gvf.29.2009.10.18.11.16.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 18 Oct 2009 11:16:32 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <200910181923.19511.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130606>

Johan Herland wrote:
> Yes. You can create the 'initial' tag with
> 
>   git rev-list HEAD | tail -n1 | xargs git tag initial
> 
> and from then on
> 
>   git describe --tags --match initial | cut -d'-' -f2
> 
> will give you the increasing "revision" number you're looking for. Just be 
> aware that if you have two parallel branches with the same number of 
> commits, they will give you the same number. I.e. this only works for a 
> single, stable (i.e. no history rewrites), branch of development.


So if you concatenate the branch name with the "revision" number you would have
pretty unique tags repo-wide, if you won't rename your branches.
