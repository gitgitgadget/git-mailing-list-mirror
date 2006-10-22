From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/4] gitweb: Whitespace cleanup - tabs are for indent, spaces are for align (2)
Date: Sun, 22 Oct 2006 22:36:45 +0200
Message-ID: <200610222236.45414.jnareb@gmail.com>
References: <200610211750.49188.jnareb@gmail.com> <200610211752.19891.jnareb@gmail.com> <7v3b9g5cde.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 22:36:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbk3e-000234-G0
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 22:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWJVUgb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 16:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWJVUga
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 16:36:30 -0400
Received: from qb-out-0506.google.com ([72.14.204.224]:9462 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751120AbWJVUga (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 16:36:30 -0400
Received: by qb-out-0506.google.com with SMTP id p36so368780qba
        for <git@vger.kernel.org>; Sun, 22 Oct 2006 13:36:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fX16UrXgIyiwObJfYNyS6WNwT50L/mHBPxANt+8SJaCsepI5Fu7AqE3fc9a/JHzhLoFDM/JqZrR5Vw/l/mh/o/50giqBOd6doMsmXBU9NfatBrjeEAkCMJUtkREi5WHCdvCBVZzM/8efpgJ40754iMrWtgtSx6VhZympD/QNjiI=
Received: by 10.67.119.5 with SMTP id w5mr6080989ugm;
        Sun, 22 Oct 2006 13:36:28 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id y7sm2873014ugc.2006.10.22.13.36.28;
        Sun, 22 Oct 2006 13:36:28 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7v3b9g5cde.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29785>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Code should be aligned the same way, regardless of tab size.
>> Use tabs for indent, but spaces for align.
> 
> I do not necessarily agree with that policy; the result of
> applying this patch is still inconsistent in some places, and I
> think that is primarily because the policy itself is flawed.

To be true I do those "whitespace cleanup" patches when I notice
that something is mis-aligned for _my_ tab width (2 spaces).
I use Emacs with show-whitespace-mode to not introduce errors
which would be aligned for 2 columsn wide tabs but be misaligned
for more common 5 or 8 characters wide tabs.
 
> For example, a part of sub format_paging_nav looks like this:
> 
>         sub format_paging_nav {
>         >>>>>>>>my ($action, $hash, $head, $page, $nrevs) = @_;
>         ...
>         >>>>>>>>if ($page > 0) {
>         >>>>>>>>>>>>>>>>$paging_nav .= " &sdot; " .
>         >>>>>>>>>>>>>>>>>>>>>>>>$cgi->a({-href => href(action=>$a
>         >>>>>>>>>>>>>>>>>>>>>>>>         -accesskey => "p", -titl
>         >>>>>>>>} else {
>         ...
> 
> If your policy is to indent continuation lines (which is why you
> have a TAB before "$cgi->a"), not having a TAB before the
> continued parameter list for the $cgi->a() call look inconsistent.
> 
> If on the other hand your policy is to align parameters to an
> operator that are spread over multiple lines, " &sdot; " and
> "$cgi-a(..." are left and right parameters to the string
> concatenation operator "." in between them, so "$cgi->a" should
> be pushed back with a run of SP starting at the column that
> begins $paging_nav and aligned with the DQ at the beginning of
> the " &sdot; " string.

That is preferred, and usually used policy, although I sometimes
use former to avoid too long lines.

I never claimed to be perfect...

Nevertheless this patch for example correct situation where the
line which should be aligned is aligned using mixture of tabs and
spaces differing from line to line in the "same alignment" block.

-- 
Jakub Narebski
Poland
