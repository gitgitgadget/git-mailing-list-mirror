From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] Add default merge options for all branches
Date: Tue, 3 May 2011 04:49:44 -0500
Message-ID: <20110503094943.GA32714@elie>
References: <4DBF04C5.1080608@dailyvoid.com>
 <4DBF94E9.2010502@dailyvoid.com>
 <20110503090351.GA27862@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	vmiklos@frugalware.org, deskinm@umich.edu
To: Michael Grubb <devel@dailyvoid.com>
X-From: git-owner@vger.kernel.org Tue May 03 11:49:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHCEw-00009x-J6
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 11:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765Ab1ECJtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 05:49:53 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62073 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620Ab1ECJtx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 05:49:53 -0400
Received: by iyb14 with SMTP id 14so5344045iyb.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 02:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=gmFBeefHDlj6+AGlIlNTe0BZhgfonvf8GThu3GbUdI0=;
        b=cmEdXsTgRK9xOIPyePldsrScBNYyKUxaI4/f5ivrQ/oCUtUnaB5WBo5K5KPWD0bO58
         J7I++BKgBfkjAXjv6mtUfVtFrg4teq4G8yLQO8sNAGzX98ShkVvCynG/Ss1gaW24Vb4p
         Al6P8iybpws5he5/eqviX25Fcb+frcVDNu7AE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hKCCaJd9CwI3KJV4bNDA05VYxFJKniUikfr5QbDpVeGwv2+oHmcEEjIT5hPU8YVRkw
         fSiHAiIjB0XEyDisrCmxwKNCOWNzCEA/VAU2zIowsTGylwXYLvmAnKXP6P9xvfOwVCfR
         2jwFbPVUDMwjixTvBQjLVTz8Y5Rqn10Q+DO5g=
Received: by 10.42.59.74 with SMTP id l10mr9439208ich.62.1304416192053;
        Tue, 03 May 2011 02:49:52 -0700 (PDT)
Received: from elie (adsl-69-209-62-211.dsl.chcgil.ameritech.net [69.209.62.211])
        by mx.google.com with ESMTPS id a1sm1794861ics.4.2011.05.03.02.49.50
        (version=SSLv3 cipher=OTHER);
        Tue, 03 May 2011 02:49:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110503090351.GA27862@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172655>

Jonathan Nieder wrote:
> Michael Grubb wrote:

>> The approach taken is to make note of whether a branch specific
>> mergeoptions key has been seen and only apply the global value if it
>> hasn't.
>
> What happens if the global value is seen first?
[...]
> With whichever of the changes below make sense,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Agh, what I meant is "except as noted above".  I am still worried
about (and have not carefully reviewed) the following case:

	[branch "*"]
		mergeoptions = --foo

	[branch "topic"]
		mergeoptions = --bar

Does it produce different behavior from

	[branch "topic"]
		mergeoptions = --bar

	[branch "*"]
		mergeoptions = --foo

?  If so, is that a good thing, and is it documented?

Sorry for the lack of clarity.
