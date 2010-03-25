From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 7/7] fmt-merge-msg: hide summary option
Date: Wed, 24 Mar 2010 22:19:32 -0700
Message-ID: <4BAAF264.7050003@gmail.com>
References: <1269414964-9518-1-git-send-email-bebarino@gmail.com> <1269414964-9518-8-git-send-email-bebarino@gmail.com> <7v4ok5dsqr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 06:20:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NufUV-0006Lh-Oc
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 06:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799Ab0CYFTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 01:19:38 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34229 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636Ab0CYFTf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 01:19:35 -0400
Received: by gyg8 with SMTP id 8so4008235gyg.19
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 22:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Y4ZK9io2HiqNd0gS6m/n22lbhOGQJrkOJEkUM19+z4E=;
        b=vrofrNpy6mabIspJP78z9BOxZsLm7lW4a26IG1GuwnWaBEdPCR0tUpmu62vznQWXMT
         2MKL2zfqmaHKgO3wSfdaqo+mYKFT8hdKsEZXUUxRV+16mcDJmfK679eh5ua6r2dyynPm
         PerMqY1/IISZtYuUxnqG9yrHl1Td9ysURfo3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=gBi4jIiZIxFkfzJZDx+e/24kY8zW3Q6lH8Qw3qri8ouHdaPnpH8Nu/n1e3vgJ8gdvy
         DcYXtsmORuzk+rvHsNfBpgb07vjXVTGZX6rqFMxDBnZRalQbNDvWJhFlGiKTaOZpYDKu
         qnfMB1nlXhTDLfuXWM15nUVC8Rki1lj18zwBk=
Received: by 10.100.81.16 with SMTP id e16mr9823631anb.68.1269494375128;
        Wed, 24 Mar 2010 22:19:35 -0700 (PDT)
Received: from [192.168.1.5] (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 23sm248992yxe.56.2010.03.24.22.19.33
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 24 Mar 2010 22:19:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7pre) Gecko/20091214 Shredder/3.0.1pre
In-Reply-To: <7v4ok5dsqr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143161>

On 03/24/2010 07:45 PM, Junio C Hamano wrote:
> We could do that sometime in this autumn timeframe if we start making
> noises when they are used, just like we did during the 1.7.0 transition
> against soon-to-be-deprecated "features".

We already make noises when the option is used. Probably need to make
some noises in release notes though.

> Are there other ancient features we have been passively advertising as
> deprecated that we should now start the removal process?

grepping for deprecated shows mostly deprecated commands:

    git lost-found
    git tar-tree
    git peek-remote (synonym to git ls-remote)
    git init-db (synonym to git init)
    git repo-config (synonym to git config)

I'm pretty sure we don't want to remove them anytime soon though, right?

The only option of interest is 'git reset --mixed' with paths. I don't
really know the backstory on that but it looks like it was deprecated
when the command was made into a builtin 0e5a7fa (Make "git reset" a
builtin., 2007-09-11). Maybe it can become a die now?

Oh and git notes has a deprecation warning but I think we'll probably
have to revisit that one in a few years.
