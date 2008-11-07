From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git and Media repositories....
Date: Fri, 07 Nov 2008 05:00:43 -0800 (PST)
Message-ID: <m3r65nelo1.fsf@localhost.localdomain>
References: <1225655428.11693.10.camel@vaio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Ansell <mithro@mithis.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 14:02:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyQyQ-00087p-Od
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 14:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbYKGNAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 08:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbYKGNAs
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 08:00:48 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:24978 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbYKGNAr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 08:00:47 -0500
Received: by nf-out-0910.google.com with SMTP id d3so594894nfc.21
        for <git@vger.kernel.org>; Fri, 07 Nov 2008 05:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=oo+MOQMDFDAJX+fpGkj8WdPgIfFMOlj48mbViBxBssI=;
        b=DRjA3ZbLMvdXEG58uqlBMPx7S5sqkF2gqnpBGoRoZYPIM9umICVEgCve2eOHe9TiWI
         6cY9CjXyO25ZoFEk8qvecR9IyJr6TyWw6m34V5oWfbPugkVd+J2dAxGxLLVCCVt4pps1
         rvowQ9nJqopAysO0395oAXQcmdISt9vHI1ED4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=g7W1DEpFDwNXAZ0n2x63lM565aWhuMFo09kgUuhAYArlGCMcVdovdP7lou0qhmLWl4
         A5S9akpd+Kqtdlf5f/fwg/7Z8jtZT9APwZQ4se3VfYQtL8fp4VXCkvZqEiOXWRaOEnmK
         Mb+8ejQEj9mlGCflj2zqBLyznaubf7hTotmo8=
Received: by 10.210.23.3 with SMTP id 3mr200316ebw.198.1226062845890;
        Fri, 07 Nov 2008 05:00:45 -0800 (PST)
Received: from localhost.localdomain (abvq140.neoplus.adsl.tpnet.pl [83.8.214.140])
        by mx.google.com with ESMTPS id 31sm13579771nfu.9.2008.11.07.05.00.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Nov 2008 05:00:43 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mA7D0Eo6017156;
	Fri, 7 Nov 2008 14:00:24 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mA7Cxw5M017149;
	Fri, 7 Nov 2008 13:59:58 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1225655428.11693.10.camel@vaio>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100311>

Tim Ansell <mithro@mithis.com> writes:

> Last week at the gittogether I lead some discussions about how we could
> make Git better support large media repositories (which is one area
> where Subversion still make sense). It was suggested that I post to this
> list to get a discussion going. 
> 
> The general idea is that we always clone the complete meta-data (tags,
> commits and trees) and then only clone blobs when they are needed (using
> something like alternates). This allows us to support shallow, narrow
> and sparse checkouts while still being able to perform operations such
> as committing and merging.
[...]

Well, the *workaround* you could currently use is to put large media
files in separate subdirectory, and make this subdirectory into
submodule.  This uses the fact that you can selectively clone
submodules, or leave them as a stubs...

...and this is also the code you might want to look at when
implementings stubs for 'remote' blob objects

-- 
Jakub Narebski
Poland
ShadeHawk on #git
