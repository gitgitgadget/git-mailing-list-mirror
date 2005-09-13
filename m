From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Define relative .git/objects/info/alternates semantics.
Date: Tue, 13 Sep 2005 09:22:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509130918170.3351@g5.osdl.org>
References: <m3mzmjvbh7.fsf@telia.com> <Pine.LNX.4.58.0509110908590.4912@g5.osdl.org>
 <20050911185711.GA22556@mars.ravnborg.org> <Pine.LNX.4.58.0509111157360.3242@g5.osdl.org>
 <20050911194630.GB22951@mars.ravnborg.org> <Pine.LNX.4.58.0509111251150.3242@g5.osdl.org>
 <52irx7cnw5.fsf@cisco.com> <Pine.LNX.4.58.0509111422510.3242@g5.osdl.org>
 <Pine.LNX.4.58.0509111431400.3242@g5.osdl.org> <7virx7njxa.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0509112038020.3242@g5.osdl.org> <7vk6hl4fd9.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 13 18:24:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFDYo-0000fz-P7
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 18:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbVIMQW5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 12:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbVIMQW4
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 12:22:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40357 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964852AbVIMQW4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2005 12:22:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8DGMjBo030383
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 13 Sep 2005 09:22:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8DGMgJc005985;
	Tue, 13 Sep 2005 09:22:43 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6hl4fd9.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8471>



On Tue, 13 Sep 2005, Junio C Hamano wrote:
>
> This patch is request-for-comments.  I have experimented it and
> have a feeling that it may be more intuitive to make it relative
> to $project.git/ directory, instead of $project.git/objects as
> you originally suggested

I don't think you can do that.

I always felt that "alternates" should be per-project, but you're the one 
who argued that "alternates" is a per-object-directory thing.

Which means that the _same_ "alternates" file can be shared with many
different project.git/ directories, and thus it's not well-defined to make
it relative to GIT_DIR.

You can make it relative to "GIT_OBJECTS_DIR/.." of course, which in most
cases is the same thing as "GIT_DIR".

		Linus
