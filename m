X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Better symbolic link support in "tree" view
Date: Tue, 5 Dec 2006 22:27:56 +0100
Message-ID: <200612052227.56770.jnareb@gmail.com>
References: <1165256780505-git-send-email-jnareb@gmail.com> <7vr6vfkv3i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Tue, 5 Dec 2006 21:26:09 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JwB/EeWbpzWUoX74khc5CByJFdUxG0XrJpCXXf9WPNGVazvWvtEpS/+8H7G6C5qtr030atdN7juk3RIhx+C0uk/rl0qtVnCjK6uM74Wtz0O+Jp/0e3v+mZA+nBzuM3T2nZFUIjaRQjKXDc4VnEAC+ANcWC5kXGrO1/2g7osH9oM=
User-Agent: KMail/1.9.3
In-Reply-To: <7vr6vfkv3i.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33374>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grhni-0006Ey-TJ for gcvg-git@gmane.org; Tue, 05 Dec
 2006 22:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031580AbWLEVZ4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 16:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031584AbWLEVZ4
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 16:25:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:59332 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1031580AbWLEVZz convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 16:25:55 -0500
Received: by ug-out-1314.google.com with SMTP id 44so3460415uga for
 <git@vger.kernel.org>; Tue, 05 Dec 2006 13:25:51 -0800 (PST)
Received: by 10.66.255.7 with SMTP id c7mr14394328ugi.1165353951349; Tue, 05
 Dec 2006 13:25:51 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id e34sm32537839ugd.2006.12.05.13.25.50; Tue, 05 Dec
 2006 13:25:50 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> In "tree" view (git_print_tree_entry subroutine), add for symbolic
>> links after file name " -> link_target", a la "ls -l".  Use
>> git_get_link_target_html to escape target name and make it into
>> hyperlink if possible.
> 
> I think " -> link_target" is fine, but I do not know if it is
> useful (while I do not think it is wrong) to make the value that
> would have been returned from readlink() into an href, even when
> it points at something inside the same revision.

I have added this bit (making symbolic link target symlink) because 
otherwise there is no way, besides hand-munging the URL, to go to the 
link target.

From the command line, tools usually follow symlinks. In gitweb, "blob" 
view (and "blob_plain" view) show symbolic link contents... not that 
I'm for changing this, mind you.
-- 
Jakub Narebski
