From: Thomas Harning <harningt@gmail.com>
Subject: Re: [PATCH] Allow commit (and tag) messages to be edited when $EDITOR
 has arguments
Date: Sat, 15 Dec 2007 20:41:53 -0500
Message-ID: <47648261.1050505@gmail.com>
References: <20071216011201.GA10867@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 02:43:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3iXH-0005RM-PE
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 02:43:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754487AbXLPBm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 20:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755076AbXLPBm4
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 20:42:56 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:32775 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775AbXLPBmz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 20:42:55 -0500
Received: by py-out-1112.google.com with SMTP id u77so2350748pyb.16
        for <git@vger.kernel.org>; Sat, 15 Dec 2007 17:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=yhOToi9sUUKtaHwNCV+cyS/sSLAdgeMhQeViysH5x6w=;
        b=AKZVmup/1gT7PDaCjY7yw/EgUHIX/jIDpK+STmelxrHy9MXUcw38o9BBOp8w5rZqMVXJZjlQL2twpnEdK5wOTlKmOU2wVCxUt61MMR0DMiD/GoBhdN2WFi/YQ987sxukygxsRDnwsY+xcz+2TVRt5RCxTm05RLePJcZuxoLEim4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=IAhGwUru6aCMgKN8UUeFMLwcsNJvASS62QDBgzBVmyObr5lzaPAgn+H2/hCH5V3fFfWvtyLM4ZfJjR3w8LkL0unj9lsVGObdQmyF392J6r1qmawDEdKscJLKQzWK+pWMe2z8QRZ+SIzbCpq9mrzrl4kyhzdmN+3O/YMmHPJ9h5c=
Received: by 10.35.84.9 with SMTP id m9mr5838872pyl.6.1197769374895;
        Sat, 15 Dec 2007 17:42:54 -0800 (PST)
Received: from ?192.168.1.192? ( [69.245.185.215])
        by mx.google.com with ESMTPS id 23sm8963122nzn.2007.12.15.17.42.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 Dec 2007 17:42:54 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <20071216011201.GA10867@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68425>

Steven Grimm wrote:
> Users who do EDITOR="/usr/bin/emacs -nw" or similar were left unable to
> edit commit messages once commit became a builtin, because the editor
> launch code assumed that $EDITOR was a single pathname.
>   
I see one problem with this code...  If you use quotes (single or 
double) then this will break it.  I suppose this isn't a major issue 
usually, but if not fixed should be documented.  One case that jumps out 
of my head is an executable path with spaces (quite stupid-and-ugly, but 
possible).
