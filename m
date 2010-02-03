From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor 
	with no changes written
Date: Wed, 3 Feb 2010 01:16:57 +0100
Message-ID: <40aa078e1002021616s3098bf53la6af93ab0949e7e@mail.gmail.com>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com>
	 <76c5b8581002021247j6df8f609ld9e5d87a060a5423@mail.gmail.com>
	 <394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com>
	 <76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com>
	 <77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com>
	 <76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com>
	 <alpine.DEB.1.00.1002022356460.4985@pacific.mpi-cbg.de>
	 <76c5b8581002021534i1f0dbd18y1b216233d282cd84@mail.gmail.com>
	 <40aa078e1002021540i13e35776xd733a4e40f34b477@mail.gmail.com>
	 <76c5b8581002021548n129b3997r48ee6f6df5a1a4eb@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wincent Colaiuta <win@wincent.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 01:17:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcSvq-0007TK-Bu
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 01:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755935Ab0BCARJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 19:17:09 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:58048 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569Ab0BCARF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 19:17:05 -0500
Received: by ewy28 with SMTP id 28so641536ewy.28
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 16:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=efGWEbPzsLQeUaboOZdslskxVBTqkDg+TEfrP7c82sY=;
        b=H1dCoH/TrBhwhjJ53Yyg8p/XXQAf5SHJtFsommwZEhPOJnLRQnMwq2LIWFezyAADqd
         ApxQ8id9BUJnut0Tdg2hg7LkD8rIcpBZqUNik4FaKJSHIRHVWZvjX6R13hJJDUvqaCeq
         ubqa77PYE96CgrRN/A3yRPw9PlKzHqtjhMC5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=Ew0okp0WPNWtAa5t4tZMwfvvRmOsKZoCXuNrKg0X2M/cH8nhzrcOJX3pTzs867tefr
         2q5HgR1gx9aaD1mKqbnufZNQHKhIQNBRNH4KzTCphPNkJcYzbLjtVB5kfxTHgu41mlii
         Wq9ezpPPhv3pZ05Fi9hrDLzpurCbQDwxC9wew=
Received: by 10.216.88.2 with SMTP id z2mr115506wee.89.1265156217248; Tue, 02 
	Feb 2010 16:16:57 -0800 (PST)
In-Reply-To: <76c5b8581002021548n129b3997r48ee6f6df5a1a4eb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138792>

On Wed, Feb 3, 2010 at 12:48 AM, Eugene Sajine <euguess@gmail.com> wrote:
>>
>> This is where you're wrong. The reason why commit (without --amend) is
>> aborting when you don't save is that the default commit message is
>> empty, not that it wasn't saved. In fact, just saving still makes in
>> abort. You need to add something to the commit message and then save
>> to get it to perform the commit.
>>
>>> Same should be applied to rebase -i and of course to commit --amend as
>>> it is still commit operation.
>>>
>>
>> "rebase -i" and "commit --amend" already has the exact same logic as
>> commit without ammend in this regard - they abort if the buffer is
>> empty.
>>
>> --
>> Erik "kusma" Faye-Lund
>>
>
> Thank you, but I'm not wrong, as i described the exact same thing
> somewhere in my second or third message, without even knowing the
> implementation details. I understand the reason WHY it is like it is,
> i just don't like it as it is inconsistent and IMHO incorrect.
>

But you are. The interface isn't inconsistent. Your model of how it
works however, is wrong.

-- 
Erik "kusma" Faye-Lund
