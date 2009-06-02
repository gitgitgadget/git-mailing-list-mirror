From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: git and multiple cores
Date: Tue, 2 Jun 2009 19:12:11 -0400
Message-ID: <eaa105840906021612y5b9e4c25o1062d7f7aecfbd16@mail.gmail.com>
References: <4A25AA4C.9070600@nortel.com>
	 <eaa105840906021555w22e62341l61f250455cf8c23b@mail.gmail.com>
	 <20090602230205.GL30527@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chris Friesen <cfriesen@nortel.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jun 03 01:12:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBd9Y-0002NB-Hb
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 01:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117AbZFBXMM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Jun 2009 19:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752274AbZFBXML
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 19:12:11 -0400
Received: from mail-ew0-f224.google.com ([209.85.219.224]:37552 "EHLO
	mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845AbZFBXMK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2009 19:12:10 -0400
Received: by ewy24 with SMTP id 24so9185159ewy.37
        for <git@vger.kernel.org>; Tue, 02 Jun 2009 16:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=Y5c7GDhU4M2UqjDAQYzJ06UYx4Pxd7VUVjRd2LZij9k=;
        b=q8qAPLTRUgBXo8YTU4f64pt0+wt4yDhTDj/6Q8xM6LA96ss6xtXubSc5yRbx5hhsaO
         mzbF4s1jCp3BMB54lq2bZQ1IP2OaBLAEbGzD/rm97N9k7AClStv0/0VSVUdyiqSSbMhB
         dyOFmxCgOwf76J3FIN7PNmHloKPFQ0cxEYroQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=TUTkteiySt0bXC5USWzhXkF1SG/ZsxDGg3x4fbrIpFbC5pmDd4Q1nx+ILJZ1x0jpDu
         MmYIk/JfkSpL+YJ3GNSb5fEGB0icO/SplK5W8f4H4cT5PYk60XXfGr8a1b9TlhLia07K
         CUL6sTec7IiKqHCxo5u0SdBk/o38qb50KbzlY=
Received: by 10.210.141.19 with SMTP id o19mr174067ebd.54.1243984331855; Tue, 
	02 Jun 2009 16:12:11 -0700 (PDT)
In-Reply-To: <20090602230205.GL30527@spearce.org>
X-Google-Sender-Auth: 57e8a60a5902ae4d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120560>

On Tue, Jun 2, 2009 at 7:02 PM, Shawn O. Pearce wrote:
> Peter Harris <git@peter.is-a-geek.org> wrote:
>> On Tue, Jun 2, 2009 at 6:40 PM, Chris Friesen wrote:
>> >
>> > I'm using git 1.6.1.3 and it seems to be limited to a single core.
>> > Given that I've seen cases where the cpu has been basically pinned=
 for
>> > minutes on end (initial clone of a repository, for instance) has t=
here
>> > been any discussion of taking advantage of multiple cores?
>>
>> Sounds like you're mostly concerned about packing.
>>
>> The good news is, your version of git already has a threaded packer.
>> You just need to enable it. See "pack.threads" in "git help config".
>>
>> 1.6.2 and newer use multiple threads by default.
>
> True, but he was talking about initial clone, which on the client
> side is git-index-pack. =A0Which is not threaded.

Ah. I thought he was talking about the server side. My mistake.

Peter Harris
