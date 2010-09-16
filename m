From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: empty directories and git
Date: Thu, 16 Sep 2010 13:02:19 -0700 (PDT)
Message-ID: <m3aanhlapl.fsf_-_@localhost.localdomain>
References: <loom.20100916T095344-932@post.gmane.org>
	<4C91D631.9010108@op5.se>
	<CDEB2042-A498-4950-A3CD-27F111455234@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Anton <tmp009@allproducts.info>, Andreas Ericsson <ae@op5.se>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Sep 16 22:02:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwKf6-0003aq-0e
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 22:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755225Ab0IPUCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 16:02:22 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43101 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754428Ab0IPUCV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 16:02:21 -0400
Received: by eyb6 with SMTP id 6so797076eyb.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 13:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=J2uqgKTDNRMupNzOHb0UD8IoIbYkTpv5qMjzUqYrxk0=;
        b=ejx/fE6PqIK3pi50IhufbaKBbZ+Cz4O/AUgYDD3BIihBfuBCvyWieDJTU/tn8xld9D
         RRKafO+zoNtmwSgNN02oCkhXr3uHIveJAlNyBKKDOwAKCbk7zoKNeE9ejiuqgKNEHUqw
         L5kxK296KNqFERyopD+tYtl4UVcT1Kvadp4jw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=nTvWh5HgJ8uFjQ7GpBF+5+E0KRUaKgdOlkDXhXR9cP2oP76DvRwQz1HFap855pV0jF
         dL2c7Cp6nYvp+6ojzT+99One2XYGqlJq9JueMjRamO8lOnWY6EkAqPtmCt0cz6cj5A4N
         h3LNXWJk2yYrfADbkedM02N/T9JKbP2q5mejA=
Received: by 10.213.29.212 with SMTP id r20mr3116083ebc.11.1284667340294;
        Thu, 16 Sep 2010 13:02:20 -0700 (PDT)
Received: from localhost.localdomain (abvm37.neoplus.adsl.tpnet.pl [83.8.210.37])
        by mx.google.com with ESMTPS id a48sm4454205eei.12.2010.09.16.13.02.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Sep 2010 13:02:19 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o8GK1XNF028011;
	Thu, 16 Sep 2010 22:01:43 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o8GK1BQW028003;
	Thu, 16 Sep 2010 22:01:11 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CDEB2042-A498-4950-A3CD-27F111455234@sb.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156351>

Kevin Ballard <kevin@sb.org> writes:
> On Sep 16, 2010, at 1:32 AM, Andreas Ericsson wrote:
> 
> > You can't have empty directories in git.

> Apologies to those who were CC'd on the original message, I'm
> resending to this list as I forgot to set plain text.
> 
> I've always wondered about that. Why do we still have this
> restriction? There is a sha1 hash that is equivalent to the empty
> tree (4b825dc642cb6eb9a060e54bf8d69288fbee4904). Why can't git just
> use that to represent an empty directory? I imagine things that
> touch the working copy may need to be updated to be aware of this,
> but the problem doesn't seem insurmountable.

If I understand it correctly the problem is that git index is flat
structure that contains only file (blob) info; there is currently no
place in it to store information that some empty directory was added.

Adding an extension to have directories in index was considered in the
past; it could even speed up git a bit, I think.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
