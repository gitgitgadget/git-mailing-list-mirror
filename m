From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] commit: Append commit_list prefix in two function names.
Date: Sun, 14 Nov 2010 15:19:05 -0600
Message-ID: <20101114211905.GB10150@burratino>
References: <0b9cde68dcdfddc13a91a63f9deb3384576164de.1289768501.git.tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 22:19:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHjzF-0003Q1-Ln
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 22:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232Ab0KNVTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Nov 2010 16:19:41 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43919 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756964Ab0KNVTk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 16:19:40 -0500
Received: by gyh4 with SMTP id 4so2680263gyh.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 13:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=INa+k8pvMC7YYEvEW2g90Uv2nLIWglc/WuJoLI2Jdh0=;
        b=V1goV5DCmp2lApf4/+vYMd1Fh5A5LBgUZECZ6qZTQxowJ6A9jVRLQZQu0pm8i7w9mT
         R2ZyXPMXwXzcyksvuohB+ZFPHj2g/GwNObRfexW3FoDwmQO0iQSlQ4SlS3PHsJbiLQEA
         Cu2VlH1nKZkRlWi5MZaxMCjLb2i5Y1iMHYDlE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Pp5qTXI79Whwz5EH03EHL5T7utkuW0aWjObCdNcUEs4yllhDPa8oiPjoHIWMmewwaL
         CH1nZsjj5ruVZ2U+hiAkxBwZiMhYWFmWN6EFOdJccVyau4mcqErKw04JiB3tjc5C1Qmd
         zwrmJ6EmP8WDYuQxL8KU882gc3t0XzdhJlmXA=
Received: by 10.100.231.9 with SMTP id d9mr3684783anh.199.1289769579772;
        Sun, 14 Nov 2010 13:19:39 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id w32sm2920581ana.37.2010.11.14.13.19.38
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 13:19:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <0b9cde68dcdfddc13a91a63f9deb3384576164de.1289768501.git.tfransosi@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161441>

Thiago Farina wrote:

> Append commit_lis prefix to insert_by_date function and to sort_by_date,
> so it's clear that these functions refer to commit_list structure.

Nits: by "Append" I think you mean "Add"; missing "t" after commit_lis.

This gives the oft-used insert_by_name() function a fairly long name:

	commit_list_insert_by_name

The proposed name is long enough to be unwieldly.  It might have
the virtue of fitting better with some of the commit_list lib:

	commit_list_count
	commit_list_insert
	free_commit_list

Compare:

	sort_by_date
	pop_most_recent_commit
	sort_in_topological_order
	pop_commit

Perhaps this change would work better if some of the others were
renamed at the same time?

Some notes on commit_lists in api-revision-walking.txt would do even
more to make it intuitive. :)

Hope that helps,
Jonathan
