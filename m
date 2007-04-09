From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 1/8] git-repack --max-pack-size: Add new file statics and struct fields
Date: Mon, 9 Apr 2007 11:38:34 -0700
Message-ID: <56b7f5510704091138r166d6caer7ea4b2497889a4c0@mail.gmail.com>
References: <46197885.3060502@gmail.com>
	 <7vabxi8lqv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 09 23:50:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaylH-0006L1-0W
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 20:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198AbXDISif (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 14:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753367AbXDISif
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 14:38:35 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:19187 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198AbXDISif (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 14:38:35 -0400
Received: by py-out-1112.google.com with SMTP id a29so1107067pyi
        for <git@vger.kernel.org>; Mon, 09 Apr 2007 11:38:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SSuh2dh1gGt/cWVCvNMpunnC9ZuiuJWNAthqkVlocLxbcNhMi7Teg822UYlfi3KVY/KH0hG7QVdt+1wH0xsut3yu519hgd3ZdrYMgOFjnZMoR9b5h2fC6rKO9IOKELmot6xGoImr2ovMDcUyIOqgD2RMr6SeSPBjlxjgivPXL2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CxCdDmjwq4UL2k9RphTZx+GG2GMVEIVVEmRTMEd/MybkJAPe/BWStxXLpjSsWpZHYvQyZnDlQIWIaeuDAdPo7b7n8iiFtYa7SNGJcdHrLwlleCcTiqImpCWqne2Tdnk+5ACSE1T/e4EYfzLCvbTkImPK3X8P8UlTfTPcntOao6U=
Received: by 10.115.32.1 with SMTP id k1mr2428105waj.1176143914103;
        Mon, 09 Apr 2007 11:38:34 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Mon, 9 Apr 2007 11:38:34 -0700 (PDT)
In-Reply-To: <7vabxi8lqv.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44068>

On 4/8/07, Junio C Hamano <junkio@cox.net> wrote:
> Dana How <danahow@gmail.com> writes:
>
> > ... The fields
> > in object_entry are re-arranged & shrunk to save memory.
>
> Is the driving principle "place fields with coarser alignment
> requirements first in the struct"?  I noticed you have a handful
> pointers and an off_t after two short fields.  Two shorts would
> be likely to make the next field aligned suitable for an int,
> but (1) if we ever add another short later that would not be
> true anymore, and (2) I suspect a pointer and an off_t can be
> longer than an int but int would never be longer than them.
All true.  My objective was to save more memory than I had
"wasted" by adding the prev_pack field.  Since it appears
I'll be submitting the patchset yet again,  I'll make this
re-arrangement complete next time.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
