From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: Gitweb caching: Google Summer of Code project
Date: Wed, 28 May 2008 20:33:56 +0200
Message-ID: <483DA594.5040803@gmail.com>
References: <483C4CFF.2070101@gmail.com> <200805272353.34319.jnareb@gmail.com> <483C912F.6010802@gmail.com> <200805281414.36141.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Hawley <warthog19@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>, Lars Hjemli <hjemli@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 20:34:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1QUB-00056g-Gb
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 20:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241AbYE1SeD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 14:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752195AbYE1SeC
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 14:34:02 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:41091 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161AbYE1SeA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 14:34:00 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1838861fgg.17
        for <git@vger.kernel.org>; Wed, 28 May 2008 11:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=SDLFRRe7aFjMr/xoPWKBEQaRtQHDKr6c5rWQQ7Zawto=;
        b=dVszkI+NfUn/9XDc4XvQ6JoDYuJ3LwoAMzfTvF85wc+0ppoYZBG/j/TYA0L6hgaZwyImI2/3jOpmzkB6wFLFrdK4gO1QjOp0/KFpULkzgfuz9wH1iNUQfAH03Az0hHW0EKeyYDrf9UA7IZKXE00D2hqflytSusVdqDu4TgvqBC8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=fLRMQDfmYN/KsqX17HczrgoAbkelWIavfcdJN63mdbfi+3txSWMgIJYZxeTezjQaMGmJS9C2JZ81zcIFSDtbsYCxbieNaQtsY7Jr7Kg+TaG86d6H9icNy6JtsW8b7TGYVEBnPi2YPQdzbMQCEYbukflo1N4JY0iPsYDZ/rApyb8=
Received: by 10.86.100.19 with SMTP id x19mr9146438fgb.61.1211999637888;
        Wed, 28 May 2008 11:33:57 -0700 (PDT)
Received: from ?192.168.23.50? ( [91.33.212.111])
        by mx.google.com with ESMTPS id e11sm14699559fga.1.2008.05.28.11.33.56
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 28 May 2008 11:33:57 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <200805281414.36141.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83124>

Jakub Narebski wrote:
> 1. Caching data
>  * disadvantages:
>    - more CPU
>    - need to serialize and deserialize (parse) data
>    - more complicated

CPU: John told me that so far CPU has *never* been an issue on k.org. 
Unless someone tells me they've had CPU problems, I'll assume that CPU 
is a non-issue until I actually run into it (and then I can optimize the 
particular pieces where CPU is actually an issue).

Serialization: I was planning to use Storable (memcached's Perl API uses 
it transparently I think).  I'm hoping that this'll just solve it.

It's true that it's more complicated.  It'll require quite a bit of 
refactoring, and maybe I'll just back off if I find that it's too hard.

> I'm afraid that implementing kernel.org caching in mainline in
> a generic way would be enough work for a whole GSoC 2008.

I probably won't reimplement the current caching mechanism.  Do you 
think that a solution using memcached is generic enough?  I'll still 
need to add some abstraction layer in the code, but when I'm finished 
the user will either get the normal uncached gitweb, or activate 
memcached caching with some configuration setting.

By the way, I'll be posting about gitweb on this mailing list 
occasionally.  If any of you would like to receive CC's on such 
messages, please let me know, otherwise I'll assume you get them through 
the mailing list.

-- Lea
