From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: refactor input parameters parse/validation
Date: Wed, 8 Oct 2008 11:45:37 +0200
Message-ID: <200810081145.37983.jnareb@gmail.com>
References: <1223054356-17643-1-git-send-email-giuseppe.bilotta@gmail.com> <200810071639.25324.jnareb@gmail.com> <cb7bb73a0810080210s49d1683dj4e2fef8072522abd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 08 11:47:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnVdB-0002Ts-KR
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 11:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753932AbYJHJpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 05:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753657AbYJHJpp
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 05:45:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:43676 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133AbYJHJpo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 05:45:44 -0400
Received: by ug-out-1314.google.com with SMTP id k3so512189ugf.37
        for <git@vger.kernel.org>; Wed, 08 Oct 2008 02:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=73xyNgLn5pceYtdbQyVOcGTnzrz1+PQXu6Va4nQiM0w=;
        b=qxeznzwzwWiwVvrCMw20onlCXh4B7jdc2z8KFJk2c4x3J/EH+Zf+w0tCfWqNGX5n4y
         3LgD9qZnarPZMNvAYAE2HrhDDcRU3SR5UFp1j98RD9NfAEj8JmLiSfz2CnwzrVZ+Bbnh
         r2bwK7K2ThKhJb81jp06NzjUHpDjRC2uLY7LQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=crO8BcxaZQKKhrK6wqnVuSBGLL4dy4qTy9Gnf5W/aUyu80mUFWpOVJLhUpr9vYaH8P
         M9tq0axsZq+rPvZY+6ghvZxSFsOAldFmFUrkRfvRr1CB85vpJ6Y9iJCerZQieqTNSgEP
         4s4tZBQxBZc1DgN5nfIV1nf7A5g9KSAcG/uTU=
Received: by 10.67.25.9 with SMTP id c9mr1989643ugj.29.1223459142485;
        Wed, 08 Oct 2008 02:45:42 -0700 (PDT)
Received: from ?192.168.1.11? (abww108.neoplus.adsl.tpnet.pl [83.8.246.108])
        by mx.google.com with ESMTPS id 32sm1511047ugf.9.2008.10.08.02.45.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Oct 2008 02:45:41 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0810080210s49d1683dj4e2fef8072522abd@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97792>

Giuseppe Bilotta wrote:
> On Tue, Oct 7, 2008 at 4:39 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> > Giuseppe Bilotta wrote:

> > Wouldn't it be simpler and as good solution to just leave validation
> > off evaluate_path_info() (well, of course except check_head_link() test),
> > and allow it to be validated when assigning global 'params' variables?
> > check_head_link() would be repeated for path_info links, but that
> > should not affect performance much.
> 
> Well, it does have a performance hit in the case of invalid $project
> since it spends time working on the rest of the URL before bailing
> out, but it's probably the cleanest solution. I'll do it this way.

I have forgot about this fact, that parameter validation serves also
as early escape. But I don't think it is much performance hit in
practice; it is performance (optimization) vs. maintability tradeoff.

-- 
Jakub Narebski
Poland
