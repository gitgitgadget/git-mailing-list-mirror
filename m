From: David Aguilar <davvid@gmail.com>
Subject: Re: [1.8.0] Tracking empty directories
Date: Wed, 2 Feb 2011 15:33:09 -0800
Message-ID: <4928FF12-E593-4CDB-AC68-B4078CC5920E@gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org> <m3zkqe8xc8.fsf_-_@localhost.localdomain> <AANLkTi=bK7mFS3eWVMWXqZSnv73tafL9AGazk4jPLddp@mail.gmail.com>
Mime-Version: 1.0 (iPhone Mail 7D11)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 03 00:34:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkmDI-0002aV-Tq
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 00:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755754Ab1BBXd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 18:33:29 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59855 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755748Ab1BBXd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 18:33:26 -0500
Received: by iyj18 with SMTP id 18so504748iyj.19
        for <git@vger.kernel.org>; Wed, 02 Feb 2011 15:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:references:message-id:from:to:in-reply-to
         :content-type:content-transfer-encoding:x-mailer:mime-version
         :subject:date:cc;
        bh=6XBgW5e/vYjDiFhc6FYZNP9xgh88362OI81sOvQqClY=;
        b=Pd31WA0eoIlCRzykBe0TSf6gcVdovvQr+gPCrttHUnxydIPJS4mxhOojpsiOLEnGlx
         yGctHeuldwt7vbeCVQk+uXl0U0ZmmBRoLgKvBbFMI+Caw+MasZip1U/VnGKnywrC6pYm
         3mqF+9iyk+tvGfXNJ3U+nzp6aeDEin8+dvTrI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:x-mailer:mime-version:subject:date:cc;
        b=q9iamTTB2XLyg/BTc3q88x3A78F1CQaTUZCDHIw/9HgWiQNjnv969c6XL3ov2syfRd
         kwjz/v7wcjr5v6ZKtOztyu5AAXpc94yqjVQzxfQc0s1hp84FkxjJYSGp3lpvyFkGhY4j
         8qbdkqM7D2cWkqAuhrMLvRBde5W199e8DoXF0=
Received: by 10.42.177.8 with SMTP id bg8mr11984397icb.216.1296689606068;
        Wed, 02 Feb 2011 15:33:26 -0800 (PST)
Received: from [10.76.245.151] ([166.205.136.152])
        by mx.google.com with ESMTPS id jv9sm100288icb.1.2011.02.02.15.33.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Feb 2011 15:33:24 -0800 (PST)
In-Reply-To: <AANLkTi=bK7mFS3eWVMWXqZSnv73tafL9AGazk4jPLddp@mail.gmail.com>
X-Mailer: iPhone Mail (7D11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165940>

On Feb 2, 2011, at 3:23 PM, Jay Soffian <jaysoffian@gmail.com> wrote:

> On Wed, Feb 2, 2011 at 6:56 AM, Jakub Narebski <jnareb@gmail.com>  
> wrote:
>> The problem with backward compatibility is twofold.  First and more
>> important is while git supports empty tree object (it has it  
>> hardcoded
>> for some time, as it is necessary e.g. for initial diff, or merging
>> unrelated branches without common ancestor), and there is no problem
>> with entry for empty tree in a tree object
>>
>>  040000 tree 22d5826c087c4b9dcc72e2131c2cfb061403f7eb  empty
>>
>> there is (supposedly) problem when checking out such tree (see email
>> referenced above) with an old git.
>>
>> Second is that tracking empty directories would require extension  
>> to the
>> git index (storing trees in index, like we store submodules)... but  
>> that
>> is purely local matter.
>
> Instead of using an empty tree, construct a tree containing a single
> sentinel file whose contents are a suitable warning not to delete/edit
> said file using pre-1.8.0 git. Meanwhile git-1.8.0 never writes the
> file to the filesystem. Too ugly?
>
> j.

I don't like where this is going. Users are not always right.  
Touch .gitignore and be done with it.   This is a big change with  
negligible benefits.  I don't understand why this is needed.
