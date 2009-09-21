From: Michael Gaffney <mr.gaffo@gmail.com>
Subject: Re: [PATCH JGit 2/5] Create abstract method on ObjectDatabase for
 accessing the list of local pack files.
Date: Mon, 21 Sep 2009 14:51:44 -0500
Message-ID: <4AB7D950.9000600@gmail.com>
References: <1253062116-13830-1-git-send-email-mr.gaffo@gmail.com> <1253062116-13830-2-git-send-email-mr.gaffo@gmail.com> <1253062116-13830-3-git-send-email-mr.gaffo@gmail.com> <20090921194035.GM14660@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Sep 21 21:51:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpovQ-0005zr-9S
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 21:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753578AbZIUTvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 15:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753421AbZIUTvn
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 15:51:43 -0400
Received: from mail-yx0-f199.google.com ([209.85.210.199]:57139 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419AbZIUTvm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 15:51:42 -0400
Received: by yxe37 with SMTP id 37so3459710yxe.33
        for <git@vger.kernel.org>; Mon, 21 Sep 2009 12:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=BhHqn25sGiJIcYrWTkw9qx4FjpdNPARxFtfVShklNEY=;
        b=DIbgH1zPvXUEw/45E7x6kXGhJDwEte8668WXQNAJ9UxTXqQjSBXE6HccYElTjnozf8
         BcbfukEAaYb9B9jeCQSubuSe6M4QSbBASgKD3CXPUWSqYNxF0o31oPOTJY1LxBZKopXu
         SUUIF7AXCBavP9PV8qlAmVS4umKHBPV03u3oQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=odUvrGTmaOw+aNL4yI6uV4xgBKsUgvNLegEQ3DfpYtqJheMxzNYUO7gfqEGyCLY52E
         /Bcv+h16MyVCCZO+sITox6TBCs5X9+xolL9ubwj0MpX1WDwn/zOD0zAb1NbvpCi+Z7w5
         3ASzmCT9UmpiGJ3EZ8oWEAflUMyGpE/GfI+MI=
Received: by 10.90.180.16 with SMTP id c16mr66055agf.15.1253562706481;
        Mon, 21 Sep 2009 12:51:46 -0700 (PDT)
Received: from ?192.168.11.102? (nat.asynchrony.com [66.236.120.131])
        by mx.google.com with ESMTPS id 1sm27731agb.48.2009.09.21.12.51.45
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 21 Sep 2009 12:51:45 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <20090921194035.GM14660@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128907>

Shawn O. Pearce wrote:
> Why not allow the ObjectDirectory code to create the directory
> before copying the pack into it?

Good point, this was one of the first tests I did before I got to that 
part of ObjectDirectory. Will fix.

> Don't you mean the list of packs this object database contains?
> An object database may not be a git repository.  Though yes, the
> common case is that it is a repository.

What's the difference in terminology? Not aruging, just wanting to know 
what we're calling a repo and what we're not so that I use it correctly. 
Will fix.

>> +	public abstract List<PackFile> listLocalPacks();
> 
> I think you should define this to be an unmodifiable list, not just
> any list.  Its sad that the Java type system didn't support this
> idea back when they added the new collections APIs.

Should it be a collection as well instead of a list; what would you 
specifically suggest?

> Instead of copying, why not return an unmodifiableList wrapped
> around the array?  PackList will never modify its internal array.

Same as above


-Mike
