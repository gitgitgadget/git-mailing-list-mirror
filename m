From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Replace instances of export VAR=VAL with VAR=VAL; export VAR
Date: Wed, 28 Nov 2007 21:19:05 +0700
Message-ID: <fcaeb9bf0711280619j3479ea6csa74f4b0d907f2a65@mail.gmail.com>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com>
	 <474AC136.8060906@viscovery.net>
	 <451492C9-F3EA-4C37-A1AD-59FC72E0A0A2@wincent.com>
	 <Pine.LNX.4.64.0711261340470.27959@racer.site>
	 <97F6E8DE-4022-4458-B6A9-C644A6EDC1E3@wincent.com>
	 <7vir3m94ku.fsf@gitster.siamese.dyndns.org>
	 <50645A3B-C5F0-4A99-A2B8-AD9251024244@wincent.com>
	 <7v1waa7lcv.fsf@gitster.siamese.dyndns.org>
	 <1570EAD5-9F47-4105-B3DA-49CA6FA57369@wincent.com>
	 <Pine.LNX.4.64.0711281355460.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Wincent Colaiuta" <win@wincent.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Benoit Sigoure" <tsuna@lrde.epita.fr>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 28 15:19:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxNlC-0002xh-HZ
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 15:19:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160AbXK1OTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 09:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754618AbXK1OTJ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 09:19:09 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:51821 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930AbXK1OTH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 09:19:07 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1409345nfb
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 06:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=W2fX+Lc15bGlrhWkbZjKkRt0BLl8T+UPwUX59ycEiGc=;
        b=eOT7rI2eJ3OzfGDhkOYiqT1SjSw+5/TRrd8VqCkCWxpq8QG1KFECfbgtde/5oXzEes26o1zvzeQq8dA6xmG05+xqlFSyxkCuL2+iZTknFnjow0/mXCzBXjtVLHY2UCGtz5bEpXotqTOr2vA4IfbZ8ytlZiD/Q6yby6KMmJDigO4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BF8JVvSirXOtaI3aj/fyKMoXFmm519wiWEw4EZFAdrG90+VJZLlg9nITHhlFdar5BbpfBW+DfRj6mhaxbx+uOOqHMq1EX1fLD1To95H0TWXteHqLKErm5fQ2vC8K/jfzbZPRIH5L2AtC6AcdfgdqWPQi0Hvvv1d2/QFKXK8U/pE=
Received: by 10.86.65.11 with SMTP id n11mr5013590fga.1196259545848;
        Wed, 28 Nov 2007 06:19:05 -0800 (PST)
Received: by 10.86.83.6 with HTTP; Wed, 28 Nov 2007 06:19:05 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711281355460.27959@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66340>

On Nov 28, 2007 8:57 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> It might be POSIX, but there are shells that do not like the
> expression 'export VAR=VAL'.  To be on the safe side, rewrite them
> into 'VAR=VAL' and 'export VAR'.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
>         On Wed, 28 Nov 2007, Wincent Colaiuta wrote:
>
>         > I'm still a little concerned that nobody commented when I
>         > pointed out that export VAR=VAL is used elsewhere in Git,
>         > especially in git-clone.sh, which is very commonly-used
>         > porcelain. Is it a problem?
>
>         How's that for a comment?
>
>  git-clone.sh         |    2 +-
>  git-filter-branch.sh |   20 ++++++++++++--------
>  git-quiltimport.sh   |   10 ++++++----
>  3 files changed, 19 insertions(+), 13 deletions(-)

Why leave test scripts behind?

-- 
Duy
