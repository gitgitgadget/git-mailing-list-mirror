From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] fix threaded grep for machines with only one cpu
Date: Wed, 17 Feb 2010 16:29:17 +0100
Message-ID: <4B7C0B4D.6080803@gnu.org>
References: <20100215225001.GA944@book.hvoigt.net> <7vwryet2cw.fsf@alter.siamese.dyndns.org> <7vocjpnc5v.fsf@alter.siamese.dyndns.org> <7vljetlx8r.fsf@alter.siamese.dyndns.org> <20100216180209.GA1532@book.hvoigt.net> <7vocjpng1w.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1002161458410.1946@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Feb 17 16:29:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhlqI-0004P7-Kr
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 16:29:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571Ab0BQP32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 10:29:28 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60317 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228Ab0BQP31 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 10:29:27 -0500
Received: by pwj8 with SMTP id 8so1211896pwj.19
        for <git@vger.kernel.org>; Wed, 17 Feb 2010 07:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=iKP3cfVqwqXfYSRZ1geCDjbMdEup8RDylZ6Qvv3TiK0=;
        b=n+spPDJxSHG3NV8NcsPBU8yxnHjFtBK945TS1OzWjnJ0GOKZgXzE/N2hPb5nw+Uytn
         O7o9ZOdsBekz2FIqNkdH+bWHgWfV8vYZFMsPpCz+eXoN1gtaE0VpYckuJYt8n9gfBRR+
         gICprzPmlyDdIVOHQs5TWI6kURw9b1Lltg74E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=t86qEsZpXvsu4DFnUZWmvyKp1y7ruzkRgAUof2HcD8Lozc7H87G21zrfZPqX2Sinmy
         ROsWdL8NZGpDT3VshtNA00q/KGdzEQMpYAphh12Gcf+FROIVfb6fzB/hzpm1W86+kUTo
         W/h3JS5i/gRs9MxuuvyWGj40koiFGYVLs4qWc=
Received: by 10.142.8.38 with SMTP id 38mr5403864wfh.125.1266420565200;
        Wed, 17 Feb 2010 07:29:25 -0800 (PST)
Received: from yakj.usersys.redhat.com (nat-pool-brq-t.redhat.com [209.132.186.34])
        by mx.google.com with ESMTPS id 21sm5256969pzk.3.2010.02.17.07.29.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Feb 2010 07:29:22 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.1
In-Reply-To: <alpine.LFD.2.00.1002161458410.1946@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140236>

On 02/16/2010 09:00 PM, Nicolas Pitre wrote:
> On Tue, 16 Feb 2010, Junio C Hamano wrote:
>
> [...]
>> Notice how your version (xyzzy) broke the cascade of if..elseif..else.
>>
>> Don't they teach this in schools anymore?
>
> What do you expect from academia?  School and real life are still too
> often disconnected.

When I taught C to second-year bachelor students, I think I did a pretty 
good course (*) but it totally lacked time to get into macros, except 
for simple constants.  I did have a student later on that was doing his 
final project with me and came asking what it was.

Another guy I know is teaching an elective "portable programming" course 
that includes pretty much everything you'd expect (including 
bit-twiddling tricks, basic Autoconf, shared libraries, blah blah) but 
that's a graduate-level course.

    (*) and not too disconnected from reality.  One year their final
    one-week project was using cairo for graphics, had a server that
    talked to multiple clients using poll, and I forced them to support
    IPv6.  Shameless plug: http://github.com/bonzini/netrobots

Paolo
