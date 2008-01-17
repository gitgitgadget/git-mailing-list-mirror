From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: Merging using only fast-forward
Date: Wed, 16 Jan 2008 22:53:15 -0800
Message-ID: <402c10cd0801162253n6ab19f51y53d0baa16319adaa@mail.gmail.com>
References: <loom.20080116T151930-575@post.gmane.org>
	 <863asxivlj.fsf@blue.stonehenge.com>
	 <7vwsq9o6ls.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 17 07:53:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFOdR-0006b1-IO
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 07:53:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042AbYAQGxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 01:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752905AbYAQGxU
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 01:53:20 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:29398 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782AbYAQGxT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 01:53:19 -0500
Received: by fg-out-1718.google.com with SMTP id e21so563925fga.17
        for <git@vger.kernel.org>; Wed, 16 Jan 2008 22:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=1DEG/0X4+Rw/O3OkYljhdG05L6PHUnMIW40bA2EfL9Q=;
        b=dGsoEVkA0hqnvTEQQ/jBm1ybKQz+Kn1BTMAMEW7CfuBdDzrwCXPFLU30OJ78v5s9rVan6QV0rpkgjkw2/SlEVCghfojWA+gBPmmRvng1AOzXe8lpWNcRxiGZL04WeKAU9cER5gWJhD7uOzqPcBwmWD1eDmvKuLcNpcNILArAfOw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jOVfb54tKD8HuIeJ7s17Osms814Tse26O26VFTVoGfuhcYhjfIYLa5oi5k8CrE5qsvtOyuzFkj+HwPrnktygUvr7QXLXMAKQD/x7uFUeuk1eIQx+3W54FTMe5ao2zngIp2XdGjLRnmymAow6no2osspYP3FNINEjEblIUZ1iBIE=
Received: by 10.82.150.20 with SMTP id x20mr3001676bud.37.1200552795374;
        Wed, 16 Jan 2008 22:53:15 -0800 (PST)
Received: by 10.82.172.18 with HTTP; Wed, 16 Jan 2008 22:53:15 -0800 (PST)
In-Reply-To: <7vwsq9o6ls.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70834>

On Jan 16, 2008 12:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> merlyn@stonehenge.com (Randal L. Schwartz) writes:
>
> > Junio implemented a 7-line patch on the IRC channel (calling parts of it
> > "for randal" or something, I believe :) to do precisely this.
>
> The mechanism itself is simple.
>
>         http://git.pastebin.com/m156a1856

I know that the patch you wrote is not good.  However, it is a good
starting point.

We need to consider cases where the branch we are merging with is an
ancestor or an descendant of HEAD.  The patch only take descendants
into account.  There may also be more than one branch we are merging
with.  All these cases must be considered.  In the case of an octopus, the
cases are slightly more complicated.

I have a patch that work for all cases except for some octopus cases.  I
have written a few test case.  All existing tests succeeds.

I will not be able to work on this for a few days, but I expect to have a
working patch some time this weekend.

I have not looked at the documentation but assume it should not be to
hard to add some documentation as well.

-- 
Sverre Hvammen Johansen
