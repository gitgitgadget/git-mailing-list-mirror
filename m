From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 00/12] vcs-svn: incremental import
Date: Mon, 7 Mar 2011 15:23:30 -0600
Message-ID: <20110307212330.GA15732@elie>
References: <20101210102007.GA26298@burratino>
 <20110306225419.GA24327@elie>
 <AANLkTi=+ujWER5aeYzYW1pN-LOdM3Xa2J2bZhjkoeWvB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 07 22:23:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pwhu6-0004RR-V6
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 22:23:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756247Ab1CGVXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 16:23:40 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58156 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754735Ab1CGVXj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 16:23:39 -0500
Received: by wyg36 with SMTP id 36so4603255wyg.19
        for <git@vger.kernel.org>; Mon, 07 Mar 2011 13:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=N41KsQyhhNyK42ivjo3SGinYBC8u1jd1TOhH6Lcespk=;
        b=lYdsEbo1gmE7Ws5KqtxypRJcmEyuAMLgu/zQSnFWfgXevTj65hmjPsiyY0Ps1hmLHi
         CL6NSle8cGlaOScguT0iYSluz4LVLaEciJrVknquw4mEPuJHZb+wHvMSK3nk5Yf1b8BL
         an4hpd+VJXyXSxwZQYQgiiHrvePOQVZFbEvJE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bt1c7BHkQF9WJflXXXAvMWICynZA6T4ED7IvkvJf2nGCbmQS2QDYpqyLTEV0S6gchf
         XMSGVIhLpBdVysWbD15Qm6Nq+933fPSDkqtuHvZ+pwOh6bZoMHpTYg78xByU2Qq/N3y5
         yx8M9mdusDs5hktXOw7O8WFkt5cDL1of+tV0A=
Received: by 10.227.157.68 with SMTP id a4mr3885812wbx.198.1299533017755;
        Mon, 07 Mar 2011 13:23:37 -0800 (PST)
Received: from elie ([69.209.61.99])
        by mx.google.com with ESMTPS id bd8sm13405wbb.7.2011.03.07.13.23.34
        (version=SSLv3 cipher=OTHER);
        Mon, 07 Mar 2011 13:23:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=+ujWER5aeYzYW1pN-LOdM3Xa2J2bZhjkoeWvB@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168612>

Sverre Rabbelier wrote:
> On Sun, Mar 6, 2011 at 23:54, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Patch 1 changes the mark numbers for blobs to be ridiculously high,
>> to make room for memorable commit marks (:1 for r1, :2 for r2, etc).
>
> How high is rediculously high?

2^30.  Later in the series (vcs-svn: eliminate repo_tree structure)
the blob marks are eliminated altogether.

> "Marks are stored in a sparse array, using 1 pointer (4 bytes or 8
> bytes, depending on pointer size) per mark. Although the array is
> sparse, frontends are still strongly encouraged to use marks between 1
> and n, where n is the total number of marks required for this import."

I assume that is mostly meant to make it easier to write alternate
backends.
